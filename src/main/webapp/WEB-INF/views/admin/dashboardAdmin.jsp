<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dashboard Administrador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%-- Verificación de sesión y rol --%>
    <%
        if (session == null || session.getAttribute("rol") == null || !session.getAttribute("rol").equals("admin")) {
            response.sendRedirect(request.getContextPath() + "/acceso-denegado.jsp");
            return;
        }
    %>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Sistema Escolar</a>
            <div class="navbar-text text-white">
                ${sessionScope.displayName}
            </div>
            <div class="ms-auto">
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light">Cerrar Sesión</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2>Panel de Administración</h2>
        <div class="row mt-4">
            <div class="col-md-4 mb-3">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Gestión de Usuarios</h5>
                        <p class="card-text">Administrar estudiantes, maestros y personal.</p>
                        <a href="#" class="btn btn-primary">Gestionar</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Calendario Escolar</h5>
                        <p class="card-text">Ver y modificar eventos del calendario.</p>
                        <a href="${pageContext.request.contextPath}/views/common/calendario.jsp" class="btn btn-primary">Ver Calendario</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Reportes</h5>
                        <p class="card-text">Generar reportes del sistema.</p>
                        <a href="#" class="btn btn-primary">Ver Reportes</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
