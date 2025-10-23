<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Calendario Escolar</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css' rel='stylesheet'>
    <style>
        .fc-event {
            cursor: pointer;
        }
    </style>
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
    // Usar contexto de la aplicación en lugar de URL hardcodeada
    const apiUrl = '${pageContext.request.contextPath}/api/calendario';

    document.addEventListener('DOMContentLoaded', function() {
        const calendarEl = document.getElementById('calendar');
        calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay'
            },
            events: cargarEventos,
            eventClick: function(info) {
                alert('Evento: ' + info.event.title + '\nDescripción: ' + (info.event.extendedProps.description || 'Sin descripción'));
            }
        });
        calendar.render();

        // Configurar el formulario
        document.getElementById('eventoForm').addEventListener('submit', guardarEvento);

        // Cargar eventos inicialmente
        cargarEventos();
    });

    function cargarEventos(fetchInfo, successCallback, failureCallback) {
        axios.get(apiUrl)
            .then(function(response) {
                const eventos = response.data.map(function(evento) {
                    return {
                        id: evento.id,
                        title: evento.title,
                        start: evento.start,
                        end: evento.end,
                        color: evento.color || '#37d757',
                        description: evento.description || '',
                        extendedProps: {
                            description: evento.description || ''
                        }
                    };
                });

                if (successCallback) {
                    successCallback(eventos);
                }
                actualizarTablaEventos(eventos);
            })
            .catch(function(error) {
                console.error('Error al cargar eventos:', error);
                if (failureCallback) {
                    failureCallback(error);
                }
                alert('Error al cargar los eventos');
            });
    }

    function actualizarTablaEventos(eventos) {
        const tbody = document.querySelector('#tablaEventos tbody');
        tbody.innerHTML = '';

        eventos.forEach(function(evento) {
            const tr = document.createElement('tr');

            // Crear celdas manualmente en lugar de usar template literals
            const tdTitulo = document.createElement('td');
            tdTitulo.textContent = evento.title;

            const tdFecha = document.createElement('td');
            tdFecha.textContent = formatDate(evento.start);

            const tdAcciones = document.createElement('td');
            const btnEliminar = document.createElement('button');
            btnEliminar.className = 'btn btn-sm btn-danger';
            btnEliminar.textContent = 'Eliminar';
            btnEliminar.onclick = function() {
                eliminarEvento(evento.id);
            };
            tdAcciones.appendChild(btnEliminar);

            tr.appendChild(tdTitulo);
            tr.appendChild(tdFecha);
            tr.appendChild(tdAcciones);

            tbody.appendChild(tr);
        });
    }

    function guardarEvento(e) {
        e.preventDefault();

        const title = document.getElementById('title').value;
        const start = document.getElementById('start').value;
        const end = document.getElementById('end').value;

        if (!title || !start || !end) {
            alert('Por favor, complete todos los campos obligatorios');
            return;
        }

        const nuevoEvento = {
            title: title,
            start: start,
            end: end,
            color: document.getElementById('color').value,
            description: document.getElementById('description').value
        };

        axios.post(apiUrl, nuevoEvento)
            .then(function(response) {
                if (response.data && response.data.status === 'ok') {
                    alert('Actividad guardada con éxito');
                    document.getElementById('eventoForm').reset();
                    calendar.refetchEvents();
                } else {
                    throw new Error('Error en la respuesta del servidor');
                }
            })
            .catch(function(error) {
                console.error('Error al guardar evento:', error);
                alert('Error al guardar la actividad: ' + error.message);
            });
    }

    function eliminarEvento(id) {
        if (confirm('¿Estás seguro de eliminar esta actividad?')) {
            axios.delete(apiUrl + '/' + id)
                .then(function(response) {
                    if (response.data && response.data.status === 'ok') {
                        alert('Actividad eliminada con éxito');
                        calendar.refetchEvents();
                    } else {
                        throw new Error('Error en la respuesta del servidor');
                    }
                })
                .catch(function(error) {
                    console.error('Error al eliminar evento:', error);
                    alert('Error al eliminar la actividad: ' + error.message);
                });
        }
    }

    function formatDate(dateString) {
        try {
            const date = new Date(dateString);
            if (isNaN(date.getTime())) {
                return dateString; // Retorna la cadena original si no es una fecha válida
            }
            return date.toLocaleDateString('es-ES', {
                year: 'numeric',
                month: '2-digit',
                day: '2-digit'
            });
        } catch (error) {
            console.error('Error formateando fecha:', error);
            return dateString;
        }
    }
</script>
</body>
</html>
