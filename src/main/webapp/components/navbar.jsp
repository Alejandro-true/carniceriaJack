<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<!-- Google Fonts (carga condicional: solo si no fue cargado ya) -->
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
/* ============================================================
   VARIABLES (mismas del sistema carnicería)
   ============================================================ */
:root {
    --nb-blood:       #8B0000;
    --nb-blood-deep: #6B0000;
    --nb-blood-soft: #A52020;
    --nb-cream:      #FDF5EC;
    --nb-bone:       #E8DDD0;
    --nb-charcoal:   #2C2420;
    --nb-smoke:      #5C4A42;
    --nb-gold:       #C8A96E;
    --nb-gold-light: #E2D0A4;
    --nb-green:      #2E7D4F;

    --nb-font-title: 'Playfair Display', Georgia, serif;
    --nb-font-body:  'DM Sans', system-ui, sans-serif;
    --nb-transition: 0.26s cubic-bezier(.4,0,.2,1);
    --nb-radius:     10px;
}

/* ============================================================
   NAVBAR STRUCTURE
   ============================================================ */
.navbar-carnic {
    font-family: var(--nb-font-body);
    background: linear-gradient(135deg, var(--nb-blood-deep) 0%, var(--nb-blood) 60%, var(--nb-blood-soft) 100%);
    padding: 0 0;
    position: sticky;
    top: 0;
    z-index: 1050;
    box-shadow:
        0 2px 0 rgba(200,169,110,.18),
        0 4px 20px rgba(44,36,32,.22);
}

/* Gold line at top */
.navbar-carnic::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 3px;
    background: linear-gradient(90deg, transparent 0%, var(--nb-gold) 30%, var(--nb-gold-light) 50%, var(--nb-gold) 70%, transparent 100%);
}

/* ============================================================
   BRAND
   ============================================================ */
.navbar-carnic .nb-brand {
    font-family: var(--nb-font-title);
    font-size: 1.38rem;
    font-weight: 800;
    color: #fff !important;
    text-decoration: none;
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 14px 0;
    letter-spacing: .3px;
    transition: opacity var(--nb-transition);
}
.navbar-carnic .nb-brand:hover { opacity: .88; }

.nb-brand-icon {
    width: 36px; height: 36px;
    background: linear-gradient(135deg, var(--nb-gold), #b8945a);
    border-radius: 10px;
    display: flex; align-items: center; justify-content: center;
    font-size: .95rem;
    color: var(--nb-charcoal);
    box-shadow: 0 2px 8px rgba(200,169,110,.35);
}
.nb-brand .nb-brand-gold { color: var(--nb-gold-light); }

/* ============================================================
   NAV LINKS
   ============================================================ */
.navbar-carnic .nb-nav {
    display: flex;
    align-items: center;
    gap: 4px;
    list-style: none;
    margin: 0;
    padding: 0;
}

.navbar-carnic .nb-nav-link {
    display: flex;
    align-items: center;
    gap: 7px;
    color: rgba(255,255,255,.75);
    text-decoration: none;
    font-size: .88rem;
    font-weight: 500;
    padding: 9px 15px;
    border-radius: 8px;
    position: relative;
    transition: color var(--nb-transition), background var(--nb-transition);
    white-space: nowrap;
}
.navbar-carnic .nb-nav-link i {
    font-size: .82rem;
    opacity: .8;
    transition: opacity var(--nb-transition);
}

.navbar-carnic .nb-nav-link:hover {
    color: #fff;
    background: rgba(255,255,255,.1);
}
.navbar-carnic .nb-nav-link:hover i { opacity: 1; }

/* Active state */
.navbar-carnic .nb-nav-link.active {
    color: #fff;
    background: rgba(255,255,255,.15);
}
.navbar-carnic .nb-nav-link.active::after {
    content: '';
    position: absolute;
    bottom: -1px; left: 18%; right: 18%;
    height: 2px;
    background: var(--nb-gold);
    border-radius: 2px;
}

/* ============================================================
   DROPDOWN TOGGLE
   ============================================================ */
.navbar-carnic .nb-dropdown-toggle {
    display: flex;
    align-items: center;
    gap: 7px;
    color: rgba(255,255,255,.75);
    text-decoration: none;
    font-size: .88rem;
    font-weight: 500;
    padding: 9px 15px;
    border-radius: 8px;
    cursor: pointer;
    transition: color var(--nb-transition), background var(--nb-transition);
    position: relative;
    white-space: nowrap;
    background: transparent;
    border: none;
}
.navbar-carnic .nb-dropdown-toggle i { font-size: .82rem; opacity: .8; }
.navbar-carnic .nb-dropdown-toggle .caret {
    font-size: .6rem;
    margin-left: 2px;
    opacity: .6;
    transition: transform var(--nb-transition), opacity var(--nb-transition);
}
.navbar-carnic .nb-dropdown-toggle:hover,
.navbar-carnic .nb-dropdown-toggle.show {
    color: #fff;
    background: rgba(255,255,255,.1);
}
.navbar-carnic .nb-dropdown-toggle.show .caret {
    transform: rotate(180deg);
    opacity: 1;
}
.navbar-carnic .nb-dropdown-toggle.active {
    background: rgba(255,255,255,.15);
    color: #fff;
}
.navbar-carnic .nb-dropdown-toggle.active::after {
    content: '';
    position: absolute;
    bottom: -1px; left: 18%; right: 18%;
    height: 2px;
    background: var(--nb-gold);
    border-radius: 2px;
}

/* ============================================================
   DROPDOWN MENUS
   ============================================================ */
.navbar-carnic .nb-dropdown {
    position: relative;
}
.nb-dropdown-menu {
    display: none;
    position: absolute;
    top: calc(100% + 10px);
    left: 50%;
    transform: translateX(-50%) translateY(-6px);
    min-width: 210px;
    background: #fff;
    border-radius: 14px;
    box-shadow:
        0 8px 32px rgba(44,36,32,.18),
        0 2px 0 rgba(200,169,110,.12);
    border: 1px solid rgba(44,36,32,.06);
    overflow: hidden;
    opacity: 0;
    transition: opacity .22s ease, transform .22s ease;
    z-index: 1060;
}
.nb-dropdown-menu.show {
    display: block;
    opacity: 1;
    transform: translateX(-50%) translateY(0);
}
/* right-align variant */
.nb-dropdown-menu.end {
    left: auto; right: 0;
    transform: translateX(0) translateY(-6px);
}
.nb-dropdown-menu.end.show {
    transform: translateX(0) translateY(0);
}

/* Arrow caret on dropdown */
.nb-dropdown-menu::before {
    content: '';
    position: absolute;
    top: -6px;
    left: 50%;
    transform: translateX(-50%);
    width: 12px; height: 12px;
    background: #fff;
    border-left: 1px solid rgba(44,36,32,.06);
    border-top: 1px solid rgba(44,36,32,.06);
    transform: translateX(-50%) rotate(45deg);
}
.nb-dropdown-menu.end::before {
    left: auto; right: 28px;
    transform: rotate(45deg);
}

/* Dropdown header */
.nb-drop-header {
    padding: 12px 16px 6px;
    font-size: .72rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: .8px;
    color: var(--nb-smoke);
    display: flex; align-items: center; gap: 7px;
}
.nb-drop-header i { font-size: .7rem; color: var(--nb-gold); }

/* Divider */
.nb-drop-divider {
    height: 1px;
    background: var(--nb-bone);
    margin: 4px 10px;
}

/* Dropdown item */
.nb-drop-item {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 9px 16px;
    color: var(--nb-charcoal);
    text-decoration: none;
    font-size: .87rem;
    font-weight: 500;
    transition: background var(--nb-transition), color var(--nb-transition), padding-left var(--nb-transition);
    white-space: nowrap;
}
.nb-drop-item i {
    width: 16px;
    text-align: center;
    font-size: .82rem;
    color: var(--nb-smoke);
    transition: color var(--nb-transition);
}
.nb-drop-item:hover {
    background: #FFF5F0;
    color: var(--nb-blood);
    padding-left: 20px;
}
.nb-drop-item:hover i { color: var(--nb-blood); }

/* Logout danger style */
.nb-drop-item.danger { color: var(--nb-blood); }
.nb-drop-item.danger i { color: var(--nb-blood); }
.nb-drop-item.danger:hover { background: #FEE8E8; }

/* ============================================================
   USER SECTION (right side)
   ============================================================ */
.nb-user-trigger {
    display: flex;
    align-items: center;
    gap: 9px;
}

.nb-avatar {
    width: 34px; height: 34px;
    border-radius: 50%;
    background: linear-gradient(135deg, var(--nb-gold), #b8945a);
    display: flex; align-items: center; justify-content: center;
    color: var(--nb-charcoal);
    font-weight: 700;
    font-size: .88rem;
    box-shadow: 0 2px 6px rgba(200,169,110,.3);
    flex-shrink: 0;
}

.nb-user-name {
    font-size: .88rem;
    font-weight: 600;
    color: #fff;
}
.nb-user-role {
    display: inline-flex;
    align-items: center;
    gap: 3px;
    background: var(--nb-gold);
    color: var(--nb-charcoal);
    font-size: .66rem;
    font-weight: 700;
    padding: 1px 7px;
    border-radius: 10px;
    text-transform: uppercase;
    letter-spacing: .5px;
    margin-left: 6px;
}
.nb-user-role i { font-size: .58rem; }

/* ============================================================
   MOBILE TOGGLER
   ============================================================ */
.nb-toggler {
    display: none;
    flex-direction: column;
    gap: 5px;
    padding: 8px;
    cursor: pointer;
    border: none;
    background: transparent;
}
.nb-toggler span {
    display: block;
    width: 24px; height: 2px;
    background: rgba(255,255,255,.8);
    border-radius: 2px;
    transition: transform .28s ease, opacity .28s ease;
}
.nb-toggler.open span:nth-child(1) { transform: translateY(7px) rotate(45deg); }
.nb-toggler.open span:nth-child(2) { opacity: 0; }
.nb-toggler.open span:nth-child(3) { transform: translateY(-7px) rotate(-45deg); }

/* ============================================================
   RESPONSIVE — mobile collapse
   ============================================================ */
.nb-collapse {
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex: 1;
}

@media (max-width: 860px) {
    .nb-toggler { display: flex; }

    .nb-collapse {
        display: none;
        position: absolute;
        top: 100%; left: 0; right: 0;
        background: linear-gradient(180deg, var(--nb-blood) 0%, var(--nb-blood-deep) 100%);
        flex-direction: column;
        align-items: stretch;
        padding: 12px 0 18px;
        box-shadow: 0 8px 24px rgba(44,36,32,.25);
        gap: 2px;
    }
    .nb-collapse.open {
        display: flex;
    }

    .nb-nav {
        flex-direction: column;
        align-items: stretch;
        gap: 2px;
        padding: 0 12px;
    }
    .navbar-carnic .nb-nav-link,
    .navbar-carnic .nb-dropdown-toggle {
        padding: 10px 14px;
        border-radius: 8px;
    }

    /* Dropdowns become static on mobile */
    .nb-dropdown { position: static; }
    .nb-dropdown-menu {
        position: static;
        transform: none !important;
        left: auto; right: auto;
        border-radius: 10px;
        margin: 6px 0 0;
        box-shadow: 0 2px 10px rgba(44,36,32,.12);
    }
    .nb-dropdown-menu::before { display: none; }

    /* User section mobile */
    .nb-user-wrap {
        border-top: 1px solid rgba(255,255,255,.12);
        margin-top: 8px;
        padding: 10px 12px 0;
    }
    .nb-user-wrap .nb-dropdown-menu {
        margin-top: 8px;
    }
}

/* ============================================================
   NAVBAR ROW (inner flex container)
   ============================================================ */
.nb-row {
    display: flex;
    align-items: center;
    gap: 16px;
    width: 100%;
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
}
</style>

<!-- ============================================================
     NAVBAR HTML
     ============================================================ -->
<nav class="navbar-carnic" role="navigation" aria-label="Navegación principal">

    <div class="nb-row">

        <!-- BRAND -->
        <a class="nb-brand" href="<%=contextPath%>/inicio.jsp">
            <div class="nb-brand-icon"><i class="fas fa-bone"></i></div>
            Carnicería <span class="nb-brand-gold">Jack</span>
        </a>

        <!-- MOBILE TOGGLER -->
        <button class="nb-toggler" id="nbToggler" aria-label="Abrir menú">
            <span></span><span></span><span></span>
        </button>

        <!-- COLLAPSIBLE CONTENT -->
        <div class="nb-collapse" id="nbCollapse">

            <!-- NAV LINKS -->
            <ul class="nb-nav">

                <!-- Inicio -->
                <li>
                    <a class="nb-nav-link <%=currentUrl.contains("inicio.jsp") ? "active" : ""%>"
                       href="<%=contextPath%>/inicio.jsp">
                        <i class="fas fa-home"></i> Inicio
                    </a>
                </li>

                <!-- Autores -->
                <li>
                    <a class="nb-nav-link <%=currentUrl.contains("ClienteController") ? "active" : ""%>"
                       href="<%=contextPath%>/ClienteController?op=listar">
                        <i class="fas fa-users"></i> Clientes
                    </a>
                </li>

                <!-- Productos (Libros) -->
                <li>
                    <a class="nb-nav-link <%=currentUrl.contains("ProductoController") ? "active" : ""%>"
                       href="<%=contextPath%>/ProductoController?op=listar">
                        <i class="fas fa-tag"></i> Productos
                    </a>
                </li>

                <!-- Admin dropdown (solo si esAdmin) -->
                <%
                if (esAdmin) {
                %>
                <li class="nb-dropdown" id="dropAdmin">
                    <button class="nb-dropdown-toggle <%=currentUrl.contains("UsuariosController") ? "active" : ""%>"
                            onclick="toggleDrop('dropAdmin')"
                            aria-expanded="false">
                        <i class="fas fa-cog"></i> Administración
                        <i class="fas fa-chevron-down caret"></i>
                    </button>
                    <div class="nb-dropdown-menu" id="menuAdmin">
                        <div class="nb-drop-header"><i class="fas fa-shield-halved"></i> Panel Admin</div>
                        <a class="nb-drop-item" href="<%=contextPath%>/UsuariosController?op=listar">
                            <i class="fas fa-user-shield"></i> Usuarios
                        </a>
                        <a class="nb-drop-item" href="#">
                            <i class="fas fa-chart-bar"></i> Reportes
                        </a>
                    </div>
                </li>
                <%
                }
                %>
            </ul>

            <!-- USER SECTION -->
            <div class="nb-user-wrap nb-dropdown" id="dropUser">
                <button class="nb-dropdown-toggle nb-user-trigger"
                        onclick="toggleDrop('dropUser')"
                        aria-expanded="false">
                    <div class="nb-avatar">
                        <%=nombreUsuario.substring(0,1).toUpperCase()%>
                    </div>
                    <span class="nb-user-name">
                        <%=nombreUsuario%>
                        <% if (esAdmin) { %>
                            <span class="nb-user-role"><i class="fas fa-shield-halved"></i> Admin</span>
                        <% } %>
                    </span>
                    <i class="fas fa-chevron-down caret"></i>
                </button>

                <div class="nb-dropdown-menu end" id="menuUser">
                    <div class="nb-drop-header"><i class="fas fa-user"></i> Cuenta</div>
                    <a class="nb-drop-item" href="<%=contextPath%>/UsuariosController?op=perfil">
                        <i class="fas fa-user-pen"></i> Mi Perfil
                    </a>
                    <a class="nb-drop-item" href="#">
                        <i class="fas fa-key"></i> Cambiar Contraseña
                    </a>
                    <div class="nb-drop-divider"></div>
                    <a class="nb-drop-item danger" href="<%=contextPath%>/LoginController?accion=logout">
                        <i class="fas fa-right-from-bracket"></i> Cerrar Sesión
                    </a>
                </div>
            </div>

        </div><!-- /nb-collapse -->
    </div><!-- /nb-row -->
</nav>

<!-- ============================================================
     SCRIPT — dropdowns + mobile toggle
     ============================================================ -->
<script>
(function () {
    // ── Dropdown toggle ──────────────────────────────────
    function toggleDrop(wrapperId) {
        const wrapper = document.getElementById(wrapperId);
        const menu    = wrapper.querySelector('.nb-dropdown-menu');
        const trigger = wrapper.querySelector('.nb-dropdown-toggle');
        const isOpen  = menu.classList.contains('show');

        // Cerrar todos los demás
        document.querySelectorAll('.nb-dropdown').forEach(function (d) {
            if (d.id === wrapperId) return;
            d.querySelector('.nb-dropdown-menu').classList.remove('show');
            d.querySelector('.nb-dropdown-toggle').classList.remove('show');
        });

        // Togglear este
        menu.classList.toggle('show', !isOpen);
        trigger.classList.toggle('show', !isOpen);
        trigger.setAttribute('aria-expanded', String(!isOpen));
    }
    window.toggleDrop = toggleDrop; // expose global para onclick

    // Cerrar al hacer click afuera
    document.addEventListener('click', function (e) {
        if (!e.target.closest('.nb-dropdown')) {
            document.querySelectorAll('.nb-dropdown').forEach(function (d) {
                d.querySelector('.nb-dropdown-menu').classList.remove('show');
                d.querySelector('.nb-dropdown-toggle').classList.remove('show');
            });
        }
    });

    // ── Mobile toggler ───────────────────────────────────
    var toggler  = document.getElementById('nbToggler');
    var collapse = document.getElementById('nbCollapse');

    if (toggler && collapse) {
        toggler.addEventListener('click', function () {
            toggler.classList.toggle('open');
            collapse.classList.toggle('open');
        });
    }
})();
</script>
