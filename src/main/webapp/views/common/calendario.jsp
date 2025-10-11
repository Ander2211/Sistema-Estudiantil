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
    <h2>Calendario de Actividades Escolares</h2>

    <div class="row">
        <div class="col-md-8">
            <div id="calendar"></div>
        </div>
        <div class="col-md-4">
            <div class="card p-3">
                <h5>Lista de actividades</h5>
                <table class="table table-striped" id="tablaEventos">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Título</th>
                            <th>Inicio</th>
                            <th>Fin</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
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
            events: function(fetchInfo, successCallback, failureCallback) {
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
        });
        calendar.render();
    });

    function actualizarTablaEventos(eventos) {
        const tbody = document.querySelector('#tablaEventos tbody');
        tbody.innerHTML = '';

        eventos.forEach(evento => {
            const tr = document.createElement('tr');
            tr.innerHTML = `
                <td>${evento.id}</td>
                <td>${evento.title}</td>
                <td>${evento.start}</td>
                <td>${evento.end}</td>
                <td>
                    <button class="btn btn-sm btn-info" onclick="verEvento(${evento.id})">Ver</button>
                </td>
            `;
            tbody.appendChild(tr);
        });
    }

    function verEvento(id) {
        axios.get(`${apiUrl}/${id}`)
            .then(function(response) {
                const evento = response.data;
                alert(`
                    Título: ${evento.title}
                    Inicio: ${evento.start}
                    Fin: ${evento.end}
                    Descripción: ${evento.description || 'Sin descripción'}
                `);
            })
            .catch(function(error) {
                console.error('Error al obtener detalles del evento:', error);
                alert('Error al obtener detalles del evento');
            });
    }
</script>
</body>
</html>
