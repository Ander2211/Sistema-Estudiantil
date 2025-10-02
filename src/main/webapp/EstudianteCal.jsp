
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
  <!-- Bootstrap -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <!-- FullCalendar -->
  <script src="https://cdn.jsdelivr.net/npm/fullcalendar/index.global.min.js"></script>
  <script src='https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js'></script>
</head>
<body class="container my-4">

<h2 class="mb-4 text-center">📚 Actividades Estudiantiles</h2>



<!-- CALENDARIO -->
<div id="calendar" class="mb-5"></div>



<script>
  let calendar;
  let apiUrl = '/sistema_escolar_war/api/calendario';

  // Inicializar calendario
  document.addEventListener('DOMContentLoaded', function () {
    let calendarEl = document.getElementById('calendar');
    calendar = new FullCalendar.Calendar(calendarEl, {
      initialView: 'dayGridMonth',
      events: async function (fetchInfo, successCallback, failureCallback) {
        try {
          let res = await axios.get(apiUrl);
          successCallback(res.data);
          renderTabla(res.data);
        } catch (err) {
          failureCallback(err);
        }
      },
      selectable: false
    });
    calendar.render();
  });

  // Formulario para crear evento
  document.getElementById('formEvento').addEventListener('submit', async function (e) {
    e.preventDefault();
    let evento = {
      titulo: document.getElementById('titulo').value,
      descripcion: document.getElementById('descripcion').value,
      fecha_inicio: document.getElementById('fechaInicio').value,
      fecha_fin: document.getElementById('fechaFin').value,
      color: document.getElementById('color').value
    };
    await axios.post(apiUrl, evento);
    calendar.refetchEvents();
    this.reset();
  });

  // Renderizar tabla de eventos con botones
  function renderTabla(eventos) {
    let tbody = document.querySelector('#tablaEventos tbody');
    tbody.innerHTML = '';
    eventos.forEach(e => {
      let fila = document.createElement('tr');
      fila.innerHTML = `
                <td>${e.id}</td>
                <td>${e.title}</td>
                <td>${e.start}</td>
                <td>${e.end}</td>
                <td>
                    <button class="btn btn-sm btn-warning me-2" onclick="editarEvento(${e.id}, '${e.title}', '${e.start}', '${e.end}', '${e.color}')">Editar</button>
                    <button class="btn btn-sm btn-danger" onclick="eliminarEvento(${e.id})">Eliminar</button>
                </td>
            `;
      tbody.appendChild(fila);
    });
  }

  // Eliminar evento
  async function eliminarEvento(id) {
    if (confirm("¿Seguro de eliminar este evento?")) {
      await axios.delete(`${apiUrl}/${id}`);
      calendar.refetchEvents();
    }
  }

  // Editar evento (rellena el form)
  async function editarEvento(id, titulo, inicio, fin, color) {
    document.getElementById('titulo').value = titulo;
    document.getElementById('fechaInicio').value = inicio;
    document.getElementById('fechaFin').value = fin;
    document.getElementById('color').value = color;

    // Cambiar acción del formulario a actualizar
    let form = document.getElementById('formEvento');
    form.onsubmit = async function (e) {
      e.preventDefault();
      let evento = {
        titulo: document.getElementById('titulo').value,
        fecha_inicio: document.getElementById('fechaInicio').value,
        fecha_fin: document.getElementById('fechaFin').value,
        color: document.getElementById('color').value,
        descripcion: document.getElementById('descripcion').value
      };
      await axios.put(`${apiUrl}/${id}`, evento);
      calendar.refetchEvents();
      form.reset();
      form.onsubmit = null; // volver al submit normal
      form.addEventListener('submit', arguments.callee);
    };
  }
</script>

</body>

</html>
