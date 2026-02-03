<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<%
String url = request.getContextPath() + "/";
String nombreCompleto = (String) session.getAttribute("nombreCompleto");
String rol = (String) session.getAttribute("rol");
boolean esAdmin = "ADMIN".equals(rol);
%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Inicio — La Carnicería</title>

<!-- Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet">
<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<!-- FA -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
/* ============================================================
   VARIABLES (sistema carnicería)
   ============================================================ */
:root {
    --blood:       #8B0000;
    --blood-deep: #6B0000;
    --blood-soft: #A52020;
    --cream:      #FDF5EC;
    --cream-dark: #F0E6D8;
    --bone:       #E8DDD0;
    --charcoal:   #2C2420;
    --smoke:      #5C4A42;
    --gold:       #C8A96E;
    --gold-light: #E2D0A4;
    --green:      #2E7D4F;

    --font-title: 'Playfair Display', Georgia, serif;
    --font-body:  'DM Sans', system-ui, sans-serif;
    --transition: 0.28s cubic-bezier(.4,0,.2,1);
}

*, *::before, *::after { box-sizing: border-box; margin:0; padding:0; }

body {
    font-family: var(--font-body);
    background: var(--cream);
    color: var(--charcoal);
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

/* ============================================================
   HERO
   ============================================================ */
.hero {
    position: relative;
    background: linear-gradient(135deg, var(--blood-deep) 0%, var(--blood) 55%, var(--blood-soft) 100%);
    padding: 56px 0 64px;
    overflow: hidden;
}

/* Diagonal bottom edge */
.hero::after {
    content: '';
    position: absolute;
    bottom: -28px; left: -4%;
    width: 108%; height: 56px;
    background: var(--cream);
    transform: rotate(-1.2deg);
    z-index: 2;
}

/* Atmospheric blobs */
.hero::before {
    content: '';
    position: absolute; inset: 0;
    background:
        radial-gradient(ellipse 380px 200px at 8% 70%,  rgba(255,255,255,.045) 0%, transparent 70%),
        radial-gradient(ellipse 220px 300px at 88% 35%, rgba(255,255,255,.035) 0%, transparent 70%),
        radial-gradient(circle 140px at 55% 75%,        rgba(255,255,255,.025) 0%, transparent 70%);
    pointer-events: none;
}

.hero-inner {
    position: relative; z-index: 1;
    display: flex; align-items: center; justify-content: space-between;
    flex-wrap: wrap; gap: 24px;
}

/* Left text */
.hero-text .hero-greeting {
    font-size: .82rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 2px;
    color: var(--gold-light);
    margin-bottom: 6px;
}
.hero-text h1 {
    font-family: var(--font-title);
    font-size: clamp(2rem, 5vw, 2.9rem);
    font-weight: 800;
    color: #fff;
    line-height: 1.12;
    text-shadow: 0 2px 14px rgba(0,0,0,.22);
}
.hero-text h1 .gold { color: var(--gold-light); }
.hero-text .hero-sub {
    color: rgba(255,255,255,.68);
    font-size: .96rem;
    margin-top: 10px;
    max-width: 440px;
}

/* Right decorative icon */
.hero-deco {
    font-size: 7rem;
    color: rgba(255,255,255,.08);
    line-height: 1;
    user-select: none;
}

/* ============================================================
   QUICK STATS (overlap hero)
   ============================================================ */
.stats-row {
    position: relative; z-index: 3;
    display: flex; gap: 12px; flex-wrap: wrap;
    justify-content: center;
    margin-top: -24px;
    padding: 0 15px;
}
.stat-card {
    flex: 1 1 140px; max-width: 200px;
    background: #fff;
    border-radius: 14px;
    padding: 16px 18px;
    box-shadow: 0 4px 24px rgba(44,36,32,.10);
    display: flex; align-items: center; gap: 14px;
    transition: transform var(--transition), box-shadow var(--transition);
}
.stat-card:hover { transform: translateY(-2px); box-shadow: 0 8px 28px rgba(44,36,32,.15); }

.stat-icon {
    width: 42px; height: 42px;
    border-radius: 12px;
    display: flex; align-items: center; justify-content: center;
    font-size: 1.1rem; flex-shrink: 0;
}
.si-red   { background:#FEE8E8; color:var(--blood); }
.si-brown { background:#F5EBE0; color:#8B5E3C; }
.si-purp  { background:#F0E4F7; color:#6B3FA0; }
.si-green { background:#E6F7ED; color:var(--green); }

.stat-info .stat-num   { font-family:var(--font-title); font-size:1.3rem; font-weight:700; }
.stat-info .stat-label { font-size:.74rem; color:var(--smoke); text-transform:uppercase; letter-spacing:.6px; }

/* ============================================================
   SECTION TITLE
   ============================================================ */
.section-wrap {
    position: relative; z-index: 2;
    padding: 44px 0 20px;
}
.section-title {
    font-family: var(--font-title);
    font-size: 1.6rem;
    font-weight: 700;
    color: var(--charcoal);
    margin-bottom: 6px;
}
.section-title .accent { color: var(--blood); }
.section-subtitle {
    font-size: .88rem;
    color: var(--smoke);
    margin-bottom: 24px;
}

/* ============================================================
   CATEGORY CARDS
   ============================================================ */
.cat-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
    gap: 18px;
    padding: 0 15px;
}

.cat-card {
    position: relative;
    background: #fff;
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 4px 20px rgba(44,36,32,.08);
    text-decoration: none;
    display: flex;
    flex-direction: column;
    transition: transform var(--transition), box-shadow var(--transition);
    border: 1px solid rgba(44,36,32,.05);
    animation: cardIn .4s ease both;
}
.cat-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 36px rgba(44,36,32,.16);
}

@keyframes cardIn {
    from { opacity:0; transform:translateY(18px); }
    to   { opacity:1; transform:translateY(0); }
}
.cat-card:nth-child(1) { animation-delay:.06s; }
.cat-card:nth-child(2) { animation-delay:.14s; }
.cat-card:nth-child(3) { animation-delay:.22s; }
.cat-card:nth-child(4) { animation-delay:.30s; }

/* Top colour stripe */
.cat-card .cat-stripe {
    height: 6px;
    width: 100%;
}
.stripe-res      { background: linear-gradient(90deg, #8B0000, #C0392B); }
.stripe-chancho  { background: linear-gradient(90deg, #D35400, #E67E22); }
.stripe-embutido { background: linear-gradient(90deg, #6B3FA0, #9B59B6); }
.stripe-admin    { background: linear-gradient(90deg, var(--blood-deep), var(--gold)); }

/* Icon circle */
.cat-icon-wrap {
    width: 72px; height: 72px;
    border-radius: 18px;
    display: flex; align-items: center; justify-content: center;
    font-size: 1.7rem;
    margin: 22px auto 0;
}
.icon-res      { background:#FEE8E8; color:#8B0000; }
.icon-chancho  { background:#FFF0E0; color:#D35400; }
.icon-embutido { background:#F0E4F7; color:#6B3FA0; }
.icon-admin    { background:#FFF8E6; color:var(--gold); }

/* Card body */
.cat-body {
    padding: 18px 22px 24px;
    text-align: center;
    flex: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}
.cat-body h3 {
    font-family: var(--font-title);
    font-size: 1.18rem;
    font-weight: 700;
    color: var(--charcoal);
    margin-bottom: 6px;
}
.cat-body p {
    font-size: .82rem;
    color: var(--smoke);
    line-height: 1.45;
    margin-bottom: 16px;
}

/* CTA pill inside card */
.cat-cta {
    display: inline-flex; align-items: center; gap: 6px;
    font-size: .8rem;
    font-weight: 600;
    padding: 6px 16px;
    border-radius: 20px;
    text-decoration: none;
    transition: background var(--transition), color var(--transition), transform var(--transition);
}
.cta-res      { background:#FEE8E8; color:#8B0000; }
.cta-chancho  { background:#FFF0E0; color:#D35400; }
.cta-embutido { background:#F0E4F7; color:#6B3FA0; }
.cta-admin    { background:#FFF8E6; color:var(--charcoal); }

.cat-card:hover .cat-cta {
    transform: translateX(3px);
}
.cat-cta i { font-size:.72rem; }

/* Hover glow on stripe */
.cat-card:hover .cat-stripe { filter: brightness(1.15); }

/* ============================================================
   SISTEMA INFO
   ============================================================ */
.info-section { padding: 36px 0 48px; position: relative; z-index: 2; }

.info-card {
    background: #fff;
    border-radius: 18px;
    box-shadow: 0 4px 20px rgba(44,36,32,.08);
    border: 1px solid rgba(44,36,32,.05);
    overflow: hidden;
}
.info-card-header {
    background: linear-gradient(135deg, var(--blood-deep), var(--blood));
    padding: 16px 22px;
    display: flex; align-items: center; gap: 10px;
}
.info-card-header h5 {
    font-family: var(--font-title);
    font-size: 1.05rem;
    font-weight: 700;
    color: #fff;
    margin: 0;
}
.info-card-header i { color: var(--gold-light); font-size: .9rem; }

.info-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 0;
}
.info-col {
    padding: 22px 24px;
    border-right: 1px solid var(--bone);
}
.info-col:last-child { border-right: none; }

.info-row {
    display: flex; align-items: center; gap: 10px;
    margin-bottom: 14px;
}
.info-row:last-child { margin-bottom: 0; }

.info-row-icon {
    width: 32px; height: 32px;
    border-radius: 8px;
    background: var(--cream);
    display: flex; align-items: center; justify-content: center;
    font-size: .78rem;
    color: var(--blood);
    flex-shrink: 0;
}
.info-row-text .info-label { font-size:.72rem; color:var(--smoke); text-transform:uppercase; letter-spacing:.5px; }
.info-row-text .info-value { font-size:.9rem; font-weight:600; color:var(--charcoal); }

/* Badges */
.badge-carnic {
    display: inline-flex; align-items: center; gap: 4px;
    padding: 3px 10px;
    border-radius: 12px;
    font-size: .75rem;
    font-weight: 600;
}
.badge-green { background:#E6F7ED; color:var(--green); }
.badge-red   { background:#FEE8E8; color:var(--blood); }
.badge-gold  { background:#FFF8E6; color:#8B5E3C; }

/* ============================================================
   FOOTER
   ============================================================ */
footer {
    margin-top: auto;
    background: var(--charcoal);
    padding: 28px 0;
}
.footer-inner {
    display: flex; align-items: center; justify-content: space-between;
    flex-wrap: wrap; gap: 12px;
}
.footer-brand {
    font-family: var(--font-title);
    font-size: 1.1rem;
    color: #fff;
    font-weight: 700;
}
.footer-brand .gold { color: var(--gold); }
.footer-copy {
    font-size: .78rem;
    color: rgba(255,255,255,.4);
}
.footer-links { display:flex; gap:18px; }
.footer-links a {
    color: rgba(255,255,255,.5);
    text-decoration: none;
    font-size: .8rem;
    transition: color var(--transition);
}
.footer-links a:hover { color: var(--gold); }

/* ============================================================
   RESPONSIVE
   ============================================================ */
@media (max-width: 600px) {
    .hero { padding: 40px 0 52px; }
    .hero-deco { display: none; }
    .cat-grid { grid-template-columns: 1fr; }
    .info-col { border-right: none; border-bottom: 1px solid var(--bone); }
    .info-col:last-child { border-bottom: none; }
    .footer-inner { flex-direction: column; text-align: center; }
}
</style>
</head>
<body>

<!-- ============================================================
     NAVBAR
     ============================================================ -->
<jsp:include page="/components/navbar.jsp" />

<!-- ============================================================
     HERO
     ============================================================ -->
<section class="hero">
    <div class="container">
        <div class="hero-inner">
            <div class="hero-text">
                <p class="hero-greeting">Bienvenido</p>
                <h1>Hola, <span class="gold"><%=nombreCompleto%></span></h1>
                <p class="hero-sub">Administra tu inventario de carne, chancho y embutidos desde un solo lugar.</p>
            </div>
            <div class="hero-deco"><i class="fas fa-bone"></i></div>
        </div>
    </div>
</section>



<!-- ============================================================
     CATEGORÍAS (cards principales)
     ============================================================ -->
<div class="section-wrap">
    <div class="container">
        <h2 class="section-title">Categorías de <span class="accent">Productos</span></h2>
        <p class="section-subtitle">Selecciona una categoría para ver los productos correspondientes</p>
    </div>
</div>

<div class="container" style="padding-bottom: 10px;">
    <div class="cat-grid">

        <!-- RES -->
        <a href="<%=url%>LibrosController?op=listar&categoria=res" class="cat-card">
            <div class="cat-stripe stripe-res"></div>
            <div class="cat-icon-wrap icon-res"><i class="fas fa-bone"></i></div>
            <div class="cat-body">
                <h3>Carne de Res</h3>
                <p>Cortes de carne vacuna frescas: lomo, bife, costilla y más.</p>
                <span class="cat-cta cta-res">Ver productos <i class="fas fa-arrow-right"></i></span>
            </div>
        </a>

        <!-- CHANCHO -->
        <a href="<%=url%>LibrosController?op=listar&categoria=chancho" class="cat-card">
            <div class="cat-stripe stripe-chancho"></div>
            <div class="cat-icon-wrap icon-chancho"><i class="fas fa-drumstick-bite"></i></div>
            <div class="cat-body">
                <h3>Carne de Chancho</h3>
                <p>Cortes de cerdo seleccionados: chuleta, costilla, pierna y otros.</p>
                <span class="cat-cta cta-chancho">Ver productos <i class="fas fa-arrow-right"></i></span>
            </div>
        </a>

        <!-- EMBUTIDOS -->
        <a href="<%=url%>LibrosController?op=listar&categoria=embutido" class="cat-card">
            <div class="cat-stripe stripe-embutido"></div>
            <div class="cat-icon-wrap icon-embutido"><i class="fas fa-hot-tub"></i></div>
            <div class="cat-body">
                <h3>Embutidos</h3>
                <p>Chorizo, salchicha, mortadela y jamón de las mejores marcas.</p>
                <span class="cat-cta cta-embutido">Ver productos <i class="fas fa-arrow-right"></i></span>
            </div>
        </a>

        <!-- TODOS (o Administración si es admin) -->
        <%
        if (esAdmin) {
        %>
        <a href="<%=url%>UsuariosController?op=listar" class="cat-card">
            <div class="cat-stripe stripe-admin"></div>
            <div class="cat-icon-wrap icon-admin"><i class="fas fa-user-shield"></i></div>
            <div class="cat-body">
                <h3>Administración</h3>
                <p>Gestiona usuarios, roles y configuración del sistema.</p>
                <span class="cat-cta cta-admin">Entrar <i class="fas fa-arrow-right"></i></span>
            </div>
        </a>
        <%
        } else {
        %>
        <a href="<%=url%>LibrosController?op=listar" class="cat-card">
            <div class="cat-stripe" style="background:linear-gradient(90deg,var(--blood-deep),var(--blood-soft));"></div>
            <div class="cat-icon-wrap" style="background:#FEE8E8; color:var(--blood);"><i class="fas fa-list"></i></div>
            <div class="cat-body">
                <h3>Todos los Productos</h3>
                <p>Ve el catálogo completo sin filtros de categoría.</p>
                <span class="cat-cta" style="background:#FEE8E8; color:var(--blood);">Ver todos <i class="fas fa-arrow-right"></i></span>
            </div>
        </a>
        <%
        }
        %>
    </div>
</div>

<!-- ============================================================
     INFO DEL SISTEMA
     ============================================================ -->
<section class="info-section">
    <div class="container">
        <div class="info-card">
            <div class="info-card-header">
                <i class="fas fa-info-circle"></i>
                <h5>Información del Sistema</h5>
            </div>
            <div class="info-grid">

                <!-- Col 1: Usuario -->
                <div class="info-col">
                    <div class="info-row">
                        <div class="info-row-icon"><i class="fas fa-user"></i></div>
                        <div class="info-row-text">
                            <div class="info-label">Usuario</div>
                            <div class="info-value"><%=nombreCompleto%></div>
                        </div>
                    </div>
                    <div class="info-row">
                        <div class="info-row-icon"><i class="fas fa-shield-halved"></i></div>
                        <div class="info-row-text">
                            <div class="info-label">Rol</div>
                            <div class="info-value">
                                <% if (esAdmin) { %>
                                    <span class="badge-carnic badge-gold"><i class="fas fa-crown"></i> Admin</span>
                                <% } else { %>
                                    <span class="badge-carnic badge-green"><i class="fas fa-user"></i> <%=rol%></span>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Col 2: Versión / Estado -->
                <div class="info-col">
                    <div class="info-row">
                        <div class="info-row-icon"><i class="fas fa-code-branch"></i></div>
                        <div class="info-row-text">
                            <div class="info-label">Versión</div>
                            <div class="info-value">1.0.0</div>
                        </div>
                    </div>
                    <div class="info-row">
                        <div class="info-row-icon"><i class="fas fa-circle-check"></i></div>
                        <div class="info-row-text">
                            <div class="info-label">Estado</div>
                            <div class="info-value"><span class="badge-carnic badge-green"><i class="fas fa-check"></i> Activo</span></div>
                        </div>
                    </div>
                </div>

                <!-- Col 3: Base de datos -->
                <div class="info-col">
                    <div class="info-row">
                        <div class="info-row-icon"><i class="fas fa-database"></i></div>
                        <div class="info-row-text">
                            <div class="info-label">Base de Datos</div>
                            <div class="info-value">MySQL</div>
                        </div>
                    </div>
                    <div class="info-row">
                        <div class="info-row-icon"><i class="fas fa-wifi"></i></div>
                        <div class="info-row-text">
                            <div class="info-label">Conexión</div>
                            <div class="info-value"><span class="badge-carnic badge-green"><i class="fas fa-check"></i> Conectado</span></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============================================================
     FOOTER
     ============================================================ -->
<footer>
    <div class="container">
        <div class="footer-inner">
            <div class="footer-brand">La <span class="gold">Carnicería</span></div>
            <div class="footer-links">
                <a href="#">Inicio</a>
                <a href="<%=url%>LibrosController?op=listar">Productos</a>
                <% if (esAdmin) { %><a href="<%=url%>UsuariosController?op=listar">Usuarios</a><% } %>
            </div>
            <div class="footer-copy">&copy; 2025 La Carnicería — Todos los derechos reservados</div>
        </div>
    </div>
</footer>

<!-- ============================================================
     SCRIPTS
     ============================================================ -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>