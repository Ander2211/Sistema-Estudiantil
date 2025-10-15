package com.poo.actividad.sistemaescolar.Servlet;

import com.poo.actividad.sistemaescolar.Controller.MaestroController;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/eliminarMaestro")
public class EliminarMaestroServlet extends HttpServlet {
    private MaestroController maestroController = new MaestroController();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        if (maestroController.eliminarMaestro(id)) {
            response.sendRedirect(request.getContextPath() + "/maestros?success=Maestro eliminado exitosamente");
        } else {
            response.sendRedirect(request.getContextPath() + "/maestros?error=Error al eliminar maestro");
        }
    }
}