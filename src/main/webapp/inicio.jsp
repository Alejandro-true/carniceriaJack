<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
String url = request.getContextPath() + "/";
String nombreCompleto = (String) session.getAttribute("nombreCompleto");
String rol = (String) session.getAttribute("rol");
%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Inicio - Carniceria Jack</title>
<style>
.hero-section {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	color: white;
	padding: 60px 0;
	margin-bottom: 40px;
}

.card-module {
	border: none;
	border-radius: 15px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, .1);
	transition: transform 0.3s, box-shadow 0.3s;
	height: 100%;
}

.card-module:hover {
	transform: translateY(-5px);
	box-shadow: 0 8px 15px rgba(0, 0, 0, .2);
}

.card-module .card-body {
	padding: 30px;
	text-align: center;
}

.card-module i {
	font-size: 3rem;
	margin-bottom: 20px;
}

.module-autores {
	color: #667eea;
}

.module-libros {
	color: #764ba2;
}

.module-usuarios {
	color: #f093fb;
}

.module-reportes {
	color: #4facfe;
}
</style>
</head>
<body>

	<!-- Navbar -->
	<jsp:include page="/components/navbar.jsp" />

	<!-- Hero Section -->
	<div class="hero-section">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-md-8">
					<h1 class="display-4 mb-3">
						<i class="fas fa-hand-sparkles"></i> ¡Bienvenido,
						<%=nombreCompleto%>!
					</h1>
					<p class="lead">Carniceria Jack- Administra
						autores, libros y más</p>
				</div>
				<div class="col-md-4 text-end">
					<i class="fas fa-book-reader"
						style="font-size: 8rem; opacity: 0.3;"></i>
				</div>
			</div>
		</div>
	</div>

	<!-- Módulos del Sistema -->
	<div class="container mb-5">
		<h2 class="mb-4">
			<i class="fas fa-th-large"></i> Módulos del Sistema
		</h2>

		<div class="row g-4">
			<!-- Módulo Autores -->
			<div class="col-md-6 col-lg-3">
				<a href="<%=url%>AutoresController?op=listar"
					class="text-decoration-none">
					<div class="card card-module">
						<div class="card-body">
							<i class="fas fa-users module-autores"></i>
							<h5 class="card-title">Producto</h5>
							<p class="card-text text-muted">Gestiona la información de
								los productos</p>
						</div>
					</div>
				</a>
			</div>

			<!-- Módulo Libros -->
			<div class="col-md-6 col-lg-3">
				<a href="<%=url%>LibrosController?op=listar"
					class="text-decoration-none">
					<div class="card card-module">
						<div class="card-body">
							<i class="fas fa-book module-libros"></i>
							<h5 class="card-title">Libros</h5>
							<p class="card-text text-muted">Administra el catálogo de
								libros</p>
						</div>
					</div>
				</a>
			</div>

			<%
			if ("ADMIN".equals(rol)) {
			%>
			<!-- Módulo Usuarios (solo admin) -->
			<div class="col-md-6 col-lg-3">
				<a href="<%=url%>UsuariosController?op=listar"
					class="text-decoration-none">
					<div class="card card-module">
						<div class="card-body">
							<i class="fas fa-user-shield module-usuarios"></i>
							<h5 class="card-title">Usuarios</h5>
							<p class="card-text text-muted">Gestiona usuarios del sistema
							</p>
						</div>
					</div>
				</a>
			</div>

			<!-- Módulo Reportes (solo admin) -->
			<div class="col-md-6 col-lg-3">
				<a href="#" class="text-decoration-none">
					<div class="card card-module">
						<div class="card-body">
							<i class="fas fa-chart-bar module-reportes"></i>
							<h5 class="card-title">Reportes</h5>
							<p class="card-text text-muted">Visualiza estadísticas</p>
						</div>
					</div>
				</a>
			</div>
			<%
			}
			%>
		</div>
	</div>

	<!-- Información rápida -->
	<div class="container mb-5">
		<div class="row">
			<div class="col-md-12">
				<div class="card border-0 shadow-sm">
					<div class="card-body">
						<h5 class="card-title">
							<i class="fas fa-info-circle text-primary"></i> Información del
							Sistema
						</h5>
						<div class="row mt-3">
							<div class="col-md-4">
								<p>
									<strong>Usuario:</strong>
									<%=session.getAttribute("nombreUsuario")%></p>
								<p>
									<strong>Rol:</strong> <span class="badge bg-primary"><%=rol%></span>
								</p>
							</div>
							<div class="col-md-4">
								<p>
									<strong>Versión:</strong> 1.0.0
								</p>
								<p>
									<strong>Estado:</strong> <span class="badge bg-success">Activo</span>
								</p>
							</div>
							<div class="col-md-4">
								<p>
									<strong>Base de Datos:</strong> MySQL
								</p>
								<p>
									<strong>Conexión:</strong> <span class="badge bg-success">
										<i class="fas fa-check"></i> Conectado
									</span>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Footer -->
	<footer class="bg-light py-4 mt-5">
		<div class="container text-center">
			<p class="text-muted mb-0">
				<i class="fas fa-book-reader"></i> Sistema de Biblioteca &copy; 2025
				- Todos los derechos reservados
			</p>
		</div>
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
		crossorigin="anonymous"></script>

</body>
</html>