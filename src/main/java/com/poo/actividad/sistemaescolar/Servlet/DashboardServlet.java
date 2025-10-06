package com.poo.actividad.sistemaescolar.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("rol") == null) {
            response.sendRedirect(request.getContextPath() + "/views/auth/login.jsp");
            return;
        }

        String rol = (String) session.getAttribute("rol");
        String dashboardPath;

        // Seleccionar el dashboard según el rol
        switch (rol) {
            case "admin":
                dashboardPath = "/WEB-INF/views/admin/dashboardAdmin.jsp";
                break;
            case "maestro":
                dashboardPath = "/WEB-INF/views/maestro/dashboardMaestro.jsp";
                break;
            case "estudiante":
                dashboardPath = "/WEB-INF/views/estudiante/dashboardEstudiante.jsp";
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/acceso-denegado.jsp");
                return;
        }

        request.getRequestDispatcher(dashboardPath).forward(request, response);
    }
}
