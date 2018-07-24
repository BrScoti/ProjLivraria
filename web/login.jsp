<%-- 
    Document   : login
    Created on : 22/05/2018, 10:33:36
    Author     : aluno
--%>

<%@page import="modelo.Usuario"%>
<%@page import="util.AcessoBD"%>
<%@page import="negocio.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Livraria</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/uikit.min.css" />
        <link rel="stylesheet" href="css/style.css" />

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    </head>
    <body>
        <nav class="uk-navbar-container" uk-navbar>
            <div class="uk-navbar-left">

                <ul class="uk-navbar-nav ">
                    <li><a href="index.jsp" class="active">Home</a></li>
                    <li>
                        <a href="cadastro.jsp" >Cadastrar</a>
                        <div class="uk-navbar-dropdown">
                            <ul class="uk-nav uk-navbar-dropdown-nav">

                                <li class="uk-active"><a href="cadastro.jsp">Usuários</a></li>



                            </ul>
                        </div>
                    </li>



                </ul>

            </div>
            <div class="uk-navbar-right">
                <ul class="uk-navbar-nav">

                    <li><button class="uk-button uk-button-primary" uk-toggle="target: #modal-example">Login</button></li>

                </ul>
            </div>
        </nav>
        <%
            Usuario user = null;
            UsuarioDAO usuarioDAO = (UsuarioDAO) application.getAttribute("dao");
            if (usuarioDAO == null) {
                usuarioDAO = new UsuarioDAO(new AcessoBD("projlivraria"));

                application.setAttribute("dao", usuarioDAO);
            }
            if (request.getParameter("senha") != null && request.getParameter("email") != null) {
                if (request.getParameter("senha").equals("admin") && request.getParameter("email").equals("admin@admin.com")) {
                    application.setAttribute("user", "Admin");
                    session.setAttribute("user", "Admin");
                    response.sendRedirect("index.jsp");
                } else {
                    if (usuarioDAO.encontrarUsuario(request.getParameter("email"), request.getParameter("senha"))) {
                        user = usuarioDAO.listarUsuario(request.getParameter("email"));

                        application.setAttribute("user", user.getNome());// Está pegando o email na verdade
                        session.setAttribute("user", user.getNome()); // Está pegando o email na verdade

                        response.sendRedirect("index.jsp");
                    } else {
        %>
        <div class="uk-alert-danger" uk-alert>
            <a class="uk-alert-close fechar" uk-close></a>
            <h2>Email ou senha incorretos.</h2>
            <br>    
            <h2>Redirecionando em três segundos.</h2>
        </div>
        <script>
            $(document).ready(function () {
                
                setTimeout(function () {
                    alert("Redirecionando para página inicial.");
                    window.location.href = "index.jsp";
                }, 3000);

               



            });
        </script>
        <%
                    }
                }
            } else {
                response.sendRedirect("index.jsp");
            }

        %>

        <script src="js/uikit.min.js"></script>
        <script src="js/uikit-icons.min.js"></script>

    </body>
</html>
