package com.poo.actividad.sistemaescolar.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/sistema_gestion_academica";
    private static final String USER = "root";
    private static final String PASS = "";  // Contraseña vacía para WAMP

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASS);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver no encontrado.", e);
        } catch (SQLException e) {
            throw new SQLException("Error al conectar a la base de datos: " + e.getMessage(), e);
        }
    }
}
