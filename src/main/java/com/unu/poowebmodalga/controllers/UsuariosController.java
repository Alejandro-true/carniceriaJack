package com.unu.poowebmodalga.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.unu.poowebmodalga.beans.Usuario;
import com.unu.poowebmodalga.models.UsuariosModel;

@WebServlet("/UsuariosController")
@MultipartConfig
public class UsuariosController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    UsuariosModel modelo = new UsuariosModel();

    public UsuariosController() {
        super();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String operacion = request.getParameter("op");

        if (operacion == null) {
            listar(request, response);
            return;
        }
        
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
            
        case "cambiarPassword":
            cargarFormularioPassword(request, response);
            break;
            
        case "cambiarPasswordAjax":
            cambiarPassword(request, response);
            break;

        case "eliminar":
            eliminar(request, response);
            break;

        default:
            listar(request, response);
            break;
        }
    }

    private void listar(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.setContentType("text/html; charset=UTF-8");
            request.setAttribute("listaUsuarios", modelo.listarUsuarios());
            request.getRequestDispatcher("/usuarios/listaUsuarios.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            Logger.getLogger(UsuariosController.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    private void cargarFormularioNuevo(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.setContentType("text/html; charset=UTF-8");
            boolean esModal = request.getParameter("modal") != null;
            String jsp = esModal ? "/usuarios/fragments/formNuevo.jsp" : "/usuarios/nuevoUsuario.jsp";
            request.getRequestDispatcher(jsp).forward(request, response);
        } catch (ServletException | IOException e) {
            Logger.getLogger(UsuariosController.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    private void cargarFormularioEditar(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.setContentType("text/html; charset=UTF-8");
            String id = request.getParameter("id");
            Usuario usuario = modelo.obtenerUsuario(Integer.parseInt(id));

            if (usuario != null) {
                request.setAttribute("usuario", usuario);
                boolean esModal = request.getParameter("modal") != null;
                String jsp = esModal ? "/usuarios/fragments/formEditar.jsp" : "/usuarios/editarUsuario.jsp";
                request.getRequestDispatcher(jsp).forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/error404.jsp");
            }
        } catch (Exception e) {
            Logger.getLogger(UsuariosController.class.getName()).log(Level.SEVERE, null, e);
        }
    }
    
    private void cargarFormularioPassword(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.setContentType("text/html; charset=UTF-8");
            String id = request.getParameter("id");
            Usuario usuario = modelo.obtenerUsuario(Integer.parseInt(id));

            if (usuario != null) {
                request.setAttribute("usuario", usuario);
                request.getRequestDispatcher("/usuarios/fragments/formPassword.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/error404.jsp");
            }
        } catch (Exception e) {
            Logger.getLogger(UsuariosController.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    private void insertar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {
        try {
            Usuario usuario = new Usuario();
            usuario.setNombreUsuario(request.getParameter("nombreUsuario"));
            usuario.setContrasena(request.getParameter("password"));
            usuario.setNombreCompleto(request.getParameter("nombreCompleto"));
            usuario.setEmail(request.getParameter("email"));
            usuario.setRol(request.getParameter("rol"));

            int resultado = modelo.insertarUsuario(usuario);

            if (esAjax) {
                enviarJSON(response, resultado > 0,
                        resultado > 0 ? "Usuario registrado exitosamente" : "Error al registrar usuario");
            } else {
                response.setContentType("text/html; charset=UTF-8");
                if (resultado > 0) {
                    request.getSession().setAttribute("mensaje", "Usuario registrado exitosamente");
                } else {
                    request.getSession().setAttribute("mensaje", "Error al registrar usuario");
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

    private void modificar(HttpServletRequest request, HttpServletResponse response, boolean esAjax) {
        try {
            Usuario usuario = new Usuario();
            usuario.setIdUsuario(Integer.parseInt(request.getParameter("id")));
            usuario.setNombreUsuario(request.getParameter("nombreUsuario"));
            usuario.setNombreCompleto(request.getParameter("nombreCompleto"));
            usuario.setEmail(request.getParameter("email"));
            usuario.setRol(request.getParameter("rol"));
            usuario.setEstado(request.getParameter("estado"));

            int resultado = modelo.modificarUsuario(usuario);

            if (esAjax) {
                enviarJSON(response, resultado > 0,
                        resultado > 0 ? "Usuario modificado exitosamente" : "Error al modificar usuario");
            } else {
                response.setContentType("text/html; charset=UTF-8");
                if (resultado > 0) {
                    request.getSession().setAttribute("mensaje", "Usuario modificado exitosamente");
                } else {
                    request.getSession().setAttribute("mensaje", "Error al modificar usuario");
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
    
    private void cambiarPassword(HttpServletRequest request, HttpServletResponse response) {
        try {
            int idUsuario = Integer.parseInt(request.getParameter("id"));
            String passwordNueva = request.getParameter("passwordNueva");

            int resultado = modelo.cambiarPassword(idUsuario, passwordNueva);
            
            enviarJSON(response, resultado > 0,
                    resultado > 0 ? "Contraseña cambiada exitosamente" : "Error al cambiar contraseña");
            
        } catch (Exception e) {
            e.printStackTrace();
            enviarJSON(response, false, "Error: " + e.getMessage());
        }
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.setContentType("text/html; charset=UTF-8");
            int id = Integer.parseInt(request.getParameter("id"));

            int resultado = modelo.eliminarUsuario(id);
            String mensaje = resultado > 0 ? "Usuario eliminado exitosamente" : "Error al eliminar usuario";
            request.getSession().setAttribute("mensaje", mensaje);

        } catch (Exception e) {
            Logger.getLogger(UsuariosController.class.getName()).log(Level.SEVERE, null, e);
            request.getSession().setAttribute("mensaje", "Error: " + e.getMessage());
        }
        listar(request, response);
    }

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