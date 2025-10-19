package com.poo.actividad.sistemaescolar.Servlet;

import com.poo.actividad.sistemaescolar.Controller.HorarioController;
import com.poo.actividad.sistemaescolar.Model.Horario;
import com.poo.actividad.sistemaescolar.Model.Grado;
import com.poo.actividad.sistemaescolar.Model.Materia;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/HorarioServlet")
public class HorarioServlet extends HttpServlet {
    private HorarioController controller = new HorarioController();
    private Gson gson = new GsonBuilder()
            .registerTypeAdapter(LocalDate.class, new com.google.gson.JsonSerializer<LocalDate>() {
                @Override
                public com.google.gson.JsonElement serialize(LocalDate src, java.lang.reflect.Type typeOfSrc, com.google.gson.JsonSerializationContext context) {
                    return new com.google.gson.JsonPrimitive(src.toString());
                }
            })
            .create();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();

        try {
            if ("obtenerHorarios".equals(action)) {
                String gradoIdStr = request.getParameter("gradoId");
                if (gradoIdStr != null && !gradoIdStr.isEmpty()) {
                    int gradoId = Integer.parseInt(gradoIdStr);
                    out.print(gson.toJson(controller.obtenerHorariosPorGrado(gradoId)));
                } else {
                    out.print(gson.toJson(controller.obtenerTodosHorarios()));
                }
            } else if ("obtenerGrados".equals(action)) {
                out.print(gson.toJson(controller.obtenerTodosGrados()));
            } else if ("obtenerMaterias".equals(action)) {
                out.print(gson.toJson(controller.obtenerTodasMaterias()));
            } else if ("obtenerHorario".equals(action)) {
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.isEmpty()) {
                    int id = Integer.parseInt(idStr);
                    Horario horario = controller.obtenerHorarioPorId(id); // Corregido el nombre del método
                    out.print(gson.toJson(horario));
                }
            }
        } catch (Exception e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", e.getMessage());
            out.print(gson.toJson(error));
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        Map<String, Object> result = new HashMap<>();

        try {
            if ("crear".equals(action) || "actualizar".equals(action)) {
                Horario horario = new Horario();

                // Si es actualización, establecer el ID
                if ("actualizar".equals(action)) {
                    horario.setId(Integer.parseInt(request.getParameter("id")));
                }

                horario.setGradoId(Integer.parseInt(request.getParameter("gradoId")));
                horario.setMateriaId(Integer.parseInt(request.getParameter("materiaId")));
                horario.setDiaSemana(request.getParameter("diaSemana"));

                // Pasar las horas directamente como String (sin parsear a LocalTime)
                String horaInicioStr = request.getParameter("horaInicio");
                String horaFinStr = request.getParameter("horaFin");

                horario.setHoraInicio(horaInicioStr); // Directamente como String
                horario.setHoraFin(horaFinStr);       // Directamente como String

                horario.setFechaInicio(LocalDate.parse(request.getParameter("fechaInicio")));
                horario.setFechaFin(LocalDate.parse(request.getParameter("fechaFin")));

                boolean success;
                if ("crear".equals(action)) {
                    success = controller.crearHorario(horario);
                    result.put("message", success ? "Horario creado exitosamente" : "Error al crear horario");
                } else {
                    success = controller.actualizarHorario(horario);
                    result.put("message", success ? "Horario actualizado exitosamente" : "Error al actualizar horario");
                }
                result.put("success", success);

            } else if ("eliminar".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean success = controller.eliminarHorario(id);
                result.put("success", success);
                result.put("message", success ? "Horario eliminado exitosamente" : "Error al eliminar horario");
            }

            out.print(gson.toJson(result));

        } catch (DateTimeParseException e) {
            result.put("success", false);
            result.put("message", "Error en el formato de fecha: " + e.getMessage());
            out.print(gson.toJson(result));
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "Error: " + e.getMessage());
            out.print(gson.toJson(result));
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}