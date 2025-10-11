package com.poo.actividad.sistemaescolar.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String carnet = request.getParameter("carnet");
        String password = request.getParameter("password");

        try (Connection conn = com.poo.actividad.sistemaescolar.utils.DBConnection.getConnection()) {
            String query = "SELECT * FROM usuario WHERE carnet = ? AND contraseña = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, carnet);
                pstmt.setString(2, password);

                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next()) {
                        String nombre = rs.getString("nombre");
                        String rol = rs.getString("rol");
                        String displayName = "";

                        // Formatear el nombre según el rol
                        switch (rol) {
                            case "estudiante":
                                displayName = "Estudiante: " + nombre;
                                break;
                            case "maestro":
                                displayName = "Docente: " + nombre;
                                break;
                            case "admin":
                                displayName = "Admin: " + nombre;
                                break;
                        }

                        // Establecer atributos de sesión
                        HttpSession session = request.getSession();
                        session.setAttribute("nombre", nombre);
                        session.setAttribute("displayName", displayName);
                        session.setAttribute("rol", rol);
                        session.setAttribute("carnet", carnet);

                        // REDIRECCIÓN DIRECTA SEGÚN ROL
                        String redirectPath = request.getContextPath();
                        switch (rol) {
                            case "admin":
                                redirectPath += "/admin/dashboard";
                                break;
                            case "maestro":
                                redirectPath += "/maestro/dashboard";
                                break;
                            case "estudiante":
                                redirectPath += "/estudiante/dashboard";
                                break;
                            default:
                                redirectPath += "/dashboard";
                        }

                        response.sendRedirect(redirectPath);

                    } else {
                        request.setAttribute("error", "Carnet o contraseña incorrectos");
                        request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
                    }
                }
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Error de conexión: " + e.getMessage());
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
        }
    }
}