<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Formulario de Contacto</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light py-5">

  <div class="container">
    <h2 class="text-center mb-4">Formulario de Contacto</h2>

    <form id="formularioContacto" class="bg-white p-4 rounded shadow">
      <div class="mb-3">
        <label for="nombre" class="form-label">Nombre:</label>
        <input type="text" class="form-control" id="nombre" placeholder="Tu nombre">
      </div>

      <div class="mb-3">
        <label for="correo" class="form-label">Correo Electrónico:</label>
        <input type="email" class="form-control" id="correo" placeholder="ejemplo@correo.com">
      </div>

      <div class="mb-3">
        <label for="mensaje" class="form-label">Mensaje:</label>
        <textarea class="form-control" id="mensaje" rows="4" placeholder="Escribe tu mensaje..."></textarea>
      </div>

      <button type="submit" class="btn btn-primary w-100">Enviar</button>
    </form>

    <div id="alerta" class="alert alert-danger mt-3 d-none" role="alert">
      Por favor, completa todos los campos antes de enviar.
    </div>
  </div>

  <!-- Bootstrap Bundle JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

  <!-- Validación con JavaScript -->
  <script>
    const formulario = document.getElementById('formularioContacto');
    const alerta = document.getElementById('alerta');

    formulario.addEventListener('submit', function (event) {
      event.preventDefault();

      const nombre = document.getElementById('nombre').value.trim();
      const correo = document.getElementById('correo').value.trim();
      const mensaje = document.getElementById('mensaje').value.trim();

      if (!nombre || !correo || !mensaje) {
        alerta.classList.remove('d-none');
      } else {
        alerta.classList.add('d-none');
        alert('Formulario enviado correctamente.\nGracias por tu mensaje, ' + nombre + '!');
        formulario.reset();
      }
    });
  </script>

</body>
</html>
