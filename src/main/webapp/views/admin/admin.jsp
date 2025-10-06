<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard Administrativo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
                <div class="position-sticky pt-3">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link active" href="#">
                                <i class="bi bi-speedometer2"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" onclick="loadContent('estudiantes')">
                                <i class="bi bi-mortarboard"></i> Gestionar Estudiantes
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" onclick="loadContent('maestros')">
                                <i class="bi bi-person-workspace"></i> Gestionar Maestros
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" onclick="loadContent('materias')">
                                <i class="bi bi-book"></i> Gestionar Materias
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" onclick="loadContent('horarios')">
                                <i class="bi bi-calendar3"></i> Gestionar Horarios
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" onclick="loadContent('pagos')">
                                <i class="bi bi-cash-coin"></i> Gestionar Pagos
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Contenido principal -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Panel de Control</h1>
                </div>

                <!-- Tarjetas de resumen -->
                <div class="row">
                    <div class="col-md-4 mb-4">
                        <div class="card text-white bg-primary">
                            <div class="card-body">
                                <h5 class="card-title">Total Estudiantes</h5>
                                <p class="card-text h2">150</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card text-white bg-success">
                            <div class="card-body">
                                <h5 class="card-title">Total Maestros</h5>
                                <p class="card-text h2">25</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card text-white bg-info">
                            <div class="card-body">
                                <h5 class="card-title">Total Materias</h5>
                                <p class="card-text h2">12</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Contenido dinámico -->
                <div id="contenido-dinamico">
                    <!-- Aquí se cargará el contenido según la opción seleccionada -->
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function loadContent(section) {
            const contenido = document.getElementById('contenido-dinamico');
            // Aquí se implementaría la lógica para cargar el contenido dinámicamente
            contenido.innerHTML = `<h3>Sección de ${section}</h3><p>Contenido en construcción...</p>`;
        }
    </script>
</body>
</html>
