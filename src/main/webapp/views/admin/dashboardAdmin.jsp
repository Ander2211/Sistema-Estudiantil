<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Administrador</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .dashboard-card {
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
            border: none;
            border-radius: 15px;
            overflow: hidden;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .card-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }
        .stats-card {
            border-left: 4px solid;
            border-radius: 10px;
        }
        .bg-gradient-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .bg-gradient-success {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }
        .bg-gradient-info {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        }
        .bg-gradient-warning {
            background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
        }
        .welcome-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 15px;
            color: white;
        }
    </style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>

<div class="container-fluid mt-4">
    <!-- Header de Bienvenida -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="welcome-header p-4">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h1 class="display-6 fw-bold">
                            <i class="bi bi-speedometer2 me-3"></i>Panel de Administración
                        </h1>
                        <p class="lead mb-0">Bienvenido, <%= session.getAttribute("nombre") != null ? session.getAttribute("nombre") : "Administrador" %></p>
                    </div>
                    <div class="col-md-4 text-end">
                        <div class="bg-white text-dark rounded p-3 d-inline-block">
                            <i class="bi bi-calendar-check text-primary"></i>
                            <span id="current-date" class="fw-bold"></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Tarjetas de Estadísticas con Datos Reales -->
    <div class="row mb-4">
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card stats-card border-left-primary text-white bg-gradient-primary h-100">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-uppercase mb-1">Total Estudiantes</div>
                            <div class="h5 mb-0 font-weight-bold">${totalEstudiantes}</div>
                            <div class="mt-2">
                                <span class="text-success"><i class="bi bi-arrow-up"></i> Activos</span>
                                <span class="text-white-50 small">en el sistema</span>
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-people fa-2x text-white-50"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card stats-card border-left-success text-white bg-gradient-success h-100">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-uppercase mb-1">Total Maestros</div>
                            <div class="h5 mb-0 font-weight-bold">${totalMaestros}</div>
                            <div class="mt-2">
                                <span class="text-success"><i class="bi bi-arrow-up"></i> Activos</span>
                                <span class="text-white-50 small">en el sistema</span>
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-person-badge fa-2x text-white-50"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card stats-card border-left-info text-white bg-gradient-info h-100">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-uppercase mb-1">Materias Activas</div>
                            <div class="h5 mb-0 font-weight-bold">${totalMaterias}</div>
                            <div class="mt-2">
                                <span class="text-success"><i class="bi bi-book"></i> Disponibles</span>
                                <span class="text-white-50 small">para asignar</span>
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-book fa-2x text-white-50"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card stats-card border-left-warning text-white bg-gradient-warning h-100">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-uppercase mb-1">Actividades</div>
                            <div class="h5 mb-0 font-weight-bold">${totalActividades}</div>
                            <div class="mt-2">
                                <span class="text-success"><i class="bi bi-calendar"></i> Programadas</span>
                                <span class="text-white-50 small">en calendario</span>
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="bi bi-calendar-event fa-2x text-white-50"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Gestión de Usuarios -->
    <div class="row mb-4">
        <div class="col-12">
            <h3 class="mb-3">
                <i class="bi bi-people-fill text-primary me-2"></i>Gestión de Usuarios
            </h3>
        </div>

        <div class="col-xl-4 col-md-6 mb-4">
            <div class="card dashboard-card border-primary">
                <div class="card-body text-center p-4">
                    <div class="card-icon text-primary">
                        <i class="bi bi-people"></i>
                    </div>
                    <h5 class="card-title">Todos los Usuarios</h5>
                    <p class="card-text text-muted">Administrar estudiantes, maestros y administradores del sistema.</p>
                    <a href="${pageContext.request.contextPath}/usuarios" class="btn btn-primary">
                        <i class="bi bi-gear me-2"></i>Gestionar Usuarios
                    </a>
                </div>
            </div>
        </div>

        <div class="col-xl-4 col-md-6 mb-4">
            <div class="card dashboard-card border-success">
                <div class="card-body text-center p-4">
                    <div class="card-icon text-success">
                        <i class="bi bi-person-badge"></i>
                    </div>
                    <h5 class="card-title">Gestión de Maestros</h5>
                    <p class="card-text text-muted">Administrar maestros, asignar materias y gestionar perfiles.</p>
                    <a href="${pageContext.request.contextPath}/maestros" class="btn btn-success">
                        <i class="bi bi-person-plus me-2"></i>Gestionar Maestros
                    </a>
                </div>
            </div>
        </div>

        <div class="col-xl-4 col-md-6 mb-4">
            <div class="card dashboard-card border-info">
                <div class="card-body text-center p-4">
                    <div class="card-icon text-info">
                        <i class="bi bi-mortarboard"></i>
                    </div>
                    <h5 class="card-title">Gestión de Estudiantes</h5>
                    <p class="card-text text-muted">Administrar estudiantes, grados y registros académicos.</p>
                    <a href="#" class="btn btn-info">
                        <i class="bi bi-person-vcard me-2"></i>Gestionar Estudiantes
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Gestión Académica -->
    <div class="row mb-4">
        <div class="col-12">
            <h3 class="mb-3">
                <i class="bi bi-book-half text-success me-2"></i>Gestión Académica
            </h3>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card dashboard-card border-warning">
                <div class="card-body text-center p-4">
                    <div class="card-icon text-warning">
                        <i class="bi bi-journal-bookmark"></i>
                    </div>
                    <h5 class="card-title">Gestión de Grados</h5>
                    <p class="card-text text-muted">Administrar grados, secciones y niveles académicos.</p>
                    <a href="#" class="btn btn-warning">
                        <i class="bi bi-diagram-3 me-2"></i>Gestionar Grados
                    </a>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card dashboard-card border-danger">
                <div class="card-body text-center p-4">
                    <div class="card-icon text-danger">
                        <i class="bi bi-calendar2-range"></i>
                    </div>
                    <h5 class="card-title">Asignación de Horarios</h5>
                    <p class="card-text text-muted">Crear y gestionar horarios de clases y actividades.</p>
                    <a href="#" class="btn btn-danger">
                        <i class="bi bi-clock me-2"></i>Gestionar Horarios
                    </a>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card dashboard-card border-info">
                <div class="card-body text-center p-4">
                    <div class="card-icon text-info">
                        <i class="bi bi-calendar-event"></i>
                    </div>
                    <h5 class="card-title">Actividades Escolares</h5>
                    <p class="card-text text-muted">Crear y gestionar actividades del calendario escolar.</p>
                    <a href="${pageContext.request.contextPath}/views/common/calendarioActividades.jsp" class="btn btn-info">
                        <i class="bi bi-plus-circle me-2"></i>Gestionar Actividades
                    </a>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card dashboard-card border-success">
                <div class="card-body text-center p-4">
                    <div class="card-icon text-success">
                        <i class="bi bi-clipboard-data"></i>
                    </div>
                    <h5 class="card-title">Reportes del Sistema</h5>
                    <p class="card-text text-muted">Generar reportes académicos y estadísticas del sistema.</p>
                    <a href="#" class="btn btn-success">
                        <i class="bi bi-graph-up me-2"></i>Ver Reportes
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="bg-dark text-white mt-5 py-4">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h5>Sistema Escolar</h5>
                <p class="mb-0">Plataforma de gestión académica integral</p>
            </div>
            <div class="col-md-6 text-end">
                <p class="mb-0">
                    <i class="bi bi-clock me-2"></i>
                    <span id="current-time"></span>
                </p>
            </div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Función para actualizar fecha y hora
    function updateDateTime() {
        const now = new Date();

        // Formatear fecha
        const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
        const dateString = now.toLocaleDateString('es-ES', options);
        document.getElementById('current-date').textContent = dateString;

        // Formatear hora
        const timeString = now.toLocaleTimeString('es-ES');
        document.getElementById('current-time').textContent = timeString;
    }

    // Actualizar cada segundo
    updateDateTime();
    setInterval(updateDateTime, 1000);

    // Efectos adicionales
    document.addEventListener('DOMContentLoaded', function() {
        // Animación de aparición progresiva de las tarjetas
        const cards = document.querySelectorAll('.dashboard-card');
        cards.forEach((card, index) => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';

            setTimeout(() => {
                card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, index * 100);
        });
    });
</script>
</body>
</html>