package com.poo.actividad.sistemaescolar.Controller;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.poo.actividad.sistemaescolar.utils.DBConnection;
import com.poo.actividad.sistemaescolar.Model.Horario;

public class HorarioController {

    public List<Horario> listar() {
        List<Horario> list = new ArrayList<>();
        String sql = "SELECT * FROM horario";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Horario h = new Horario();
                h.setId(rs.getInt("id"));
                h.setGradoId(rs.getInt("grado_id"));
                h.setMateriaId(rs.getInt("materia_id"));
                h.setDiaSemana(rs.getString("dia_semana"));
                h.setHoraInicio(rs.getString("hora_inicio"));
                h.setHoraFin(rs.getString("hora_fin"));
                list.add(h);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public Horario obtener(int id) {
        String sql = "SELECT * FROM horario WHERE id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Horario h = new Horario();
                    h.setId(rs.getInt("id"));
                    h.setGradoId(rs.getInt("grado_id"));
                    h.setMateriaId(rs.getInt("materia_id"));
                    h.setDiaSemana(rs.getString("dia_semana"));
                    h.setHoraInicio(rs.getString("hora_inicio"));
                    h.setHoraFin(rs.getString("hora_fin"));
                    return h;
                }
            }
        } catch (Exception ex) { ex.printStackTrace(); }
        return null;
    }

    public void insertar(Horario h) {
        String sql = "INSERT INTO horario(grado_id, materia_id, dia_semana, hora_inicio, hora_fin) VALUES (?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, h.getGradoId());
            ps.setInt(2, h.getMateriaId());
            ps.setString(3, h.getDiaSemana());
            ps.setString(4, h.getHoraInicio());
            ps.setString(5, h.getHoraFin());
            ps.executeUpdate();
        } catch (Exception ex) { ex.printStackTrace(); }
    }

    public void actualizar(Horario h) {
        String sql = "UPDATE horario SET grado_id=?, materia_id=?, dia_semana=?, hora_inicio=?, hora_fin=? WHERE id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, h.getGradoId());
            ps.setInt(2, h.getMateriaId());
            ps.setString(3, h.getDiaSemana());
            ps.setString(4, h.getHoraInicio());
            ps.setString(5, h.getHoraFin());
            ps.setInt(6, h.getId());
            ps.executeUpdate();
        } catch (Exception ex) { ex.printStackTrace(); }
    }

    public void eliminar(int id) {
        String sql = "DELETE FROM horario WHERE id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception ex) { ex.printStackTrace(); }
    }
}
