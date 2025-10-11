package com.poo.actividad.sistemaescolar.Controller;

import com.poo.actividad.sistemaescolar.Model.Evento;
import com.poo.actividad.sistemaescolar.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CalendarioController {

    public List<Evento> obtenerEventos() {
        List<Evento> eventos = new ArrayList<>();
        String sql = "SELECT * FROM calendario";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Evento evento = new Evento();
                evento.setId(rs.getInt("id"));
                evento.setTitulo(rs.getString("titulo"));
                evento.setDescripcion(rs.getString("descripcion"));
                evento.setFecha_inicio(rs.getString("fecha_inicio"));
                evento.setFecha_fin(rs.getString("fecha_fin"));
                evento.setColor(rs.getString("color"));
                eventos.add(evento);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return eventos;
    }

    public boolean agregarEvento(Evento evento) {
        String sql = "INSERT INTO calendario (titulo, descripcion, fecha_inicio, fecha_fin, color) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, evento.getTitulo());
            pstmt.setString(2, evento.getDescripcion());
            pstmt.setString(3, evento.getFecha_inicio());
            pstmt.setString(4, evento.getFecha_fin());
            pstmt.setString(5, evento.getColor());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean actualizarEvento(int id, Evento evento) {
        String sql = "UPDATE calendario SET titulo = ?, descripcion = ?, fecha_inicio = ?, fecha_fin = ?, color = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, evento.getTitulo());
            pstmt.setString(2, evento.getDescripcion());
            pstmt.setString(3, evento.getFecha_inicio());
            pstmt.setString(4, evento.getFecha_fin());
            pstmt.setString(5, evento.getColor());
            pstmt.setInt(6, id);

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean eliminarEvento(int id) {
        String sql = "DELETE FROM calendario WHERE id = ?";

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