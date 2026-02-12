<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.unu.poowebmodalga.beans.Pedido"%>
<%@ page import="com.unu.poowebmodalga.beans.Cliente"%>
<!DOCTYPE html>
<html lang="es">
<head>
<%
String url = request.getContextPath() + "/";
List<Pedido> listaPedidos = (List<Pedido>) request.getAttribute("listaPedidos");
int totalPedidos = (listaPedidos != null) ? listaPedidos.size() : 0;
double totalVentas = 0;
int pedidosHoy = 0;

if (listaPedidos != null) {
    java.util.Date hoy = new java.util.Date();
    for (Pedido p : listaPedidos) {
        totalVentas += p.getTotal();
        // Comparar fechas (simplificado - ajustar según tu lógica)
        if (p.getFecha() != null) {
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
            if (sdf.format(p.getFecha()).equals(sdf.format(hoy))) {
                pedidosHoy++;
            }
        }
    }
}
double promedioVenta = totalPedidos > 0 ? totalVentas / totalPedidos : 0;
%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>🛒 Gestión de Pedidos — La Carnicería</title>

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet">

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
    crossorigin="anonymous">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
/* ============================================================
   VARIABLES & BASE
   ============================================================ */
:root {
    --color-blood:      #8B0000;
    --color-blood-deep:#6B0000;
    --color-blood-soft:#A52020;
    --color-cream:      #FDF5EC;
    --color-bone:       #E8DDD0;
    --color-charcoal:   #2C2420;
    --color-smoke:      #5C4A42;
    --color-gold:       #C8A96E;
    --color-gold-light:#E2D0A4;
    --color-green:      #2E7D4F;
    --color-blue:       #3498DB;
    
    --font-title:       'Playfair Display', Georgia, serif;
    --font-body:        'DM Sans', system-ui, sans-serif;
    --radius:           10px;
    --shadow-card:      0 4px 24px rgba(44,36,32,0.10);
    --shadow-hover:     0 8px 32px rgba(139,0,0,0.18);
    --transition:       0.28s cubic-bezier(.4,0,.2,1);
}

*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

body {
    font-family: var(--font-body);
    background: var(--color-cream);
    color: var(--color-charcoal);
    min-height: 100vh;
    position: relative;
    overflow-x: hidden;
}

body::before {
    content: '';
    position: fixed; inset: 0;
    background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.85' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='0.03'/%3E%3C/svg%3E");
    pointer-events: none;
    z-index: 0;
}

/* ============================================================
   HERO BANNER
   ============================================================ */
.hero-banner {
    position: relative;
    background: linear-gradient(135deg, var(--color-blood-deep) 0%, var(--color-blood) 50%, var(--color-blood-soft) 100%);
    padding: 48px 0 52px;
    overflow: hidden;
    z-index: 1;
}

.hero-banner::after {
    content: '';
    position: absolute;
    bottom: -30px; left: -5%;
    width: 110%; height: 60px;
    background: var(--color-cream);
    transform: rotate(-1.2deg);
    z-index: 2;
}

.hero-banner::before {
    content: '';
    position: absolute; inset: 0;
    background:
        radial-gradient(ellipse 320px 180px at 12% 60%, rgba(255,255,255,.04) 0%, transparent 70%),
        radial-gradient(ellipse 200px 260px at 85% 40%, rgba(255,255,255,.03) 0%, transparent 70%);
    pointer-events: none;
}

.hero-content {
    position: relative; z-index: 1;
    display: flex; align-items: center; justify-content: space-between;
    flex-wrap: wrap; gap: 16px;
}

.hero-left h1 {
    font-family: var(--font-title);
    font-size: clamp(1.8rem, 4vw, 2.6rem);
    font-weight: 800;
    color: #fff;
    line-height: 1.15;
    text-shadow: 0 2px 12px rgba(0,0,0,.25);
}
.hero-left h1 .gold { color: var(--color-gold-light); }
.hero-left p {
    color: rgba(255,255,255,.72);
    font-size: .95rem;
    margin-top: 8px;
}

.btn-nuevo {
    display: inline-flex; align-items: center; gap: 8px;
    background: linear-gradient(135deg, var(--color-gold), #b8945a);
    color: var(--color-charcoal);
    font-family: var(--font-body);
    font-weight: 600;
    font-size: .92rem;
    padding: 12px 26px;
    border: none;
    border-radius: 40px;
    box-shadow: 0 4px 18px rgba(200,169,110,.35);
    cursor: pointer;
    transition: transform var(--transition), box-shadow var(--transition);
    text-decoration: none;
}
.btn-nuevo:hover { transform: translateY(-2px); box-shadow: 0 6px 24px rgba(200,169,110,.45); }
.btn-nuevo i { font-size: .88rem; }

/* ============================================================
   STATS BAR
   ============================================================ */
.stats-bar {
    position: relative; z-index: 1;
    display: flex; gap: 12px; flex-wrap: wrap;
    margin-top: -22px;
    padding: 0 15px;
    justify-content: center;
}
.stat-card {
    flex: 1 1 140px; max-width: 200px;
    background: #fff;
    border-radius: 14px;
    padding: 16px 18px;
    box-shadow: var(--shadow-card);
    display: flex; align-items: center; gap: 14px;
    transition: transform var(--transition), box-shadow var(--transition);
}
.stat-card:hover { transform: translateY(-2px); box-shadow: var(--shadow-hover); }

.stat-icon {
    width: 42px; height: 42px;
    border-radius: 12px;
    display: flex; align-items: center; justify-content: center;
    font-size: 1.1rem;
    flex-shrink: 0;
}
.stat-icon.blue   { background: #E3F2FD; color: var(--color-blue); }
.stat-icon.green  { background: #E6F7ED; color: var(--color-green); }
.stat-icon.gold   { background: #FFF8E6; color: var(--color-gold); }
.stat-icon.purple { background: #F0E4F7; color: #6B3FA0; }

.stat-info .stat-number { font-family: var(--font-title); font-size: 1.35rem; font-weight: 700; }
.stat-info .stat-label  { font-size: .76rem; color: var(--color-smoke); text-transform: uppercase; letter-spacing: .6px; }

/* ============================================================
   MAIN CONTENT
   ============================================================ */
.main-wrap { position: relative; z-index: 1; padding: 28px 0 60px; }

.alert-carnic {
    border: none;
    border-left: 4px solid var(--color-gold);
    background: #FFF9EE;
    color: var(--color-smoke);
    border-radius: 0 10px 10px 0;
    padding: 14px 18px;
    font-size: .9rem;
    box-shadow: 0 2px 8px rgba(44,36,32,.06);
}

/* ============================================================
   ORDERS LIST
   ============================================================ */
.orders-list {
    display: flex;
    flex-direction: column;
    gap: 16px;
}

.order-card {
    background: #fff;
    border-radius: 16px;
    box-shadow: var(--shadow-card);
    border: 1px solid rgba(44,36,32,.06);
    overflow: hidden;
    transition: transform var(--transition), box-shadow var(--transition);
    animation: cardIn .4s ease both;
}

.order-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 28px rgba(44,36,32,.12);
}

@keyframes cardIn {
    from { opacity: 0; transform: translateY(12px); }
    to { opacity: 1; transform: translateY(0); }
}

.order-card:nth-child(1) { animation-delay: .05s; }
.order-card:nth-child(2) { animation-delay: .10s; }
.order-card:nth-child(3) { animation-delay: .15s; }
.order-card:nth-child(4) { animation-delay: .20s; }
.order-card:nth-child(5) { animation-delay: .25s; }

.order-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 20px 24px;
    background: linear-gradient(135deg, #FAFAFA, #F5F5F5);
    border-bottom: 1px solid var(--color-bone);
}

.order-left {
    display: flex;
    align-items: center;
    gap: 16px;
}

.order-id-badge {
    min-width: 50px;
    height: 50px;
    border-radius: 12px;
    background: linear-gradient(135deg, var(--color-blue), #2980B9);
    color: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: var(--font-title);
    font-weight: 800;
    font-size: .9rem;
    box-shadow: 0 3px 12px rgba(52,152,219,.3);
}

.order-info h3 {
    font-size: 1rem;
    font-weight: 700;
    color: var(--color-charcoal);
    margin-bottom: 4px;
}

.order-meta {
    display: flex;
    align-items: center;
    gap: 14px;
    font-size: .82rem;
    color: var(--color-smoke);
}

.order-meta i {
    color: var(--color-blood);
    font-size: .75rem;
}

.order-right {
    text-align: right;
}

.order-total {
    font-family: var(--font-title);
    font-size: 1.6rem;
    font-weight: 800;
    color: var(--color-blood);
    line-height: 1;
}

.order-total .currency {
    font-size: .9rem;
    font-weight: 500;
    opacity: .7;
}

.order-date {
    font-size: .78rem;
    color: var(--color-smoke);
    margin-top: 4px;
}

.order-body {
    padding: 20px 24px;
}

.order-actions {
    display: flex;
    gap: 8px;
    justify-content: flex-end;
}

.btn-action {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 9px 16px;
    border: none;
    border-radius: 10px;
    font-size: .8rem;
    font-weight: 600;
    cursor: pointer;
    transition: transform var(--transition), box-shadow var(--transition);
}

.btn-action:hover { transform: translateY(-2px); }

.btn-action.view {
    background: linear-gradient(135deg, var(--color-blue), #2980B9);
    color: #fff;
    box-shadow: 0 3px 12px rgba(52,152,219,.25);
}
.btn-action.view:hover { box-shadow: 0 5px 18px rgba(52,152,219,.35); }

.btn-action.edit {
    background: linear-gradient(135deg, #F5A623, #E8961F);
    color: #fff;
    box-shadow: 0 3px 12px rgba(245,166,35,.25);
}
.btn-action.edit:hover { box-shadow: 0 5px 18px rgba(245,166,35,.35); }

.btn-action.del {
    background: linear-gradient(135deg, var(--color-blood-soft), var(--color-blood-deep));
    color: #fff;
    box-shadow: 0 3px 12px rgba(139,0,0,.25);
}
.btn-action.del:hover { box-shadow: 0 5px 18px rgba(139,0,0,.35); }

.btn-action i { font-size: .75rem; }

/* Empty state */
.empty-state {
    text-align: center;
    padding: 80px 20px;
    color: var(--color-smoke);
}
.empty-state .empty-icon { font-size: 4rem; opacity: .2; margin-bottom: 16px; }
.empty-state p { font-size: .95rem; opacity: .7; }

/* ============================================================
   MODAL
   ============================================================ */
.modal-carnic .modal-content {
    border: none;
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 20px 60px rgba(44,36,32,.22);
}
.modal-carnic .modal-header {
    background: linear-gradient(135deg, var(--color-blood-deep), var(--color-blood));
    padding: 20px 24px;
    border: none;
}
.modal-carnic .modal-title {
    font-family: var(--font-title);
    font-size: 1.25rem;
    color: #fff;
    font-weight: 700;
}
.modal-carnic .modal-title i { color: var(--color-gold-light); margin-right: 8px; }
.modal-carnic .btn-close { filter: invert(1); opacity: .7; }
.modal-carnic .btn-close:hover { opacity: 1; }
.modal-carnic .modal-body { padding: 28px 24px; background: #fff; }

#loadingSpinner { text-align: center; padding: 40px 0; }
#loadingSpinner .spinner-border {
    width: 2.5rem; height: 2.5rem;
    border-width: .35rem;
    color: var(--color-blood) !important;
}
#loadingSpinner p { color: var(--color-smoke); font-size: .88rem; margin-top: 10px; }

#mensajeModal {
    border-radius: 10px;
    font-size: .88rem;
    border: none;
    padding: 12px 16px;
}
#mensajeModal.alert-success { background: #E8F7EF; color: var(--color-green); }
#mensajeModal.alert-danger  { background: #FEE8E8; color: var(--color-blood); }

/* ============================================================
   CONFIRM MODAL
   ============================================================ */
.modal-confirm .modal-content {
    border: none;
    border-radius: 18px;
    overflow: hidden;
    box-shadow: 0 16px 48px rgba(44,36,32,.2);
}
.modal-confirm .modal-header {
    background: linear-gradient(135deg, var(--color-blood-deep), var(--color-blood-soft));
    border: none; padding: 18px 22px;
}
.modal-confirm .modal-title { color: #fff; font-family: var(--font-title); font-weight: 700; }
.modal-confirm .modal-title i { color: var(--color-gold-light); margin-right: 6px; }
.modal-confirm .btn-close { filter: invert(1); opacity: .7; }

.modal-confirm .modal-body {
    padding: 28px 24px 18px;
    text-align: center;
}
.confirm-icon {
    width: 64px; height: 64px;
    border-radius: 50%;
    background: #FEE8E8;
    display: flex; align-items: center; justify-content: center;
    margin: 0 auto 16px;
    font-size: 1.6rem;
    color: var(--color-blood);
}
.modal-confirm .modal-body p { color: var(--color-smoke); font-size: .93rem; }
.modal-confirm .modal-body strong { color: var(--color-charcoal); }

.modal-confirm .modal-footer {
    border-top: 1px solid var(--color-bone);
    padding: 16px 24px;
    justify-content: center;
    gap: 10px;
    background: #FAFAFA;
}
.btn-confirm-cancel {
    padding: 8px 22px; border-radius: 10px;
    border: 1px solid var(--color-bone);
    background: #fff; color: var(--color-smoke);
    font-weight: 600; font-size: .85rem;
    cursor: pointer; transition: all var(--transition);
}
.btn-confirm-cancel:hover { background: var(--color-bone); }
.btn-confirm-del {
    padding: 8px 22px; border-radius: 10px;
    border: none;
    background: linear-gradient(135deg, var(--color-blood-soft), var(--color-blood-deep));
    color: #fff; font-weight: 600; font-size: .85rem;
    cursor: pointer; box-shadow: 0 3px 10px rgba(139,0,0,.25);
    transition: all var(--transition);
}
.btn-confirm-del:hover { box-shadow: 0 4px 14px rgba(139,0,0,.35); transform: translateY(-1px); }

/* ============================================================
   RESPONSIVE
   ============================================================ */
@media (max-width: 640px) {
    .hero-banner { padding: 34px 0 44px; }
    .hero-left h1 { font-size: 1.5rem; }
    .stats-bar { margin-top: -16px; }
    .stat-card { flex: 1 1 100%; max-width: 100%; }
    .order-header { flex-direction: column; align-items: flex-start; gap: 14px; }
    .order-right { text-align: left; }
    .order-actions { width: 100%; flex-wrap: wrap; }
    .btn-action { flex: 1; justify-content: center; }
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
                <h1><i class="fas fa-shopping-cart" style="font-size:.75em; opacity:.6;"></i> Gestión de <span class="gold">Pedidos</span></h1>
                <p>Administra las ventas y órdenes de tus clientes.</p>
            </div>
            <div class="hero-right mt-3 mt-md-0">
                <button class="btn-nuevo" onclick="modalPedido.abrir('nuevo')">
                    <i class="fas fa-plus"></i> Nuevo Pedido
                </button>
            </div>
        </div>
    </div>
</section>

<!-- STATS BAR -->
<div class="stats-bar">
    <div class="stat-card">
        <div class="stat-icon blue"><i class="fas fa-receipt"></i></div>
        <div class="stat-info">
            <div class="stat-number"><%=totalPedidos%></div>
            <div class="stat-label">Pedidos</div>
        </div>
    </div>
    <div class="stat-card">
        <div class="stat-icon green"><i class="fas fa-dollar-sign"></i></div>
        <div class="stat-info">
            <div class="stat-number">$<%=String.format("%,.2f", totalVentas)%></div>
            <div class="stat-label">Total Ventas</div>
        </div>
    </div>
    <div class="stat-card">
        <div class="stat-icon gold"><i class="fas fa-chart-line"></i></div>
        <div class="stat-info">
            <div class="stat-number">$<%=String.format("%.2f", promedioVenta)%></div>
            <div class="stat-label">Promedio</div>
        </div>
    </div>
    <div class="stat-card">
        <div class="stat-icon purple"><i class="fas fa-calendar-day"></i></div>
        <div class="stat-info">
            <div class="stat-number"><%=pedidosHoy%></div>
            <div class="stat-label">Hoy</div>
        </div>
    </div>
</div>

<!-- MAIN -->
<div class="main-wrap">
    <div class="container">

        <!-- Mensaje de sesión -->
        <%
        String mensaje = (String) session.getAttribute("mensaje");
        if (mensaje != null) {
        %>
        <div class="alert alert-carnic alert-dismissible fade show mb-4" role="alert">
            <i class="fas fa-info-circle" style="color:var(--color-gold); margin-right:6px;"></i>
            <%=mensaje%>
            <button type="button" class="btn-close" data-bs-dismiss="alert" style="font-size:.7rem;"></button>
        </div>
        <%
        session.removeAttribute("mensaje");
        }
        %>

        <!-- ORDERS LIST -->
        <div class="orders-list">
            <%
            if (listaPedidos != null && !listaPedidos.isEmpty()) {
                for (Pedido pedido : listaPedidos) {
                    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy HH:mm");
                    String fechaStr = pedido.getFecha() != null ? sdf.format(pedido.getFecha()) : "Sin fecha";
            %>
            <div class="order-card">
                <div class="order-header">
                    <div class="order-left">
                        <div class="order-id-badge">#<%=pedido.getIdPedido()%></div>
                        <div class="order-info">
                            <h3><%=pedido.getCliente() != null ? pedido.getCliente().getNombreCompleto() : "Cliente no especificado"%></h3>
                            <div class="order-meta">
                                <span><i class="fas fa-calendar"></i> <%=fechaStr%></span>
                                <span><i class="fas fa-user"></i> Cliente ID: <%=pedido.getIdCliente()%></span>
                            </div>
                        </div>
                    </div>
                    <div class="order-right">
                        <div class="order-total">
                            <span class="currency">S/.</span><%=String.format("%.2f", pedido.getTotal())%>
                        </div>
                        <div class="order-date"><%=fechaStr.split(" ")[0]%></div>
                    </div>
                </div>

                <div class="order-body">
                    <div class="order-actions">
                        <button class="btn-action view" onclick="verDetalle(<%=pedido.getIdPedido()%>)">
                            <i class="fas fa-eye"></i> Ver Detalle
                        </button>
                        <button class="btn-action edit" onclick="modalPedido.abrir('editar', <%=pedido.getIdPedido()%>)">
                            <i class="fas fa-pen"></i> Editar
                        </button>
                        <button class="btn-action del" onclick="confirmarEliminar(<%=pedido.getIdPedido()%>, '#<%=pedido.getIdPedido()%>')">
                            <i class="fas fa-trash-alt"></i> Eliminar
                        </button>
                    </div>
                </div>
            </div>
            <%
                }
            } else {
            %>
            <div class="empty-state">
                <div class="empty-icon"><i class="fas fa-shopping-cart"></i></div>
                <p><strong>No hay pedidos registrados.</strong><br>Crea el primer pedido usando el botón <em>"Nuevo Pedido"</em>.</p>
            </div>
            <%
            }
            %>
        </div>
    </div>
</div>

<!-- MODAL PEDIDO -->
<div class="modal fade modal-carnic" id="modalPedido" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-dialog-centered modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalPedidoLabel">
                    <i class="fas fa-plus-circle"></i> Pedido
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" id="btnCerrarModal"></button>
            </div>
            <div class="modal-body">
                <div id="loadingSpinner">
                    <div class="spinner-border" role="status">
                        <span class="visually-hidden">Cargando...</span>
                    </div>
                    <p>Preparando formulario...</p>
                </div>
                <div id="mensajeModal" class="alert d-none" role="alert"></div>
                <div id="contenidoModal" style="display:none;"></div>
            </div>
        </div>
    </div>
</div>

<!-- MODAL CONFIRMAR -->
<div class="modal fade modal-confirm" id="modalConfirmar" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"><i class="fas fa-exclamation-triangle"></i> Confirmar</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="confirm-icon"><i class="fas fa-trash-alt"></i></div>
                <p>¿Estás seguro de eliminar el pedido <strong id="pedidoNameConfirm"></strong>?<br><small class="text-muted">Esta acción no puede ser deshecha.</small></p>
            </div>
            <div class="modal-footer">
                <button class="btn-confirm-cancel" data-bs-dismiss="modal">Cancelar</button>
                <button class="btn-confirm-del" id="btnConfirmDel">Sí, eliminar</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
    crossorigin="anonymous"></script>

<script>
const modalPedido = {
    instance: null,
    procesando: false,
    init() { this.instance = new bootstrap.Modal(document.getElementById('modalPedido')); },
    abrir(tipo, id = null) {
        this.resetear();
        const titulo = tipo === 'nuevo'
            ? '<i class="fas fa-plus-circle"></i> Nuevo Pedido'
            : '<i class="fas fa-pen"></i> Editar Pedido';
        document.getElementById('modalPedidoLabel').innerHTML = titulo;
        this.mostrarSpinner();
        this.instance.show();
        let fetchUrl = '<%=url%>PedidoController?op=' + tipo + '&modal=true';
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
        fetch('<%=url%>PedidoController', {
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
                    location.href = '<%=url%>PedidoController?op=listar';
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
    document.getElementById('pedidoNameConfirm').textContent = nombre;
    new bootstrap.Modal(document.getElementById('modalConfirmar')).show();
}
document.getElementById('btnConfirmDel').addEventListener('click', function () {
    if (_deleteId === null) return;
    bootstrap.Modal.getInstance(document.getElementById('modalConfirmar')).hide();
    window.location.href = '<%=url%>PedidoController?op=eliminar&id=' + _deleteId;
});

function verDetalle(idPedido) {
    window.location.href = '<%=url%>PedidoController?op=verDetalle&id=' + idPedido;
}

document.addEventListener('DOMContentLoaded', () => modalPedido.init());
</script>

</body>
</html>
