<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Horarios Escolares</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FullCalendar CSS -->
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.0/main.min.css" rel="stylesheet">
    <style>
        .fc-event {
            cursor: pointer;
        }
        .modal-dialog {
            max-width: 600px;
        }
    </style>
</head>
<body>
<div class="container-fluid mt-4">
    <div class="row">
        <div class="col-md-3">
            <div class="card">
                <div class="card-header">
                    <h5>Filtros</h5>
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <label for="gradoSelect" class="form-label">Grado:</label>
                        <select class="form-select" id="gradoSelect">
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="turnoSelect" class="form-label">Turno:</label>
                        <select class="form-select" id="turnoSelect">
                            <option value="">Todos los turnos</option>
                            <option value="mañana">Mañana</option>
                            <option value="tarde">Tarde</option>
                        </select>
                    </div>
                    <button class="btn btn-primary w-100" id="btnNuevoHorario">
                        Nuevo Horario
                    </button>
                </div>
            </div>
        </div>
        <div class="col-md-9">
            <div id="calendar"></div>
        </div>
    </div>
</div>

<!-- Modal para Crear/Editar Horario -->
<div class="modal fade" id="horarioModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="horarioModalLabel">Nuevo Horario</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="horarioForm">
                    <input type="hidden" id="horarioId">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="gradoId" class="form-label">Grado:</label>
                            <select class="form-select" id="gradoId" required>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="materiaId" class="form-label">Materia:</label>
                            <select class="form-select" id="materiaId" required>
                            </select>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="diaSemana" class="form-label">Día:</label>
                            <select class="form-select" id="diaSemana" required>
                                <option value="Lunes">Lunes</option>
                                <option value="Martes">Martes</option>
                                <option value="Miércoles">Miércoles</option>
                                <option value="Jueves">Jueves</option>
                                <option value="Viernes">Viernes</option>
                            </select>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="horaInicio" class="form-label">Hora Inicio:</label>
                            <input type="time" class="form-control" id="horaInicio" required>
                        </div>
                        <div class="col-md-6">
                            <label for="horaFin" class="form-label">Hora Fin:</label>
                            <input type="time" class="form-control" id="horaFin" required>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                <button type="button" class="btn btn-danger" id="btnEliminar">Eliminar</button>
                <button type="button" class="btn btn-primary" id="btnGuardar">Guardar</button>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.0/main.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.0/locales/es.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        let calendar;
        const modal = new bootstrap.Modal(document.getElementById('horarioModal'));
        let currentHorario = null;

        // Inicializar FullCalendar
        const calendarEl = document.getElementById('calendar');
        calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'timeGridWeek',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'timeGridWeek,timeGridDay'
            },
            slotMinTime: '07:00:00',
            slotMaxTime: '18:00:00',
            allDaySlot: false,
            locale: 'es',
            weekends: false,
            hiddenDays: [0, 6], // Oculta domingo (0) y sábado (6)
            daysOfWeek: [1,2,3,4,5], // Solo lunes a viernes
            events: function(fetchInfo, successCallback, failureCallback) {
                loadEvents(fetchInfo, successCallback);
            },
            eventClick: function(info) {
                editHorario(info.event);
            }
        });
        calendar.render();

        // Cargar datos iniciales
        loadGrados();
        loadMaterias();

        // Event Listeners
        document.getElementById('btnNuevoHorario').addEventListener('click', () => {
            currentHorario = null;
            document.getElementById('horarioForm').reset();
            document.getElementById('horarioModalLabel').textContent = 'Nuevo Horario';
            document.getElementById('btnEliminar').style.display = 'none';
            modal.show();
        });

        document.getElementById('btnGuardar').addEventListener('click', saveHorario);
        document.getElementById('btnEliminar').addEventListener('click', deleteHorario);

        // Funciones
        function secondsToTime(sec) {
            const h = Math.floor(sec / 3600).toString().padStart(2, '0');
            const m = Math.floor((sec % 3600) / 60).toString().padStart(2, '0');
            const s = (sec % 60).toString().padStart(2, '0');
            return `${h}:${m}:${s}`;
        }

        function loadEvents(fetchInfo, successCallback) {
            const gradoId = document.getElementById('gradoSelect').value;
            const turno = document.getElementById('turnoSelect').value;

            fetch('/api/horarios/')
                .then(response => response.json())
                .then(data => {
                    // Filtra por grado y turno si se selecciona
                    const filtered = data.filter(horario => {
                        let match = true;
                        if (gradoId && horario.grado_id != gradoId) match = false;
                        if (turno && horario.grado_turno != turno) match = false;
                        return match;
                    });
                    const events = filtered.map(horario => ({
                        id: horario.id,
                        title: `${horario.grado_nombre} - ${horario.materia_nombre}`,
                        daysOfWeek: [getDayNumber(horario.dia_semana)],
                        startTime: secondsToTime(horario.hora_inicio),
                        endTime: secondsToTime(horario.hora_fin),
                        extendedProps: horario
                    }));
                    successCallback(events);
                });
        }

        function loadGrados() {
            fetch('/api/grados/')
                .then(response => response.json())
                .then(data => {
                    const gradoSelect = document.getElementById('gradoId');
                    const filterSelect = document.getElementById('gradoSelect');
                    filterSelect.innerHTML = ""; // Limpia el select
                    data.forEach(grado => {
                        gradoSelect.innerHTML += `<option value="${grado.id}">${grado.nombre} - ${grado.turno}</option>`;
                        filterSelect.innerHTML += `<option value="${grado.id}">${grado.nombre} - ${grado.turno}</option>`;
                    });
                });
        }

        function loadMaterias() {
            fetch('/api/materias/')
                .then(response => response.json())
                .then((data) => {
                    const materiaSelect = document.getElementById('materiaId');
                    data.forEach(materia => {
                        materiaSelect.innerHTML += `<option value="${materia.id}">${materia.nombre}</option>`;
                    });
                });
        }

        function saveHorario() {
            const horarioData = {
                grado_id: parseInt(document.getElementById('gradoId').value),
                materia_id: parseInt(document.getElementById('materiaId').value),
                dia_semana: document.getElementById('diaSemana').value,
                hora_inicio: document.getElementById('horaInicio').value,
                hora_fin: document.getElementById('horaFin').value
            };

            const method = currentHorario ? 'PUT' : 'POST';
            const url = currentHorario ?
                `/api/horarios/${currentHorario.id}` : '/api/horarios/';

            fetch(url, {
                method: method,
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(horarioData)
            })
                .then(response => response.json())
                .then(data => {
                    modal.hide();
                    calendar.refetchEvents();
                });
        }

        function editHorario(event) {
            currentHorario = event.extendedProps;
            document.getElementById('horarioModalLabel').textContent = 'Editar Horario';
            document.getElementById('btnEliminar').style.display = 'block';

            document.getElementById('gradoId').value = currentHorario.grado_id;
            document.getElementById('materiaId').value = currentHorario.materia_id;
            document.getElementById('diaSemana').value = currentHorario.dia_semana;
            document.getElementById('horaInicio').value = currentHorario.hora_inicio;
            document.getElementById('horaFin').value = currentHorario.hora_fin;

            modal.show();
        }

        function deleteHorario() {
            if (!currentHorario) return;

            fetch(`/api/horarios/${currentHorario.id}`, {
                method: 'DELETE'
            })
                .then(response => response.json())
                .then(data => {
                    modal.hide();
                    calendar.refetchEvents();
                });
        }

        function getDayNumber(day) {
            const days = {
                'Lunes': 1,
                'Martes': 2,
                'Miércoles': 3,
                'Jueves': 4,
                'Viernes': 5
            };
            return days[day];
        }

        // Filtros
        document.getElementById('gradoSelect').addEventListener('change', () => calendar.refetchEvents());
        document.getElementById('turnoSelect').addEventListener('change', () => calendar.refetchEvents());
    });
</script>
</body>
</html>