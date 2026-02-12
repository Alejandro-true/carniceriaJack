package com.unu.poowebmodalga.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.unu.poowebmodalga.beans.Producto;
import com.unu.poowebmodalga.beans.Usuario;
import com.unu.poowebmodalga.models.CategoriaModel;
import com.unu.poowebmodalga.models.ProductoModel;

@WebServlet("/ProductoController")
@MultipartConfig
public class ProductoController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	ProductoModel modelo = new ProductoModel();
	CategoriaModel modeloCategoria = new CategoriaModel();
	HttpSession session;
	private static final String UPLOAD_DIRECTORY = "uploads/productos";

	public ProductoController() {
		super();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String operacion = request.getParameter("op");

		if (operacion == null) {
			listar(request, response);
			return;
		}

		// Detectar si es AJAX
		boolean esAjax = operacion.endsWith("Ajax");

		switch (operacion) {
		case "listar":
			listar(request, response);
			break;

		case "nuevo":
			cargarFormularioNuevo(request, response);
			break;

		case "editar":
			cargarFormularioEditar(request, response);
			break;

		case "insertarAjax":
		case "insertar":
			insertar(request, response, esAjax);
			break;

		case "modificarAjax":
		case "modificar":
			modificar(request, response, esAjax);
			break;

		case "eliminar":
			eliminar(request, response);
			break;
		/*
		 * case "reporte": reporte(request, response); break;
		 */
		default:
			listar(request, response);
			break;
		}
	}

	/**
	 * Carga la lista completa de libros
	 */
	private void listar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			HttpSession session = request.getSession(false);
			if (session == null || session.getAttribute("usuario") == null) {
				response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
				return;
			}
			String categoria = request.getParameter("categoria");

			request.setAttribute("usuario", (Usuario) session.getAttribute("usuario"));
			List<Producto> listaProducto;
			if (categoria == null)
				listaProducto = modelo.listarProducto();
			else
				listaProducto = modelo.listarPorCategoria(categoria);
			request.setAttribute("listaProducto", listaProducto);
			request.getRequestDispatcher("/producto/listaProductos.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			Logger.getLogger(ProductoController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * Carga el formulario para nuevo producto
	 */
	private void cargarFormularioNuevo(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			boolean esModal = request.getParameter("modal") != null;

			request.setAttribute("listaCategoria", modeloCategoria.listarCategorias());

			String jsp = esModal ? "/producto/fragments/formNuevo.jsp" : "/producto/nuevoLibro.jsp";
			request.getRequestDispatcher(jsp).forward(request, response);
		} catch (ServletException | IOException e) {
			Logger.getLogger(ProductoController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * Carga el formulario para editar producto
	 */
	private void cargarFormularioEditar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			String id = request.getParameter("id");
			Producto producto = modelo.obtenerProducto(Integer.parseInt(id));
			request.setAttribute("listaCategoria", modeloCategoria.listarCategorias());
			if (producto != null) {
				request.setAttribute("producto", producto);

				boolean esModal = request.getParameter("modal") != null;
				String jsp = esModal ? "/producto/fragments/formEditar.jsp" : "/producto/editarLibro.jsp";

				request.getRequestDispatcher(jsp).forward(request, response);
			} else {
				response.sendRedirect(request.getContextPath() + "/error404.jsp");
			}
		} catch (Exception e) {
			Logger.getLogger(ProductoController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * Inserta un nuevo producto
	 */
	private void insertar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {
		try {
			Producto producto = new Producto();
			producto.setNombreProducto(request.getParameter("nombre"));
			producto.setStock(Integer.parseInt(request.getParameter("stock")));
			producto.setPrecioUnitario(Double.parseDouble(request.getParameter("precio")));
			producto.setIdCategoria(Integer.parseInt(request.getParameter("categoria")));

			// =========================
			// SUBIDA DE IMAGEN
			// =========================
			String uploadPath = getServletContext().getRealPath("/uploads/productos");

			File uploadDir = new File(uploadPath);
			if (!uploadDir.exists()) {
				uploadDir.mkdirs();
			}

			Part filePart = request.getPart("imagen");

			String rutaImagen = null;
			if (filePart != null && filePart.getSize() > 0) {
				String fileName = System.currentTimeMillis() + "_"
						+ Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

				filePart.write(uploadPath + File.separator + fileName);

				rutaImagen = "uploads/productos/" + fileName;
			}

			// Asignar ruta al producto
			producto.setImagenUrl(rutaImagen);

			int resultado = modelo.insertarProducto(producto);

			if (esAjax) {
				enviarJSON(response, resultado > 0,
						resultado > 0 ? "Producto registrado exitosamente" : "Error al registrar producto");
			} else {
				response.setContentType("text/html; charset=UTF-8");
				request.getSession().setAttribute("mensaje",
						resultado > 0 ? "Producto registrado exitosamente" : "Error al registrar Producto");
				listar(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();

			if (esAjax) {
				enviarJSON(response, false, "Error: " + e.getMessage());
			} else {
				try {
					response.setContentType("text/html; charset=UTF-8");
					request.getSession().setAttribute("mensaje", "Error: " + e.getMessage());
					listar(request, response);
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
		}
	}

	// Método para extraer el nombre del archivo
	private String getFileName(Part part) {
		String contentDisp = part.getHeader("content-disposition");
		String[] tokens = contentDisp.split(";");
		for (String token : tokens) {
			if (token.trim().startsWith("filename")) {
				return token.substring(token.indexOf("=") + 2, token.length() - 1);
			}
		}
		return "";
	}

	// Método para generar un nombre único (evitar sobrescribir archivos)
	private String generarNombreUnico(String fileName) {
		String extension = "";
		int i = fileName.lastIndexOf('.');
		if (i > 0) {
			extension = fileName.substring(i);
		}
		return System.currentTimeMillis() + "_" + UUID.randomUUID().toString() + extension;
	}

	/**
	 * Modifica un producto existente
	 */
	private void modificar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {
		try {
			Producto producto = new Producto();
			producto.setIdProducto(Integer.parseInt(request.getParameter("id")));
			producto.setNombreProducto(request.getParameter("nombre"));
			producto.setStock(Integer.parseInt(request.getParameter("stock")));
			producto.setPrecioUnitario(Double.parseDouble(request.getParameter("precio")));
			producto.setIdCategoria(Integer.parseInt(request.getParameter("categoria")));
			Part imagenPart = request.getPart("imagen");

			if (imagenPart != null && imagenPart.getSize() > 0) {
				String fileName = getFileName(imagenPart);
				String uniqueFileName = generarNombreUnico(fileName);

				// Obtener la ruta física del directorio de uploads
				String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;

				// Crear el directorio si no existe
				File uploadDir = new File(uploadPath);
				if (!uploadDir.exists()) {
					uploadDir.mkdirs();
				}

				// Guardar el archivo
				String filePath = uploadPath + File.separator + uniqueFileName;
				imagenPart.write(filePath);

				// Guardar la URL relativa en el producto
				String imagenUrl = request.getContextPath() + "/" + UPLOAD_DIRECTORY + "/" + uniqueFileName;
				producto.setImagenUrl(imagenUrl);
			} else {
				// Imagen por defecto si no se sube ninguna
				producto.setImagenUrl(request.getContextPath() + "/images/producto-default.png");
			}
			int resultado = modelo.modificarProducto(producto);

			if (esAjax) {
				enviarJSON(response, resultado > 0,
						resultado > 0 ? "Producto modificado exitosamente" : "Error al modificar Producto");
			} else {
				response.setContentType("text/html; charset=UTF-8");
				if (resultado > 0) {
					request.getSession().setAttribute("mensaje", "Producto modificado exitosamente");
				} else {
					request.getSession().setAttribute("mensaje", "Error al modificar Producto");
				}
				listar(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();

			if (esAjax) {
				enviarJSON(response, false, "Error: " + e.getMessage());
			} else {
				try {
					response.setContentType("text/html; charset=UTF-8");
					request.getSession().setAttribute("mensaje", "Error: " + e.getMessage());
					listar(request, response);
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
		}
	}

	/**
	 * Elimina un producto
	 */
	private void eliminar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			int id = Integer.parseInt(request.getParameter("id"));

			int resultado = modelo.eliminarProducto(id);
			String mensaje = resultado > 0 ? "Producto eliminado exitosamente" : "Error al eliminar Producto";
			request.getSession().setAttribute("mensaje", mensaje);

		} catch (Exception e) {
			Logger.getLogger(ProductoController.class.getName()).log(Level.SEVERE, null, e);
			request.getSession().setAttribute("mensaje", "Error: " + e.getMessage());
		}
		listar(request, response);
	}

	/*
	 * private void reporte(HttpServletRequest request, HttpServletResponse
	 * response) { try { // Detectar si es una petición AJAX verificando el header
	 * Accept String acceptHeader = request.getHeader("Accept"); boolean esAjax =
	 * acceptHeader != null && acceptHeader.contains("application/json");
	 * 
	 * if (esAjax) { // CASO 1: Petición AJAX - devolver JSON con los datos //
	 * List<LibroGenero> datos = modelo.obtenerLibroPorGenero();
	 * 
	 * List<String> labels = new ArrayList<>(); List<Integer> values = new
	 * ArrayList<>();
	 * 
	 * for (LibroGenero d : datos) { String genero = d.getNombreGenero(); Integer
	 * total = d.getTotal();
	 * 
	 * labels.add(genero == null ? "" : genero); values.add(total == null ? 0 :
	 * total); }
	 * 
	 * // Construir el objeto data como JSON String dataJson = new
	 * StringBuilder(128).append("{").append("\"labels\":")
	 * .append(UtilsJson.jsonArrayStrings(labels)).append(',').append("\"values\":")
	 * .append(UtilsJson.jsonArrayInts(values)).append("}").toString();
	 * 
	 * // Enviar respuesta JSON enviarJSON(response, true, "OK", dataJson);
	 * 
	 * } else { // CASO 2: Petición directa desde navegador - mostrar JSP
	 * response.setContentType("text/html; charset=UTF-8");
	 * request.getRequestDispatcher("/libros/reporte.jsp").forward(request,
	 * response); }
	 * 
	 * } catch (Exception e) { e.printStackTrace();
	 * 
	 * // Manejar error según el tipo de petición String acceptHeader =
	 * request.getHeader("Accept"); boolean esAjax = acceptHeader != null &&
	 * acceptHeader.contains("application/json");
	 * 
	 * if (esAjax) { enviarJSON(response, false, "Error: " + e.getMessage(), null);
	 * } else { try { request.setAttribute("error", "Error al cargar el reporte: " +
	 * e.getMessage()); request.getRequestDispatcher("/error.jsp").forward(request,
	 * response); } catch (Exception ex) { ex.printStackTrace(); } } } }
	 */

	/**
	 * Envía una respuesta JSON
	 */
	private void enviarJSON(HttpServletResponse response, boolean success, String mensaje) {
		try {
			response.reset();
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.setHeader("Cache-Control", "no-cache");

			String mensajeLimpio = mensaje.replace("\"", "'").replace("\n", " ").replace("\r", " ");
			String json = "{\"success\":" + success + ",\"mensaje\":\"" + mensajeLimpio + "\"}";

			PrintWriter out = response.getWriter();
			out.write(json);
			out.flush();
			out.close();

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Envía una respuesta JSON con datos adicionales
	 * 
	 * @param success        - true si la operación fue exitosa
	 * @param mensaje        - mensaje a enviar
	 * @param dataJsonObject - objeto JSON con datos adicionales
	 */
	private void enviarJSON(HttpServletResponse response, boolean success, String mensaje, String dataJsonObject) {
		try {
			response.reset();
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.setHeader("Cache-Control", "no-cache");

			String mensajeLimpio = mensaje.replace("\"", "'").replace("\n", " ").replace("\r", " ");

			StringBuilder sb = new StringBuilder(256);
			sb.append("{\"success\":").append(success).append(",\"mensaje\":\"").append(mensajeLimpio).append("\"");

			if (dataJsonObject != null && !dataJsonObject.isEmpty()) {
				sb.append(",\"data\":").append(dataJsonObject);
			}
			sb.append('}');

			try (PrintWriter out = response.getWriter()) {
				out.write(sb.toString());
				out.flush();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}
}