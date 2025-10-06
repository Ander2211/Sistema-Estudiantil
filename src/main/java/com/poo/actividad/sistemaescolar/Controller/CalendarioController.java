package com.poo.actividad.sistemaescolar.Controller;



import com.poo.actividad.sistemaescolar.Model.Evento;
import com.poo.actividad.sistemaescolar.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CalendarioController {

    public List<Evento> obtenerEventos() {
        List<Evento> lista = new ArrayList<>();
        String sql = "SELECT * FROM calendario";

        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Evento e = new Evento(
                        rs.getInt("id"),
                        rs.getString("titulo"),
                        rs.getString("descripcion"),
                        rs.getString("fecha_inicio"),
                        rs.getString("fecha_fin"),
                        rs.getString("color")
                );
                lista.add(e);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    public void agregarEvento(Evento e) {
        String sql = "INSERT INTO calendario (titulo, descripcion, fecha_inicio, fecha_fin, color) VALUES (?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, e.getTitulo());
            ps.setString(2, e.getDescripcion());
            ps.setString(3, e.getFecha_inicio());
            ps.setString(4, e.getFecha_fin());
            ps.setString(5, e.getColor());
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void actualizarEvento(int id, Evento e) {
        String sql = "UPDATE calendario SET titulo=?, descripcion=?, fecha_inicio=?, fecha_fin=?, color=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, e.getTitulo());
            ps.setString(2, e.getDescripcion());
            ps.setString(3, e.getFecha_inicio());
            ps.setString(4, e.getFecha_fin());
            ps.setString(5, e.getColor());
            ps.setInt(6, id);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public void eliminarEvento(int id) {
        String sql = "DELETE FROM calendario WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}

