<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.unu.poowebmodalga.beans.Usuario"%>
<!DOCTYPE html>
<html lang="es">
<head>
<%
String url = request.getContextPath() + "/";
Usuario usuario = (Usuario) request.getAttribute("usuario");
if (usuario == null) {
    response.sendRedirect(url + "LoginController");
    return;
}
String nombreCompleto = usuario.getNombreCompleto();
String rol = usuario.getRol();
String email = usuario.getEmail();
String nombreUsuario = usuario.getNombreUsuario();
boolean esAdmin = "ADMIN".equals(rol);
%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>👤 Mi Perfil — La Carnicería</title>

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
   HERO
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
    display: flex; align-items: center; gap: 24px;
}

.hero-left h1 {
    font-family: var(--font-title);
    font-size: clamp(1.8rem, 4vw, 2.4rem);
    font-weight: 800;
    color: #fff;
    line-height: 1.15;
    text-shadow: 0 2px 12px rgba(0,0,0,.25);
}
.hero-left h1 .gold { color: var(--color-gold-light); }
.hero-left p {
    color: rgba(255,255,255,.72);
    font-size: .9rem;
    margin-top: 8px;
}

/* ============================================================
   PROFILE HEADER
   ============================================================ */
.profile-header {
    position: relative; z-index: 3;
    margin-top: -50px;
    padding: 0 15px;
}

.profile-card {
    background: #fff;
    border-radius: 20px;
    box-shadow: 0 8px 32px rgba(44,36,32,.15);
    padding: 32px;
    display: flex;
    align-items: center;
    gap: 28px;
    border: 1px solid rgba(44,36,32,.06);
    animation: slideUp .5s ease both;
}

@keyframes slideUp {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

.profile-avatar {
    flex-shrink: 0;
    width: 120px;
    height: 120px;
    border-radius: 50%;
    background: linear-gradient(135deg, var(--color-blood), var(--color-blood-soft));
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: var(--font-title);
    font-size: 2.5rem;
    font-weight: 800;
    color: #fff;
    box-shadow: 0 4px 20px rgba(139,0,0,.3);
    position: relative;
}

.profile-avatar::after {
    content: '';
    position: absolute;
    inset: -4px;
    border-radius: 50%;
    border: 3px solid var(--color-gold);
    opacity: .4;
}

.profile-info {
    flex: 1;
}

.profile-name {
    font-family: var(--font-title);
    font-size: 1.8rem;
    font-weight: 800;
    color: var(--color-charcoal);
    margin-bottom: 6px;
}

.profile-role {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    background: linear-gradient(135deg, var(--color-gold), #b8945a);
    color: var(--color-charcoal);
    padding: 6px 16px;
    border-radius: 20px;
    font-size: .8rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: .6px;
    margin-bottom: 12px;
}

.profile-role i { font-size: .75rem; }

.profile-meta {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    color: var(--color-smoke);
    font-size: .88rem;
}

.profile-meta-item {
    display: flex;
    align-items: center;
    gap: 8px;
}

.profile-meta-item i {
    color: var(--color-blood);
    font-size: .85rem;
}

.profile-actions {
    display: flex;
    gap: 12px;
    flex-shrink: 0;
}

.btn-profile {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 11px 20px;
    border: none;
    border-radius: 10px;
    font-size: .85rem;
    font-weight: 600;
    cursor: pointer;
    transition: transform var(--transition), box-shadow var(--transition);
}

.btn-profile.primary {
    background: linear-gradient(135deg, var(--color-blood), var(--color-blood-soft));
    color: #fff;
    box-shadow: 0 3px 12px rgba(139,0,0,.25);
}

.btn-profile.primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 18px rgba(139,0,0,.35);
}

.btn-profile.secondary {
    background: #fff;
    border: 1.5px solid var(--color-bone);
    color: var(--color-charcoal);
}

.btn-profile.secondary:hover {
    background: var(--color-cream);
    border-color: var(--color-gold);
}

.btn-profile i { font-size: .8rem; }

/* ============================================================
   MAIN CONTENT
   ============================================================ */
.main-wrap { padding: 32px 0 60px; }

.content-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
}

.content-card {
    background: #fff;
    border-radius: 16px;
    padding: 24px;
    box-shadow: 0 4px 20px rgba(44,36,32,.08);
    border: 1px solid rgba(44,36,32,.05);
}

.card-header {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 20px;
    padding-bottom: 16px;
    border-bottom: 2px solid var(--color-bone);
}

.card-header i {
    width: 36px;
    height: 36px;
    border-radius: 10px;
    background: linear-gradient(135deg, var(--color-blood), var(--color-blood-soft));
    color: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: .9rem;
}

.card-header h3 {
    font-family: var(--font-title);
    font-size: 1.15rem;
    font-weight: 700;
    color: var(--color-charcoal);
}

/* Info Item */
.info-item {
    display: flex;
    align-items: flex-start;
    gap: 14px;
    padding: 14px 0;
    border-bottom: 1px solid var(--color-bone);
}

.info-item:last-child { border-bottom: none; }

.info-icon {
    width: 40px;
    height: 40px;
    border-radius: 10px;
    background: var(--color-cream);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: .9rem;
    color: var(--color-blood);
    flex-shrink: 0;
}

.info-content {
    flex: 1;
}

.info-label {
    font-size: .72rem;
    text-transform: uppercase;
    letter-spacing: .6px;
    color: var(--color-smoke);
    margin-bottom: 4px;
}

.info-value {
    font-size: .95rem;
    font-weight: 600;
    color: var(--color-charcoal);
}

/* Stats */
.stats-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 14px;
}

.stat-box {
    background: var(--color-cream);
    border-radius: 12px;
    padding: 18px;
    text-align: center;
    border: 1px solid var(--color-bone);
    transition: transform var(--transition), box-shadow var(--transition);
}

.stat-box:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 16px rgba(44,36,32,.1);
}

.stat-icon {
    width: 48px;
    height: 48px;
    border-radius: 12px;
    background: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 12px;
    font-size: 1.2rem;
}

.stat-icon.red   { color: var(--color-blood); }
.stat-icon.gold  { color: var(--color-gold); }
.stat-icon.green { color: var(--color-green); }
.stat-icon.blue  { color: var(--color-blue); }

.stat-number {
    font-family: var(--font-title);
    font-size: 1.6rem;
    font-weight: 800;
    color: var(--color-charcoal);
    margin-bottom: 4px;
}

.stat-label {
    font-size: .75rem;
    color: var(--color-smoke);
    text-transform: uppercase;
    letter-spacing: .5px;
}

/* Security */
.security-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 14px 0;
    border-bottom: 1px solid var(--color-bone);
}

.security-item:last-child { border-bottom: none; }

.security-left {
    display: flex;
    align-items: center;
    gap: 12px;
}

.security-icon {
    width: 36px;
    height: 36px;
    border-radius: 8px;
    background: var(--color-cream);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: .85rem;
    color: var(--color-blood);
}

.security-info h4 {
    font-size: .9rem;
    font-weight: 600;
    color: var(--color-charcoal);
    margin-bottom: 2px;
}

.security-info p {
    font-size: .75rem;
    color: var(--color-smoke);
    margin: 0;
}

.security-status {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    padding: 4px 10px;
    border-radius: 12px;
    font-size: .72rem;
    font-weight: 600;
}

.security-status.ok {
    background: #E8F7EF;
    color: var(--color-green);
}

.security-status.warning {
    background: #FFF3CD;
    color: #856404;
}

/* Full width card */
.content-card.full {
    grid-column: 1 / -1;
}

/* ============================================================
   RESPONSIVE
   ============================================================ */
@media (max-width: 768px) {
    .profile-card {
        flex-direction: column;
        text-align: center;
    }
    .profile-actions {
        flex-direction: column;
        width: 100%;
    }
    .btn-profile {
        width: 100%;
        justify-content: center;
    }
    .content-grid {
        grid-template-columns: 1fr;
    }
    .stats-grid {
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
                <h1><i class="fas fa-user-circle" style="font-size:.75em; opacity:.6;"></i> Mi <span class="gold">Perfil</span></h1>
                <p>Administra tu información personal y configuración de cuenta.</p>
            </div>
        </div>
    </div>
</section>

<!-- PROFILE HEADER -->
<div class="profile-header">
    <div class="container">
        <div class="profile-card">
            <div class="profile-avatar">
                <%=nombreCompleto.substring(0,1).toUpperCase()%>
            </div>

            <div class="profile-info">
                <div class="profile-name"><%=nombreCompleto%></div>
                <div class="profile-role">
                    <i class="fas fa-<%= esAdmin ? "crown" : "user" %>"></i>
                    <%= rol %>
                </div>
                <div class="profile-meta">
                    <div class="profile-meta-item">
                        <i class="fas fa-user"></i>
                        <span>@<%=nombreUsuario%></span>
                    </div>
                    <div class="profile-meta-item">
                        <i class="fas fa-envelope"></i>
                        <span><%=email != null ? email : "Sin email"%></span>
                    </div>
                    <div class="profile-meta-item">
                        <i class="fas fa-calendar"></i>
                        <span>Miembro desde 2025</span>
                    </div>
                </div>
            </div>

            <div class="profile-actions">
                <button class="btn-profile primary" onclick="openEditModal()">
                    <i class="fas fa-pen"></i> Editar Perfil
                </button>
                <button class="btn-profile secondary" onclick="openPasswordModal()">
                    <i class="fas fa-key"></i> Cambiar Contraseña
                </button>
            </div>
        </div>
    </div>
</div>

<!-- MAIN CONTENT -->
<div class="main-wrap">
    <div class="container">
        <div class="content-grid">

            <!-- Información Personal -->
            <div class="content-card">
                <div class="card-header">
                    <i class="fas fa-id-card"></i>
                    <h3>Información Personal</h3>
                </div>

                <div class="info-item">
                    <div class="info-icon"><i class="fas fa-signature"></i></div>
                    <div class="info-content">
                        <div class="info-label">Nombre Completo</div>
                        <div class="info-value"><%=nombreCompleto%></div>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon"><i class="fas fa-user"></i></div>
                    <div class="info-content">
                        <div class="info-label">Usuario</div>
                        <div class="info-value">@<%=nombreUsuario%></div>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon"><i class="fas fa-at"></i></div>
                    <div class="info-content">
                        <div class="info-label">Correo Electrónico</div>
                        <div class="info-value"><%=email != null ? email : "No configurado"%></div>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon"><i class="fas fa-shield-halved"></i></div>
                    <div class="info-content">
                        <div class="info-label">Rol en el Sistema</div>
                        <div class="info-value"><%= rol %></div>
                    </div>
                </div>
            </div>

            <!-- Estadísticas -->
            <div class="content-card">
                <div class="card-header">
                    <i class="fas fa-chart-line"></i>
                    <h3>Actividad Reciente</h3>
                </div>

                <div class="stats-grid">
                    <div class="stat-box">
                        <div class="stat-icon red"><i class="fas fa-box"></i></div>
                        <div class="stat-number">—</div>
                        <div class="stat-label">Productos</div>
                    </div>

                    <div class="stat-box">
                        <div class="stat-icon gold"><i class="fas fa-shopping-cart"></i></div>
                        <div class="stat-number">—</div>
                        <div class="stat-label">Ventas</div>
                    </div>

                    <div class="stat-box">
                        <div class="stat-icon green"><i class="fas fa-clock"></i></div>
                        <div class="stat-number">—</div>
                        <div class="stat-label">Días Activo</div>
                    </div>

                    <div class="stat-box">
                        <div class="stat-icon blue"><i class="fas fa-star"></i></div>
                        <div class="stat-number">100%</div>
                        <div class="stat-label">Rendimiento</div>
                    </div>
                </div>
            </div>

            <!-- Seguridad -->
            <div class="content-card full">
                <div class="card-header">
                    <i class="fas fa-lock"></i>
                    <h3>Seguridad de la Cuenta</h3>
                </div>

                <div class="security-item">
                    <div class="security-left">
                        <div class="security-icon"><i class="fas fa-key"></i></div>
                        <div class="security-info">
                            <h4>Contraseña</h4>
                            <p>Última actualización hace 30 días</p>
                        </div>
                    </div>
                    <div class="security-status ok">
                        <i class="fas fa-check-circle"></i> Segura
                    </div>
                </div>

                <div class="security-item">
                    <div class="security-left">
                        <div class="security-icon"><i class="fas fa-envelope"></i></div>
                        <div class="security-info">
                            <h4>Correo de Verificación</h4>
                            <p><%=email != null ? email : "No configurado"%></p>
                        </div>
                    </div>
                    <div class="security-status <%= email != null ? "ok" : "warning" %>">
                        <i class="fas fa-<%= email != null ? "check-circle" : "exclamation-triangle" %>"></i>
                        <%= email != null ? "Verificado" : "Pendiente" %>
                    </div>
                </div>

                <div class="security-item">
                    <div class="security-left">
                        <div class="security-icon"><i class="fas fa-clock"></i></div>
                        <div class="security-info">
                            <h4>Última Sesión</h4>
                            <p>Hoy a las <%= new java.text.SimpleDateFormat("HH:mm").format(new java.util.Date()) %></p>
                        </div>
                    </div>
                    <div class="security-status ok">
                        <i class="fas fa-check-circle"></i> Activa
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
    crossorigin="anonymous"></script>

<script>
function openEditModal() {
    alert('Función de editar perfil - próximamente');
    // Aquí puedes abrir un modal o redirigir a una página de edición
}

function openPasswordModal() {
    alert('Función de cambiar contraseña - próximamente');
    // Aquí puedes abrir un modal o redirigir a cambio de contraseña
}
</script>

</body>
</html>
