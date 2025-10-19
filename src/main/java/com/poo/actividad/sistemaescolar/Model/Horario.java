package com.poo.actividad.sistemaescolar.Model;

import java.time.LocalDate;
import java.time.LocalTime;

public class Horario {
    private int id;
    private int gradoId;
    private int materiaId;
    private String diaSemana;
    private String horaInicio;  // Mantener como String para compatibilidad
    private String horaFin;     // Mantener como String para compatibilidad
    private LocalDate fechaInicio;
    private LocalDate fechaFin;

    // Campos para nombres
    private String gradoNombre;
    private String gradoTurno;
    private String materiaNombre;

    public Horario() {}

    // Getters y Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getGradoId() { return gradoId; }
    public void setGradoId(int gradoId) { this.gradoId = gradoId; }

    public int getMateriaId() { return materiaId; }
    public void setMateriaId(int materiaId) { this.materiaId = materiaId; }

    public String getDiaSemana() { return diaSemana; }
    public void setDiaSemana(String diaSemana) { this.diaSemana = diaSemana; }

    public String getHoraInicio() { return horaInicio; }
    public void setHoraInicio(String horaInicio) { this.horaInicio = horaInicio; }

    public String getHoraFin() { return horaFin; }
    public void setHoraFin(String horaFin) { this.horaFin = horaFin; }

    public LocalDate getFechaInicio() { return fechaInicio; }
    public void setFechaInicio(LocalDate fechaInicio) { this.fechaInicio = fechaInicio; }

    public LocalDate getFechaFin() { return fechaFin; }
    public void setFechaFin(LocalDate fechaFin) { this.fechaFin = fechaFin; }

    public String getGradoNombre() { return gradoNombre; }
    public void setGradoNombre(String gradoNombre) { this.gradoNombre = gradoNombre; }

    public String getGradoTurno() { return gradoTurno; }
    public void setGradoTurno(String gradoTurno) { this.gradoTurno = gradoTurno; }

    public String getMateriaNombre() { return materiaNombre; }
    public void setMateriaNombre(String materiaNombre) { this.materiaNombre = materiaNombre; }
}