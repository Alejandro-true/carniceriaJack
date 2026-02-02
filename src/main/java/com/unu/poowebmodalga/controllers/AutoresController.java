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

import com.unu.poowebmodalga.beans.Autor;
import com.unu.poowebmodalga.dto.AutorPaisDTO;
import com.unu.poowebmodalga.models.AutoresModel;
import com.unu.poowebmodalga.utilitarios.UtilsJson;

@WebServlet("/AutoresController")
@MultipartConfig
public class AutoresController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	AutoresModel modelo = new AutoresModel();

	public AutoresController() {
		super();
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String operacion = request.getParameter("op");

		if (operacion == null) {
			listar(request, response);
			return;
		}

		// FORZAR: Si termina en "Ajax", ES AJAX
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
	 * Carga la lista completa de autores
	 */
	private void listar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			request.setAttribute("listaAutores", modelo.listarAutores());
			request.getRequestDispatcher("/autores/listaAutores.jsp").forward(request, response);

		} catch (ServletException | IOException e) {
			Logger.getLogger(AutoresController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * Carga el formulario para nuevo autor Si es modal, carga solo el fragment
	 */
	private void cargarFormularioNuevo(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			boolean esModal = request.getParameter("modal") != null;

			String jsp = esModal ? "/autores/fragments/formNuevo.jsp" : "/autores/nuevoAutor.jsp";

			request.getRequestDispatcher(jsp).forward(request, response);
		} catch (ServletException | IOException e) {
			Logger.getLogger(AutoresController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * Carga el formulario para editar autor Si es modal, carga solo el fragment
	 */
	private void cargarFormularioEditar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			String id = request.getParameter("id");
			Autor autor = modelo.obtenerAutor(Integer.parseInt(id));

			if (autor != null) {
				request.setAttribute("autor", autor);

				boolean esModal = request.getParameter("modal") != null;
				String jsp = esModal ? "/autores/fragments/formEditar.jsp" : "/autores/editarAutor.jsp";

				request.getRequestDispatcher(jsp).forward(request, response);
			} else {
				response.sendRedirect(request.getContextPath() + "/error404.jsp");
			}
		} catch (Exception e) {
			Logger.getLogger(AutoresController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * Inserta un nuevo autor
	 * 
	 * @param esAjax - true si es petición AJAX, false para redirección normal
	 */
	private void insertar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {

		try {
			Autor autor = new Autor();
			autor.setCodigoAutor(request.getParameter("codigo"));
			autor.setNacionalidad(request.getParameter("nacionalidad"));
			autor.setNombreAutor(request.getParameter("nombre"));

			int resultado = modelo.insertarAutor(autor);

			if (esAjax) {
				enviarJSON(response, resultado > 0,
						resultado > 0 ? "Autor registrado exitosamente" : "Error al registrar");
			} else {

				response.setContentType("text/html; charset=UTF-8");
				if (resultado > 0) {
					request.getSession().setAttribute("mensaje", "Registro exitoso");
				} else {
					request.getSession().setAttribute("mensaje", "Registro fallido");
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
	 * Genera el reporte de autores por país - Si es petición AJAX (Accept:
	 * application/json): devuelve JSON con datos - Si es petición directa: muestra
	 * el JSP con los gráficos
	 */

	/**
	 * Modifica un autor existente
	 * 
	 * @param esAjax - true si es petición AJAX, false para redirección normal
	 */
	private void modificar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {

		try {
			Autor autor = new Autor();
			autor.setIdAutor(Integer.parseInt(request.getParameter("id")));
			autor.setCodigoAutor(request.getParameter("codigo"));
			autor.setNacionalidad(request.getParameter("nacionalidad"));
			autor.setNombreAutor(request.getParameter("nombre"));

			int resultado = modelo.modificarAutor(autor);

			if (esAjax) {

				enviarJSON(response, resultado > 0,
						resultado > 0 ? "Autor modificado exitosamente" : "Error al modificar");
			} else {

				response.setContentType("text/html; charset=UTF-8");
				if (resultado > 0) {
					request.getSession().setAttribute("mensaje", "Modificación exitosa");
				} else {
					request.getSession().setAttribute("mensaje", "Modificación fallida");
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
	 * Elimina un autor
	 */
	private void eliminar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			int id = Integer.parseInt(request.getParameter("id"));

			int resultado = modelo.eliminarAutor(id);
			String mensaje = resultado > 0 ? "Autor eliminado exitosamente" : "Error al eliminar autor";
			request.getSession().setAttribute("mensaje", mensaje);

		} catch (Exception e) {
			Logger.getLogger(AutoresController.class.getName()).log(Level.SEVERE, null, e);
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
				List<AutorPaisDTO> datos = modelo.obtenerAutoresPorPais();

				List<String> labels = new ArrayList<>();
				List<Integer> values = new ArrayList<>();

				for (AutorPaisDTO d : datos) {
					String pais = d.getPais();
					Integer total = d.getTotal();

					labels.add(pais == null ? "" : pais);
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
				request.getRequestDispatcher("/autores/reporte.jsp").forward(request, response);
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
	 * Envía una respuesta JSON simple
	 * 
	 * @param success - true si la operación fue exitosa
	 * @param mensaje - mensaje a enviar
	 */
	private void enviarJSON(HttpServletResponse response, boolean success, String mensaje) {
		try {
			// IMPORTANTE: Reset response para limpiar cualquier contenido previo
			response.reset();

			// Configurar headers
			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.setHeader("Cache-Control", "no-cache");

			// Limpiar mensaje (escapar caracteres especiales)
			String mensajeLimpio = mensaje.replace("\"", "'").replace("\n", " ").replace("\r", " ");

			// Construir JSON
			String json = "{\"success\":" + success + ",\"mensaje\":\"" + mensajeLimpio + "\"}";

			// Enviar respuesta
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