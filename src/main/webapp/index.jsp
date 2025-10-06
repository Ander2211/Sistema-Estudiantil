<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sistema Escolar</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        body {
            background-color: #f8f9fa;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .welcome-container {
            text-align: center;
            padding: 2rem;
            background: white;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .welcome-title {
            color: #2c3e50;
            margin-bottom: 1.5rem;
        }
        .login-btn {
            padding: 1rem 3rem;
            font-size: 1.2rem;
            transition: transform 0.2s;
        }
        .login-btn:hover {
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <div class="welcome-container">
        <h1 class="welcome-title">Bienvenido al Sistema Escolar</h1>
        <p class="lead mb-4">Por favor, inicia sesión para acceder al sistema</p>
        <a href="${pageContext.request.contextPath}/views/auth/login.jsp" class="btn btn-primary btn-lg login-btn">
            <i class="bi bi-box-arrow-in-right"></i> Iniciar Sesión
        </a>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>