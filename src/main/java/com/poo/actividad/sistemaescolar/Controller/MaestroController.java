package com.poo.actividad.sistemaescolar.Controller;

import com.poo.actividad.sistemaescolar.Model.Maestro;
import com.poo.actividad.sistemaescolar.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MaestroController {

    public List<Maestro> listarMaestros() {
        List<Maestro> maestros = new ArrayList<>();
        String sql = "SELECT * FROM usuario WHERE rol = 'maestro'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Maestro maestro = new Maestro();
                maestro.setId(rs.getInt("id"));
                maestro.setCarnet(rs.getString("carnet"));
                maestro.setNombre(rs.getString("nombre"));
                maestro.setEmail(rs.getString("email"));
                maestro.setContraseña(rs.getString("contraseña"));
                maestro.setActivo(rs.getBoolean("activo"));
                maestros.add(maestro);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return maestros;
    }

    public Maestro obtenerMaestroPorId(int id) {
        Maestro maestro = null;
        String sql = "SELECT * FROM usuario WHERE id = ? AND rol = 'maestro'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    maestro = new Maestro();
                    maestro.setId(rs.getInt("id"));
                    maestro.setCarnet(rs.getString("carnet"));
                    maestro.setNombre(rs.getString("nombre"));
                    maestro.setEmail(rs.getString("email"));
                    maestro.setContraseña(rs.getString("contraseña"));
                    maestro.setActivo(rs.getBoolean("activo"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return maestro;
    }

    public boolean insertarMaestro(Maestro maestro) {
        String sql = "INSERT INTO usuario (carnet, nombre, email, contraseña, rol, activo) VALUES (?, ?, ?, ?, 'maestro', ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, maestro.getCarnet());
            pstmt.setString(2, maestro.getNombre());
            pstmt.setString(3, maestro.getEmail());
            pstmt.setString(4, maestro.getContraseña());
            pstmt.setBoolean(5, maestro.isActivo());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean actualizarMaestro(Maestro maestro) {
        String sql = "UPDATE usuario SET carnet = ?, nombre = ?, email = ?, contraseña = ?, activo = ? WHERE id = ? AND rol = 'maestro'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, maestro.getCarnet());
            pstmt.setString(2, maestro.getNombre());
            pstmt.setString(3, maestro.getEmail());
            pstmt.setString(4, maestro.getContraseña());
            pstmt.setBoolean(5, maestro.isActivo());
            pstmt.setInt(6, maestro.getId());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean eliminarMaestro(int id) {
        String sql = "DELETE FROM usuario WHERE id = ? AND rol = 'maestro'";

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