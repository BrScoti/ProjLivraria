<%@page import="modelo.Usuario"%>
<%@page import="util.AcessoBD"%>
<%@page import="negocio.UsuarioDAO"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
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
            UsuarioDAO usuarioDAO = (UsuarioDAO) application.getAttribute("userdao");
            if (usuarioDAO == null) {
                usuarioDAO = new UsuarioDAO(new AcessoBD("projlivraria"));

                application.setAttribute("userdao", usuarioDAO);
            }

            if (usuarioDAO.listarUsuario(request.getParameter("email").toLowerCase()) == null) {
                    
                Usuario u = new Usuario(request.getParameter("nome"),
                        request.getParameter("email").toLowerCase(),
                        request.getParameter("senha"));
                usuarioDAO.inserir(u);
                application.setAttribute("user", u.getEmail());
                session.setAttribute("user", u.getEmail());
                response.sendRedirect("index.jsp");

            } else {
        %>
        <div class="uk-alert-danger" uk-alert>
            <a class="uk-alert-close fechar" uk-close></a>
            <h2>Email já cadastrado.</h2>
        </div>
         <script>
            $(document).ready(function () {
                if (confirm("Email já cadastrado. \n Voltar para página do cadastro?")) {
                    window.location.href = "cadastro.jsp";
                } else {

                }

            });
        </script>
        
        <%
            }
        %>

       
        <script src="js/uikit.min.js"></script>
        <script src="js/uikit-icons.min.js"></script>
    </body>
</html>
