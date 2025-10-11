package com.poo.actividad.sistemaescolar.Servlet.API;

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
        String body = readBody(req);
        JSONObject json = new JSONObject(body);

        Evento e = new Evento();
        e.setTitulo(json.getString("title")); // Cambiado de "titulo" a "title"
        e.setDescripcion(json.optString("description", "")); // Cambiado de "descripcion" a "description"
        e.setFecha_inicio(json.getString("start")); // Cambiado de "fecha_inicio" a "start"
        e.setFecha_fin(json.getString("end")); // Cambiado de "fecha_fin" a "end"
        e.setColor(json.optString("color", "#3788d8"));

        dao.agregarEvento(e);
        resp.setContentType("application/json");
        resp.getWriter().print("{\"status\":\"ok\"}");
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
        JSONObject json = new JSONObject(body);

        Evento e = new Evento();
        e.setTitulo(json.getString("title")); // Cambiado de "titulo" a "title"
        e.setDescripcion(json.optString("description", "")); // Cambiado de "descripcion" a "description"
        e.setFecha_inicio(json.getString("start")); // Cambiado de "fecha_inicio" a "start"
        e.setFecha_fin(json.getString("end")); // Cambiado de "fecha_fin" a "end"
        e.setColor(json.optString("color", "#3788d8"));

        dao.actualizarEvento(id, e);
        resp.setContentType("application/json");
        resp.getWriter().print("{\"status\":\"ok\"}");
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String path = req.getPathInfo();
        if (path == null || path.length() < 2) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Falta id");
            return;
        }

        int id = Integer.parseInt(path.substring(1));
        dao.eliminarEvento(id);
        resp.setContentType("application/json");
        resp.getWriter().print("{\"status\":\"ok\"}");
    }

    // Agregar método readBody para leer el contenido del request
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