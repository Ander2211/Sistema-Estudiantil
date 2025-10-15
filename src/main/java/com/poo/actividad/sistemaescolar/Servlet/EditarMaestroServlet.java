package com.poo.actividad.sistemaescolar.Servlet;

import com.poo.actividad.sistemaescolar.Controller.MaestroController;
import com.poo.actividad.sistemaescolar.Model.Maestro;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/editarMaestro")
public class EditarMaestroServlet extends HttpServlet {
    private MaestroController maestroController = new MaestroController();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Maestro maestro = maestroController.obtenerMaestroPorId(id);
        request.setAttribute("maestro", maestro);
        request.getRequestDispatcher("/views/admin/editarMaestro.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String carnet = request.getParameter("carnet");
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String contraseña = request.getParameter("password");

        Maestro maestro = new Maestro();
        maestro.setId(id);
        maestro.setCarnet(carnet);
        maestro.setNombre(nombre);
        maestro.setEmail(email);
        maestro.setContraseña(contraseña);
        maestro.setActivo(true);

        if (maestroController.actualizarMaestro(maestro)) {
            response.sendRedirect(request.getContextPath() + "/maestros?success=Maestro actualizado exitosamente");
        } else {
            response.sendRedirect(request.getContextPath() + "/editarMaestro?id=" + id + "&error=Error al actualizar maestro");
        }
    }
}