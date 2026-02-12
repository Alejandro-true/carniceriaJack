<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.unu.poowebmodalga.beans.Producto"%>
<%@ page import="com.unu.poowebmodalga.beans.Categoria"%>
<%
String url = request.getContextPath() + "/";
List<Categoria> listaCategoria = (List<Categoria>) request.getAttribute("listaCategoria");
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
    --fc-orange: #F5A623;
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
    color: var(--fc-orange);
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

.form-carnic .form-control,
.form-carnic .form-select {
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

.form-carnic .form-control:focus,
.form-carnic .form-select:focus {
    border-color: var(--fc-orange);
    background: #fff;
    box-shadow: 0 0 0 3px rgba(245, 166, 35, 0.1);
}

.form-carnic .input-wrapper:focus-within .input-icon {
    color: var(--fc-orange);
}

/* Info alert */
.form-carnic .info-alert {
    background: linear-gradient(135deg, #FFF8E6, #FFF0DD);
    border: 1px solid rgba(245, 166, 35, 0.3);
    border-left: 4px solid var(--fc-orange);
    border-radius: 10px;
    padding: 12px 16px;
    margin: 20px 0;
    display: flex;
    align-items: center;
    gap: 10px;
    font-size: .86rem;
    color: var(--fc-charcoal);
}

.form-carnic .info-alert i {
    color: var(--fc-orange);
    font-size: 1rem;
    flex-shrink: 0;
}

.form-carnic .info-alert strong {
    color: var(--fc-blood);
    font-weight: 700;
}

/* Submit button */
.form-carnic .btn-submit {
    width: 100%;
    padding: 12px;
    border: none;
    border-radius: 10px;
    background: linear-gradient(135deg, var(--fc-orange), #E8961F);
    color: #fff;
    font-weight: 600;
    font-size: .92rem;
    letter-spacing: .4px;
    cursor: pointer;
    box-shadow: 0 4px 14px rgba(245, 166, 35, 0.3);
    transition: transform 0.26s ease, box-shadow 0.26s ease;
    margin-top: 6px;
}

.form-carnic .btn-submit:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 18px rgba(245, 166, 35, 0.4);
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
    border-bottom: 2px solid var(--fc-orange);
}

/* ============================================================
   IMAGE UPLOAD SECTION
   ============================================================ */
.image-upload-section {
    margin-bottom: 20px;
}

.image-preview-container {
    display: flex;
    gap: 16px;
    align-items: flex-start;
}

.image-preview-box {
    flex-shrink: 0;
    width: 160px;
    height: 160px;
    border-radius: 12px;
    overflow: hidden;
    background: linear-gradient(135deg, #f8f8f8, #e8e8e8);
    border: 2px dashed var(--fc-bone);
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
}

.image-preview-box img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.image-preview-placeholder {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 8px;
    color: #ccc;
}

.image-preview-placeholder i {
    font-size: 2.5rem;
}

.image-preview-placeholder span {
    font-size: .75rem;
    font-weight: 500;
}

.image-upload-controls {
    flex: 1;
}

.image-current-info {
    background: #FFF8E6;
    border: 1px solid rgba(200, 169, 110, 0.3);
    border-radius: 8px;
    padding: 10px 12px;
    margin-bottom: 12px;
    font-size: .8rem;
    color: var(--fc-charcoal);
}

.image-current-info i {
    color: var(--fc-orange);
    margin-right: 6px;
}

.image-current-info strong {
    color: var(--fc-blood);
}

.file-input-wrapper {
    position: relative;
}

.file-input-wrapper input[type="file"] {
    position: absolute;
    opacity: 0;
    width: 0;
    height: 0;
}

.btn-file-select {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 10px 18px;
    background: linear-gradient(135deg, var(--fc-orange), #E8961F);
    color: #fff;
    border: none;
    border-radius: 8px;
    font-size: .85rem;
    font-weight: 600;
    cursor: pointer;
    transition: transform 0.26s ease, box-shadow 0.26s ease;
    box-shadow: 0 2px 8px rgba(245, 166, 35, 0.25);
}

.btn-file-select:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(245, 166, 35, 0.35);
}

.btn-file-select i {
    font-size: .8rem;
}

.file-name-display {
    margin-top: 8px;
    font-size: .8rem;
    color: var(--fc-smoke);
}

.file-name-display i {
    color: var(--fc-green);
    margin-right: 5px;
}

.file-help-text {
    font-size: .72rem;
    color: var(--fc-smoke);
    margin-top: 8px;
    opacity: .7;
}

@media (max-width: 600px) {
    .form-carnic .form-row {
        grid-template-columns: 1fr;
    }
    .image-preview-container {
        flex-direction: column;
    }
    .image-preview-box {
        width: 100%;
        height: 200px;
    }
}
</style>

<form action="<%=url%>ProductoController" method="POST" id="formProducto" class="form-carnic" enctype="multipart/form-data" novalidate>
    <input type="hidden" name="op" value="insertarAjax">

    <!-- Info Alert -->
    <div class="info-alert">
        <i class="fas fa-plus-circle"></i>
        <span>Registrando <strong>nuevo producto</strong></span>
    </div>

    <!-- Sección: Imagen del Producto -->
    <div class="form-section-title">
        <i class="fas fa-image" style="color: var(--fc-orange); margin-right: 6px;"></i>
        Imagen del Producto
    </div>

    <div class="image-upload-section">
        <div class="image-preview-container">
            <!-- Preview Box -->
            <div class="image-preview-box" id="imagePreview">
                <div class="image-preview-placeholder" id="previewPlaceholder">
                    <i class="fas fa-image"></i>
                    <span>Sin imagen</span>
                </div>
            </div>

            <!-- Upload Controls -->
            <div class="image-upload-controls">
                <div class="file-input-wrapper">
                    <label for="imagen" class="btn-file-select">
                        <i class="fas fa-cloud-upload-alt"></i>
                        <span>Seleccionar imagen</span>
                    </label>
                    <input type="file" 
                           name="imagen" 
                           id="imagen" 
                           accept="image/jpeg,image/jpg,image/png,image/webp">
                </div>

                <div class="file-name-display" id="fileName" style="display:none;">
                    <i class="fas fa-file-image"></i>
                    <span id="fileNameText"></span>
                </div>

                <div class="file-help-text">
                    Formatos permitidos: JPG, PNG, WEBP (Máx. 5MB)
                </div>
            </div>
        </div>
    </div>

    <div class="form-divider"></div>

    <!-- Sección: Información del Producto -->
    <div class="form-section-title">
        <i class="fas fa-box" style="color: var(--fc-orange); margin-right: 6px;"></i>
        Información del Producto
    </div>

    <!-- Nombre -->
    <div class="form-group">
        <label for="nombre" class="form-label">
            <i class="fas fa-tag"></i> Nombre del Producto
            <span class="required">*</span>
        </label>
        <div class="input-wrapper">
            <i class="fas fa-drumstick-bite input-icon"></i>
            <input type="text" 
                   class="form-control" 
                   name="nombre" 
                   id="nombre"
                   placeholder="Ej: Carne de Res Premium"
                   required
                   minlength="3"
                   maxlength="100">
        </div>
    </div>

    <!-- Categoría -->
    <div class="form-group">
        <label for="categoria" class="form-label">
            <i class="fas fa-list"></i> Categoría
            <span class="required">*</span>
        </label>
        <div class="input-wrapper">
            <i class="fas fa-folder input-icon"></i>
            <select class="form-select" name="categoria" id="categoria" required>
                <option value="">Seleccione una categoría...</option>
                <%
                if (listaCategoria != null && !listaCategoria.isEmpty()) {
                    for (Categoria categoria : listaCategoria) {
                %>
                <option value="<%=categoria.getIdCategoria()%>">
                    <%=categoria.getNombreCategoria()%>
                </option>
                <%
                    }
                } else {
                %>
                <option value="" disabled>No hay categorías disponibles</option>
                <%
                }
                %>
            </select>
        </div>
    </div>

    <!-- Stock y Precio (2 columnas) -->
    <div class="form-row">
        <div class="form-group">
            <label for="stock" class="form-label">
                <i class="fas fa-boxes"></i> Stock
                <span class="required">*</span>
            </label>
            <div class="input-wrapper">
                <i class="fas fa-boxes input-icon"></i>
                <input type="number" 
                       class="form-control" 
                       name="stock" 
                       id="stock"
                       placeholder="Ej: 50"
                       min="0"
                       required>
            </div>
        </div>

        <div class="form-group">
            <label for="precio" class="form-label">
                <i class="fas fa-dollar-sign"></i> Precio (S/.)
                <span class="required">*</span>
            </label>
            <div class="input-wrapper">
                <i class="fas fa-money-bill input-icon"></i>
                <input type="number" 
                       class="form-control" 
                       name="precio" 
                       id="precio"
                       placeholder="Ej: 25.50"
                       step="0.01"
                       min="0"
                       required>
            </div>
        </div>
    </div>

    <!-- Submit Button -->
    <div class="form-group" style="margin-top: 24px;">
        <button type="submit" class="btn-submit">
            <i class="fas fa-save"></i> Guardar Producto
        </button>
    </div>
</form>

<script>
(function() {
    'use strict';
    
    const form = document.getElementById('formProducto');
    const fileInput = document.getElementById('imagen');
    const previewBox = document.getElementById('imagePreview');
    const fileName = document.getElementById('fileName');
    const fileNameText = document.getElementById('fileNameText');
    
    if (!form) return;

    // ============================================================
    // IMAGE PREVIEW
    // ============================================================
    if (fileInput) {
        fileInput.addEventListener('change', function(e) {
            const file = e.target.files[0];
            
            if (file) {
                // Validar tamaño (5MB max)
                if (file.size > 5 * 1024 * 1024) {
                    alert('La imagen no debe superar los 5MB');
                    fileInput.value = '';
                    return;
                }

                // Validar tipo
                const validTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/webp'];
                if (!validTypes.includes(file.type)) {
                    alert('Solo se permiten imágenes JPG, PNG o WEBP');
                    fileInput.value = '';
                    return;
                }

                // Mostrar nombre del archivo
                fileName.style.display = 'block';
                fileNameText.textContent = file.name;

                // Preview
                const reader = new FileReader();
                reader.onload = function(event) {
                    // Limpiar preview anterior
                    previewBox.innerHTML = '';
                    
                    // Crear nueva imagen
                    const img = document.createElement('img');
                    img.src = event.target.result;
                    img.id = 'previewImg';
                    previewBox.appendChild(img);
                };
                reader.readAsDataURL(file);
            }
        });
    }

    // ============================================================
    // VALIDACIÓN
    // ============================================================
    const inputs = form.querySelectorAll('.form-control, .form-select');
    
    inputs.forEach(input => {
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

    // Capitalizar nombre
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

    // Prevenir envío con errores
    form.addEventListener('submit', function(e) {
        if (!form.checkValidity()) {
            e.preventDefault();
            e.stopPropagation();
            
            inputs.forEach(input => {
                input.classList.add('touched');
                if (!input.validity.valid) {
                    input.classList.add('is-invalid');
                }
            });
            
            const firstInvalid = form.querySelector('.form-control:invalid, .form-select:invalid');
            if (firstInvalid) {
                firstInvalid.focus();
            }
            
            return false;
        }
    });

    // Auto-focus primer campo
    setTimeout(() => {
        const firstInput = form.querySelector('.form-control:not([readonly])');
        if (firstInput) {
            firstInput.focus();
        }
    }, 300);
})();
</script>
