<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<%
String url = request.getContextPath() + "/";
%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Iniciar Sesión — La Carnicería</title>

<!-- Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet">
<!-- FA -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
/* ============================================================
   RESET & VARIABLES
   ============================================================ */
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

:root {
    --blood:       #8B0000;
    --blood-deep: #6B0000;
    --blood-soft: #A52020;
    --cream:      #FDF5EC;
    --bone:       #E8DDD0;
    --charcoal:   #2C2420;
    --smoke:      #5C4A42;
    --gold:       #C8A96E;
    --gold-light: #E2D0A4;
    --green:      #2E7D4F;

    --font-title: 'Playfair Display', Georgia, serif;
    --font-body:  'DM Sans', system-ui, sans-serif;
    --transition: 0.26s cubic-bezier(.4,0,.2,1);
}

/* ============================================================
   BODY / BG
   ============================================================ */
html, body {
    height: 100%;
    font-family: var(--font-body);
    background: var(--blood-deep);
    color: var(--charcoal);
    overflow: hidden;
}

/* Full-page gradient */
.page-bg {
    position: fixed; inset: 0; z-index: 0;
    background: linear-gradient(150deg, var(--blood-deep) 0%, var(--blood) 45%, var(--blood-soft) 100%);
}

/* Atmospheric blobs */
.page-bg::before {
    content: '';
    position: absolute; inset: 0;
    background:
        radial-gradient(ellipse 500px 320px at 5%  75%,  rgba(255,255,255,.05) 0%, transparent 70%),
        radial-gradient(ellipse 340px 440px at 92% 20%,  rgba(255,255,255,.04) 0%, transparent 70%),
        radial-gradient(circle 180px at 50% 90%,         rgba(255,255,255,.03) 0%, transparent 70%),
        radial-gradient(ellipse 260px 160px at 75% 75%,  rgba(255,255,255,.025) 0%, transparent 70%);
}

/* Subtle grain */
.page-bg::after {
    content: '';
    position: absolute; inset: 0;
    background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='0.035'/%3E%3C/svg%3E");
    pointer-events: none;
}

/* Decorative floating bones */
.deco-bone {
    position: fixed;
    color: rgba(255,255,255,.06);
    pointer-events: none;
    z-index: 1;
}
.deco-bone.b1 { top: 8%;  left: 6%;  font-size: 5rem;  animation: float1 18s ease-in-out infinite; }
.deco-bone.b2 { top: 65%; left: 2%;  font-size: 3.5rem; animation: float2 20s ease-in-out infinite; }
.deco-bone.b3 { top: 12%; right: 8%; font-size: 4rem;  animation: float3 16s ease-in-out infinite; }
.deco-bone.b4 { bottom: 10%; right: 5%; font-size: 5.5rem; animation: float4 22s ease-in-out infinite; }

@keyframes float1 { 0%,100%{ transform:translateY(0) rotate(0deg); } 50%{ transform:translateY(-22px) rotate(6deg); } }
@keyframes float2 { 0%,100%{ transform:translateY(0) rotate(25deg); } 50%{ transform:translateY(-18px) rotate(31deg); } }
@keyframes float3 { 0%,100%{ transform:translateY(0) rotate(-18deg); } 50%{ transform:translateY(-20px) rotate(-12deg); } }
@keyframes float4 { 0%,100%{ transform:translateY(0) rotate(40deg); } 50%{ transform:translateY(-16px) rotate(46deg); } }

/* ============================================================
   CENTERING
   ============================================================ */
.login-wrap {
    position: relative; z-index: 2;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 24px;
    animation: wrapIn .5s ease both;
}
@keyframes wrapIn {
    from { opacity: 0; transform: translateY(14px); }
    to   { opacity: 1; transform: translateY(0); }
}

/* ============================================================
   CARD
   ============================================================ */
.login-card {
    width: 100%;
    max-width: 420px;
    background: #fff;
    border-radius: 24px;
    overflow: hidden;
    box-shadow:
        0 8px 40px rgba(44,36,32,.28),
        0 2px 0 rgba(200,169,110,.15);
}

/* ── Header ── */
.login-header {
    background: linear-gradient(135deg, var(--blood-deep), var(--blood));
    padding: 36px 28px 32px;
    text-align: center;
    position: relative;
    overflow: hidden;
}
.login-header::before {
    content: '';
    position: absolute;
    top: -50px; left: 50%;
    transform: translateX(-50%);
    width: 220px; height: 220px;
    background: radial-gradient(circle, rgba(255,255,255,.07) 0%, transparent 70%);
    pointer-events: none;
}

/* Logo badge */
.login-logo {
    width: 64px; height: 64px;
    border-radius: 18px;
    background: linear-gradient(135deg, var(--gold), #b8945a);
    display: flex; align-items: center; justify-content: center;
    margin: 0 auto 16px;
    font-size: 1.7rem;
    color: var(--charcoal);
    box-shadow: 0 4px 14px rgba(200,169,110,.4);
    position: relative; z-index: 1;
}

.login-header h2 {
    font-family: var(--font-title);
    font-size: 1.55rem;
    font-weight: 800;
    color: #fff;
    position: relative; z-index: 1;
    margin-bottom: 4px;
}
.login-header h2 .gold { color: var(--gold-light); }
.login-header p {
    color: rgba(255,255,255,.6);
    font-size: .84rem;
    position: relative; z-index: 1;
}

/* Gold line at bottom of header */
.login-header::after {
    content: '';
    position: absolute;
    bottom: 0; left: 12%; right: 12%;
    height: 2px;
    background: linear-gradient(90deg, transparent, var(--gold), transparent);
}

/* ── Body ── */
.login-body {
    padding: 34px 32px 30px;
}

/* ── Error alert ── */
.alert-login {
    display: flex; align-items: flex-start; gap: 10px;
    background: #FEE8E8;
    border: 1px solid #F5C6CB;
    border-radius: 10px;
    padding: 12px 14px;
    margin-bottom: 22px;
    font-size: .84rem;
    color: var(--blood);
    animation: shakeIn .35s ease;
}
.alert-login i { color: var(--blood); font-size: .9rem; flex-shrink: 0; margin-top: 1px; }
.alert-login .close-alert {
    margin-left: auto; background: none; border: none;
    color: var(--blood); opacity: .6; cursor: pointer; font-size: .88rem;
    transition: opacity var(--transition);
}
.alert-login .close-alert:hover { opacity: 1; }

@keyframes shakeIn {
    0%   { transform: translateX(-6px); opacity: 0; }
    40%  { transform: translateX(4px); }
    100% { transform: translateX(0); opacity: 1; }
}

/* ── Labels ── */
.inp-label {
    display: block;
    font-size: .76rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: .7px;
    color: var(--smoke);
    margin-bottom: 7px;
}
.inp-label i { color: var(--gold); margin-right: 5px; font-size: .72rem; }

/* ── Input group ── */
.inp-wrap {
    position: relative;
    margin-bottom: 20px;
}
.inp-icon {
    position: absolute;
    left: 14px; top: 50%; transform: translateY(-50%);
    color: var(--smoke);
    font-size: .82rem;
    pointer-events: none;
    transition: color var(--transition);
    z-index: 1;
}

.inp-field {
    width: 100%;
    padding: 12px 14px 12px 40px;
    border: 1.5px solid var(--bone);
    border-radius: 10px;
    font-family: var(--font-body);
    font-size: .92rem;
    color: var(--charcoal);
    background: var(--cream);
    transition: border-color var(--transition), box-shadow var(--transition), background var(--transition);
    outline: none;
}
.inp-field::placeholder { color: #B8ADA3; }

.inp-field:focus {
    border-color: var(--blood-soft);
    background: #fff;
    box-shadow: 0 0 0 3px rgba(139,0,0,.1);
}
.inp-wrap:focus-within .inp-icon { color: var(--blood); }

/* Password toggle btn */
.btn-toggle-pw {
    position: absolute;
    right: 10px; top: 50%; transform: translateY(-50%);
    background: none; border: none;
    color: var(--smoke);
    font-size: .84rem;
    cursor: pointer;
    width: 30px; height: 30px;
    display: flex; align-items: center; justify-content: center;
    border-radius: 7px;
    transition: color var(--transition), background var(--transition);
    z-index: 2;
}
.btn-toggle-pw:hover { color: var(--blood); background: rgba(139,0,0,.06); }

/* ── Submit btn ── */
.btn-login {
    display: flex; align-items: center; justify-content: center; gap: 8px;
    width: 100%;
    padding: 13px;
    border: none;
    border-radius: 10px;
    background: linear-gradient(135deg, var(--blood), var(--blood-soft));
    color: #fff;
    font-family: var(--font-body);
    font-size: .93rem;
    font-weight: 600;
    letter-spacing: .4px;
    cursor: pointer;
    box-shadow: 0 4px 16px rgba(139,0,0,.3);
    transition: transform var(--transition), box-shadow var(--transition), filter var(--transition);
    margin-top: 6px;
}
.btn-login:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 22px rgba(139,0,0,.38);
}
.btn-login:active { transform: translateY(0); }
.btn-login:disabled {
    filter: brightness(.88);
    cursor: not-allowed;
    transform: none;
}
.btn-login i { font-size: .88rem; }

/* Spinner */
.spin { display: inline-block; animation: spin .6s linear infinite; }
@keyframes spin { to { transform: rotate(360deg); } }

/* ── Credentials hint ── */
.hint-box {
    margin-top: 24px;
    background: linear-gradient(135deg, #FFF8EE, #FFF0DD);
    border: 1px solid rgba(200,169,110,.25);
    border-radius: 10px;
    padding: 12px 16px;
    text-align: center;
}
.hint-box p {
    font-size: .78rem;
    color: var(--smoke);
    margin: 0;
}
.hint-box strong { color: var(--charcoal); }
.hint-box .hint-icon { color: var(--gold); margin-right: 5px; font-size: .74rem; }

/* ============================================================
   FOOTER
   ============================================================ */
.login-footer {
    margin-top: 22px;
    text-align: center;
}
.login-footer p {
    color: rgba(255,255,255,.38);
    font-size: .77rem;
}
.login-footer .brand-small {
    font-family: var(--font-title);
    color: rgba(255,255,255,.55);
    font-weight: 700;
}
.login-footer .brand-small .gold { color: var(--gold); }

/* ============================================================
   RESPONSIVE
   ============================================================ */
@media (max-width: 480px) {
    html, body { overflow: auto; }
    .login-wrap { padding: 40px 16px; justify-content: flex-start; padding-top: 10vh; }
    .login-header { padding: 28px 20px 26px; }
    .login-body   { padding: 26px 22px 24px; }
    .deco-bone    { display: none; }
}
</style>
</head>
<body>

<!-- Background -->
<div class="page-bg"></div>

<!-- Floating bones decorative -->
<div class="deco-bone b1"><i class="fas fa-bone"></i></div>
<div class="deco-bone b2"><i class="fas fa-bone"></i></div>
<div class="deco-bone b3"><i class="fas fa-bone"></i></div>
<div class="deco-bone b4"><i class="fas fa-bone"></i></div>

<!-- ============================================================
     LOGIN CARD
     ============================================================ -->
<div class="login-wrap">
    <div class="login-card">

        <!-- Header -->
        <div class="login-header">
            <div class="login-logo"><i class="fas fa-bone"></i></div>
            <h2>La <span class="gold">Carnicería</span></h2>
            <p>Iniciar sesión para continuar</p>
        </div>

        <!-- Body -->
        <div class="login-body">

            <!-- Error condicional -->
            <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
            %>
            <div class="alert-login" id="alertError">
                <i class="fas fa-circle-exclamation"></i>
                <span><%=error%></span>
                <button class="close-alert" onclick="document.getElementById('alertError').remove()">
                    <i class="fas fa-xmark"></i>
                </button>
            </div>
            <%
            }
            %>

            <!-- Formulario -->
            <form action="<%=url%>LoginController" method="POST" id="formLogin">
                <input type="hidden" name="accion" value="login">

                <!-- Usuario -->
                <div class="inp-wrap">
                    <label class="inp-label"><i class="fas fa-user"></i> Usuario</label>
                    <i class="fas fa-user inp-icon"></i>
                    <input type="text"
                           class="inp-field"
                           name="usuario"
                           id="usuario"
                           placeholder="Nombre de usuario"
                           required
                           autofocus
                           autocomplete="username">
                </div>

                <!-- Contraseña -->
                <div class="inp-wrap">
                    <label class="inp-label"><i class="fas fa-lock"></i> Contraseña</label>
                    <i class="fas fa-lock inp-icon"></i>
                    <input type="password"
                           class="inp-field"
                           name="password"
                           id="password"
                           placeholder="Contraseña"
                           required
                           autocomplete="current-password">
                    <button type="button" class="btn-toggle-pw" id="togglePassword" title="Mostrar contraseña">
                        <i class="fas fa-eye"></i>
                    </button>
                </div>

                <!-- Submit -->
                <button type="submit" class="btn-login" id="btnLogin">
                    <i class="fas fa-right-to-bracket"></i> Iniciar Sesión
                </button>
            </form>

            <!-- Hint credenciales -->
            <div class="hint-box">
                <p><i class="fas fa-circle-info hint-icon"></i>
                    Usuario: <strong>admin</strong> &nbsp;|&nbsp; Contraseña: <strong>admin123</strong>
                </p>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="login-footer">
        <p><span class="brand-small">La <span class="gold">Carnicería</span></span> &nbsp;·&nbsp; &copy; 2025 — Todos los derechos reservados</p>
    </div>
</div>

<!-- ============================================================
     SCRIPTS
     ============================================================ -->
<script>
(function () {
    // ── Toggle contraseña ─────────────────────────────────
    var input  = document.getElementById('password');
    var btn    = document.getElementById('togglePassword');
    var icon   = btn.querySelector('i');

    btn.addEventListener('click', function () {
        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.replace('fa-eye', 'fa-eye-slash');
            btn.title = 'Ocultar contraseña';
        } else {
            input.type = 'password';
            icon.classList.replace('fa-eye-slash', 'fa-eye');
            btn.title = 'Mostrar contraseña';
        }
        input.focus();
    });

    // ── Spinner al enviar ─────────────────────────────────
    document.getElementById('formLogin').addEventListener('submit', function () {
        var btnLogin = document.getElementById('btnLogin');
        btnLogin.innerHTML = '<i class="fas fa-circle-notch spin"></i> Iniciando sesión…';
        btnLogin.disabled = true;
    });

    // ── Enter en usuario → saltar a contraseña ───────────
    document.getElementById('usuario').addEventListener('keydown', function (e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            document.getElementById('password').focus();
        }
    });
})();
</script>

</body>
</html>
