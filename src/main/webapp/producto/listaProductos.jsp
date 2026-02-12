<%@page import="com.unu.poowebmodalga.beans.Usuario"%>
<%@page import="com.unu.poowebmodalga.beans.Producto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html lang="es">
<head>
<%
String url = request.getContextPath() + "/";
Usuario usuario = (Usuario) request.getAttribute("usuario");
List<Producto> listaProducto = (List<Producto>) request.getAttribute("listaProducto");
int totalProductos = (listaProducto != null) ? listaProducto.size() : 0;
double totalPrecio = 0;
int totalStock = 0;
if (listaProducto != null) {
	for (Producto p : listaProducto) {
		totalPrecio += p.getPrecioUnitario() * p.getStock();
		totalStock += p.getStock();
	}
}
%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>🥩 La Carnicería — Gestión de Productos</title>

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
	--color-cream-dark: #F0E6D8;
	--color-bone: #E8DDD0;
	--color-charcoal: #2C2420;
	--color-smoke: #5C4A42;
	--color-gold: #C8A96E;
	--color-gold-light: #E2D0A4;
	--color-green: #2E7D4F;
	--color-green-soft: #3DA86B;
	--font-title: 'Playfair Display', Georgia, serif;
	--font-body: 'DM Sans', system-ui, sans-serif;
	--radius: 10px;
	--shadow-card: 0 4px 24px rgba(44, 36, 32, 0.10);
	--shadow-hover: 0 8px 32px rgba(139, 0, 0, 0.18);
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
	position: relative;
	overflow-x: hidden;
}

/* Subtle noise texture overlay */
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
   HERO BANNER
   ============================================================ */
.hero-banner {
	position: relative;
	background: linear-gradient(135deg, var(--color-blood-deep) 0%,
		var(--color-blood) 50%, var(--color-blood-soft) 100%);
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

.hero-banner::before {
	content: '';
	position: absolute;
	inset: 0;
	background: radial-gradient(ellipse 320px 180px at 12% 60%, rgba(255, 255, 255, .04)
		0%, transparent 70%),
		radial-gradient(ellipse 200px 260px at 85% 40%, rgba(255, 255, 255, .03)
		0%, transparent 70%),
		radial-gradient(circle 90px at 50% 80%, rgba(255, 255, 255, .025) 0%,
		transparent 70%);
	pointer-events: none;
}

.hero-content {
	position: relative;
	z-index: 1;
	display: flex;
	align-items: center;
	justify-content: space-between;
	flex-wrap: wrap;
	gap: 16px;
}

.hero-left h1 {
	font-family: var(--font-title);
	font-size: clamp(1.8rem, 4vw, 2.6rem);
	font-weight: 800;
	color: #fff;
	line-height: 1.15;
	text-shadow: 0 2px 12px rgba(0, 0, 0, .25);
}

.hero-left h1 .gold {
	color: var(--color-gold-light);
}

.hero-left p {
	color: rgba(255, 255, 255, .72);
	font-size: .95rem;
	margin-top: 8px;
	font-weight: 400;
}

.category-pills {
	display: flex;
	flex-wrap: wrap;
	gap: 8px;
	margin-top: 18px;
}

.cat-pill {
	display: inline-flex;
	align-items: center;
	gap: 6px;
	background: rgba(255, 255, 255, .12);
	border: 1px solid rgba(255, 255, 255, .22);
	backdrop-filter: blur(4px);
	color: #fff;
	padding: 6px 14px;
	border-radius: 30px;
	font-size: .82rem;
	font-weight: 500;
	letter-spacing: .3px;
	transition: background var(--transition), transform var(--transition);
	cursor: default;
}

.cat-pill:hover {
	background: rgba(255, 255, 255, .22);
	transform: translateY(-1px);
}

.cat-pill i {
	font-size: .78rem;
	opacity: .85;
}

.btn-nuevo {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	background: linear-gradient(135deg, var(--color-gold), #b8945a);
	color: var(--color-charcoal);
	font-family: var(--font-body);
	font-weight: 600;
	font-size: .92rem;
	padding: 12px 26px;
	border: none;
	border-radius: 40px;
	box-shadow: 0 4px 18px rgba(200, 169, 110, .35);
	cursor: pointer;
	transition: transform var(--transition), box-shadow var(--transition);
	text-decoration: none;
}

.btn-nuevo:hover {
	transform: translateY(-2px);
	box-shadow: 0 6px 24px rgba(200, 169, 110, .45);
}

.btn-nuevo i {
	font-size: .88rem;
}

/* ============================================================
   STATS BAR
   ============================================================ */
.stats-bar {
	position: relative;
	z-index: 1;
	display: flex;
	gap: 12px;
	flex-wrap: wrap;
	margin-top: -22px;
	padding: 0 15px;
	justify-content: center;
}

.stat-card {
	flex: 1 1 140px;
	max-width: 200px;
	background: #fff;
	border-radius: 14px;
	padding: 16px 18px;
	box-shadow: var(--shadow-card);
	display: flex;
	align-items: center;
	gap: 14px;
	transition: transform var(--transition), box-shadow var(--transition);
}

.stat-card:hover {
	transform: translateY(-2px);
	box-shadow: var(--shadow-hover);
}

.stat-icon {
	width: 42px;
	height: 42px;
	border-radius: 12px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 1.1rem;
	flex-shrink: 0;
}

.stat-icon.red {
	background: #FEE8E8;
	color: var(--color-blood);
}

.stat-icon.brown {
	background: #F5EBE0;
	color: #8B5E3C;
}

.stat-icon.green {
	background: #E6F7ED;
	color: var(--color-green);
}

.stat-icon.gold {
	background: #FFF8E6;
	color: var(--color-gold);
}

.stat-info .stat-number {
	font-family: var(--font-title);
	font-size: 1.35rem;
	font-weight: 700;
}

.stat-info .stat-label {
	font-size: .76rem;
	color: var(--color-smoke);
	text-transform: uppercase;
	letter-spacing: .6px;
}

/* ============================================================
   MAIN CONTENT
   ============================================================ */
.main-wrap {
	position: relative;
	z-index: 1;
	padding: 28px 0 60px;
}

.alert-carnic {
	border: none;
	border-left: 4px solid var(--color-gold);
	background: #FFF9EE;
	color: var(--color-smoke);
	border-radius: 0 10px 10px 0;
	padding: 14px 18px;
	font-size: .9rem;
	box-shadow: 0 2px 8px rgba(44, 36, 32, .06);
}

/* ============================================================
   PRODUCT GRID
   ============================================================ */
.products-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
	gap: 20px;
	padding: 0;
}

/* Product Card */
.product-card {
	background: #fff;
	border-radius: 16px;
	overflow: hidden;
	box-shadow: var(--shadow-card);
	border: 1px solid rgba(44, 36, 32, .06);
	transition: transform var(--transition), box-shadow var(--transition);
	display: flex;
	flex-direction: column;
	animation: cardIn .4s ease both;
}

.product-card:hover {
	transform: translateY(-4px);
	box-shadow: 0 12px 40px rgba(44, 36, 32, .15);
}

@
keyframes cardIn {from { opacity:0;
	transform: translateY(20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.product-card:nth-child(1) {
	animation-delay: .05s;
}

.product-card:nth-child(2) {
	animation-delay: .10s;
}

.product-card:nth-child(3) {
	animation-delay: .15s;
}

.product-card:nth-child(4) {
	animation-delay: .20s;
}

.product-card:nth-child(5) {
	animation-delay: .25s;
}

.product-card:nth-child(6) {
	animation-delay: .30s;
}

.product-card:nth-child(7) {
	animation-delay: .35s;
}

.product-card:nth-child(8) {
	animation-delay: .40s;
}

.product-card:nth-child(9) {
	animation-delay: .45s;
}

/* Image Container */
.product-image {
	position: relative;
	width: 100%;
	height: 220px;
	background: linear-gradient(135deg, #f8f8f8, #e8e8e8);
	overflow: hidden;
}

.product-image img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	transition: transform var(--transition);
}

.product-card:hover .product-image img {
	transform: scale(1.05);
}

/* Placeholder when no image */
.product-image-placeholder {
	width: 100%;
	height: 100%;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	gap: 8px;
	background: linear-gradient(135deg, #f5f5f5, #ececec);
	color: #ccc;
}

.product-image-placeholder i {
	font-size: 3rem;
}

.product-image-placeholder span {
	font-size: .8rem;
	font-weight: 500;
}

/* ID Badge on image */
.product-id-badge {
	position: absolute;
	top: 12px;
	left: 12px;
	min-width: 36px;
	height: 32px;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 0 10px;
	background: linear-gradient(135deg, var(--color-blood),
		var(--color-blood-soft));
	color: #fff;
	border-radius: 8px;
	font-weight: 700;
	font-size: .82rem;
	font-family: var(--font-title);
	box-shadow: 0 2px 8px rgba(139, 0, 0, .3);
}

/* Category badge on image */
.product-cat-badge {
	position: absolute;
	top: 12px;
	right: 12px;
	display: inline-flex;
	align-items: center;
	gap: 5px;
	padding: 5px 12px;
	border-radius: 20px;
	font-size: .75rem;
	font-weight: 600;
	backdrop-filter: blur(8px);
	box-shadow: 0 2px 8px rgba(0, 0, 0, .15);
}

.product-cat-badge.res {
	background: rgba(255, 228, 228, .95);
	color: #8B0000;
}

.product-cat-badge.chancho {
	background: rgba(255, 240, 224, .95);
	color: #B56A1B;
}

.product-cat-badge.embutido {
	background: rgba(239, 228, 245, .95);
	color: #6B3FA0;
}

.product-cat-badge.default {
	background: rgba(232, 221, 208, .95);
	color: var(--color-smoke);
}

.product-cat-badge i {
	font-size: .7rem;
}

/* Card Body */
.product-body {
	padding: 18px;
	flex: 1;
	display: flex;
	flex-direction: column;
}

.product-name {
	font-family: var(--font-title);
	font-weight: 700;
	font-size: 1.1rem;
	color: var(--color-charcoal);
	margin-bottom: 8px;
	line-height: 1.3;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
}

/* Info row (stock + price) */
.product-info {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-bottom: 14px;
	padding-bottom: 14px;
	border-bottom: 1px solid var(--color-bone);
}

.stock-badge {
	display: inline-flex;
	align-items: center;
	gap: 5px;
	padding: 5px 11px;
	border-radius: 20px;
	font-weight: 600;
	font-size: .8rem;
}

.stock-badge.ok {
	background: #E8F7EF;
	color: var(--color-green);
}

.stock-badge.low {
	background: #FFF3CD;
	color: #856404;
}

.stock-badge.empty {
	background: #F8D7DA;
	color: #721C24;
}

.stock-badge i {
	font-size: .72rem;
}

.product-price {
	font-family: var(--font-title);
	font-weight: 700;
	font-size: 1.3rem;
	color: var(--color-blood);
	line-height: 1;
}

.product-price .currency {
	font-size: .8rem;
	font-weight: 500;
	opacity: .7;
	vertical-align: top;
}

/* Actions */
.product-actions {
	display: flex;
	gap: 8px;
	margin-top: auto;
}

.btn-action {
	flex: 1;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 6px;
	padding: 10px 14px;
	border: none;
	border-radius: 10px;
	font-size: .8rem;
	font-weight: 600;
	cursor: pointer;
	transition: transform var(--transition), box-shadow var(--transition);
	white-space: nowrap;
}

.btn-action:hover {
	transform: translateY(-2px);
}

.btn-action:active {
	transform: translateY(0);
}

.btn-action.edit {
	background: linear-gradient(135deg, #F5A623, #E8961F);
	color: #fff;
	box-shadow: 0 3px 12px rgba(245, 166, 35, .3);
}

.btn-action.edit:hover {
	box-shadow: 0 5px 18px rgba(245, 166, 35, .4);
}

.btn-action.del {
	background: linear-gradient(135deg, var(--color-blood-soft),
		var(--color-blood-deep));
	color: #fff;
	box-shadow: 0 3px 12px rgba(139, 0, 0, .25);
}

.btn-action.del:hover {
	box-shadow: 0 5px 18px rgba(139, 0, 0, .35);
}

.btn-action i {
	font-size: .75rem;
}

/* Empty state */
.empty-state {
	text-align: center;
	padding: 80px 20px;
	color: var(--color-smoke);
	grid-column: 1/-1;
}

.empty-state .empty-icon {
	font-size: 4rem;
	opacity: .2;
	margin-bottom: 16px;
}

.empty-state p {
	font-size: .95rem;
	opacity: .7;
}

/* ============================================================
   MODAL
   ============================================================ */
.modal-carnic .modal-content {
	border: none;
	border-radius: 20px;
	overflow: hidden;
	box-shadow: 0 20px 60px rgba(44, 36, 32, .22);
}

.modal-carnic .modal-header {
	background: linear-gradient(135deg, var(--color-blood-deep),
		var(--color-blood));
	padding: 20px 24px;
	border: none;
}

.modal-carnic .modal-title {
	font-family: var(--font-title);
	font-size: 1.25rem;
	color: #fff;
	font-weight: 700;
}

.modal-carnic .modal-title i {
	color: var(--color-gold-light);
	margin-right: 8px;
}

.modal-carnic .btn-close {
	filter: invert(1);
	opacity: .7;
}

.modal-carnic .btn-close:hover {
	opacity: 1;
}

.modal-carnic .modal-body {
	padding: 28px 24px;
	background: #fff;
}

#loadingSpinner {
	text-align: center;
	padding: 40px 0;
}

#loadingSpinner .spinner-border {
	width: 2.5rem;
	height: 2.5rem;
	border-width: .35rem;
	color: var(--color-blood) !important;
}

#loadingSpinner p {
	color: var(--color-smoke);
	font-size: .88rem;
	margin-top: 10px;
}

#mensajeModal {
	border-radius: 10px;
	font-size: .88rem;
	border: none;
	padding: 12px 16px;
}

#mensajeModal.alert-success {
	background: #E8F7EF;
	color: var(--color-green);
}

#mensajeModal.alert-danger {
	background: #FEE8E8;
	color: var(--color-blood);
}

/* ============================================================
   CONFIRM MODAL
   ============================================================ */
.modal-confirm .modal-content {
	border: none;
	border-radius: 18px;
	overflow: hidden;
	box-shadow: 0 16px 48px rgba(44, 36, 32, .2);
}

.modal-confirm .modal-header {
	background: linear-gradient(135deg, var(--color-blood-deep),
		var(--color-blood-soft));
	border: none;
	padding: 18px 22px;
}

.modal-confirm .modal-title {
	color: #fff;
	font-family: var(--font-title);
	font-weight: 700;
}

.modal-confirm .modal-title i {
	color: var(--color-gold-light);
	margin-right: 6px;
}

.modal-confirm .btn-close {
	filter: invert(1);
	opacity: .7;
}

.modal-confirm .modal-body {
	padding: 28px 24px 18px;
	text-align: center;
}

.confirm-icon {
	width: 64px;
	height: 64px;
	border-radius: 50%;
	background: #FEE8E8;
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 0 auto 16px;
	font-size: 1.6rem;
	color: var(--color-blood);
}

.modal-confirm .modal-body p {
	color: var(--color-smoke);
	font-size: .93rem;
}

.modal-confirm .modal-body strong {
	color: var(--color-charcoal);
}

.modal-confirm .modal-footer {
	border-top: 1px solid var(--color-bone);
	padding: 16px 24px;
	justify-content: center;
	gap: 10px;
	background: #FAFAFA;
}

.btn-confirm-cancel {
	padding: 8px 22px;
	border-radius: 10px;
	border: 1px solid var(--color-bone);
	background: #fff;
	color: var(--color-smoke);
	font-weight: 600;
	font-size: .85rem;
	cursor: pointer;
	transition: all var(--transition);
}

.btn-confirm-cancel:hover {
	background: var(--color-bone);
}

.btn-confirm-del {
	padding: 8px 22px;
	border-radius: 10px;
	border: none;
	background: linear-gradient(135deg, var(--color-blood-soft),
		var(--color-blood-deep));
	color: #fff;
	font-weight: 600;
	font-size: .85rem;
	cursor: pointer;
	box-shadow: 0 3px 10px rgba(139, 0, 0, .25);
	transition: all var(--transition);
}

.btn-confirm-del:hover {
	box-shadow: 0 4px 14px rgba(139, 0, 0, .35);
	transform: translateY(-1px);
}

/* ============================================================
   RESPONSIVE
   ============================================================ */
@media ( max-width : 640px) {
	.hero-banner {
		padding: 34px 0 44px;
	}
	.hero-left h1 {
		font-size: 1.5rem;
	}
	.stats-bar {
		margin-top: -16px;
	}
	.stat-card {
		flex: 1 1 100%;
		max-width: 100%;
	}
	.products-grid {
		grid-template-columns: 1fr;
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
				<div class="hero-left">
					<h1>
						<i class="fas fa-bone" style="font-size: .75em; opacity: .6;"></i>
						La <span class="gold">Carnicería</span><br>Gestión de
						Productos
					</h1>
					<p>Administra tu inventario de res, chancho y embutidos con
						facilidad.</p>
					<div class="category-pills">
						<span class="cat-pill"><i class="fas fa-circle"
							style="color: #c0392b;"></i> Res</span> <span class="cat-pill"><i
							class="fas fa-circle" style="color: #e67e22;"></i> Chancho</span> <span
							class="cat-pill"><i class="fas fa-circle"
							style="color: #9b59b6;"></i> Embutidos</span>
					</div>
				</div>
				<%
				if (usuario.getRol().equalsIgnoreCase("ADMIN")) {
				%>
				<div class="hero-right mt-3 mt-md-0">
					<button class="btn-nuevo" onclick="modalLibro.abrir('nuevo')">
						<i class="fas fa-plus"></i> Agregar Producto
					</button>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</section>

	<!-- STATS BAR -->
	<%
	if (usuario.getRol().equalsIgnoreCase("ADMIN")) {
	%>
	<div class="stats-bar">
		<div class="stat-card">
			<div class="stat-icon red">
				<i class="fas fa-boxes"></i>
			</div>
			<div class="stat-info">
				<div class="stat-number"><%=totalProductos%></div>
				<div class="stat-label">Productos</div>
			</div>
		</div>
		<div class="stat-card">
			<div class="stat-icon brown">
				<i class="fas fa-layer-group"></i>
			</div>
			<div class="stat-info">
				<div class="stat-number"><%=totalStock%></div>
				<div class="stat-label">Unidades</div>
			</div>
		</div>
		<div class="stat-card">
			<div class="stat-icon gold">
				<i class="fas fa-dollar-sign"></i>
			</div>
			<div class="stat-info">
				<div class="stat-number">
					$<%=String.format("%,.2f", totalPrecio)%></div>
				<div class="stat-label">Valor Total</div>
			</div>
		</div>
		<div class="stat-card">
			<div class="stat-icon green">
				<i class="fas fa-check-circle"></i>
			</div>
			<div class="stat-info">
				<div class="stat-number"><%=(totalProductos > 0 ? "OK" : "—")%></div>
				<div class="stat-label">Estado</div>
			</div>
		</div>
	</div>
	<%
	}
	%>

	<!-- MAIN -->
	<div class="main-wrap">
		<div class="container">

			<!-- Mensaje de sesión -->
			<%
			String mensaje = (String) session.getAttribute("mensaje");
			if (mensaje != null) {
			%>
			<div class="alert alert-carnic alert-dismissible fade show mb-4"
				role="alert">
				<i class="fas fa-info-circle"
					style="color: var(--color-gold); margin-right: 6px;"></i>
				<%=mensaje%>
				<button type="button" class="btn-close" data-bs-dismiss="alert"
					style="font-size: .7rem;"></button>
			</div>
			<%
			session.removeAttribute("mensaje");
			}
			%>

			<!-- PRODUCTS GRID -->
			<div class="products-grid">
				<%
				if (listaProducto != null && !listaProducto.isEmpty()) {
					for (Producto producto : listaProducto) {
						// Stock level
						String stockClass = "ok";
						String stockIcon = "fa-check-circle";
						if (producto.getStock() <= 0) {
					stockClass = "empty";
					stockIcon = "fa-exclamation-triangle";
						} else if (producto.getStock() <= 5) {
					stockClass = "low";
					stockIcon = "fa-clock";
						}

						// Category classification
						String nombre = producto.getNombreProducto().toLowerCase();
						String catClass = "default";
						String catLabel = "Otro";
						String catIcon = "fa-circle";
						if (nombre.contains("res") || nombre.contains("carne de res") || nombre.contains("vacuno")) {
					catClass = "res";
					catLabel = "Res";
					catIcon = "fa-circle";
						} else if (nombre.contains("chancho") || nombre.contains("cerdo") || nombre.contains("pork")) {
					catClass = "chancho";
					catLabel = "Chancho";
					catIcon = "fa-circle";
						} else if (nombre.contains("embutido") || nombre.contains("salchicha") || nombre.contains("chorizo")
						|| nombre.contains("jamon") || nombre.contains("mortadela")) {
					catClass = "embutido";
					catLabel = "Embutido";
					catIcon = "fa-circle";
						}

						// Image path (adjust this to your actual image path logic)
						String imagePath = producto.getImagenUrl(); // Assuming you have this getter
						boolean hasImage = (imagePath != null && !imagePath.trim().isEmpty());
				%>
				<div class="product-card">
					<!-- Image -->
					<div class="product-image">
						<%
						if (hasImage) {
						%>
						<img
							src="<%=imagePath%>"
							alt="<%=producto.getNombreProducto()%>" class="img-fluid">
						<%
						} else {
						%>
						<div class="product-image-placeholder">
							<i class="fas fa-drumstick-bite"></i> <span>Sin imagen</span>
						</div>
						<%
						}
						%>

						<!-- ID Badge -->
						<div class="product-id-badge"><%=producto.getIdProducto()%></div>

						<!-- Category Badge -->
						<div class="product-cat-badge <%=catClass%>">
							<i class="fas <%=catIcon%>"></i>
							<%=catLabel%>
						</div>
					</div>

					<!-- Body -->
					<div class="product-body">
						<div class="product-name"><%=producto.getNombreProducto()%></div>

						<div class="product-info">
							<span class="stock-badge <%=stockClass%>"> <i
								class="fas <%=stockIcon%>"></i> <%=producto.getStock()%>
							</span>
							<div class="product-price">
								<span class="currency">S/.</span><%=String.format("%.2f", producto.getPrecioUnitario())%>
							</div>
						</div>

						<%
						if (usuario.getRol().equalsIgnoreCase("ADMIN")) {
						%>
						<div class="product-actions">
							<button class="btn-action edit"
								onclick="modalLibro.abrir('editar', <%=producto.getIdProducto()%>)">
								<i class="fas fa-pen"></i> Editar
							</button>
							<button class="btn-action del"
								onclick="confirmarEliminar(<%=producto.getIdProducto()%>, '<%=producto.getNombreProducto()%>')">
								<i class="fas fa-trash-alt"></i> Eliminar
							</button>
						</div>
						<%
						}
						%>
					</div>
				</div>
				<%
				}
				} else {
				%>
				<div class="empty-state">
					<div class="empty-icon">
						<i class="fas fa-bone"></i>
					</div>
					<p>
						<strong>No hay productos registrados.</strong><br>Agrega tu
						primer producto usando el botón <em>"Agregar Producto"</em>.
					</p>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</div>

	<!-- MODAL PRODUCTO -->
	<div class="modal fade modal-carnic" id="modalLibro" tabindex="-1"
		aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalLibroLabel">
						<i class="fas fa-plus-circle"></i> Producto
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						id="btnCerrarModal"></button>
				</div>
				<div class="modal-body">
					<div id="loadingSpinner">
						<div class="spinner-border" role="status">
							<span class="visually-hidden">Cargando...</span>
						</div>
						<p>Preparando formulario...</p>
					</div>
					<div id="mensajeModal" class="alert d-none" role="alert"></div>
					<div id="contenidoModal" style="display: none;"></div>
				</div>
			</div>
		</div>
	</div>

	<!-- MODAL CONFIRMAR -->
	<div class="modal fade modal-confirm" id="modalConfirmar" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">
						<i class="fas fa-exclamation-triangle"></i> Confirmar
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body">
					<div class="confirm-icon">
						<i class="fas fa-trash-alt"></i>
					</div>
					<p>
						¿Estás seguro de eliminar el producto <strong
							id="productNameConfirm"></strong>?<br> <small
							class="text-muted">Esta acción no puede ser deshecha.</small>
					</p>
				</div>
				<div class="modal-footer">
					<button class="btn-confirm-cancel" data-bs-dismiss="modal">Cancelar</button>
					<button class="btn-confirm-del" id="btnConfirmDel">Sí,
						eliminar</button>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
		crossorigin="anonymous"></script>

	<script>
const modalLibro = {
    instance: null,
    procesando: false,
    init() { this.instance = new bootstrap.Modal(document.getElementById('modalLibro')); },
    abrir(tipo, id = null) {
        this.resetear();
        const titulo = tipo === 'nuevo'
            ? '<i class="fas fa-plus-circle"></i> Nuevo Producto'
            : '<i class="fas fa-pen"></i> Editar Producto';
        document.getElementById('modalLibroLabel').innerHTML = titulo;
        this.mostrarSpinner();
        this.instance.show();
        let fetchUrl = '<%=url%>ProductoController?op=' + tipo + '&modal=true';
        if (id) fetchUrl += '&id=' + id;
        fetch(fetchUrl)
            .then(r => r.text())
            .then(html => {
                this.cargarContenido(html);
                this.interceptarFormulario();
            })
            .catch(err => {
                this.ocultarSpinner();
                this.mostrarMensaje('Error al cargar el formulario: ' + err.message, 'danger');
            });
    },
    resetear() {
        this.procesando = false;
        this.ocultarMensaje();
        this.habilitarBotones();
        document.getElementById('contenidoModal').style.display = 'none';
    },
    mostrarSpinner() { document.getElementById('loadingSpinner').style.display = 'block'; },
    ocultarSpinner() { document.getElementById('loadingSpinner').style.display = 'none'; },
    cargarContenido(html) {
        document.getElementById('contenidoModal').innerHTML = html;
        this.ocultarSpinner();
        document.getElementById('contenidoModal').style.display = 'block';
    },
    interceptarFormulario() {
        const form = document.querySelector('#contenidoModal form');
        if (!form || form.dataset.listenerAdded === 'true') return;
        form.dataset.listenerAdded = 'true';
        form.addEventListener('submit', (e) => this.enviarFormulario(e, form));
    },
    enviarFormulario(e, form) {
        e.preventDefault();
        if (this.procesando) return;
        if (!form.checkValidity()) { form.reportValidity(); return; }
        this.procesando = true;
        this.deshabilitarBotones();
        const formData = new FormData(form);
        let op = formData.get('op');
        if (!op || !op.endsWith('Ajax')) formData.set('op', 'insertarAjax');
        formData.set('ajax', 'true');
        fetch('<%=url%>ProductoController', {
            method: 'POST',
            headers: { 'X-Requested-With': 'XMLHttpRequest' },
            body: formData
        })
        .then(r => r.text())
        .then(text => {
            if (text.trim().startsWith('<') || text.trim().startsWith('<!'))
                throw new Error('El servidor devolvió HTML en lugar de JSON');
            return JSON.parse(text);
        })
        .then(data => {
            this.procesando = false;
            if (data.success) {
                this.mostrarMensaje(data.mensaje, 'success');
                setTimeout(() => {
                    this.instance.hide();
                    location.href = '<%=url%>ProductoController?op=listar';
                }, 1400);
            } else {
                this.mostrarMensaje(data.mensaje, 'danger');
                this.habilitarBotones();
            }
        })
        .catch(err => {
            this.procesando = false;
            this.mostrarMensaje('Error: ' + err.message, 'danger');
            this.habilitarBotones();
        });
    },
    deshabilitarBotones() {
        const btn = document.querySelector('#contenidoModal input[type="submit"]');
        const close = document.getElementById('btnCerrarModal');
        if (btn)   { btn.disabled = true; btn.value = 'Guardando…'; }
        if (close) close.disabled = true;
    },
    habilitarBotones() {
        const btn = document.querySelector('#contenidoModal input[type="submit"]');
        const close = document.getElementById('btnCerrarModal');
        if (btn)   { btn.disabled = false; btn.value = 'Guardar'; }
        if (close) close.disabled = false;
    },
    mostrarMensaje(msg, tipo) {
        const el = document.getElementById('mensajeModal');
        el.className = 'alert alert-' + tipo;
        el.textContent = msg;
        el.classList.remove('d-none');
    },
    ocultarMensaje() {
        document.getElementById('mensajeModal').classList.add('d-none');
    }
};

let _deleteId = null;
function confirmarEliminar(id, nombre) {
    _deleteId = id;
    document.getElementById('productNameConfirm').textContent = nombre;
    new bootstrap.Modal(document.getElementById('modalConfirmar')).show();
}
document.getElementById('btnConfirmDel').addEventListener('click', function () {
    if (_deleteId === null) return;
    bootstrap.Modal.getInstance(document.getElementById('modalConfirmar')).hide();
    window.location.href = '<%=url%>ProductoController?op=eliminar&id=' + _deleteId;
});

document.addEventListener('DOMContentLoaded', () => modalLibro.init());
</script>

</body>
</html>
