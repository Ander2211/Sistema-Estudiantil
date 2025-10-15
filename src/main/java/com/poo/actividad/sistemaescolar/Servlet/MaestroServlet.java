package com.poo.actividad.sistemaescolar.Servlet;

import com.poo.actividad.sistemaescolar.Controller.MaestroController;
import com.poo.actividad.sistemaescolar.Model.Maestro;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/maestros")
public class MaestroServlet extends HttpServlet {
    private MaestroController maestroController = new MaestroController();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Maestro> listaMaestros = maestroController.listarMaestros();
        request.setAttribute("maestros", listaMaestros);
        request.getRequestDispatcher("/views/admin/maestros.jsp").forward(request, response);
    }
}