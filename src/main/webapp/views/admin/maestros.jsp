<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.poo.actividad.sistemaescolar.Model.Maestro" %>
<%
    List<Maestro> maestros = (List<Maestro>) request.getAttribute("maestros");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Gestión de Maestros</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .table-actions {
            white-space: nowrap;
        }
        .page-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<jsp:include page="../common/header.jsp"/>

<div class="container-fluid mt-4">
    <!-- Header de la página -->
    <div class="page-header">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1><i class="bi bi-person-badge me-3"></i>Gestión de Maestros</h1>
                <p class="lead mb-0">Administra los maestros del sistema educativo</p>
            </div>
            <div class="col-md-4 text-end">
                <a href="${pageContext.request.contextPath}/crearMaestro" class="btn btn-light">
                    <i class="bi bi-person-plus me-2"></i>Nuevo Maestro
                </a>
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-outline-light">
                    <i class="bi bi-arrow-left me-2"></i>Volver al Dashboard
                </a>
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

    <!-- Tarjeta de estadísticas -->
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="card bg-primary text-white">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h4 class="mb-0"><%= maestros != null ? maestros.size() : 0 %></h4>
                            <p class="mb-0">Total Maestros</p>
                        </div>
                        <div class="align-self-center">
                            <i class="bi bi-person-badge fs-1"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-success text-white">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h4 class="mb-0">
                                <%= maestros != null ? maestros.stream().filter(Maestro::isActivo).count() : 0 %>
                            </h4>
                            <p class="mb-0">Maestros Activos</p>
                        </div>
                        <div class="align-self-center">
                            <i class="bi bi-check-circle fs-1"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Tabla de maestros -->
    <div class="card">
        <div class="card-header">
            <h5 class="card-title mb-0">
                <i class="bi bi-list-ul me-2"></i>Lista de Maestros
            </h5>
        </div>
        <div class="card-body">
            <% if (maestros != null && !maestros.isEmpty()) { %>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Carnet</th>
                        <th>Nombre</th>
                        <th>Email</th>
                        <th>Estado</th>
                        <th class="text-center">Acciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (Maestro maestro : maestros) { %>
                    <tr>
                        <td><strong><%= maestro.getId() %></strong></td>
                        <td>
                                        <span class="badge bg-secondary">
                                            <i class="bi bi-person-badge me-1"></i><%= maestro.getCarnet() %>
                                        </span>
                        </td>
                        <td>
                            <i class="bi bi-person me-2"></i><%= maestro.getNombre() %>
                        </td>
                        <td>
                            <% if (maestro.getEmail() != null && !maestro.getEmail().isEmpty()) { %>
                            <i class="bi bi-envelope me-2"></i><%= maestro.getEmail() %>
                            <% } else { %>
                            <span class="text-muted">No especificado</span>
                            <% } %>
                        </td>
                        <td>
                                        <span class="badge <%= maestro.isActivo() ? "bg-success" : "bg-danger" %>">
                                            <i class="bi <%= maestro.isActivo() ? "bi-check-circle" : "bi-x-circle" %> me-1"></i>
                                            <%= maestro.isActivo() ? "Activo" : "Inactivo" %>
                                        </span>
                        </td>
                        <td class="table-actions text-center">
                            <a href="${pageContext.request.contextPath}/editarMaestro?id=<%= maestro.getId() %>"
                               class="btn btn-warning btn-sm"
                               title="Editar maestro">
                                <i class="bi bi-pencil"></i> Editar
                            </a>
                            <a href="${pageContext.request.contextPath}/eliminarMaestro?id=<%= maestro.getId() %>"
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('¿Estás seguro de eliminar al maestro <%= maestro.getNombre() %>?')"
                               title="Eliminar maestro">
                                <i class="bi bi-trash"></i> Eliminar
                            </a>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
            <% } else { %>
            <div class="text-center py-5">
                <i class="bi bi-person-x fs-1 text-muted"></i>
                <h4 class="text-muted mt-3">No hay maestros registrados</h4>
                <p class="text-muted">Comienza agregando el primer maestro al sistema.</p>
                <a href="${pageContext.request.contextPath}/crearMaestro" class="btn btn-primary">
                    <i class="bi bi-person-plus me-2"></i>Agregar Primer Maestro
                </a>
            </div>
            <% } %>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Auto-cierre de alertas después de 5 segundos
    document.addEventListener('DOMContentLoaded', function() {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(function(alert) {
            setTimeout(function() {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            }, 5000);
        });
    });
</script>
</body>
</html>