package com.poo.actividad.sistemaescolar.Servlet.API;

import com.poo.actividad.sistemaescolar.Controller.HorarioController;
import com.poo.actividad.sistemaescolar.Model.Horario;
import org.json.JSONArray;
import org.json.JSONObject;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;

@WebServlet("/api/horarios/*")
public class HorarioApiServlet extends HttpServlet {
    private HorarioController dao = new HorarioController();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        List<Horario> horarios = dao.listar();
        JSONArray arr = new JSONArray();

        for (Horario h : horarios) {
            JSONObject ev = new JSONObject();
            ev.put("id", h.getId());
            ev.put("title", "Grado " + h.getGradoId() + " • Materia " + h.getMateriaId());

            int dow = switch (h.getDiaSemana()) {
                case "Lunes" -> 1;
                case "Martes" -> 2;
                case "Miércoles" -> 3;
                case "Jueves" -> 4;
                case "Viernes" -> 5;
                default -> 1;
            };

            JSONArray days = new JSONArray();
            days.put(dow);
            ev.put("daysOfWeek", days);
            ev.put("startTime", h.getHoraInicio());
            ev.put("endTime", h.getHoraFin());
            ev.put("extendedProps", new JSONObject()
                    .put("gradoId", h.getGradoId())
                    .put("materiaId", h.getMateriaId())
            );
            arr.put(ev);
        }

        resp.getWriter().print(arr.toString());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String body = readBody(req);
        JSONObject j = new JSONObject(body);

        Horario h = new Horario();
        h.setGradoId(j.getInt("gradoId"));
        h.setMateriaId(j.getInt("materiaId"));
        h.setDiaSemana(j.getString("diaSemana"));
        h.setHoraInicio(j.getString("horaInicio"));
        h.setHoraFin(j.getString("horaFin"));

        dao.insertar(h);

        resp.setContentType("application/json");
        resp.getWriter().print(new JSONObject().put("status", "ok").toString());
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String path = req.getPathInfo();
        if (path == null || path.length() < 2) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Falta id");
            return;
        }

        int id = Integer.parseInt(path.substring(1));
        String body = readBody(req);
        JSONObject j = new JSONObject(body);

        Horario h = new Horario();
        h.setId(id);
        h.setGradoId(j.getInt("gradoId"));
        h.setMateriaId(j.getInt("materiaId"));
        h.setDiaSemana(j.getString("diaSemana"));
        h.setHoraInicio(j.getString("horaInicio"));
        h.setHoraFin(j.getString("horaFin"));

        dao.actualizar(h);

        resp.setContentType("application/json");
        resp.getWriter().print(new JSONObject().put("status", "ok").toString());
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String path = req.getPathInfo();
        if (path == null || path.length() < 2) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Falta id");
            return;
        }

        int id = Integer.parseInt(path.substring(1));
        dao.eliminar(id);

        resp.setContentType("application/json");
        resp.getWriter().print(new JSONObject().put("status", "ok").toString());
    }

    private String readBody(HttpServletRequest req) throws IOException {
        StringBuilder sb = new StringBuilder();
        try (BufferedReader br = req.getReader()) {
            String line;
            while((line = br.readLine()) != null) {
                sb.append(line);
            }
        }
        return sb.toString();
    }

}
