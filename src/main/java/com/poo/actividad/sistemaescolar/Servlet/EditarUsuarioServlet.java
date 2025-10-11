package com.poo.actividad.sistemaescolar.Servlet;

import com.poo.actividad.sistemaescolar.Controller.UsuarioController;
import com.poo.actividad.sistemaescolar.Model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/editarUsuario")
public class EditarUsuarioServlet extends HttpServlet {
    private UsuarioController usuarioController = new UsuarioController();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Usuario usuario = usuarioController.obtenerUsuarioPorId(id);
        request.setAttribute("usuario", usuario);
        request.getRequestDispatcher("/views/admin/editarUsuario.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String carnet = request.getParameter("carnet");
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String contraseña = request.getParameter("password");
        String rol = request.getParameter("rol");
        String grado = request.getParameter("grado");
        String turno = request.getParameter("turno");

        Usuario usuario = new Usuario();
        usuario.setId(id);
        usuario.setCarnet(carnet);
        usuario.setNombre(nombre);
        usuario.setEmail(email);
        usuario.setContraseña(contraseña);
        usuario.setRol(rol);
        usuario.setGrado(grado);
        usuario.setTurno(turno);
        usuario.setActivo(true);

        if (usuarioController.actualizarUsuario(usuario)) {
            response.sendRedirect(request.getContextPath() + "/usuarios?success=Usuario actualizado exitosamente");
        } else {
            response.sendRedirect(request.getContextPath() + "/editarUsuario?id=" + id + "&error=Error al actualizar usuario");
        }
    }
}