package com.unu.poowebmodalga.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import com.unu.poowebmodalga.beans.Usuario;
import com.unu.poowebmodalga.models.UsuariosModel;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    UsuariosModel modelo = new UsuariosModel();

    public LoginController() {
        super();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if (accion == null) {
            mostrarLogin(request, response);
            return;
        }
        
        switch (accion) {
            case "login":
                autenticar(request, response);
                break;
            case "logout":
                cerrarSesion(request, response);
                break;
            default:
                mostrarLogin(request, response);
                break;
        }
    }

    /**
     * Muestra el formulario de login
     */
    private void mostrarLogin(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.getRequestDispatcher("/auth/login.jsp").forward(request, response);
    }

    private void autenticar(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String nombreUsuario = request.getParameter("usuario");
        String password = request.getParameter("password");
        
        // Validar campos vacíos
        if (nombreUsuario == null || nombreUsuario.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Por favor complete todos los campos");
            mostrarLogin(request, response);
            return;
        }
        
        // Autenticar usuario
        Usuario usuario = modelo.autenticarUsuario(nombreUsuario, password);
        
        if (usuario != null) {
            // Usuario autenticado correctamente
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);
            session.setAttribute("nombreUsuario", usuario.getNombreUsuario());
            session.setAttribute("nombreCompleto", usuario.getNombreCompleto());
            session.setAttribute("rol", usuario.getRol());
            session.setAttribute("idUsuario", usuario.getIdUsuario());
            
            // Redireccionar al inicio
            response.sendRedirect(request.getContextPath() + "/inicio.jsp");
        } else {
            // Credenciales incorrectas
            request.setAttribute("error", "Usuario o contraseña incorrectos");
            mostrarLogin(request, response);
        }
    }

    /**
     * Cierra la sesión del usuario
     */
    private void cerrarSesion(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        
        response.sendRedirect(request.getContextPath() + "/LoginController");
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