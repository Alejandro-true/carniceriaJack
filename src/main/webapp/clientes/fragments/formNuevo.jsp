<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String url = request.getContextPath() + "/";
%>

<style>
/* ============================================================
   FORM STYLES (scoped to modal)
   ============================================================ */
.form-carnic {
    --fc-blood: #8B0000;
    --fc-cream: #FDF5EC;
    --fc-bone: #E8DDD0;
    --fc-charcoal: #2C2420;
    --fc-smoke: #5C4A42;
    --fc-gold: #C8A96E;
    --fc-green: #2E7D4F;
}

.form-carnic .form-group {
    margin-bottom: 18px;
}

.form-carnic .form-label {
    display: block;
    font-size: .76rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: .6px;
    color: var(--fc-smoke);
    margin-bottom: 7px;
}
.form-carnic .form-label i {
    color: var(--fc-gold);
    margin-right: 5px;
    font-size: .72rem;
}
.form-carnic .form-label .required {
    color: var(--fc-blood);
    margin-left: 3px;
}

/* Input wrapper */
.form-carnic .input-wrapper {
    position: relative;
}

.form-carnic .input-icon {
    position: absolute;
    left: 14px;
    top: 50%;
    transform: translateY(-50%);
    color: var(--fc-smoke);
    font-size: .82rem;
    pointer-events: none;
    transition: color 0.26s ease;
    z-index: 1;
}

.form-carnic .form-control {
    width: 100%;
    padding: 11px 14px 11px 40px;
    border: 1.5px solid var(--fc-bone);
    border-radius: 10px;
    font-size: .9rem;
    color: var(--fc-charcoal);
    background: var(--fc-cream);
    transition: border-color 0.26s ease, box-shadow 0.26s ease, background 0.26s ease;
    outline: none;
    font-family: 'DM Sans', system-ui, sans-serif;
}

.form-carnic .form-control::placeholder {
    color: #B8ADA3;
    font-size: .86rem;
}

.form-carnic .form-control:focus {
    border-color: var(--fc-blood);
    background: #fff;
    box-shadow: 0 0 0 3px rgba(139, 0, 0, 0.1);
}

.form-carnic .input-wrapper:focus-within .input-icon {
    color: var(--fc-blood);
}

/* Validation states */
.form-carnic .form-control:invalid:not(:placeholder-shown) {
    border-color: #dc3545;
    background: #FFF5F5;
}

.form-carnic .form-control:valid:not(:placeholder-shown) {
    border-color: var(--fc-green);
}

/* Helper text */
.form-carnic .form-help {
    font-size: .76rem;
    color: var(--fc-smoke);
    margin-top: 5px;
    display: block;
    opacity: .7;
}

/* Submit button */
.form-carnic .btn-submit {
    width: 100%;
    padding: 12px;
    border: none;
    border-radius: 10px;
    background: linear-gradient(135deg, var(--fc-blood), #A52020);
    color: #fff;
    font-weight: 600;
    font-size: .92rem;
    letter-spacing: .4px;
    cursor: pointer;
    box-shadow: 0 4px 14px rgba(139, 0, 0, 0.25);
    transition: transform 0.26s ease, box-shadow 0.26s ease;
    margin-top: 6px;
}

.form-carnic .btn-submit:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 18px rgba(139, 0, 0, 0.32);
}

.form-carnic .btn-submit:active {
    transform: translateY(0);
}

.form-carnic .btn-submit:disabled {
    opacity: .6;
    cursor: not-allowed;
    transform: none;
}

.form-carnic .btn-submit i {
    margin-right: 6px;
    font-size: .88rem;
}

/* Form grid (2 columns) */
.form-carnic .form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 16px;
}

@media (max-width: 600px) {
    .form-carnic .form-row {
        grid-template-columns: 1fr;
    }
}

/* Divider */
.form-carnic .form-divider {
    height: 1px;
    background: var(--fc-bone);
    margin: 20px 0;
}

.form-carnic .form-section-title {
    font-size: .82rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: .8px;
    color: var(--fc-charcoal);
    margin-bottom: 14px;
    padding-bottom: 8px;
    border-bottom: 2px solid var(--fc-gold);
}
</style>

<form action="<%=url%>ClienteController" method="POST" id="formCliente" class="form-carnic" novalidate>
    <input type="hidden" name="op" value="insertarAjax">

    <!-- Sección: Información Personal -->
    <div class="form-section-title">
        <i class="fas fa-user" style="color: var(--fc-gold); margin-right: 6px;"></i>
        Información Personal
    </div>

    <!-- Nombre Completo -->
    <div class="form-group">
        <label for="nombre" class="form-label">
            <i class="fas fa-signature"></i> Nombre Completo
            <span class="required">*</span>
        </label>
        <div class="input-wrapper">
            <i class="fas fa-user input-icon"></i>
            <input type="text" 
                   class="form-control" 
                   name="nombre" 
                   id="nombre"
                   placeholder="Ej: José María Campos Rivera"
                   required
                   minlength="3"
                   maxlength="100">
        </div>
    </div>

    <!-- DNI -->
    <div class="form-group">
        <label for="dni" class="form-label">
            <i class="fas fa-id-card"></i> DNI
            <span class="required">*</span>
        </label>
        <div class="input-wrapper">
            <i class="fas fa-id-card input-icon"></i>
            <input type="text" 
                   class="form-control" 
                   name="dni" 
                   id="dni"
                   placeholder="Ej: 12345678"
                   required
                   pattern="[0-9]{8}"
                   maxlength="8">
        </div>
        <small class="form-help">Ingrese 8 dígitos numéricos</small>
    </div>

    <div class="form-divider"></div>

    <!-- Sección: Información de Contacto -->
    <div class="form-section-title">
        <i class="fas fa-address-book" style="color: var(--fc-gold); margin-right: 6px;"></i>
        Información de Contacto
    </div>

    <!-- Email y Teléfono (2 columnas) -->
    <div class="form-row">
        <div class="form-group">
            <label for="email" class="form-label">
                <i class="fas fa-envelope"></i> Email
                <span class="required">*</span>
            </label>
            <div class="input-wrapper">
                <i class="fas fa-at input-icon"></i>
                <input type="email" 
                       class="form-control" 
                       name="email" 
                       id="email"
                       placeholder="correo@ejemplo.com"
                       required>
            </div>
        </div>

        <div class="form-group">
            <label for="telefono" class="form-label">
                <i class="fas fa-phone"></i> Teléfono
                <span class="required">*</span>
            </label>
            <div class="input-wrapper">
                <i class="fas fa-phone input-icon"></i>
                <input type="tel" 
                       class="form-control" 
                       name="telefono" 
                       id="telefono"
                       placeholder="987654321"
                       required
                       pattern="[0-9]{9}"
                       maxlength="9">
            </div>
        </div>
    </div>

    <!-- Dirección -->
    <div class="form-group">
        <label for="direccion" class="form-label">
            <i class="fas fa-map-marker-alt"></i> Dirección
            <span class="required">*</span>
        </label>
        <div class="input-wrapper">
            <i class="fas fa-home input-icon"></i>
            <input type="text" 
                   class="form-control" 
                   name="direccion" 
                   id="direccion"
                   placeholder="Ej: Av. Principal 123, Miraflores"
                   required
                   minlength="5"
                   maxlength="200">
        </div>
    </div>

    <!-- Submit Button -->
    <div class="form-group" style="margin-top: 24px;">
        <button type="submit" class="btn-submit">
            <i class="fas fa-save"></i> Guardar Cliente
        </button>
    </div>
</form>

<script>
(function() {
    'use strict';
    
    const form = document.getElementById('formCliente');
    if (!form) return;

    // Validación en tiempo real
    const inputs = form.querySelectorAll('.form-control');
    
    inputs.forEach(input => {
        // Validar al escribir (después del primer blur)
        input.addEventListener('blur', function() {
            this.classList.add('touched');
        });
        
        input.addEventListener('input', function() {
            if (this.classList.contains('touched')) {
                if (this.validity.valid) {
                    this.classList.remove('is-invalid');
                    this.classList.add('is-valid');
                } else {
                    this.classList.remove('is-valid');
                    this.classList.add('is-invalid');
                }
            }
        });
    });

    // Validación especial para DNI (solo números)
    const dniInput = document.getElementById('dni');
    if (dniInput) {
        dniInput.addEventListener('input', function(e) {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
    }

    // Validación especial para teléfono (solo números)
    const telInput = document.getElementById('telefono');
    if (telInput) {
        telInput.addEventListener('input', function(e) {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
    }

    // Formatear nombre (capitalizar)
    const nombreInput = document.getElementById('nombre');
    if (nombreInput) {
        nombreInput.addEventListener('blur', function() {
            this.value = this.value
                .toLowerCase()
                .split(' ')
                .map(word => word.charAt(0).toUpperCase() + word.slice(1))
                .join(' ');
        });
    }

    // Prevenir envío si hay errores
    form.addEventListener('submit', function(e) {
        if (!form.checkValidity()) {
            e.preventDefault();
            e.stopPropagation();
            
            // Marcar todos los campos como tocados para mostrar errores
            inputs.forEach(input => {
                input.classList.add('touched');
                if (!input.validity.valid) {
                    input.classList.add('is-invalid');
                }
            });
            
            // Focus en el primer campo inválido
            const firstInvalid = form.querySelector('.form-control:invalid');
            if (firstInvalid) {
                firstInvalid.focus();
            }
            
            return false;
        }
    });
})();
</script>
