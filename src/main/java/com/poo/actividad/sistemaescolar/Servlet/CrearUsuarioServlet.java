package com.poo.actividad.sistemaescolar.Servlet;

import com.poo.actividad.sistemaescolar.Controller.UsuarioController;
import com.poo.actividad.sistemaescolar.Model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/crearUsuario")
public class CrearUsuarioServlet extends HttpServlet {
    private UsuarioController usuarioController = new UsuarioController();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/admin/crearUsuario.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String carnet = request.getParameter("carnet");
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String contraseña = request.getParameter("password");
        String rol = request.getParameter("rol");
        String grado = request.getParameter("grado");
        String turno = request.getParameter("turno");

        Usuario usuario = new Usuario();
        usuario.setCarnet(carnet);
        usuario.setNombre(nombre);
        usuario.setEmail(email);
        usuario.setContraseña(contraseña);
        usuario.setRol(rol);
        usuario.setGrado(grado);
        usuario.setTurno(turno);
        usuario.setActivo(true);

        try {
            if (usuarioController.insertarUsuario(usuario)) {
                response.sendRedirect(request.getContextPath() + "/usuarios?success=Usuario creado exitosamente");
            } else {
                request.setAttribute("error", "Error al crear usuario");
                request.getRequestDispatcher("/views/admin/crearUsuario.jsp").forward(request, response);
            }
        } catch (RuntimeException e) {
            // Manejar error de carnet duplicado
            request.setAttribute("error", e.getMessage());
            request.setAttribute("usuario", usuario); // Mantener los datos del formulario
            request.getRequestDispatcher("/views/admin/crearUsuario.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error inesperado: " + e.getMessage());
            request.setAttribute("usuario", usuario); // Mantener los datos del formulario
            request.getRequestDispatcher("/views/admin/crearUsuario.jsp").forward(request, response);
        }
    }
}