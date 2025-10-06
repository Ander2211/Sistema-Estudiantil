<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dashboard Docente</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../common/header.jsp" />

    <div class="container mt-4">
        <h2>Panel de Docente</h2>
        <div class="row mt-4">
            <div class="col-md-4 mb-3">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Mi Horario</h5>
                        <p class="card-text">Ver mi horario de clases.</p>
                        <a href="${pageContext.request.contextPath}/views/maestro/horario.jsp" class="btn btn-primary">Ver Horario</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Asistencia</h5>
                        <p class="card-text">Registrar asistencia de estudiantes.</p>
                        <a href="#" class="btn btn-primary">Gestionar</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Calificaciones</h5>
                        <p class="card-text">Gestionar calificaciones de estudiantes.</p>
                        <a href="#" class="btn btn-primary">Gestionar</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
