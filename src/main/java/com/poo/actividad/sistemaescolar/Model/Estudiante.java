package com.poo.actividad.sistemaescolar.Model;

public class Estudiante {
    private int id;
    private String nombre;
    private String email;
    private Integer gradoId;

    public Estudiante(){}

    public Estudiante(int id, String nombre, String email, Integer gradoId) {
        this.id = id;
        this.nombre = nombre;
        this.email = email;
        this.gradoId = gradoId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getGradoId() {
        return gradoId;
    }

    public void setGradoId(Integer gradoId) {
        this.gradoId = gradoId;
    }
}