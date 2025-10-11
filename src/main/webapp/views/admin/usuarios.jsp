<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.poo.actividad.sistemaescolar.Model.Usuario" %>
<%
  List<Usuario> usuarios = (List<Usuario>) request.getAttribute("usuarios");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Gestión de Usuarios</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../common/header.jsp"/>

<div class="container mt-4">
  <h2>Gestión de Usuarios</h2>

  <% if (request.getParameter("success") != null) { %>
  <div class="alert alert-success"><%= request.getParameter("success") %></div>
  <% } %>
  <% if (request.getParameter("error") != null) { %>
  <div class="alert alert-danger"><%= request.getParameter("error") %></div>
  <% } %>

  <a href="${pageContext.request.contextPath}/crearUsuario" class="btn btn-primary mb-3">Crear Usuario</a>

  <table class="table table-striped">
    <thead>
    <tr>
      <th>ID</th>
      <th>Carnet</th>
      <th>Nombre</th>
      <th>Email</th>
      <th>Rol</th>
      <th>Grado</th>
      <th>Turno</th>
      <th>Acciones</th>
    </tr>
    </thead>
    <tbody>
    <% if (usuarios != null) {
      for (Usuario usuario : usuarios) { %>
    <tr>
      <td><%= usuario.getId() %></td>
      <td><%= usuario.getCarnet() %></td>
      <td><%= usuario.getNombre() %></td>
      <td><%= usuario.getEmail() %></td>
      <td><%= usuario.getRol() %></td>
      <td><%= usuario.getGrado() != null ? usuario.getGrado() : "-" %></td>
      <td><%= usuario.getTurno() != null ? usuario.getTurno() : "-" %></td>
      <td>
        <a href="${pageContext.request.contextPath}/editarUsuario?id=<%= usuario.getId() %>" class="btn btn-warning btn-sm">Editar</a>
        <a href="${pageContext.request.contextPath}/eliminarUsuario?id=<%= usuario.getId() %>" class="btn btn-danger btn-sm" onclick="return confirm('¿Estás seguro de eliminar este usuario?')">Eliminar</a>
      </td>
    </tr>
    <% }
    } %>
    </tbody>
  </table>
</div>

</body>
</html>