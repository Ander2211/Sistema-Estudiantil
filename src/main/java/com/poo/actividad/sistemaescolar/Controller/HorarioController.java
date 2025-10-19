package com.poo.actividad.sistemaescolar.Controller;

import com.poo.actividad.sistemaescolar.Model.Horario;
import com.poo.actividad.sistemaescolar.Model.Grado;
import com.poo.actividad.sistemaescolar.Model.Materia;
import com.poo.actividad.sistemaescolar.utils.DBConnection;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class HorarioController {

    public boolean crearHorario(Horario horario) {
        String sql = "INSERT INTO horario (grado_id, materia_id, dia_semana, hora_inicio, hora_fin, fecha_inicio, fecha_fin) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, horario.getGradoId());
            stmt.setInt(2, horario.getMateriaId());
            stmt.setString(3, horario.getDiaSemana());
            stmt.setString(4, horario.getHoraInicio()); // Como String
            stmt.setString(5, horario.getHoraFin());    // Como String
            stmt.setDate(6, Date.valueOf(horario.getFechaInicio()));
            stmt.setDate(7, Date.valueOf(horario.getFechaFin()));

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Horario> obtenerTodosHorarios() {
        List<Horario> horarios = new ArrayList<>();
        String sql = "SELECT h.*, g.nombre as grado_nombre, g.turno as grado_turno, m.nombre as materia_nombre " +
                "FROM horario h " +
                "JOIN grado g ON h.grado_id = g.id " +
                "JOIN materia m ON h.materia_id = m.id";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Horario horario = mapearHorario(rs);
                horarios.add(horario);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return horarios;
    }

    public List<Horario> obtenerHorariosPorGrado(int gradoId) {
        List<Horario> horarios = new ArrayList<>();
        String sql = "SELECT h.*, g.nombre as grado_nombre, g.turno as grado_turno, m.nombre as materia_nombre " +
                "FROM horario h " +
                "JOIN grado g ON h.grado_id = g.id " +
                "JOIN materia m ON h.materia_id = m.id " +
                "WHERE h.grado_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, gradoId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Horario horario = mapearHorario(rs);
                horarios.add(horario);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return horarios;
    }

    public Horario obtenerHorarioPorId(int id) { // Nombre del método corregido
        String sql = "SELECT h.*, g.nombre as grado_nombre, g.turno as grado_turno, m.nombre as materia_nombre " +
                "FROM horario h " +
                "JOIN grado g ON h.grado_id = g.id " +
                "JOIN materia m ON h.materia_id = m.id " +
                "WHERE h.id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapearHorario(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean actualizarHorario(Horario horario) {
        String sql = "UPDATE horario SET grado_id=?, materia_id=?, dia_semana=?, hora_inicio=?, hora_fin=?, fecha_inicio=?, fecha_fin=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, horario.getGradoId());
            stmt.setInt(2, horario.getMateriaId());
            stmt.setString(3, horario.getDiaSemana());
            stmt.setString(4, horario.getHoraInicio()); // Como String
            stmt.setString(5, horario.getHoraFin());    // Como String
            stmt.setDate(6, Date.valueOf(horario.getFechaInicio()));
            stmt.setDate(7, Date.valueOf(horario.getFechaFin()));
            stmt.setInt(8, horario.getId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean eliminarHorario(int id) {
        String sql = "DELETE FROM horario WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Grado> obtenerTodosGrados() {
        List<Grado> grados = new ArrayList<>();
        String sql = "SELECT * FROM grado ORDER BY nombre, turno";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Grado grado = new Grado();
                grado.setId(rs.getInt("id"));
                grado.setNombre(rs.getString("nombre"));
                grado.setTurno(rs.getString("turno"));
                grados.add(grado);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return grados;
    }

    public List<Materia> obtenerTodasMaterias() {
        List<Materia> materias = new ArrayList<>();
        String sql = "SELECT * FROM materia ORDER BY nombre";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Materia materia = new Materia();
                materia.setId(rs.getInt("id"));
                materia.setNombre(rs.getString("nombre"));
                materia.setDescripcion(rs.getString("descripcion"));
                materias.add(materia);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return materias;
    }

    private Horario mapearHorario(ResultSet rs) throws SQLException {
        Horario horario = new Horario();
        horario.setId(rs.getInt("id"));
        horario.setGradoId(rs.getInt("grado_id"));
        horario.setMateriaId(rs.getInt("materia_id"));
        horario.setDiaSemana(rs.getString("dia_semana"));

        // Mantener como String directamente
        horario.setHoraInicio(rs.getString("hora_inicio"));
        horario.setHoraFin(rs.getString("hora_fin"));

        Date fechaInicio = rs.getDate("fecha_inicio");
        Date fechaFin = rs.getDate("fecha_fin");
        if (fechaInicio != null) horario.setFechaInicio(fechaInicio.toLocalDate());
        if (fechaFin != null) horario.setFechaFin(fechaFin.toLocalDate());

        horario.setGradoNombre(rs.getString("grado_nombre"));
        horario.setGradoTurno(rs.getString("grado_turno"));
        horario.setMateriaNombre(rs.getString("materia_nombre"));

        return horario;
    }
}