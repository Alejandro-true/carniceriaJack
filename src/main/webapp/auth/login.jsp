<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
String url = request.getContextPath() + "/";
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
<title>Iniciar Sesión - Sistema Biblioteca</title>
<style>
body {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	min-height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
}

.login-container {
	max-width: 450px;
	width: 100%;
	padding: 20px;
}

.login-card {
	background: white;
	border-radius: 15px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
	overflow: hidden;
}

.login-header {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	color: white;
	padding: 30px;
	text-align: center;
}

.login-header i {
	font-size: 3rem;
	margin-bottom: 10px;
}

.login-body {
	padding: 40px;
}

.form-control:focus {
	border-color: #667eea;
	box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
}

.btn-login {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	border: none;
	padding: 12px;
	font-weight: 600;
	transition: transform 0.2s;
}

.btn-login:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
}

.input-group-text {
	background-color: #f8f9fa;
	border-right: none;
}

.form-control {
	border-left: none;
}
</style>
</head>
<body>

	<div class="login-container">
		<div class="login-card">
			<div class="login-header">
				<i class="fas fa-book-reader"></i>
				<h3 class="mb-0">Sistema de Biblioteca</h3>
				<p class="mb-0 mt-2">Iniciar Sesión</p>
			</div>

			<div class="login-body">
				<!-- Mensajes de error -->
				<%
				String error = (String) request.getAttribute("error");
				if (error != null) {
				%>
				<div class="alert alert-danger alert-dismissible fade show"
					role="alert">
					<i class="fas fa-exclamation-circle"></i>
					<%=error%>
					<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
				</div>
				<%
				}
				%>

				<!-- Formulario de login -->
				<form action="<%=url%>LoginController" method="POST" id="formLogin">
					<input type="hidden" name="accion" value="login">

					<div class="mb-3">
						<label for="usuario" class="form-label"> <i
							class="fas fa-user"></i> Usuario
						</label>
						<div class="input-group">
							<span class="input-group-text"> <i class="fas fa-user"></i>
							</span> <input type="text" class="form-control" name="usuario"
								id="usuario" placeholder="Nombre de usuario" required autofocus>
						</div>
					</div>

					<div class="mb-4">
						<label for="password" class="form-label"> <i
							class="fas fa-lock"></i> Contraseña
						</label>
						<div class="input-group">
							<span class="input-group-text"> <i class="fas fa-lock"></i>
							</span> <input type="password" class="form-control" name="password"
								id="password" placeholder="Contraseña" required>
							<button class="btn btn-outline-secondary" type="button"
								id="togglePassword">
								<i class="fas fa-eye"></i>
							</button>
						</div>
					</div>

					<div class="d-grid">
						<button type="submit" class="btn btn-primary btn-login">
							<i class="fas fa-sign-in-alt"></i> Iniciar Sesión
						</button>
					</div>
				</form>

				<!-- Información de acceso -->
				<div class="mt-4 text-center">
					<small class="text-muted"> <i class="fas fa-info-circle"></i>
						Usuario: <strong>admin</strong> | Contraseña: <strong>admin123</strong>
					</small>
				</div>
			</div>
		</div>

		<div class="text-center mt-3 text-white">
			<small>&copy; 2025 Sistema de Biblioteca - Todos los derechos
				reservados</small>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
		crossorigin="anonymous"></script>

	<script>
		// Toggle para mostrar/ocultar contraseña
		document.getElementById('togglePassword').addEventListener('click',
				function() {
					const passwordInput = document.getElementById('password');
					const icon = this.querySelector('i');

					if (passwordInput.type === 'password') {
						passwordInput.type = 'text';
						icon.classList.remove('fa-eye');
						icon.classList.add('fa-eye-slash');
					} else {
						passwordInput.type = 'password';
						icon.classList.remove('fa-eye-slash');
						icon.classList.add('fa-eye');
					}
				});

		// Animación al enviar formulario
		document
				.getElementById('formLogin')
				.addEventListener(
						'submit',
						function(e) {
							const btn = this
									.querySelector('button[type="submit"]');
							btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Iniciando sesión...';
							btn.disabled = true;
						});
	</script>

</body>
</html>