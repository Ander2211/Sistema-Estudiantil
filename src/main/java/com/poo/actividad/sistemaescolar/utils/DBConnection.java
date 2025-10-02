package com.poo.actividad.sistemaescolar.utils;


import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/sistema_gestion_academica"; // cambia si tu BD es distinta
    private static final String USER = "root"; // cambia si tu usuario es distinto
    private static final String PASSWORD = "123"; // cambia si tienes password

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
