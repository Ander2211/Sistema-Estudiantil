<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sistema Escolar</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Sistema Escolar</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <% if (session.getAttribute("rol") != null) {
                    String rol = (String) session.getAttribute("rol");
                %>
                <% if (rol.equals("admin")) { %>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
                </li>
                <% } else if (rol.equals("maestro")) { %>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/maestro/dashboard">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/views/maestro/horario.jsp">Horario</a>
                </li>
                <% } else if (rol.equals("estudiante")) { %>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/estudiante/dashboard">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/views/common/ver-horario.jsp">Horario</a>
                </li>
                <% } %>
                <% } %>
            </ul>
            <div class="navbar-nav">
                <% if (session.getAttribute("displayName") != null) { %>
                    <span class="nav-item nav-link text-light">
                        <%= session.getAttribute("displayName") %>
                    </span>
                    <a class="nav-link" href="${pageContext.request.contextPath}/logout">Cerrar Sesión</a>
                <% } %>
            </div>
        </div>
    </div>
</nav>
