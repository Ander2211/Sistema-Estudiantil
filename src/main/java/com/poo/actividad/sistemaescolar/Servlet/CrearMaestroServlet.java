package com.poo.actividad.sistemaescolar.Servlet;

import com.poo.actividad.sistemaescolar.Controller.MaestroController;
import com.poo.actividad.sistemaescolar.Model.Maestro;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/crearMaestro")
public class CrearMaestroServlet extends HttpServlet {
    private MaestroController maestroController = new MaestroController();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/admin/crearMaestro.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String carnet = request.getParameter("carnet");
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String contraseña = request.getParameter("password");

        Maestro maestro = new Maestro();
        maestro.setCarnet(carnet);
        maestro.setNombre(nombre);
        maestro.setEmail(email);
        maestro.setContraseña(contraseña);
        maestro.setActivo(true);

        if (maestroController.insertarMaestro(maestro)) {
            response.sendRedirect(request.getContextPath() + "/maestros?success=Maestro creado exitosamente");
        } else {
            response.sendRedirect(request.getContextPath() + "/crearMaestro?error=Error al crear maestro");
        }
    }
}