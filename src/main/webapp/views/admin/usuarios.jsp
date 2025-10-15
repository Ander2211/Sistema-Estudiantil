<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.poo.actividad.sistemaescolar.Model.Usuario" %>
<%
  List<Usuario> usuarios = (List<Usuario>) request.getAttribute("usuarios");
  String searchTerm = request.getParameter("search") != null ? request.getParameter("search") : "";
  String roleFilter = request.getParameter("role") != null ? request.getParameter("role") : "";
  String statusFilter = request.getParameter("status") != null ? request.getParameter("status") : "";
%>
<!DOCTYPE html>
<html>
<head>
  <title>Gestión de Usuarios</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
  <style>
    .search-section {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      border-radius: 15px;
      padding: 25px;
      margin-bottom: 25px;
    }
    .filter-card {
      background: #f8f9fa;
      border: 1px solid #dee2e6;
      border-radius: 10px;
      transition: all 0.3s ease;
    }
    .filter-card:hover {
      box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }
    .table-actions {
      white-space: nowrap;
    }
    .user-avatar {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-weight: bold;
      font-size: 14px;
    }
    .stats-card {
      border-left: 4px solid;
      border-radius: 10px;
      transition: transform 0.2s ease;
    }
    .stats-card:hover {
      transform: translateY(-2px);
    }
    .search-btn {
      border-radius: 25px;
      padding: 8px 25px;
    }
  </style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>

<div class="container-fluid mt-4">
  <!-- Header de la página -->
  <div class="row mb-4">
    <div class="col-12">
      <div class="d-flex justify-content-between align-items-center">
        <div>
          <h1><i class="bi bi-people-fill me-3"></i>Gestión de Usuarios</h1>
          <p class="lead mb-0">Administra todos los usuarios del sistema</p>
        </div>
        <div>
          <a href="${pageContext.request.contextPath}/crearUsuario" class="btn btn-primary btn-lg">
            <i class="bi bi-person-plus me-2"></i>Nuevo Usuario
          </a>
        </div>
      </div>
    </div>
  </div>

  <!-- Mensajes de éxito/error -->
  <% if (request.getParameter("success") != null) { %>
  <div class="alert alert-success alert-dismissible fade show" role="alert">
    <i class="bi bi-check-circle me-2"></i><%= request.getParameter("success") %>
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
  </div>
  <% } %>
  <% if (request.getParameter("error") != null) { %>
  <div class="alert alert-danger alert-dismissible fade show" role="alert">
    <i class="bi bi-exclamation-triangle me-2"></i><%= request.getParameter("error") %>
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
  </div>
  <% } %>

  <!-- Tarjetas de Estadísticas -->
  <div class="row mb-4">
    <div class="col-xl-3 col-md-6 mb-4">
      <div class="card stats-card border-left-primary text-white bg-primary h-100">
        <div class="card-body">
          <div class="d-flex justify-content-between">
            <div>
              <h3 class="mb-0"><%= usuarios != null ? usuarios.size() : 0 %></h3>
              <p class="mb-0">Total Usuarios</p>
            </div>
            <div class="align-self-center">
              <i class="bi bi-people fs-1 opacity-50"></i>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="col-xl-3 col-md-6 mb-4">
      <%
        long estudiantesCount = usuarios != null ? usuarios.stream().filter(u -> "estudiante".equals(u.getRol())).count() : 0;
        long maestrosCount = usuarios != null ? usuarios.stream().filter(u -> "maestro".equals(u.getRol())).count() : 0;
        long adminsCount = usuarios != null ? usuarios.stream().filter(u -> "admin".equals(u.getRol())).count() : 0;
      %>
      <div class="card stats-card border-left-success text-white bg-success h-100">
        <div class="card-body">
          <div class="d-flex justify-content-between">
            <div>
              <h3 class="mb-0"><%= estudiantesCount %></h3>
              <p class="mb-0">Estudiantes</p>
            </div>
            <div class="align-self-center">
              <i class="bi bi-mortarboard fs-1 opacity-50"></i>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="col-xl-3 col-md-6 mb-4">
      <div class="card stats-card border-left-warning text-white bg-warning h-100">
        <div class="card-body">
          <div class="d-flex justify-content-between">
            <div>
              <h3 class="mb-0"><%= maestrosCount %></h3>
              <p class="mb-0">Maestros</p>
            </div>
            <div class="align-self-center">
              <i class="bi bi-person-badge fs-1 opacity-50"></i>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="col-xl-3 col-md-6 mb-4">
      <div class="card stats-card border-left-danger text-white bg-danger h-100">
        <div class="card-body">
          <div class="d-flex justify-content-between">
            <div>
              <h3 class="mb-0"><%= adminsCount %></h3>
              <p class="mb-0">Administradores</p>
            </div>
            <div class="align-self-center">
              <i class="bi bi-shield-check fs-1 opacity-50"></i>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Sistema de Búsqueda Avanzada -->
  <div class="card filter-card mb-4">
    <div class="card-header bg-transparent">
      <h5 class="card-title mb-0">
        <i class="bi bi-search me-2"></i>Sistema de Búsqueda Avanzada
      </h5>
    </div>
    <div class="card-body">
      <form method="get" action="${pageContext.request.contextPath}/usuarios" id="searchForm">
        <div class="row g-3">
          <!-- Búsqueda por texto -->
          <div class="col-md-4">
            <label for="search" class="form-label">Buscar Usuarios</label>
            <div class="input-group">
              <span class="input-group-text"><i class="bi bi-search"></i></span>
              <input type="text" class="form-control" id="search" name="search"
                     value="<%= searchTerm %>" placeholder="Buscar por nombre, carnet o email...">
            </div>
          </div>

          <!-- Filtro por Rol -->
          <div class="col-md-3">
            <label for="role" class="form-label">Filtrar por Rol</label>
            <select class="form-select" id="role" name="role">
              <option value="">Todos los roles</option>
              <option value="estudiante" <%= "estudiante".equals(roleFilter) ? "selected" : "" %>>Estudiantes</option>
              <option value="maestro" <%= "maestro".equals(roleFilter) ? "selected" : "" %>>Maestros</option>
              <option value="admin" <%= "admin".equals(roleFilter) ? "selected" : "" %>>Administradores</option>
            </select>
          </div>

          <!-- Filtro por Estado -->
          <div class="col-md-3">
            <label for="status" class="form-label">Filtrar por Estado</label>
            <select class="form-select" id="status" name="status">
              <option value="">Todos los estados</option>
              <option value="activo" <%= "activo".equals(statusFilter) ? "selected" : "" %>>Activos</option>
              <option value="inactivo" <%= "inactivo".equals(statusFilter) ? "selected" : "" %>>Inactivos</option>
            </select>
          </div>

          <!-- Botones de acción -->
          <div class="col-md-2 d-flex align-items-end">
            <button type="submit" class="btn btn-primary search-btn me-2 w-100">
              <i class="bi bi-funnel me-1"></i>Filtrar
            </button>
          </div>
        </div>

        <!-- Filtros rápidos -->
        <div class="row mt-3">
          <div class="col-12">
            <label class="form-label">Filtros Rápidos:</label>
            <div class="btn-group" role="group">
              <button type="button" class="btn btn-outline-primary btn-sm quick-filter" data-role="estudiante">
                <i class="bi bi-mortarboard me-1"></i>Estudiantes
              </button>
              <button type="button" class="btn btn-outline-success btn-sm quick-filter" data-role="maestro">
                <i class="bi bi-person-badge me-1"></i>Maestros
              </button>
              <button type="button" class="btn btn-outline-danger btn-sm quick-filter" data-role="admin">
                <i class="bi bi-shield-check me-1"></i>Admins
              </button>
              <button type="button" class="btn btn-outline-warning btn-sm" onclick="clearFilters()">
                <i class="bi bi-x-circle me-1"></i>Limpiar
              </button>
            </div>
          </div>
        </div>
      </form>
    </div>
  </div>

  <!-- Resultados de Búsqueda -->
  <div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
      <h5 class="card-title mb-0">
        <i class="bi bi-list-ul me-2"></i>Resultados de Usuarios
        <span class="badge bg-primary ms-2" id="resultCount">
                    <%= usuarios != null ? usuarios.size() : 0 %> usuarios
                </span>
      </h5>
      <div class="dropdown">
        <button class="btn btn-outline-secondary btn-sm dropdown-toggle" type="button"
                data-bs-toggle="dropdown" aria-expanded="false">
          <i class="bi bi-download me-1"></i>Exportar
        </button>
        <ul class="dropdown-menu">
          <li><a class="dropdown-item" href="#" onclick="exportToPDF()"><i class="bi bi-file-pdf me-2"></i>PDF</a></li>
          <li><a class="dropdown-item" href="#" onclick="exportToExcel()"><i class="bi bi-file-excel me-2"></i>Excel</a></li>
        </ul>
      </div>
    </div>
    <div class="card-body">
      <% if (usuarios != null && !usuarios.isEmpty()) { %>
      <div class="table-responsive">
        <table class="table table-striped table-hover" id="usersTable">
          <thead class="table-dark">
          <tr>
            <th width="60px">Avatar</th>
            <th>ID</th>
            <th>Carnet</th>
            <th>Nombre</th>
            <th>Email</th>
            <th>Rol</th>
            <th>Grado</th>
            <th>Turno</th>
            <th>Estado</th>
            <th class="text-center" width="150px">Acciones</th>
          </tr>
          </thead>
          <tbody>
          <% for (Usuario usuario : usuarios) {
            String avatarText = usuario.getNombre() != null && !usuario.getNombre().isEmpty()
                    ? usuario.getNombre().substring(0, 1).toUpperCase()
                    : "U";
            String roleBadgeClass = "";
            switch(usuario.getRol()) {
              case "admin": roleBadgeClass = "bg-danger"; break;
              case "maestro": roleBadgeClass = "bg-warning"; break;
              case "estudiante": roleBadgeClass = "bg-info"; break;
              default: roleBadgeClass = "bg-secondary";
            }
          %>
          <tr>
            <td>
              <div class="user-avatar" title="<%= usuario.getNombre() %>">
                <%= avatarText %>
              </div>
            </td>
            <td><strong>#<%= usuario.getId() %></strong></td>
            <td>
                                        <span class="badge bg-secondary">
                                            <i class="bi bi-person-badge me-1"></i><%= usuario.getCarnet() %>
                                        </span>
            </td>
            <td>
              <div class="d-flex align-items-center">
                <i class="bi bi-person me-2 text-muted"></i>
                <div>
                  <div class="fw-bold"><%= usuario.getNombre() %></div>
                  <% if (usuario.getEmail() != null && !usuario.getEmail().isEmpty()) { %>
                  <small class="text-muted"><%= usuario.getEmail() %></small>
                  <% } %>
                </div>
              </div>
            </td>
            <td>
              <% if (usuario.getEmail() != null && !usuario.getEmail().isEmpty()) { %>
              <a href="mailto:<%= usuario.getEmail() %>" class="text-decoration-none">
                <i class="bi bi-envelope me-1"></i><%= usuario.getEmail() %>
              </a>
              <% } else { %>
              <span class="text-muted">No especificado</span>
              <% } %>
            </td>
            <td>
                                        <span class="badge <%= roleBadgeClass %>">
                                            <i class="bi
                                                <%= "admin".equals(usuario.getRol()) ? "bi-shield-check" :
                                                   "maestro".equals(usuario.getRol()) ? "bi-person-badge" :
                                                   "bi-mortarboard" %>
                                                me-1">
                                            </i>
                                            <%= usuario.getRol() %>
                                        </span>
            </td>
            <td>
              <% if (usuario.getGrado() != null && !usuario.getGrado().isEmpty()) { %>
              <span class="badge bg-light text-dark">
                                                <i class="bi bi-book me-1"></i><%= usuario.getGrado() %>
                                            </span>
              <% } else { %>
              <span class="text-muted">-</span>
              <% } %>
            </td>
            <td>
              <% if (usuario.getTurno() != null && !usuario.getTurno().isEmpty()) { %>
              <span class="badge bg-light text-dark">
                                                <i class="bi bi-clock me-1"></i><%= usuario.getTurno() %>
                                            </span>
              <% } else { %>
              <span class="text-muted">-</span>
              <% } %>
            </td>
            <td>
                                        <span class="badge <%= usuario.isActivo() ? "bg-success" : "bg-danger" %>">
                                            <i class="bi <%= usuario.isActivo() ? "bi-check-circle" : "bi-x-circle" %> me-1"></i>
                                            <%= usuario.isActivo() ? "Activo" : "Inactivo" %>
                                        </span>
            </td>
            <td class="table-actions text-center">
              <div class="btn-group" role="group">
                <a href="${pageContext.request.contextPath}/editarUsuario?id=<%= usuario.getId() %>"
                   class="btn btn-warning btn-sm"
                   title="Editar usuario">
                  <i class="bi bi-pencil"></i>
                </a>
                <a href="${pageContext.request.contextPath}/eliminarUsuario?id=<%= usuario.getId() %>"
                   class="btn btn-danger btn-sm"
                   onclick="return confirm('¿Estás seguro de eliminar a <%= usuario.getNombre() %>?')"
                   title="Eliminar usuario">
                  <i class="bi bi-trash"></i>
                </a>
              </div>
            </td>
          </tr>
          <% } %>
          </tbody>
        </table>
      </div>
      <% } else { %>
      <div class="text-center py-5">
        <i class="bi bi-search fs-1 text-muted"></i>
        <h4 class="text-muted mt-3">No se encontraron usuarios</h4>
        <p class="text-muted">Intenta ajustar los filtros de búsqueda o crear un nuevo usuario.</p>
        <a href="${pageContext.request.contextPath}/crearUsuario" class="btn btn-primary">
          <i class="bi bi-person-plus me-2"></i>Crear Primer Usuario
        </a>
        <button class="btn btn-outline-secondary ms-2" onclick="clearFilters()">
          <i class="bi bi-arrow-clockwise me-2"></i>Limpiar Filtros
        </button>
      </div>
      <% } %>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Filtros rápidos
  document.querySelectorAll('.quick-filter').forEach(button => {
    button.addEventListener('click', function() {
      const role = this.getAttribute('data-role');
      document.getElementById('role').value = role;
      document.getElementById('searchForm').submit();
    });
  });

  // Limpiar filtros
  function clearFilters() {
    document.getElementById('search').value = '';
    document.getElementById('role').value = '';
    document.getElementById('status').value = '';
    document.getElementById('searchForm').submit();
  }

  // Búsqueda en tiempo real (opcional - para futuras implementaciones)
  let searchTimeout;
  document.getElementById('search').addEventListener('input', function() {
    clearTimeout(searchTimeout);
    searchTimeout = setTimeout(() => {
      // Para búsqueda en tiempo real, necesitarías AJAX
      // Por ahora solo submit del form
      if (this.value.length === 0 || this.value.length >= 3) {
        document.getElementById('searchForm').submit();
      }
    }, 500);
  });

  // Exportar funciones (placeholders)
  function exportToPDF() {
    alert('Función de exportación a PDF - Próximamente');
    // Implementar lógica de exportación a PDF
  }

  function exportToExcel() {
    alert('Función de exportación a Excel - Próximamente');
    // Implementar lógica de exportación a Excel
  }

  // Auto-cierre de alertas
  document.addEventListener('DOMContentLoaded', function() {
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(function(alert) {
      setTimeout(function() {
        const bsAlert = new bootstrap.Alert(alert);
        bsAlert.close();
      }, 5000);
    });

    // Actualizar contador de resultados
    const rowCount = document.querySelectorAll('#usersTable tbody tr').length;
    document.getElementById('resultCount').textContent = rowCount + ' usuarios';
  });
</script>
</body>
</html>