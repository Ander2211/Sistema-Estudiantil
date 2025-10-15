<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.poo.actividad.sistemaescolar.Model.Usuario" %>
<%
  Usuario usuario = (Usuario) request.getAttribute("usuario");
  String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Crear Usuario</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
  <style>
    .card {
      border: none;
      border-radius: 15px;
      box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    }
    .card-header {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      border-radius: 15px 15px 0 0 !important;
    }
  </style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>

<div class="container mt-4">
  <div class="row justify-content-center">
    <div class="col-md-8">
      <div class="card">
        <div class="card-header">
          <h4 class="mb-0"><i class="bi bi-person-plus me-2"></i>Crear Nuevo Usuario</h4>
        </div>
        <div class="card-body">
          <% if (error != null) { %>
          <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle me-2"></i><%= error %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
          </div>
          <% } %>

          <form action="${pageContext.request.contextPath}/crearUsuario" method="post" id="userForm">
            <div class="row">
              <div class="col-md-6">
                <div class="mb-3">
                  <label for="carnet" class="form-label">
                    <i class="bi bi-person-badge me-1"></i>Carnet *
                  </label>
                  <input type="text" class="form-control <%= error != null && error.contains("carnet") ? "is-invalid" : "" %>"
                         id="carnet" name="carnet"
                         value="<%= usuario != null ? usuario.getCarnet() : "" %>"
                         required
                         onblur="checkCarnetAvailability()">
                  <div class="invalid-feedback" id="carnetFeedback">
                    <%= error != null && error.contains("carnet") ? error : "Este carnet ya está en uso" %>
                  </div>
                  <div class="valid-feedback" id="carnetValid">
                    Carnet disponible
                  </div>
                </div>
              </div>
              <div class="col-md-6">
                <div class="mb-3">
                  <label for="nombre" class="form-label">
                    <i class="bi bi-person me-1"></i>Nombre Completo *
                  </label>
                  <input type="text" class="form-control" id="nombre" name="nombre"
                         value="<%= usuario != null ? usuario.getNombre() : "" %>" required>
                </div>
              </div>
            </div>

            <div class="row">
              <div class="col-md-6">
                <div class="mb-3">
                  <label for="email" class="form-label">
                    <i class="bi bi-envelope me-1"></i>Correo electrónico *
                  </label>
                  <input type="email" class="form-control" id="email" name="email"
                         value="<%= usuario != null ? usuario.getEmail() : "" %>" required>
                </div>
              </div>
              <div class="col-md-6">
                <div class="mb-3">
                  <label for="password" class="form-label">
                    <i class="bi bi-lock me-1"></i>Contraseña *
                  </label>
                  <input type="password" class="form-control" id="password" name="password"
                         value="<%= usuario != null ? usuario.getContraseña() : "" %>" required>
                </div>
              </div>
            </div>

            <div class="mb-3">
              <label for="rol" class="form-label">
                <i class="bi bi-person-rolodex me-1"></i>Rol *
              </label>
              <select class="form-select" id="rol" name="rol" required onchange="toggleGradoTurno()">
                <option value="">Seleccionar rol</option>
                <option value="estudiante" <%= usuario != null && "estudiante".equals(usuario.getRol()) ? "selected" : "" %>>Estudiante</option>
                <option value="maestro" <%= usuario != null && "maestro".equals(usuario.getRol()) ? "selected" : "" %>>Maestro</option>
                <option value="admin" <%= usuario != null && "admin".equals(usuario.getRol()) ? "selected" : "" %>>Administrador</option>
              </select>
            </div>

            <div class="row" id="gradoTurnoFields" style="display: <%= usuario != null && "estudiante".equals(usuario.getRol()) ? "flex" : "none" %>;">
              <div class="col-md-6">
                <div class="mb-3">
                  <label for="grado" class="form-label">
                    <i class="bi bi-book me-1"></i>Grado
                  </label>
                  <select class="form-select" id="grado" name="grado">
                    <option value="">Seleccionar grado</option>
                    <option value="Primero" <%= usuario != null && "Primero".equals(usuario.getGrado()) ? "selected" : "" %>>Primero</option>
                    <option value="Segundo" <%= usuario != null && "Segundo".equals(usuario.getGrado()) ? "selected" : "" %>>Segundo</option>
                    <option value="Tercero" <%= usuario != null && "Tercero".equals(usuario.getGrado()) ? "selected" : "" %>>Tercero</option>
                    <option value="Cuarto" <%= usuario != null && "Cuarto".equals(usuario.getGrado()) ? "selected" : "" %>>Cuarto</option>
                    <option value="Quinto" <%= usuario != null && "Quinto".equals(usuario.getGrado()) ? "selected" : "" %>>Quinto</option>
                  </select>
                </div>
              </div>
              <div class="col-md-6">
                <div class="mb-3">
                  <label for="turno" class="form-label">
                    <i class="bi bi-clock me-1"></i>Turno
                  </label>
                  <select class="form-select" id="turno" name="turno">
                    <option value="">Seleccionar turno</option>
                    <option value="mañana" <%= usuario != null && "mañana".equals(usuario.getTurno()) ? "selected" : "" %>>Mañana</option>
                    <option value="tarde" <%= usuario != null && "tarde".equals(usuario.getTurno()) ? "selected" : "" %>>Tarde</option>
                  </select>
                </div>
              </div>
            </div>

            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
              <button type="submit" class="btn btn-success btn-lg">
                <i class="bi bi-check-circle me-2"></i>Crear Usuario
              </button>
              <a href="${pageContext.request.contextPath}/usuarios" class="btn btn-secondary btn-lg">
                <i class="bi bi-arrow-left me-2"></i>Cancelar
              </a>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
  function toggleGradoTurno() {
    const rol = document.getElementById('rol').value;
    const gradoTurnoFields = document.getElementById('gradoTurnoFields');

    if (rol === 'estudiante') {
      gradoTurnoFields.style.display = 'flex';
      // Hacer obligatorios los campos de grado y turno para estudiantes
      document.getElementById('grado').required = true;
      document.getElementById('turno').required = true;
    } else {
      gradoTurnoFields.style.display = 'none';
      // Quitar requerimiento para otros roles
      document.getElementById('grado').required = false;
      document.getElementById('turno').required = false;
    }
  }

  // Ejecutar al cargar la página para establecer el estado inicial
  document.addEventListener('DOMContentLoaded', function() {
    toggleGradoTurno();

    // Si hay un error relacionado con el carnet, mostrar feedback
    const carnetInput = document.getElementById('carnet');
    const carnetFeedback = document.getElementById('carnetFeedback');

    <% if (error != null && error.contains("carnet")) { %>
    carnetInput.classList.add('is-invalid');
    carnetFeedback.style.display = 'block';
    <% } %>
  });

  // Función para verificar disponibilidad del carnet (opcional - para AJAX)
  function checkCarnetAvailability() {
    const carnet = document.getElementById('carnet').value;
    const carnetInput = document.getElementById('carnet');
    const carnetFeedback = document.getElementById('carnetFeedback');
    const carnetValid = document.getElementById('carnetValid');

    if (carnet.length > 0) {
      // Aquí podrías implementar una verificación AJAX con el servidor
      // Por ahora solo validamos formato básico
      if (carnet.length < 3) {
        carnetInput.classList.remove('is-valid');
        carnetInput.classList.add('is-invalid');
        carnetFeedback.textContent = 'El carnet debe tener al menos 3 caracteres';
        carnetFeedback.style.display = 'block';
        carnetValid.style.display = 'none';
      } else {
        carnetInput.classList.remove('is-invalid');
        carnetInput.classList.add('is-valid');
        carnetFeedback.style.display = 'none';
        carnetValid.style.display = 'block';
      }
    } else {
      carnetInput.classList.remove('is-invalid', 'is-valid');
      carnetFeedback.style.display = 'none';
      carnetValid.style.display = 'none';
    }
  }

  // Validación del formulario
  document.getElementById('userForm').addEventListener('submit', function(e) {
    const carnet = document.getElementById('carnet').value;
    const rol = document.getElementById('rol').value;

    if (carnet.length < 3) {
      e.preventDefault();
      alert('El carnet debe tener al menos 3 caracteres');
      return;
    }

    if (rol === 'estudiante') {
      const grado = document.getElementById('grado').value;
      const turno = document.getElementById('turno').value;

      if (!grado || !turno) {
        e.preventDefault();
        alert('Para estudiantes, el grado y turno son obligatorios');
        return;
      }
    }
  });
</script>
</body>
</html>