<%-- 
    Document   : index
    Created on : 13 oct 2026, 7:34:39 a.m.
    Author     : Ing.Fco.Gaz 
--%>
<%@page import="mx.com.psicologia.www.Permisos"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Verificar que exista una sesión iniciada
    String usuario = (String) session.getAttribute("usuario");

    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String nombre = (String) session.getAttribute("nombre");
    String rol = (String) session.getAttribute("rol");

    if (nombre == null) {
        nombre = usuario;
    }

    if (rol == null) {
        rol = "USUARIO";
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agenda Médica | Panel principal</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f1f5f9;
            color: #1e293b;
        }

        header {
            background: #ffffff;
            padding: 20px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 8px #00000012;
        }

        .marca {
            color: #0f4c81;
            font-size: 24px;
            font-weight: bold;
        }

        .usuario {
            text-align: right;
            font-size: 14px;
        }

        .contenedor {
            max-width: 1200px;
            margin: 35px auto;
            padding: 0 20px;
        }

        .bienvenida {
            margin-bottom: 28px;
        }

        .bienvenida h1 {
            margin-bottom: 8px;
            font-size: 30px;
        }

        .bienvenida p {
            color: #64748b;
        }

        .tarjetas {
            display: grid;
            grid-template-columns: repeat(
                auto-fit, minmax(220px, 1fr)
            );
            gap: 20px;
        }

        .tarjeta {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 3px 12px #0000000c;
            border-top: 4px solid #1677ff;
        }

        .tarjeta h2 {
            font-size: 19px;
            margin-top: 0;
        }

        .tarjeta p {
            color: #64748b;
            font-size: 14px;
            line-height: 1.5;
        }

        .boton {
            display: inline-block;
            background: #1677ff;
            color: white;
            padding: 10px 16px;
            border-radius: 7px;
            text-decoration: none;
            font-size: 14px;
        }

        .boton:hover {
            background: #095dcc;
        }

        .expediente {
            border-top-color: #16a085;
        }

        .expediente .boton {
            background: #12836c;
        }

        footer {
            text-align: center;
            padding: 25px;
            color: #64748b;
            font-size: 13px;
        }

        @media (max-width: 600px) {
            header {
                padding: 18px;
                gap: 15px;
                flex-wrap: wrap;
            }

            .usuario {
                text-align: left;
            }
        }
    </style>
</head>

<body>

<header>
    <div class="marca">
        &#9764; Agenda Médica
    </div>

    <div class="usuario">
        <strong><%= nombre %></strong><br>
        Usuario: <%= usuario %> | Rol: <%= rol %>
        <br><br>
        <a class="boton" href="LogoutServlet">Cerrar sesión</a>
    </div>
</header>

<main class="contenedor">

    <section class="bienvenida">
        <h1>Panel principal</h1>
        <p>Bienvenido al sistema de gestión del consultorio médico.</p>
    </section>

<section class="tarjetas">

    <% if (Permisos.puede(rol, Permisos.PACIENTES)) { %>
    <article class="tarjeta">
        <h2>Pacientes</h2>
        <p>Registro y administración de los datos de los pacientes.</p>
        <a class="boton" href="PacienteServlet">Abrir</a>
    </article>
    <% } %>

    <% if (Permisos.puede(rol, Permisos.MEDICOS)) { %>
    <article class="tarjeta">
        <h2>Médicos</h2>
        <p>Información de los médicos y sus datos profesionales.</p>
        <span class="boton">Próximamente</span>
    </article>
    <% } %>

    <% if (Permisos.puede(rol, Permisos.CITAS)) { %>
    <article class="tarjeta">
        <h2>Agenda de citas</h2>
        <p>Organización de horarios, citas y disponibilidad médica.</p>
        <span class="boton">Próximamente</span>
    </article>
    <% } %>

    <% if (Permisos.puede(rol, Permisos.CONSULTAS)) { %>
    <article class="tarjeta">
        <h2>Consultas</h2>
        <p>Registro de consultas y notas médicas.</p>
        <span class="boton">Próximamente</span>
    </article>
    <% } %>

    <% if (Permisos.puede(rol, Permisos.EXPEDIENTES)) { %>
    <article class="tarjeta expediente">
        <h2>Expedientes médicos</h2>
        <p>Acceso controlado a la información clínica confidencial.</p>
        <span class="boton">Próximamente</span>
    </article>
    <% } %>

    <% if (Permisos.puede(rol, Permisos.USUARIOS)) { %>
    <article class="tarjeta">
        <h2>Usuarios</h2>
        <p>Administración de las cuentas y permisos del sistema.</p>
        <span class="boton">Próximamente</span>
    </article>
    <% } %>

</section>
</main>

<footer>
    Agenda Médica &copy; 2026 | Sistema de gestión del consultorio
</footer>

</body>
</html>

