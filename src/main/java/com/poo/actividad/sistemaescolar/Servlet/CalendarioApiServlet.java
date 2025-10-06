package com.poo.actividad.sistemaescolar.Servlet;

import com.poo.actividad.sistemaescolar.Controller.CalendarioController;
import com.poo.actividad.sistemaescolar.Model.Evento;
import org.json.JSONArray;
import org.json.JSONObject;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.List;

@WebServlet("/api/calendario/*")
public class CalendarioApiServlet extends HttpServlet {
    private CalendarioController dao = new CalendarioController();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        List<Evento> eventos = dao.obtenerEventos();
        JSONArray arr = new JSONArray();

        for (Evento e : eventos) {
            JSONObject obj = new JSONObject();
            obj.put("id", e.getId());
            obj.put("title", e.getTitulo());
            obj.put("description", e.getDescripcion());
            obj.put("start", e.getFecha_inicio());
            obj.put("end", e.getFecha_fin());
            obj.put("color", e.getColor());
            arr.put(obj);
        }

        resp.setContentType("application/json");
        resp.getWriter().print(arr.toString());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String body = req.getReader().lines().reduce("", (acc, line) -> acc + line);
        JSONObject json = new JSONObject(body);

        Evento e = new Evento();
        e.setTitulo(json.getString("titulo"));
        e.setDescripcion(json.optString("descripcion", ""));
        e.setFecha_inicio(json.getString("fecha_inicio"));
        e.setFecha_fin(json.getString("fecha_fin"));
        e.setColor(json.optString("color", "#3788d8"));

        dao.agregarEvento(e);
        resp.setContentType("application/json");
        resp.getWriter().print("{\"status\":\"ok\"}");
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getPathInfo().substring(1));
        String body = req.getReader().lines().reduce("", (acc, line) -> acc + line);
        JSONObject json = new JSONObject(body);

        Evento e = new Evento();
        e.setTitulo(json.getString("titulo"));
        e.setDescripcion(json.optString("descripcion", ""));
        e.setFecha_inicio(json.getString("fecha_inicio"));
        e.setFecha_fin(json.getString("fecha_fin"));
        e.setColor(json.optString("color", "#3788d8"));

        dao.actualizarEvento(id, e);
        resp.setContentType("application/json");
        resp.getWriter().print("{\"status\":\"ok\"}");
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getPathInfo().substring(1));
        dao.eliminarEvento(id);
        resp.setContentType("application/json");
        resp.getWriter().print("{\"status\":\"ok\"}");
    }
}
