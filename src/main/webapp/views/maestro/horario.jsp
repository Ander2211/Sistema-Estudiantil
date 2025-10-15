                            </a>
                        </li>
                    </ul>
                </div>
            </nav>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
            <!-- Contenido principal -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">Panel del Docente</h1>
                </div>
    <title>Dashboard Docente</title>
                <!-- Tarjetas de resumen -->
                <div class="row">
                    <div class="col-md-4 mb-4">
                        <div class="card text-white bg-primary">
                            <div class="card-body">
                                <h5 class="card-title">Mis Grupos</h5>
                                <p class="card-text h2">5</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card text-white bg-success">
                            <div class="card-body">
                                <h5 class="card-title">Total Estudiantes</h5>
                                <p class="card-text h2">120</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="card text-white bg-info">
                            <div class="card-body">
                                <h5 class="card-title">Clases Hoy</h5>
                                <p class="card-text h2">4</p>
                            </div>
                        </div>
                    </div>
                </div>
                        </li>
                <!-- Horario del día -->
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h5>Horario de Hoy</h5>
                            </div>
                            <div class="card-body">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Hora</th>
                                            <th>Materia</th>
                                            <th>Grado</th>
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
                                <i class="bi bi-file-text"></i> Reportes
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function loadContent(section) {
            const contenido = document.getElementById('contenido-dinamico');
            // Aquí se implementaría la lógica para cargar el contenido dinámicamente
            contenido.innerHTML = `<h3>Sección de ${section}</h3><p>Contenido en construcción...</p>`;
        }
    </script>
%>
<jsp:include page="../common/header.jsp"/>

<div class="container mt-4">
    <div class="card mb-4">
        <div class="card-body">
            <h4>Información del Docente</h4>
            <p><strong>Nombre:</strong> <%= nombre %></p>
            <p><strong>Departamento:</strong> <%= departamento %></p>
        </div>
    </div>

    <div class="card">
        <div class="card-body">
            <h4>Mi Horario de Clases</h4>
            <div id="calendar"></div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const calendarEl = document.getElementById('calendar');
        const calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'timeGridWeek',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'timeGridWeek,timeGridDay'
            },
            allDaySlot: false,
            slotMinTime: "07:00:00",
            slotMaxTime: "19:00:00",
            hiddenDays: [0,6],
            events: '<%= request.getContextPath() %>/sistema_escolar_war/api/horarios/maestro/<%= userId %>'
        });
        calendar.render();
    });
</script>
</body>
</html>
