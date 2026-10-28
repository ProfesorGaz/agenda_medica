<%--
    Vista: lista de pacientes
    Se muestra a través de PacienteServlet (está dentro de WEB-INF,
    por eso no se puede abrir escribiendo la URL).
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.List"%>
<%@page import="mx.com.psicologia.www.Html"%>
<%@page import="mx.com.psicologia.www.Paciente"%>
<%
    String ctx = request.getContextPath();

    String usuarioSesion = (String) session.getAttribute("usuario");
    String nombreSesion = (String) session.getAttribute("nombre");
    String rolSesion = (String) session.getAttribute("rol");

    if (nombreSesion == null) {
        nombreSesion = usuarioSesion;
    }

    List<Paciente> pacientes = (List<Paciente>) request.getAttribute("pacientes");
    String filtro = (String) request.getAttribute("filtro");
    boolean verInactivos = Boolean.TRUE.equals(request.getAttribute("verInactivos"));
    String mensaje = (String) request.getAttribute("mensaje");
    boolean mensajeError = Boolean.TRUE.equals(request.getAttribute("mensajeError"));

    DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM/yyyy");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agenda Médica | Pacientes</title>
    <link rel="stylesheet" href="<%= ctx %>/css/estilos.css">
</head>

<body>

<header>
    <div class="marca">
        <a href="<%= ctx %>/index.jsp">&#9764; Agenda Médica</a>
    </div>

    <div class="usuario">
        <strong><%= Html.esc(nombreSesion) %></strong><br>
        Usuario: <%= Html.esc(usuarioSesion) %> | Rol: <%= Html.esc(rolSesion) %>
        <br><br>
        <a class="boton" href="<%= ctx %>/LogoutServlet">Cerrar sesión</a>
    </div>
</header>

<main class="contenedor">

    <div class="encabezado-seccion">
        <h1>Pacientes</h1>

        <div>
            <a class="boton secundario" href="<%= ctx %>/index.jsp">Volver al panel</a>
            <a class="boton" href="<%= ctx %>/PacienteServlet?accion=nuevo">Nuevo paciente</a>
        </div>
    </div>

    <% if (mensaje != null) { %>
    <div class="mensaje <%= mensajeError ? "error" : "ok" %>" role="status">
        <%= Html.esc(mensaje) %>
    </div>
    <% } %>

    <section class="panel">

        <form class="busqueda" method="get" action="<%= ctx %>/PacienteServlet">
            <input type="text" name="q" value="<%= Html.esc(filtro) %>"
                   placeholder="Buscar por nombre, apellido o teléfono"
                   aria-label="Buscar paciente">

            <label>
                <input type="checkbox" name="inactivos" value="1"
                       <%= verInactivos ? "checked" : "" %>>
                Ver desactivados
            </label>

            <button type="submit" class="boton">Buscar</button>
        </form>

        <div class="tabla-contenedor">
            <table>
                <thead>
                    <tr>
                        <th>Paciente</th>
                        <th>Nacimiento</th>
                        <th>Teléfono</th>
                        <th>Correo</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                <% if (pacientes == null || pacientes.isEmpty()) { %>
                    <tr>
                        <td colspan="5" class="vacio">
                            <% if (filtro != null && !filtro.isEmpty()) { %>
                                Ningún paciente coincide con la búsqueda.
                            <% } else if (verInactivos) { %>
                                No hay pacientes desactivados.
                            <% } else { %>
                                Aún no hay pacientes registrados. Agrega el primero con «Nuevo paciente».o marca «Ver desactivados» para ver los que desactivaste.
                            <% } %>
                        </td>
                    </tr>
                <% } else {
                       for (Paciente p : pacientes) { %>
                    <tr>
                        <td class="<%= p.isActivo() ? "" : "inactivo" %>">
                            <%= Html.esc(p.getNombreCompleto()) %>
                        </td>
                        <td>
                            <%= p.getFechaNacimiento() != null
                                    ? p.getFechaNacimiento().format(formato) : "—" %>
                        </td>
                        <td><%= p.getTelefono() != null ? Html.esc(p.getTelefono()) : "—" %></td>
                        <td><%= p.getCorreo() != null ? Html.esc(p.getCorreo()) : "—" %></td>
                        <td class="acciones">
                            <a class="boton chico"
                               href="<%= ctx %>/PacienteServlet?accion=editar&amp;id=<%= p.getId() %>">Editar</a>

                            <form class="en-linea" method="post"
                                  action="<%= ctx %>/PacienteServlet"
                                  onsubmit="return confirm('<%= p.isActivo()
                                          ? "¿Desactivar a este paciente?"
                                          : "¿Reactivar a este paciente?" %>');">
                                <input type="hidden" name="accion"
                                       value="<%= p.isActivo() ? "desactivar" : "reactivar" %>">
                                <input type="hidden" name="id" value="<%= p.getId() %>">
                                <button type="submit"
                                        class="boton chico <%= p.isActivo() ? "peligro" : "secundario" %>">
                                    <%= p.isActivo() ? "Desactivar" : "Reactivar" %>
                                </button>
                            </form>
                        </td>
                    </tr>
                <%     }
                   } %>
                </tbody>
            </table>
        </div>

    </section>
</main>

<footer>
    Agenda Médica &copy; 2026 | Sistema de gestión del consultorio
</footer>

</body>
</html>
