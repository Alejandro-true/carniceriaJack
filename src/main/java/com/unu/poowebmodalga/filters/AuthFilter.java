package com.unu.poowebmodalga.filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Inicialización si es necesaria
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String uri = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        
        // Recursos públicos que no requieren autenticación
        boolean esRecursoPublico = uri.endsWith("LoginController") ||
                                   uri.endsWith("login.jsp") ||
                                   uri.endsWith(".css") ||
                                   uri.endsWith(".js") ||
                                   uri.endsWith(".png") ||
                                   uri.endsWith(".jpg") ||
                                   uri.endsWith(".jpeg") ||
                                   uri.endsWith(".gif") ||
                                   uri.endsWith(".ico") ||
                                   uri.equals(contextPath + "/") ||
                                   uri.equals(contextPath);
        
        // Si es un recurso público, permitir el acceso
        if (esRecursoPublico) {
            chain.doFilter(request, response);
            return;
        }
        
        // Verificar si hay sesión activa
        HttpSession session = httpRequest.getSession(false);
        boolean usuarioLogueado = (session != null && session.getAttribute("usuario") != null);
        
        if (usuarioLogueado) {
            // Usuario autenticado, continuar con la petición
            chain.doFilter(request, response);
        } else {
            // Usuario no autenticado, redirigir al login
            httpResponse.sendRedirect(contextPath + "/LoginController");
        }
    }

    @Override
    public void destroy() {
        // Limpieza si es necesaria
    }
}