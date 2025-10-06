<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Actividades</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css' rel='stylesheet'>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="container mt-4">
    <div class="row">
        <div class="col-md-8">
            <div class="card">
                <div class="card-body">
                    <h4>Calendario</h4>
                    <div id="calendar"></div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h4>Agregar Actividad</h4>
                    <form id="eventoForm">
                        <div class="mb-3">
                            <label for="title" class="form-label">Título</label>
                            <input type="text" class="form-control" id="title" required>
                        </div>
                        <div class="mb-3">
                            <label for="start" class="form-label">Fecha Inicio</label>
                            <input type="date" class="form-control" id="start" required>
                        </div>
                        <div class="mb-3">
                            <label for="end" class="form-label">Fecha Fin</label>
                            <input type="date" class="form-control" id="end" required>
                        </div>
                        <div class="mb-3">
                            <label for="color" class="form-label">Color</label>
                            <input type="color" class="form-control" id="color" value="#37d757">
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Descripción</label>
                            <textarea class="form-control" id="description" rows="3"></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Guardar</button>
                    </form>
                </div>
            </div>

            <div class="card mt-3">
                <div class="card-body">
                    <h4>Actividades</h4>
                    <div class="table-responsive">
                        <table class="table table-striped" id="tablaEventos">
                            <thead>
                                <tr>
                                    <th>Título</th>
                                    <th>Inicio</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js'></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>
    let calendar;
    const apiUrl = 'http://localhost:8080/sistema_escolar_war/api/calendario';

    document.addEventListener('DOMContentLoaded', function() {
        const calendarEl = document.getElementById('calendar');
        calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay'
            },
            events: cargarEventos
        });
        calendar.render();

        // Configurar el formulario
        document.getElementById('eventoForm').addEventListener('submit', guardarEvento);
    });

    function cargarEventos(fetchInfo, successCallback, failureCallback) {
        axios.get(apiUrl)
            .then(function(response) {
                const eventos = response.data.map(evento => ({
                    id: evento.id,
                    title: evento.title,
                    start: evento.start,
                    end: evento.end,
                    color: evento.color || '#37d757',
                    description: evento.description || ''
                }));
                successCallback(eventos);
                actualizarTablaEventos(eventos);
            })
            .catch(function(error) {
                console.error('Error al cargar eventos:', error);
                failureCallback(error);
            });
    }

    function actualizarTablaEventos(eventos) {
        const tbody = document.querySelector('#tablaEventos tbody');
        tbody.innerHTML = '';

        eventos.forEach(evento => {
            const tr = document.createElement('tr');
            tr.innerHTML = `
                <td>${evento.title}</td>
                <td>${evento.start}</td>
                <td>
                    <button class="btn btn-sm btn-danger" onclick="eliminarEvento(${evento.id})">Eliminar</button>
                </td>
            `;
            tbody.appendChild(tr);
        });
    }

    function guardarEvento(e) {
        e.preventDefault();

        const nuevoEvento = {
            title: document.getElementById('title').value,
            start: document.getElementById('start').value,
            end: document.getElementById('end').value,
            color: document.getElementById('color').value,
            description: document.getElementById('description').value
        };

        axios.post(apiUrl, nuevoEvento)
            .then(function(response) {
                alert('Actividad guardada con éxito');
                document.getElementById('eventoForm').reset();
                calendar.refetchEvents();
            })
            .catch(function(error) {
                console.error('Error al guardar evento:', error);
                alert('Error al guardar la actividad');
            });
    }

    function eliminarEvento(id) {
        if (confirm('¿Estás seguro de eliminar esta actividad?')) {
            axios.delete(`${apiUrl}/${id}`)
                .then(function() {
                    alert('Actividad eliminada con éxito');
                    calendar.refetchEvents();
                })
                .catch(function(error) {
                    console.error('Error al eliminar evento:', error);
                    alert('Error al eliminar la actividad');
                });
        }
    }
</script>
</body>
</html>
