package com.poo.actividad.sistemaescolar.Controller;


import com.poo.actividad.sistemaescolar.Model.Usuario;
import com.poo.actividad.sistemaescolar.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioController {

    public List<Usuario> listarUsuarios() {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM usuario";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setCarnet(rs.getString("carnet"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setEmail(rs.getString("email"));
                usuario.setContraseña(rs.getString("contraseña"));
                usuario.setRol(rs.getString("rol"));
                usuario.setGrado(rs.getString("grado"));
                usuario.setTurno(rs.getString("turno"));
                usuario.setActivo(rs.getBoolean("activo"));
                usuarios.add(usuario);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuarios;
    }

    public Usuario obtenerUsuarioPorId(int id) {
        Usuario usuario = null;
        String sql = "SELECT * FROM usuario WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    usuario = new Usuario();
                    usuario.setId(rs.getInt("id"));
                    usuario.setCarnet(rs.getString("carnet"));
                    usuario.setNombre(rs.getString("nombre"));
                    usuario.setEmail(rs.getString("email"));
                    usuario.setContraseña(rs.getString("contraseña"));
                    usuario.setRol(rs.getString("rol"));
                    usuario.setGrado(rs.getString("grado"));
                    usuario.setTurno(rs.getString("turno"));
                    usuario.setActivo(rs.getBoolean("activo"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuario;
    }

    public boolean insertarUsuario(Usuario usuario) {
        String sql = "INSERT INTO usuario (carnet, nombre, email, contraseña, rol, grado, turno, activo) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, usuario.getCarnet());
            pstmt.setString(2, usuario.getNombre());
            pstmt.setString(3, usuario.getEmail());
            pstmt.setString(4, usuario.getContraseña());
            pstmt.setString(5, usuario.getRol());
            pstmt.setString(6, usuario.getGrado());
            pstmt.setString(7, usuario.getTurno());
            pstmt.setBoolean(8, usuario.isActivo());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean actualizarUsuario(Usuario usuario) {
        String sql = "UPDATE usuario SET carnet = ?, nombre = ?, email = ?, contraseña = ?, rol = ?, grado = ?, turno = ?, activo = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, usuario.getCarnet());
            pstmt.setString(2, usuario.getNombre());
            pstmt.setString(3, usuario.getEmail());
            pstmt.setString(4, usuario.getContraseña());
            pstmt.setString(5, usuario.getRol());
            pstmt.setString(6, usuario.getGrado());
            pstmt.setString(7, usuario.getTurno());
            pstmt.setBoolean(8, usuario.isActivo());
            pstmt.setInt(9, usuario.getId());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean eliminarUsuario(int id) {
        String sql = "DELETE FROM usuario WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}