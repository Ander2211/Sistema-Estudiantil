<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard Estudiante</title>
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
                            <a class="nav-link" href="#" onclick="loadContent('horario')">
                                <i class="bi bi-calendar3"></i> Mi Horario
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" onclick="loadContent('calificaciones')">
                                <i class="bi bi-journal-check"></i> Mis Calificaciones
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" onclick="loadContent('asistencia')">
                                <i class="bi bi-person-check"></i> Mi Asistencia
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" onclick="loadContent('pagos')">
                                <i class="bi bi-cash-coin"></i> Estado de Pagos
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Contenido principal -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Mi Panel de Estudiante</h1>
                </div>

                <!-- Información del estudiante -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Información Personal</h5>
                                <div class="row">
                                    <div class="col-md-6">
                                        <p><strong>Carnet:</strong> ${sessionScope.carnet}</p>
                                        <p><strong>Grado:</strong> ${sessionScope.grado}</p>
                                    </div>
                                    <div class="col-md-6">
                                        <p><strong>Turno:</strong> ${sessionScope.turno}</p>
                                        <p><strong>Estado:</strong> <span class="badge bg-success">Activo</span></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tarjetas de resumen -->
                <div class="row">
                    <div class="col-md-4 mb-4">
                        <div class="card text-white bg-primary">
                            <div class="card-body">
                                <h5 class="card-title">Materias Inscritas</h5>
                                <p class="card-text h2">7</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card text-white bg-success">
                            <div class="card-body">
                                <h5 class="card-title">Asistencia</h5>
                                <p class="card-text h2">95%</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card text-white bg-info">
                            <div class="card-body">
                                <h5 class="card-title">Promedio General</h5>
                                <p class="card-text h2">8.5</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Horario del día -->
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5>Clases de Hoy</h5>
                            </div>
                            <div class="card-body">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Hora</th>
                                            <th>Materia</th>
                                            <th>Docente</th>
                                            <th>Aula</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Aquí se cargaría dinámicamente el horario del día -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Contenido dinámico -->
                <div id="contenido-dinamico" class="mt-4">
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
