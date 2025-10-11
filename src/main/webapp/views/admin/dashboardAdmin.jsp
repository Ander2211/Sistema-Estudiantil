<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Administrador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../common/header.jsp"/>

<div class="container mt-4">
    <h2>Panel de Administración</h2>
    <div class="row">
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Gestión de Usuarios</h5>
                    <p class="card-text">Administrar estudiantes, maestros y administradores.</p>
                    <a href="${pageContext.request.contextPath}/usuarios" class="btn btn-primary">Gestionar Usuarios</a>                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Gestión de Grados</h5>
                    <p class="card-text">Administrar grados y secciones.</p>
                    <a href="#" class="btn btn-primary">Gestionar</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Reportes</h5>
                    <p class="card-text">Generar reportes del sistema.</p>
                    <a href="#" class="btn btn-primary">Ver Reportes</a>
                </div>
            </div>
        </div>
    </div>

    <div class="row my-2">
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Creacion de Acitividades</h5>
                    <p class="card-text"></p>
                    <a href="${pageContext.request.contextPath}/views/common/calendarioActividades.jsp" class="btn btn-primary">Gestionar</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Asignacion de horarios</h5>
                    <p class="card-text">Generar reportes del sistema.</p>
                    <a href="#" class="btn btn-primary">Ver Reportes</a>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>