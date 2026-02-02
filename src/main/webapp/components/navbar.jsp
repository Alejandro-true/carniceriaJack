<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String currentUrl = request.getRequestURI();
String contextPath = request.getContextPath();
String nombreUsuario = (String) session.getAttribute("nombreCompleto");
String rol = (String) session.getAttribute("rol");
boolean esAdmin = "ADMIN".equals(rol);

if (nombreUsuario == null) {
	response.sendRedirect(contextPath + "/LoginController");
	return;
}
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
	<div class="container-fluid">
		<a class="navbar-brand" href="<%=contextPath%>/inicio.jsp"> <i
			class="fas fa-book-reader"></i> Sistema Biblioteca
		</a>

		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav me-auto">
				<li class="nav-item"><a
					class="nav-link <%=currentUrl.contains("inicio.jsp") ? "active" : ""%>"
					href="<%=contextPath%>/inicio.jsp"> <i class="fas fa-home"></i>
						Inicio
				</a></li>

				<li class="nav-item"><a
					class="nav-link <%=currentUrl.contains("AutoresController") ? "active" : ""%>"
					href="<%=contextPath%>/AutoresController?op=listar"> <i
						class="fas fa-users"></i> Autores
				</a></li>

				<li class="nav-item"><a
					class="nav-link <%=currentUrl.contains("LibrosController") ? "active" : ""%>"
					href="<%=contextPath%>/LibrosController?op=listar"> <i
						class="fas fa-book"></i> Libros
				</a></li>

				<%
				if (esAdmin) {
				%>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle <%=currentUrl.contains("UsuariosController") ? "active" : ""%>"
					href="#" id="adminDropdown" role="button" data-bs-toggle="dropdown"
					aria-expanded="false"> <i class="fas fa-cog"></i>
						Administración
				</a>
					<ul class="dropdown-menu" aria-labelledby="adminDropdown">
						<li><a class="dropdown-item"
							href="<%=contextPath%>/UsuariosController?op=listar"> <i
								class="fas fa-user-shield"></i> Usuarios
						</a></li>
						<li><hr class="dropdown-divider"></li>
						<li><a class="dropdown-item" href="#"> <i
								class="fas fa-chart-bar"></i> Reportes
						</a></li>
					</ul></li>
				<%
				}
				%>
			</ul>

			<!-- Usuario logueado -->
			<ul class="navbar-nav">
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="userDropdown"
					role="button" data-bs-toggle="dropdown" aria-expanded="false">
						<i class="fas fa-user-circle"></i> <%=nombreUsuario%> <%
 if (esAdmin) {
 %>
						<span class="badge bg-warning text-dark">Admin</span> <%
 }
 %>
				</a>
					<ul class="dropdown-menu dropdown-menu-end"
						aria-labelledby="userDropdown">
						<li>
							<h6 class="dropdown-header">
								<i class="fas fa-user"></i>
								<%=nombreUsuario%>
							</h6>
						</li>
						<li><hr class="dropdown-divider"></li>
						<li><a class="dropdown-item" href="#"> <i
								class="fas fa-user-edit"></i> Mi Perfil
						</a></li>
						<li><a class="dropdown-item" href="#"> <i
								class="fas fa-key"></i> Cambiar Contraseña
						</a></li>
						<li><hr class="dropdown-divider"></li>
						<li><a class="dropdown-item text-danger"
							href="<%=contextPath%>/LoginController?accion=logout"> <i
								class="fas fa-sign-out-alt"></i> Cerrar Sesión
						</a></li>
					</ul></li>
			</ul>
		</div>
	</div>
</nav>

<style>
.navbar {
	box-shadow: 0 2px 4px rgba(0, 0, 0, .1);
}

.navbar-brand {
	font-weight: bold;
	font-size: 1.3rem;
}

.nav-link.active {
	background-color: rgba(255, 255, 255, 0.2);
	border-radius: 5px;
}

.nav-link:hover {
	background-color: rgba(255, 255, 255, 0.1);
	border-radius: 5px;
}

.dropdown-menu {
	box-shadow: 0 4px 6px rgba(0, 0, 0, .1);
}

.badge {
	font-size: 0.7rem;
	vertical-align: middle;
}
</style>