<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.poo.actividad.sistemaescolar.controller.HorarioController" %>
<%@ page import="com.poo.actividad.sistemaescolar.Model.Grado" %>
<%@ page import="java.util.List" %>
<%
    HorarioController controller = new HorarioController();
    List<Grado> grados = controller.obtenerTodosGrados();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Visualización de Horarios</title>

    <!-- FullCalendar CSS -->
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css' rel='stylesheet' />

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }

        .controls {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
            flex-wrap: wrap;
            align-items: end;
            justify-content: center;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }

        select, button {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        button {
            background-color: #28a745;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #218838;
        }

        #calendar {
            margin-top: 20px;
        }

        .event-info {
            font-size: 12px;
            margin-top: 2px;
            color: #666;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>📚 Horarios Escolares</h1>

    <div class="controls">
        <div class="form-group">
            <label for="gradoSelect">Grado y Turno:</label>
            <select id="gradoSelect">
                <option value="">-- Seleccionar Grado --</option>
                <% for (Grado grado : grados) { %>
                <option value="<%= grado.getId() %>">
                    <%= grado.getNombre() %> - <%= grado.getTurno() %>
                </option>
                <% } %>
            </select>
        </div>

        <button onclick="cargarHorarios()">Ver Horario</button>
    </div>

    <div id="calendar"></div>
</div>

<!-- FullCalendar JS -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/locales/es.min.js'></script>

<script>
    let calendar;

    document.addEventListener('DOMContentLoaded', function() {
        const calendarEl = document.getElementById('calendar');

        calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'timeGridWeek',
            locale: 'es',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay'
            },
            allDaySlot: false,
            slotMinTime: '07:00:00',
            slotMaxTime: '18:00:00',
            weekends: false,
            editable: false,
            selectable: false,
            eventContent: function(arg) {
                // Personalizar el contenido del evento
                return {
                    html: `
                            <div>
                                <div><strong>${arg.event.title}</strong></div>
                                <div class="event-info">${arg.timeText}</div>
                                <div class="event-info">${arg.event.extendedProps.materiaNombre}</div>
                            </div>
                        `
                };
            }
        });

        calendar.render();
    });

    function cargarHorarios() {
        const gradoId = document.getElementById('gradoSelect').value;
        if (!gradoId) {
            alert('Por favor seleccione un grado');
            return;
        }

        fetch('HorarioServlet?action=obtenerHorarios&gradoId=' + gradoId)
            .then(response => response.json())
            .then(horarios => {
                const events = horarios.map(horario => ({
                    id: horario.id,
                    title: horario.materiaNombre,
                    daysOfWeek: [diasSemanaToNumber(horario.diaSemana)],
                    startTime: horario.horaInicio,
                    endTime: horario.horaFin,
                    startRecur: horario.fechaInicio,
                    endRecur: horario.fechaFin,
                    extendedProps: {
                        materiaNombre: horario.materiaNombre,
                        gradoNombre: horario.gradoNombre,
                        gradoTurno: horario.gradoTurno
                    }
                }));

                calendar.removeAllEvents();
                calendar.addEventSource(events);
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error al cargar horarios');
            });
    }

    function diasSemanaToNumber(dia) {
        const dias = {'Lunes': 1, 'Martes': 2, 'Miércoles': 3, 'Jueves': 4, 'Viernes': 5};
        return dias[dia] || 1;
    }
</script>
</body>
</html>