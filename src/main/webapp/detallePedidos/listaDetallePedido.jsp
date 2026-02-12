<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.unu.poowebmodalga.beans.Pedido"%>
<%@ page import="com.unu.poowebmodalga.beans.DetallePedido"%>
<%@ page import="com.unu.poowebmodalga.beans.Producto"%>
<!DOCTYPE html>
<html lang="es">
<head>
<%
String url = request.getContextPath() + "/";
Pedido pedido = (Pedido) request.getAttribute("pedido");
List<DetallePedido> detalles = (List<DetallePedido>) request.getAttribute("detalles");

if (pedido == null) {
	response.sendRedirect(url + "PedidoController?op=listar");
	return;
}

int totalItems = (detalles != null) ? detalles.size() : 0;
int totalUnidades = 0;
if (detalles != null) {
	for (DetallePedido d : detalles) {
		totalUnidades += d.getCantidad();
	}
}
%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>📋 Detalle Pedido #<%=pedido.getIdPedido()%> — La
	Carnicería
</title>

<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=DM+Sans:wght@400;500;600&display=swap"
	rel="stylesheet">

<!-- Bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
	crossorigin="anonymous">

<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
/* ============================================================
   VARIABLES & BASE
   ============================================================ */
:root {
	--color-blood: #8B0000;
	--color-blood-deep: #6B0000;
	--color-blood-soft: #A52020;
	--color-cream: #FDF5EC;
	--color-bone: #E8DDD0;
	--color-charcoal: #2C2420;
	--color-smoke: #5C4A42;
	--color-gold: #C8A96E;
	--color-gold-light: #E2D0A4;
	--color-green: #2E7D4F;
	--color-blue: #3498DB;
	--font-title: 'Playfair Display', Georgia, serif;
	--font-body: 'DM Sans', system-ui, sans-serif;
	--shadow-card: 0 4px 24px rgba(44, 36, 32, 0.10);
	--transition: 0.28s cubic-bezier(.4, 0, .2, 1);
}

*, *::before, *::after {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-family: var(--font-body);
	background: var(--color-cream);
	color: var(--color-charcoal);
	min-height: 100vh;
}

body::before {
	content: '';
	position: fixed;
	inset: 0;
	background-image:
		url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.85' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='0.03'/%3E%3C/svg%3E");
	pointer-events: none;
	z-index: 0;
}

/* ============================================================
   HERO
   ============================================================ */
.hero-banner {
	position: relative;
	background: linear-gradient(135deg, var(--color-blue) 0%, #2980B9 100%);
	padding: 48px 0 52px;
	overflow: hidden;
	z-index: 1;
}

.hero-banner::after {
	content: '';
	position: absolute;
	bottom: -30px;
	left: -5%;
	width: 110%;
	height: 60px;
	background: var(--color-cream);
	transform: rotate(-1.2deg);
	z-index: 2;
}

.hero-content {
	position: relative;
	z-index: 1;
}

.back-btn {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	background: rgba(255, 255, 255, .15);
	color: #fff;
	padding: 8px 16px;
	border-radius: 8px;
	text-decoration: none;
	font-size: .85rem;
	font-weight: 600;
	margin-bottom: 16px;
	transition: background var(--transition);
	border: 1px solid rgba(255, 255, 255, .2);
}

.back-btn:hover {
	background: rgba(255, 255, 255, .25);
	color: #fff;
}

.hero-title {
	font-family: var(--font-title);
	font-size: clamp(1.8rem, 4vw, 2.4rem);
	font-weight: 800;
	color: #fff;
	margin-bottom: 8px;
}

.hero-subtitle {
	color: rgba(255, 255, 255, .8);
	font-size: .95rem;
}

/* ============================================================
   MAIN
   ============================================================ */
.main-wrap {
	padding: 32px 0 60px;
	position: relative;
	z-index: 1;
}

.content-grid {
	display: grid;
	grid-template-columns: 2fr 1fr;
	gap: 20px;
	margin-bottom: 20px;
}

.card-section {
	background: #fff;
	border-radius: 16px;
	padding: 24px;
	box-shadow: var(--shadow-card);
	border: 1px solid rgba(44, 36, 32, .05);
}

.section-header {
	display: flex;
	align-items: center;
	gap: 12px;
	margin-bottom: 20px;
	padding-bottom: 16px;
	border-bottom: 2px solid var(--color-bone);
}

.section-icon {
	width: 40px;
	height: 40px;
	border-radius: 10px;
	background: linear-gradient(135deg, var(--color-blue), #2980B9);
	color: #fff;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 1rem;
}

.section-header h2 {
	font-family: var(--font-title);
	font-size: 1.2rem;
	font-weight: 700;
	color: var(--color-charcoal);
	margin: 0;
}

/* Info Item */
.info-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 12px 0;
	border-bottom: 1px solid var(--color-bone);
}

.info-row:last-child {
	border-bottom: none;
}

.info-label {
	font-size: .85rem;
	color: var(--color-smoke);
	display: flex;
	align-items: center;
	gap: 8px;
}

.info-label i {
	color: var(--color-blue);
	font-size: .8rem;
}

.info-value {
	font-weight: 600;
	color: var(--color-charcoal);
	font-size: .9rem;
}

/* Summary */
.summary-total {
	background: linear-gradient(135deg, #F8F8F8, #F0F0F0);
	border-radius: 12px;
	padding: 18px;
	margin-top: 16px;
}

.summary-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
}

.summary-row:last-child {
	margin-bottom: 0;
	padding-top: 12px;
	border-top: 2px solid var(--color-bone);
}

.summary-label {
	font-size: .88rem;
	color: var(--color-smoke);
}

.summary-value {
	font-weight: 600;
	color: var(--color-charcoal);
}

.summary-total-label {
	font-family: var(--font-title);
	font-size: 1.1rem;
	font-weight: 700;
	color: var(--color-charcoal);
}

.summary-total-value {
	font-family: var(--font-title);
	font-size: 1.6rem;
	font-weight: 800;
	color: var(--color-blood);
}

/* Products Table */
.products-table {
	width: 100%;
	border-collapse: collapse;
}

.products-table thead {
	background: linear-gradient(135deg, var(--color-blue), #2980B9);
}

.products-table thead th {
	color: #fff;
	font-weight: 600;
	padding: 14px 12px;
	text-align: left;
	font-size: .78rem;
	text-transform: uppercase;
	letter-spacing: .6px;
}

.products-table tbody tr {
	border-bottom: 1px solid var(--color-bone);
	transition: background var(--transition);
}

.products-table tbody tr:hover {
	background: #F8FCFF;
}

.products-table tbody td {
	padding: 14px 12px;
	font-size: .88rem;
}

.product-name {
	font-weight: 600;
	color: var(--color-charcoal);
}

.product-image-mini {
	width: 50px;
	height: 50px;
	border-radius: 8px;
	object-fit: cover;
	background: #f0f0f0;
}

.qty-badge {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	min-width: 50px;
	padding: 6px 12px;
	background: var(--color-cream);
	border: 1px solid var(--color-bone);
	border-radius: 8px;
	font-weight: 700;
	font-size: .85rem;
	color: var(--color-charcoal);
}

.price-cell {
	font-family: var(--font-title);
	font-weight: 700;
	color: var(--color-smoke);
}

.subtotal-cell {
	font-family: var(--font-title);
	font-weight: 800;
	font-size: 1rem;
	color: var(--color-blood);
}

.empty-state {
	text-align: center;
	padding: 40px 20px;
	color: var(--color-smoke);
}

/* Actions */
.action-buttons {
	display: flex;
	gap: 10px;
	margin-top: 24px;
}

.btn-action {
	flex: 1;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
	padding: 12px 20px;
	border: none;
	border-radius: 10px;
	font-size: .88rem;
	font-weight: 600;
	cursor: pointer;
	transition: transform var(--transition), box-shadow var(--transition);
}

.btn-action:hover {
	transform: translateY(-2px);
}

.btn-action.print {
	background: linear-gradient(135deg, var(--color-green), #27AE60);
	color: #fff;
	box-shadow: 0 3px 12px rgba(46, 125, 79, .25);
}

.btn-action.print:hover {
	box-shadow: 0 5px 18px rgba(46, 125, 79, .35);
}

.btn-action.edit {
	background: linear-gradient(135deg, #F5A623, #E8961F);
	color: #fff;
	box-shadow: 0 3px 12px rgba(245, 166, 35, .25);
}

.btn-action.edit:hover {
	box-shadow: 0 5px 18px rgba(245, 166, 35, .35);
}

/* ============================================================
   RESPONSIVE
   ============================================================ */
@media ( max-width : 768px) {
	.content-grid {
		grid-template-columns: 1fr;
	}
	.products-table {
		font-size: .82rem;
	}
	.products-table th, .products-table td {
		padding: 10px 8px;
	}
	.action-buttons {
		flex-direction: column;
	}
}
</style>
</head>
<body>

	<!-- NAVBAR -->
	<jsp:include page="/components/navbar.jsp" />

	<!-- HERO -->
	<section class="hero-banner">
		<div class="container">
			<div class="hero-content">
				<a href="<%=url%>PedidoController?op=listar" class="back-btn"> <i
					class="fas fa-arrow-left"></i> Volver a Pedidos
				</a>
				<h1 class="hero-title">
					Pedido #<%=pedido.getIdPedido()%></h1>
				<p class="hero-subtitle">
					Cliente:
					<%=pedido.getIdCliente() != 0 ? pedido.getIdCliente() : "No especificado"%>
					• Fecha:
					<%=pedido.getFecha() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(pedido.getFecha())
		: "Sin fecha"%>
				</p>
			</div>
		</div>
	</section>

	<!-- MAIN -->
	<div class="main-wrap">
		<div class="container">

			<div class="content-grid">
				<!-- Detalles del Pedido -->
				<div class="card-section">
					<div class="section-header">
						<div class="section-icon">
							<i class="fas fa-receipt"></i>
						</div>
						<h2>Información del Pedido</h2>
					</div>

					<div class="info-row">
						<div class="info-label">
							<i class="fas fa-hashtag"></i> ID del Pedido
						</div>
						<div class="info-value">
							#<%=pedido.getIdPedido()%></div>
					</div>

					<div class="info-row">
						<div class="info-label">
							<i class="fas fa-user"></i> Cliente
						</div>
						<div class="info-value"><%=pedido.getIdCliente() != 0 ? pedido.getIdCliente() : "No especificado"%></div>
					</div>

					<div class="info-row">
						<div class="info-label">
							<i class="fas fa-calendar"></i> Fecha
						</div>
						<div class="info-value">
							<%=pedido.getFecha() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm").format(pedido.getFecha())
		: "Sin fecha"%>
						</div>
					</div>

					<div class="info-row">
						<div class="info-label">
							<i class="fas fa-boxes"></i> Total de Productos
						</div>
						<div class="info-value"><%=totalItems%>
							producto<%=totalItems != 1 ? "s" : ""%></div>
					</div>

					<div class="info-row">
						<div class="info-label">
							<i class="fas fa-layer-group"></i> Total de Unidades
						</div>
						<div class="info-value"><%=totalUnidades%>
							unidad<%=totalUnidades != 1 ? "es" : ""%></div>
					</div>
				</div>

				<!-- Resumen -->
				<div class="card-section">
					<div class="section-header">
						<div class="section-icon">
							<i class="fas fa-calculator"></i>
						</div>
						<h2>Resumen</h2>
					</div>

					<div class="summary-total">
						<div class="summary-row">
							<span class="summary-label">Subtotal</span> <span
								class="summary-value">S/. <%=String.format("%.2f", pedido.getTotal())%></span>
						</div>
						<div class="summary-row">
							<span class="summary-label">IGV (0%)</span> <span
								class="summary-value">S/. 0.00</span>
						</div>
						<div class="summary-row">
							<span class="summary-total-label">Total</span> <span
								class="summary-total-value">S/. <%=String.format("%.2f", pedido.getTotal())%></span>
						</div>
					</div>

					<div class="action-buttons">
						<button class="btn-action print" onclick="window.print()">
							<i class="fas fa-print"></i> Imprimir
						</button>
						<button class="btn-action edit"
							onclick="location.href='<%=url%>PedidoController?op=editar&id=<%=pedido.getIdPedido()%>'">
							<i class="fas fa-pen"></i> Editar
						</button>
					</div>
				</div>
			</div>

			<!-- Productos del Pedido -->
			<div class="card-section">
				<div class="section-header">
					<div class="section-icon">
						<i class="fas fa-shopping-basket"></i>
					</div>
					<h2>Productos del Pedido</h2>
				</div>

				<%
				if (detalles != null && !detalles.isEmpty()) {
				%>
				<div class="table-responsive">
					<table class="products-table">
						<thead>
							<tr>
								<th>Producto</th>
								<th>Precio Unitario</th>
								<th style="text-align: center;">Cantidad</th>
								<th style="text-align: right;">Subtotal</th>
							</tr>
						</thead>
						<tbody>
							<%
							for (DetallePedido detalle : detalles) {
								Producto producto = (Producto) detalle.getIdProducto();
								String nombreProducto = (producto != null) ? producto.getNombreProducto() : "Producto no encontrado";
							%>
							<tr>
								<td>
									<div class="product-name"><%=nombreProducto%></div> <small
									style="color: var(--color-smoke); font-size: .78rem;">ID:
										<%=detalle.getIdProducto()%></small>
								</td>
								<td class="price-cell">S/. <%=String.format("%.2f", detalle.getPrecioUnitario())%></td>
								<td style="text-align: center;"><span class="qty-badge"><%=detalle.getCantidad()%></span>
								</td>
								<td class="subtotal-cell" style="text-align: right;">S/. <%=String.format("%.2f", detalle.getSubtotal())%>
								</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
				<%
				} else {
				%>
				<div class="empty-state">
					<i class="fas fa-inbox"
						style="font-size: 3rem; opacity: .2; margin-bottom: 10px;"></i>
					<p>No hay productos en este pedido.</p>
				</div>
				<%
				}
				%>
			</div>

		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
		crossorigin="anonymous"></script>

</body>
</html>
