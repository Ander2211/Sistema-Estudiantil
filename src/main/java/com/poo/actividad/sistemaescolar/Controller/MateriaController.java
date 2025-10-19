package com.poo.actividad.sistemaescolar.Controller;

import com.poo.actividad.sistemaescolar.Model.Materia;
import com.poo.actividad.sistemaescolar.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MateriaController {
    public List<Materia> listar() {
        List<Materia> materias = new ArrayList<>();
        String sql = "SELECT id, nombre FROM materia";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Materia materia = new Materia();
                materia.setId(rs.getInt("id"));
                materia.setNombre(rs.getString("nombre"));
                materias.add(materia);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return materias;
    }
}

