package com.unu.poowebmodalga.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.unu.poowebmodalga.beans.Cliente;
import com.unu.poowebmodalga.models.PedidoModel;

@WebServlet("/PedidoController")
public class PedidoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	PedidoModel modelo = new PedidoModel();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PedidoController() {
		super();
		// TODO Auto-generated constructor stub
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
			// reporte(request, response);
			break;
		default:
			listar(request, response);
			break;
		}
	}

	private void listar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			request.setAttribute("listaPedido", modelo.listarPedidos());
			request.getRequestDispatcher("/pedidos/listaClientes.jsp").forward(request, response);

		} catch (ServletException | IOException e) {
			Logger.getLogger(ClienteController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * Carga el formulario para nuevo autor Si es modal, carga solo el fragment
	 */
	private void cargarFormularioNuevo(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			boolean esModal = request.getParameter("modal") != null;

			String jsp = esModal ? "/clientes/fragments/formNuevo.jsp" : "/clientes/nuevoAutor.jsp";

			request.getRequestDispatcher(jsp).forward(request, response);
		} catch (ServletException | IOException e) {
			Logger.getLogger(ClienteController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * Carga el formulario para editar cliente Si es modal, carga solo el fragment
	 */
	private void cargarFormularioEditar(HttpServletRequest request, HttpServletResponse response) {
		try {
			response.setContentType("text/html; charset=UTF-8");
			String id = request.getParameter("id");
			Cliente cliente = modelo.obtenerCliente(Integer.parseInt(id));

			if (cliente != null) {
				request.setAttribute("cliente", cliente);

				boolean esModal = request.getParameter("modal") != null;
				String jsp = esModal ? "/clientes/fragments/formEditar.jsp" : "/clientes/editarAutor.jsp";

				request.getRequestDispatcher(jsp).forward(request, response);
			} else {
				response.sendRedirect(request.getContextPath() + "/error404.jsp");
			}
		} catch (Exception e) {
			Logger.getLogger(ClienteController.class.getName()).log(Level.SEVERE, null, e);
		}
	}

	/**
	 * Inserta un nuevo autor
	 * 
	 * @param esAjax - true si es petición AJAX, false para redirección normal
	 */
	private void insertar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {

		try {
			Cliente cliente = new Cliente();
			cliente.setNombreCompleto(request.getParameter("nombre"));
			cliente.setTelefono(request.getParameter("telefono"));
			cliente.setDireccion(request.getParameter("direccion"));
			cliente.setEmail(request.getParameter("email"));
			cliente.setDni(request.getParameter("dni"));

			int resultado = modelo.insertarCliente(cliente);

			if (esAjax) {
				enviarJSON(response, resultado > 0,
						resultado > 0 ? "Cliente registrado exitosamente" : "Error al registrar");
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
			Cliente cliente = new Cliente();
			cliente.setNombreCompleto(request.getParameter("nombre"));
			cliente.setTelefono(request.getParameter("telefono"));
			cliente.setDireccion(request.getParameter("direccion"));
			cliente.setEmail(request.getParameter("email"));
			cliente.setDni(request.getParameter("dni"));
			cliente.setIdCliente(Integer.parseInt(request.getParameter("id")));

			int resultado = modelo.modificarCliente(cliente);

			if (esAjax) {

				enviarJSON(response, resultado > 0,
						resultado > 0 ? "Cliente modificado exitosamente" : "Error al modificar");
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

			int resultado = modelo.inhabilitarCliente(id);
			String mensaje = resultado > 0 ? "Cliente inhabilitado exitosamente" : "Error al inhabilitar cliente";
			request.getSession().setAttribute("mensaje", mensaje);

		} catch (Exception e) {
			Logger.getLogger(ClienteController.class.getName()).log(Level.SEVERE, null, e);
			request.getSession().setAttribute("mensaje", "Error: " + e.getMessage());
		}
		listar(request, response);
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest(request, response):
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest(request, response);
	}

}
