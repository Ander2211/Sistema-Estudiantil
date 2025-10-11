<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.poo.actividad.sistemaescolar.Model.Usuario" %>
<%
  Usuario usuario = (Usuario) request.getAttribute("usuario");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Editar Usuario</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../common/header.jsp"/>

<div class="container mt-4">
  <h2>Editar Usuario</h2>

  <% if (request.getParameter("error") != null) { %>
  <div class="alert alert-danger"><%= request.getParameter("error") %></div>
  <% } %>

  <form action="${pageContext.request.contextPath}/editarUsuario" method="post">
    <input type="hidden" name="id" value="<%= usuario.getId() %>">
    <div class="mb-3">
      <label for="carnet" class="form-label">Carnet</label>
      <input type="text" class="form-control" id="carnet" name="carnet" value="<%= usuario.getCarnet() %>" required>
    </div>
    <div class="mb-3">
      <label for="nombre" class="form-label">Nombre Completo</label>
      <input type="text" class="form-control" id="nombre" name="nombre" value="<%= usuario.getNombre() %>" required>
    </div>
    <div class="mb-3">
      <label for="email" class="form-label">Correo electrónico</label>
      <input type="email" class="form-control" id="email" name="email" value="<%= usuario.getEmail() %>" >
    </div>
    <div class="mb-3">
      <label for="password" class="form-label">Contraseña</label>
      <input type="password" class="form-control" id="password" name="password" value="<%= usuario.getContraseña() %>" required>
    </div>
    <div class="mb-3">
      <label for="rol" class="form-label">Rol</label>
      <select class="form-select" id="rol" name="rol" required onchange="toggleGradoTurno()">
        <option value="estudiante" <%= "estudiante".equals(usuario.getRol()) ? "selected" : "" %>>Estudiante</option>
        <option value="maestro" <%= "maestro".equals(usuario.getRol()) ? "selected" : "" %>>Maestro</option>
        <option value="admin" <%= "admin".equals(usuario.getRol()) ? "selected" : "" %>>Administrador</option>
      </select>
    </div>
    <div class="mb-3" id="gradoField">
      <label for="grado" class="form-label">Grado</label>
      <select class="form-select" id="grado" name="grado">
        <option value="">Seleccionar grado</option>
        <option value="Primero" <%= "Primero".equals(usuario.getGrado()) ? "selected" : "" %>>Primero</option>
        <option value="Segundo" <%= "Segundo".equals(usuario.getGrado()) ? "selected" : "" %>>Segundo</option>
        <option value="Tercero" <%= "Tercero".equals(usuario.getGrado()) ? "selected" : "" %>>Tercero</option>
        <option value="Cuarto" <%= "Cuarto".equals(usuario.getGrado()) ? "selected" : "" %>>Cuarto</option>
        <option value="Quinto" <%= "Quinto".equals(usuario.getGrado()) ? "selected" : "" %>>Quinto</option>
      </select>
    </div>
    <div class="mb-3" id="turnoField">
      <label for="turno" class="form-label">Turno</label>
      <select class="form-select" id="turno" name="turno">
        <option value="">Seleccionar turno</option>
        <option value="mañana" <%= "mañana".equals(usuario.getTurno()) ? "selected" : "" %>>Mañana</option>
        <option value="tarde" <%= "tarde".equals(usuario.getTurno()) ? "selected" : "" %>>Tarde</option>
      </select>
    </div>
    <button type="submit" class="btn btn-success">Actualizar Usuario</button>
    <a href="${pageContext.request.contextPath}/usuarios" class="btn btn-secondary">Cancelar</a>
  </form>
</div>

<script>
  function toggleGradoTurno() {
    const rol = document.getElementById('rol').value;
    const gradoField = document.getElementById('gradoField');
    const turnoField = document.getElementById('turnoField');

    if (rol === 'estudiante') {
      gradoField.style.display = 'block';
      turnoField.style.display = 'block';
    } else {
      gradoField.style.display = 'none';
      turnoField.style.display = 'none';
    }
  }

  // Ejecutar al cargar la página
  document.addEventListener('DOMContentLoaded', toggleGradoTurno);
</script>

</body>
</html>