<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Estudiante</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../common/header.jsp"/>

<div class="container mt-4">
    <h2>Panel del Estudiante</h2>
    <div class="row">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Mi Horario</h5>
                    <p class="card-text">Ver horario de clases.</p>
                    <a href="${pageContext.request.contextPath}/views/common/ver-horario.jsp" class="btn btn-primary">Ver Horario</a>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Mis Calificaciones</h5>
                    <p class="card-text">Ver calificaciones y progreso.</p>
                    <a href="../common/calendario.jsp" class="btn btn-primary">Ver Calificaciones</a>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Actividades</h5>
                    <p class="card-text">Ver calificaciones y progreso.</p>
                    <a href="../common/calendario.jsp" class="btn btn-primary">Actividades</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>