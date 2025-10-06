package com.poo.actividad.sistemaescolar.Model;


public class Evento {
    private int id;
    private String titulo;
    private String descripcion;
    private String fecha_inicio;
    private String fecha_fin;
    private String color;

    public Evento() {}

    public Evento(int id, String titulo, String descripcion, String fecha_inicio, String fecha_fin, String color) {
        this.id = id;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.fecha_inicio = fecha_inicio;
        this.fecha_fin = fecha_fin;
        this.color = color;
    }

    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public String getFecha_inicio() { return fecha_inicio; }
    public void setFecha_inicio(String fecha_inicio) { this.fecha_inicio = fecha_inicio; }

    public String getFecha_fin() { return fecha_fin; }
    public void setFecha_fin(String fecha_fin) { this.fecha_fin = fecha_fin; }

    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
}
