package com.poo.actividad.sistemaescolar.Servlet;

import com.poo.actividad.sistemaescolar.Controller.UsuarioController;
import com.poo.actividad.sistemaescolar.Model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/usuarios")
public class UsuarioServlet extends HttpServlet {
    private UsuarioController usuarioController = new UsuarioController();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Usuario> listaUsuarios = usuarioController.listarUsuarios();

        // Aplicar filtros si existen
        String searchTerm = request.getParameter("search");
        String roleFilter = request.getParameter("role");
        String statusFilter = request.getParameter("status");

        if ((searchTerm != null && !searchTerm.isEmpty()) ||
                (roleFilter != null && !roleFilter.isEmpty()) ||
                (statusFilter != null && !statusFilter.isEmpty())) {

            listaUsuarios = filtrarUsuarios(listaUsuarios, searchTerm, roleFilter, statusFilter);
        }

        request.setAttribute("usuarios", listaUsuarios);
        request.getRequestDispatcher("/views/admin/usuarios.jsp").forward(request, response);
    }

    private List<Usuario> filtrarUsuarios(List<Usuario> usuarios, String searchTerm, String roleFilter, String statusFilter) {
        return usuarios.stream()
                .filter(usuario -> {
                    // Filtro por término de búsqueda
                    if (searchTerm != null && !searchTerm.isEmpty()) {
                        String searchLower = searchTerm.toLowerCase();
                        boolean matchesSearch =
                                (usuario.getNombre() != null && usuario.getNombre().toLowerCase().contains(searchLower)) ||
                                        (usuario.getCarnet() != null && usuario.getCarnet().toLowerCase().contains(searchLower)) ||
                                        (usuario.getEmail() != null && usuario.getEmail().toLowerCase().contains(searchLower));
                        if (!matchesSearch) return false;
                    }

                    // Filtro por rol
                    if (roleFilter != null && !roleFilter.isEmpty()) {
                        if (!roleFilter.equals(usuario.getRol())) return false;
                    }

                    // Filtro por estado
                    if (statusFilter != null && !statusFilter.isEmpty()) {
                        boolean isActive = statusFilter.equals("activo");
                        if (usuario.isActivo() != isActive) return false;
                    }

                    return true;
                })
                .collect(Collectors.toList());
    }
}