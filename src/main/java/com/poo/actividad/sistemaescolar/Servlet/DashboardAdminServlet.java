package com.poo.actividad.sistemaescolar.Servlet;

import com.poo.actividad.sistemaescolar.utils.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/admin/dashboard")
public class DashboardAdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener estadísticas reales desde la base de datos
        int totalEstudiantes = getTotalUsuariosPorRol("estudiante");
        int totalMaestros = getTotalUsuariosPorRol("maestro");
        int totalMaterias = getTotalMaterias();
        int totalActividades = getTotalActividades();

        // Establecer atributos para la JSP
        request.setAttribute("totalEstudiantes", totalEstudiantes);
        request.setAttribute("totalMaestros", totalMaestros);
        request.setAttribute("totalMaterias", totalMaterias);
        request.setAttribute("totalActividades", totalActividades);

        // Despachar a la JSP
        request.getRequestDispatcher("/views/admin/dashboardAdmin.jsp").forward(request, response);
    }

    private int getTotalUsuariosPorRol(String rol) {
        int total = 0;
        String sql = "SELECT COUNT(*) as total FROM usuario WHERE rol = ? AND activo = 1";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, rol);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    private int getTotalMaterias() {
        int total = 0;
        String sql = "SELECT COUNT(*) as total FROM materia";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    private int getTotalActividades() {
        int total = 0;
        String sql = "SELECT COUNT(*) as total FROM calendario";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }
}