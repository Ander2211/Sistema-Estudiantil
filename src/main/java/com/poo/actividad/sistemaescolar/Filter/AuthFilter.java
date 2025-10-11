package com.poo.actividad.sistemaescolar.Filter;

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
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = requestURI.substring(contextPath.length());

        // Recursos que siempre son públicos
        if (isPublicResource(path)) {
            chain.doFilter(request, response);
            return;
        }

        // Si no hay sesión, redirigir al login
        if (session == null || session.getAttribute("rol") == null) {
            httpResponse.sendRedirect(contextPath + "/views/auth/login.jsp");
            return;
        }

        String rol = (String) session.getAttribute("rol");

        // Verificar acceso según el rol
        if (hasAccess(path, rol)) {
            chain.doFilter(request, response);
        } else {
            httpResponse.sendRedirect(contextPath + "/acceso-denegado.jsp");
        }
    }

    private boolean isPublicResource(String path) {
        return path.equals("/") ||
                path.equals("/index.jsp") ||
                path.equals("/views/auth/login.jsp") ||
                path.equals("/login") ||
                path.equals("/logout") ||
                path.startsWith("/api/") ||
                path.endsWith(".css") ||
                path.endsWith(".js") ||
                path.endsWith(".ico") ||
                path.endsWith(".png") ||
                path.endsWith(".jpg") ||
                path.endsWith(".jsp"); // PERMITIR TODOS LOS JSPs
    }

    private boolean hasAccess(String path, String rol) {
        // Admin tiene acceso a todo
        if ("admin".equals(rol)) {
            return true;
        }

        // Verificar acceso específico por rol
        switch (rol) {
            case "estudiante":
                return path.startsWith("/views/estudiante/") ||
                        path.equals("/estudiante/dashboard") ||
                        path.equals("/views/estudiante/dashboardEstudiante.jsp");
            case "maestro":
                return path.startsWith("/views/maestro/") ||
                        path.equals("/maestro/dashboard") ||
                        path.equals("/views/maestro/dashboardMaestro.jsp");
            default:
                return false;
        }
    }

    @Override
    public void destroy() {
    }
}