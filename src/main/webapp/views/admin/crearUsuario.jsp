<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Crear Usuario</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../common/header.jsp"/>

<div class="container mt-4">
  <h2>Crear Usuario</h2>

  <% if (request.getParameter("error") != null) { %>
  <div class="alert alert-danger"><%= request.getParameter("error") %></div>
  <% } %>

  <form action="${pageContext.request.contextPath}/crearUsuario" method="post">
    <div class="mb-3">
      <label for="carnet" class="form-label">Carnet</label>
      <input type="text" class="form-control" id="carnet" name="carnet" required>
    </div>
    <div class="mb-3">
      <label for="nombre" class="form-label">Nombre Completo</label>
      <input type="text" class="form-control" id="nombre" name="nombre" required>
    </div>
    <div class="mb-3">
      <label for="email" class="form-label">Correo electrónico</label>
      <input type="email" class="form-control" id="email" name="email" >
    </div>
    <div class="mb-3">
      <label for="password" class="form-label">Contraseña</label>
      <input type="password" class="form-control" id="password" name="password" required>
    </div>
    <div class="mb-3">
      <label for="rol" class="form-label">Rol</label>
      <select class="form-select" id="rol" name="rol" required onchange="toggleGradoTurno()">
        <option value="estudiante">Estudiante</option>
        <option value="maestro">Maestro</option>
        <option value="admin">Administrador</option>
      </select>
    </div>
    <div class="mb-3" id="gradoField">
      <label for="grado" class="form-label">Grado</label>
      <select class="form-select" id="grado" name="grado">
        <option value="">Seleccionar grado</option>
        <option value="Primero">Primero</option>
        <option value="Segundo">Segundo</option>
        <option value="Tercero">Tercero</option>
        <option value="Cuarto">Cuarto</option>
        <option value="Quinto">Quinto</option>
      </select>
    </div>
    <div class="mb-3" id="turnoField">
      <label for="turno" class="form-label">Turno</label>
      <select class="form-select" id="turno" name="turno">
        <option value="">Seleccionar turno</option>
        <option value="mañana">Mañana</option>
        <option value="tarde">Tarde</option>
      </select>
    </div>
    <button type="submit" class="btn btn-success">Crear Usuario</button>
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