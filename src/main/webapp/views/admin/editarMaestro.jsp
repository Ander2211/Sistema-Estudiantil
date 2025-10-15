<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.poo.actividad.sistemaescolar.Model.Maestro" %>
<%
  Maestro maestro = (Maestro) request.getAttribute("maestro");
%>
<!DOCTYPE html>
<html>
<head>
  <title>Editar Maestro</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../common/header.jsp"/>

<div class="container mt-4">
  <h2>Editar Maestro</h2>

  <% if (request.getParameter("error") != null) { %>
  <div class="alert alert-danger"><%= request.getParameter("error") %></div>
  <% } %>

  <form action="${pageContext.request.contextPath}/editarMaestro" method="post">
    <input type="hidden" name="id" value="<%= maestro.getId() %>">
    <div class="mb-3">
      <label for="carnet" class="form-label">Carnet</label>
      <input type="text" class="form-control" id="carnet" name="carnet" value="<%= maestro.getCarnet() %>" required>
    </div>
    <div class="mb-3">
      <label for="nombre" class="form-label">Nombre Completo</label>
      <input type="text" class="form-control" id="nombre" name="nombre" value="<%= maestro.getNombre() %>" required>
    </div>
    <div class="mb-3">
      <label for="email" class="form-label">Correo electrónico</label>
      <input type="email" class="form-control" id="email" name="email" value="<%= maestro.getEmail() %>" required>
    </div>
    <div class="mb-3">
      <label for="password" class="form-label">Contraseña</label>
      <input type="password" class="form-control" id="password" name="password" value="<%= maestro.getContraseña() %>" required>
    </div>
    <button type="submit" class="btn btn-success">Actualizar Maestro</button>
    <a href="${pageContext.request.contextPath}/maestros" class="btn btn-secondary">Cancelar</a>
  </form>
</div>

</body>
</html>