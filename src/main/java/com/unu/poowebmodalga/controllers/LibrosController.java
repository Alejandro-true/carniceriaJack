package com.unu.poowebmodalga.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.unu.poowebmodalga.beans.Libro;
import com.unu.poowebmodalga.dto.LibroGenero;
import com.unu.poowebmodalga.models.LibrosModel;
import com.unu.poowebmodalga.utilitarios.UtilsJson;

@WebServlet("/LibrosController")
@MultipartConfig
public class LibrosController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	LibrosModel modelo = new LibrosModel();

	public LibrosController() {
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
		case "reporte":
			reporte(request, response);
			break;
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
			request.setAttribute("listaLibros", modelo.listarLibros());
			request.getRequestDispatcher("/libros/listaLibros.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			Logger.getLogger(LibrosController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * Carga el formulario para nuevo libro
	 */
	private void cargarFormularioNuevo(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			boolean esModal = request.getParameter("modal") != null;

			// Cargar listas para los combos
			request.setAttribute("listaAutores", modelo.listarAutores());
			request.setAttribute("listaGeneros", modelo.listarGeneros());

			String jsp = esModal ? "/libros/fragments/formNuevo.jsp" : "/libros/nuevoLibro.jsp";
			request.getRequestDispatcher(jsp).forward(request, response);
		} catch (ServletException | IOException e) {
			Logger.getLogger(LibrosController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * Carga el formulario para editar libro
	 */
	private void cargarFormularioEditar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			String id = request.getParameter("id");
			Libro libro = modelo.obtenerLibro(Integer.parseInt(id));

			if (libro != null) {
				request.setAttribute("libro", libro);

				// Cargar listas para los combos
				request.setAttribute("listaAutores", modelo.listarAutores());
				request.setAttribute("listaGeneros", modelo.listarGeneros());

				boolean esModal = request.getParameter("modal") != null;
				String jsp = esModal ? "/libros/fragments/formEditar.jsp" : "/libros/editarLibro.jsp";

				request.getRequestDispatcher(jsp).forward(request, response);
			} else {
				response.sendRedirect(request.getContextPath() + "/error404.jsp");
			}
		} catch (Exception e) {
			Logger.getLogger(LibrosController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * Inserta un nuevo libro
	 */
	private void insertar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {
		try {
			Libro libro = new Libro();
			libro.setNombreLibro(request.getParameter("nombre"));
			libro.setExistencia(Integer.parseInt(request.getParameter("existencia")));
			libro.setPrecio(Double.parseDouble(request.getParameter("precio")));
			libro.setDescripcion(request.getParameter("descripcion"));
			libro.setIdAutor(Integer.parseInt(request.getParameter("autor")));
			libro.setIdGenero(Integer.parseInt(request.getParameter("genero")));

			int resultado = modelo.insertarLibro(libro);

			if (esAjax) {
				enviarJSON(response, resultado > 0,
						resultado > 0 ? "Libro registrado exitosamente" : "Error al registrar libro");
			} else {
				response.setContentType("text/html; charset=UTF-8");
				if (resultado > 0) {
					request.getSession().setAttribute("mensaje", "Libro registrado exitosamente");
				} else {
					request.getSession().setAttribute("mensaje", "Error al registrar libro");
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
	 * Modifica un libro existente
	 */
	private void modificar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {
		try {
			Libro libro = new Libro();
			libro.setIdLibro(Integer.parseInt(request.getParameter("id")));
			libro.setNombreLibro(request.getParameter("nombre"));
			libro.setExistencia(Integer.parseInt(request.getParameter("existencia")));
			libro.setPrecio(Double.parseDouble(request.getParameter("precio")));
			libro.setDescripcion(request.getParameter("descripcion"));
			libro.setIdAutor(Integer.parseInt(request.getParameter("autor")));
			libro.setIdGenero(Integer.parseInt(request.getParameter("genero")));

			int resultado = modelo.modificarLibro(libro);

			if (esAjax) {
				enviarJSON(response, resultado > 0,
						resultado > 0 ? "Libro modificado exitosamente" : "Error al modificar libro");
			} else {
				response.setContentType("text/html; charset=UTF-8");
				if (resultado > 0) {
					request.getSession().setAttribute("mensaje", "Libro modificado exitosamente");
				} else {
					request.getSession().setAttribute("mensaje", "Error al modificar libro");
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
	 * Elimina un libro
	 */
	private void eliminar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			int id = Integer.parseInt(request.getParameter("id"));

			int resultado = modelo.eliminarLibro(id);
			String mensaje = resultado > 0 ? "Libro eliminado exitosamente" : "Error al eliminar libro";
			request.getSession().setAttribute("mensaje", mensaje);

		} catch (Exception e) {
			Logger.getLogger(LibrosController.class.getName()).log(Level.SEVERE, null, e);
			request.getSession().setAttribute("mensaje", "Error: " + e.getMessage());
		}
		listar(request, response);
	}

	private void reporte(HttpServletRequest request, HttpServletResponse response) {
		try {
			// Detectar si es una petición AJAX verificando el header Accept
			String acceptHeader = request.getHeader("Accept");
			boolean esAjax = acceptHeader != null && acceptHeader.contains("application/json");

			if (esAjax) {
				// CASO 1: Petición AJAX - devolver JSON con los datos
				List<LibroGenero> datos = modelo.obtenerLibroPorGenero();

				List<String> labels = new ArrayList<>();
				List<Integer> values = new ArrayList<>();

				for (LibroGenero d : datos) {
					String genero = d.getNombreGenero();
					Integer total = d.getTotal();

					labels.add(genero == null ? "" : genero);
					values.add(total == null ? 0 : total);
				}

				// Construir el objeto data como JSON
				String dataJson = new StringBuilder(128).append("{").append("\"labels\":")
						.append(UtilsJson.jsonArrayStrings(labels)).append(',').append("\"values\":")
						.append(UtilsJson.jsonArrayInts(values)).append("}").toString();

				// Enviar respuesta JSON
				enviarJSON(response, true, "OK", dataJson);

			} else {
				// CASO 2: Petición directa desde navegador - mostrar JSP
				response.setContentType("text/html; charset=UTF-8");
				request.getRequestDispatcher("/libros/reporte.jsp").forward(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();

			// Manejar error según el tipo de petición
			String acceptHeader = request.getHeader("Accept");
			boolean esAjax = acceptHeader != null && acceptHeader.contains("application/json");

			if (esAjax) {
				enviarJSON(response, false, "Error: " + e.getMessage(), null);
			} else {
				try {
					request.setAttribute("error", "Error al cargar el reporte: " + e.getMessage());
					request.getRequestDispatcher("/error.jsp").forward(request, response);
				} catch (Exception ex) {
					ex.printStackTrace();
				}
			}
		}
	}

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