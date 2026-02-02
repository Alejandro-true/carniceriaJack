<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
String url = request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Estadísticas de Libros por Genero</title>
  
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" 
        rel="stylesheet"
        integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
        crossorigin="anonymous">
  
  <!-- Font Awesome -->
  <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  
  <!-- Chart.js -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  
  <style>
    body {
      background-color: #f8f9fa;
    }
    
    .card {
      box-shadow: 0 0.125rem 0.25rem rgba(0,0,0,0.075);
      border: none;
      border-radius: 0.5rem;
      margin-bottom: 1.5rem;
    }
    
    .card-header {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      border-radius: 0.5rem 0.5rem 0 0 !important;
      padding: 1rem 1.5rem;
    }
    
    .chart-container {
      position: relative;
      height: 300px;
      padding: 1rem;
    }
    
    .loading-overlay {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(255,255,255,0.9);
      display: flex;
      align-items: center;
      justify-content: center;
      z-index: 1000;
      border-radius: 0.5rem;
    }
    
    .loading-overlay.d-none {
      display: none !important;
    }
    
    .stats-badge {
      font-size: 1.1rem;
      padding: 0.5rem 1rem;
    }
    
    .table-hover tbody tr:hover {
      background-color: #f8f9fa;
      cursor: pointer;
    }
  </style>
</head>
<body>

  <div class="container mt-4 mb-5">
    <!-- Encabezado -->
    <div class="d-flex justify-content-between align-items-center mb-4">
      <h2 class="mb-0">
        <i class="fas fa-chart-pie text-primary"></i> 
        Estadísticas de Libros por Generos
      </h2>
      <div>
        <a href="<%=url%>LibrosController?op=listar" class="btn btn-outline-secondary">
          <i class="fas fa-arrow-left"></i> Volver
        </a>
        <button onclick="reporteManager.recargarDatos()" class="btn btn-primary">
          <i class="fas fa-sync-alt"></i> Actualizar
        </button>
      </div>
    </div>

    <!-- Mensaje de estado -->
    <div id="mensajeEstado" class="alert d-none" role="alert"></div>

    <!-- Loading overlay global -->
    <div id="loadingGlobal" class="loading-overlay d-none">
      <div class="text-center">
        <div class="spinner-border text-primary" role="status" style="width: 3rem; height: 3rem;">
          <span class="visually-hidden">Cargando datos...</span>
        </div>
        <p class="mt-3 text-muted fw-bold">Cargando estadísticas...</p>
      </div>
    </div>

    <!-- Estadísticas generales -->
    <div class="row mb-4">
      <div class="col-md-4">
        <div class="card bg-primary text-white">
          <div class="card-body text-center">
            <h6 class="card-title mb-2">
              <i class="fas fa-globe"></i> Total de Libros
            </h6>
            <h2 class="mb-0" id="totalLibros">0</h2>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card bg-success text-white">
          <div class="card-body text-center">
            <h6 class="card-title mb-2">
              <i class="fas fa-users"></i> Total de Generos
            </h6>
            <h2 class="mb-0" id="totalGeneros">0</h2>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card bg-info text-white">
          <div class="card-body text-center">
            <h6 class="card-title mb-2">
              <i class="fas fa-crown"></i> Genero con Más Libros
            </h6>
            <h2 class="mb-0" id="GeneroTop">-</h2>
          </div>
        </div>
      </div>
    </div>

    <!-- Gráficos -->
    <div class="row">
      <!-- Gráfico de Barras -->
      <div class="col-md-6">
        <div class="card">
          <div class="card-header">
            <h5 class="mb-0">
              <i class="fas fa-chart-bar"></i> Libros por Genero (Barras)
            </h5>
          </div>
          <div class="card-body">
            <div class="chart-container">
              <canvas id="barChart"></canvas>
            </div>
          </div>
        </div>
      </div>

      <!-- Gráfico de Pastel -->
      <div class="col-md-6">
        <div class="card">
          <div class="card-header">
            <h5 class="mb-0">
              <i class="fas fa-chart-pie"></i> Distribución por Genero (Pastel)
            </h5>
          </div>
          <div class="card-body">
            <div class="chart-container">
              <canvas id="pieChart"></canvas>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Tabla de Datos -->
    <div class="row">
      <div class="col-12">
        <div class="card">
          <div class="card-header">
            <h5 class="mb-0">
              <i class="fas fa-table"></i> Detalle de Libros por Genero
            </h5>
          </div>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-striped table-hover" id="tablaDatos">
                <thead class="table-dark">
                  <tr>
                    <th style="width: 10%">#</th>
                    <th style="width: 60%">
                      <i class="fas fa-flag"></i> Genero
                    </th>
                    <th style="width: 30%" class="text-end">
                      <i class="fas fa-users"></i> Total de Libro
                    </th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td colspan="3" class="text-center text-muted">
                      <i class="fas fa-inbox"></i> No hay datos disponibles
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap Bundle JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"
          integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI"
          crossorigin="anonymous"></script>

  <script>
// ====================================
// OBJETO GLOBAL PARA MANEJAR EL REPORTE
// ====================================
const reporteManager = {
    barChart: null,
    pieChart: null,
    cargando: false,

    // Inicializar el manager
    init() {
        console.log('Inicializando reporte manager...');
        this.cargarDatos();
    },

    // Mostrar loading overlay
    mostrarLoading() {
        document.getElementById('loadingGlobal').classList.remove('d-none');
    },

    // Ocultar loading overlay
    ocultarLoading() {
        document.getElementById('loadingGlobal').classList.add('d-none');
    },

    // Mostrar mensaje
    mostrarMensaje(mensaje, tipo = 'info') {
        const mensajeDiv = document.getElementById('mensajeEstado');
        mensajeDiv.className = 'alert alert-' + tipo + ' alert-dismissible fade show';
        mensajeDiv.innerHTML = '<i class="fas fa-' + (tipo === 'success' ? 'check-circle' : 
                                tipo === 'danger' ? 'exclamation-circle' : 'info-circle') + 
                                '"></i> ' + mensaje +
                                '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
        mensajeDiv.classList.remove('d-none');
        
        // Auto-ocultar después de 5 segundos
        if(tipo === 'success') {
            setTimeout(() => {
                mensajeDiv.classList.add('d-none');
            }, 5000);
        }
    },

    // Ocultar mensaje
    ocultarMensaje() {
        document.getElementById('mensajeEstado').classList.add('d-none');
    },

    // Cargar datos desde el servidor
    cargarDatos() {
        if(this.cargando) {
            console.log('Ya hay una carga en proceso');
            return;
        }

        this.cargando = true;
        this.mostrarLoading();
        this.ocultarMensaje();

        console.log('Solicitando datos al servidor...');

        const fetchUrl = '<%=url%>LibrosController?op=reporte';

        fetch(fetchUrl, {
            method: 'GET',
            headers: {
                'Accept': 'application/json',
                'X-Requested-With': 'XMLHttpRequest'
            },
            cache: 'no-cache'
        })
        .then(response => {
            console.log('Respuesta recibida:', response.status, response.statusText);
            
            if (!response.ok) {
                throw new Error('HTTP ' + response.status + ': ' + response.statusText);
            }
            
            return response.text();
        })
        .then(text => {
            console.log('📄 Texto recibido:', text.substring(0, 200));
            
            // Validar que sea JSON
            if(text.trim().startsWith('<') || text.trim().startsWith('<!')) {
                throw new Error('El servidor devolvió HTML en lugar de JSON');
            }
            
            try {
                const data = JSON.parse(text);
                console.log('JSON parseado exitosamente:', data);
                return data;
            } catch (e) {
                console.error('Error al parsear JSON:', e);
                throw new Error('Respuesta no es JSON válido: ' + e.message);
            }
        })
        .then(data => {
            this.cargando = false;
            this.ocultarLoading();
            
            console.log('Validando estructura de datos...');
            
            if(!data || data.success !== true) {
                const mensaje = data && data.mensaje ? data.mensaje : 'Error al cargar datos';
                console.error('Error en respuesta:', mensaje);
                throw new Error(mensaje);
            }

            if(!data.data || !data.data.labels || !data.data.values) {
                console.error('Estructura de datos incorrecta:', data);
                throw new Error('La respuesta no contiene los datos esperados (labels/values)');
            }

            console.log('Datos válidos recibidos');
            console.log('Labels:', data.data.labels);
            console.log('Values:', data.data.values);

            // Procesar los datos
            this.procesarDatos(data.data.labels, data.data.values);
            
            // Mostrar mensaje de éxito
            this.mostrarMensaje(data.mensaje || 'Datos cargados correctamente', 'success');
        })
        .catch(error => {
            this.cargando = false;
            this.ocultarLoading();
            
            console.error('Error al cargar datos:', error);
            this.mostrarMensaje('Error: ' + error.message, 'danger');
            
            // Mostrar datos de ejemplo en caso de error
            this.procesarDatos(['Sin datos'], [0]);
        });
    },

    // Procesar y renderizar los datos
    procesarDatos(labels, values) {
        console.log('Procesando datos para visualización...');
        
        if(!labels || !values || labels.length === 0 || values.length === 0) {
            console.warn('No hay datos para mostrar');
            this.renderizarSinDatos();
            return;
        }

        // Actualizar estadísticas generales
        this.actualizarEstadisticas(labels, values);

        // Renderizar gráficos
        this.renderizarGraficos(labels, values);

        // Renderizar tabla
        this.renderizarTabla(labels, values);

        console.log('Datos procesados y renderizados correctamente');
    },

    // Actualizar estadísticas generales
    actualizarEstadisticas(labels, values) {
        const totalPaises = labels.length;
        const totalAutores = values.reduce((a, b) => a + b, 0);
        const maxIndex = values.indexOf(Math.max(...values));
        const paisTop = labels[maxIndex] || '-';

        document.getElementById('totalGeneros').textContent = totalPaises;
        document.getElementById('totalLibros').textContent = totalAutores;
        document.getElementById('GeneroTop').textContent = paisTop;
    },

    // Renderizar gráficos
    renderizarGraficos(labels, values) {
        console.log('Renderizando gráficos...');

        // Destruir instancias anteriores
        if(this.barChart) {
            this.barChart.destroy();
        }
        if(this.pieChart) {
            this.pieChart.destroy();
        }

        // Colores para los gráficos
        const colores = this.generarColores(labels.length);

        // Gráfico de Barras
        const barCtx = document.getElementById('barChart');
        this.barChart = new Chart(barCtx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Número de Autores',
                    data: values,
                    backgroundColor: 'rgba(102, 126, 234, 0.8)',
                    borderColor: 'rgba(102, 126, 234, 1)',
                    borderWidth: 2
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: true,
                        position: 'top'
                    },
                    title: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1
                        }
                    }
                }
            }
        });

        // Gráfico de Pastel
        const pieCtx = document.getElementById('pieChart');
        this.pieChart = new Chart(pieCtx, {
            type: 'pie',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Generos',
                    data: values,
                    backgroundColor: colores,
                    borderWidth: 2,
                    borderColor: '#fff'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: true,
                        position: 'right'
                    }
                }
            }
        });

        console.log('Gráficos renderizados');
    },

    // Renderizar tabla
    renderizarTabla(labels, values) {
        console.log('Renderizando tabla...');
        
        const tbody = document.querySelector('#tablaDatos tbody');
        
        if(labels.length === 0) {
            tbody.innerHTML = '<tr><td colspan="3" class="text-center text-muted">' +
                              '<i class="fas fa-inbox"></i> No hay datos disponibles</td></tr>';
            return;
        }

        let html = '';
        for(let i = 0; i < labels.length; i++) {
            html += '<tr>' +
                    '<td class="text-center fw-bold">' + (i + 1) + '</td>' +
                    '<td><i class="fas fa-flag text-primary"></i> ' + 
                    (labels[i] || 'Sin especificar') + '</td>' +
                    '<td class="text-end"><span class="badge bg-primary stats-badge">' + 
                    values[i] + '</span></td>' +
                    '</tr>';
        }
        
        tbody.innerHTML = html;
        console.log('Tabla renderizada con ' + labels.length + ' filas');
    },

    // Renderizar vista sin datos
    renderizarSinDatos() {
        console.log('Renderizando vista sin datos');
        
        document.getElementById('totalGeneros').textContent = '0';
        document.getElementById('totalLibros').textContent = '0';
        document.getElementById('GeneroTop').textContent = '-';

        const tbody = document.querySelector('#tablaDatos tbody');
        tbody.innerHTML = '<tr><td colspan="3" class="text-center text-muted">' +
                          '<i class="fas fa-inbox"></i> No hay datos disponibles</td></tr>';

        // Destruir gráficos existentes
        if(this.barChart) this.barChart.destroy();
        if(this.pieChart) this.pieChart.destroy();
    },

    // Generar colores para los gráficos
    generarColores(cantidad) {
        const coloresBase = [
            'rgba(102, 126, 234, 0.8)',
            'rgba(118, 75, 162, 0.8)',
            'rgba(237, 100, 166, 0.8)',
            'rgba(255, 154, 158, 0.8)',
            'rgba(250, 208, 196, 0.8)',
            'rgba(255, 183, 77, 0.8)',
            'rgba(129, 199, 132, 0.8)',
            'rgba(77, 182, 172, 0.8)'
        ];

        const colores = [];
        for(let i = 0; i < cantidad; i++) {
            colores.push(coloresBase[i % coloresBase.length]);
        }
        return colores;
    },

    // Recargar datos
    recargarDatos() {
        console.log('🔄 Recargando datos...');
        this.cargarDatos();
    }
};

// ====================================
// INICIALIZAR AL CARGAR LA PÁGINA
// ====================================
document.addEventListener('DOMContentLoaded', function() {
    console.log('DOM cargado, inicializando reporte...');
    reporteManager.init();
});
</script>

</body>
</html>
