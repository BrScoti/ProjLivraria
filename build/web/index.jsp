<%@page import="negocio.UsuarioDAO"%>
<%@page import="negocio.LivroDAO"%>
<%@page import="util.AcessoBD"%>
<%@page import="negocio.AvaliacaoDAO"%>
<%@page import="javafx.application.Application"%>
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
        <link href="http://www.cssscript.com/wp-includes/css/sticky.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <%
            UsuarioDAO usuarioDAO = (UsuarioDAO) application.getAttribute("userdao");
            if (usuarioDAO == null) {
                usuarioDAO = new UsuarioDAO(new AcessoBD("projlivraria"));

                application.setAttribute("userdao", usuarioDAO);
            }

            LivroDAO livroDAO = (LivroDAO) application.getAttribute("livrodao");
            if (livroDAO == null) {
                livroDAO = new LivroDAO(new AcessoBD("projlivraria"));

                application.setAttribute("livrodao", livroDAO);
            }
            AvaliacaoDAO avaliacaoDAO = (AvaliacaoDAO) application.getAttribute("avaliacaodao");
            if (avaliacaoDAO == null) {
                avaliacaoDAO = new AvaliacaoDAO(new AcessoBD("projlivraria"));

                application.setAttribute("avaliacaodao", avaliacaoDAO);
            }

        %>
        <nav class="uk-navbar-container" uk-navbar>
            <div class="uk-navbar-left">

                <ul class="uk-navbar-nav ">
                    <li><a href="index.jsp" class="active">Home</a></li>
                    <li>
                        <a href="cadastro.jsp" >Cadastrar</a>
                        <div class="uk-navbar-dropdown">
                            <ul class="uk-nav uk-navbar-dropdown-nav">

                                <li class="uk-active"><a href="cadastro.jsp">Usuários</a></li>
                                    <% if (application.getAttribute("user") != null) {
                                    %>
                                <li class="uk-active"><a href="cadastro.jsp">Avaliações</a></li>

                                <%
                                    if (application.getAttribute("user").equals("Admin")) {
                                %>
                                <li class="uk-active"><a href="cadastro.jsp">Livros</a></li>

                                <%
                                    }
                                %>
                                <%
                                    }
                                %>
                            </ul>
                        </div>
                    </li>
                    <% if (application.getAttribute("user") != null) {
                    %>
                    <li>
                        <a href="listar.jsp"  >Listar</a>
                        <div class="uk-navbar-dropdown">
                            <ul class="uk-nav uk-navbar-dropdown-nav">

                                <li class="uk-active"><a href="listar.jsp">Usuários</a></li>

                                <li class="uk-active"><a href="listar.jsp">Avaliações</a></li>


                                <li class="uk-active"><a href="listar.jsp">Livros</a></li>


                            </ul>
                        </div>
                    </li>   
                    <%
                        }
                    %>

                </ul>

            </div>
            <div class="uk-navbar-right">
                <ul class="uk-navbar-nav">
                    <% if (application.getAttribute("user") != null) {
                    %>
                    <li class="form"><%
                        if (application.getAttribute("user").equals("Admin")) {
                            out.print("<a href='#'>");
                            
                            out.print("Admin");
                            out.print("</a>");
                            
                        }
                        else{
                            out.print("<a href='user.jsp'>");
                            out.print(usuarioDAO.listarUsuario((String) application.getAttribute("user")).getEmail());
                            out.print("</a>");
                        }
                        %></li>
                    
                    
                    <li><a class="uk-button active" href="logout.jsp">Logout</a></li>

                    <%
                    } else {

                    %>
                    <li><button class="uk-button uk-button-primary" uk-toggle="target: #modal-example">Login</button></li>
                        <%                        }
                        %> 

                </ul>
            </div>
        </nav>


        <div id="modal-example" uk-modal>
            <div class="uk-modal-dialog uk-modal-body">
                <h2 class="uk-modal-title"></h2>
                <form class="uk-form-horizontal uk-margin-large" action="login.jsp" method="post">

                    <div class="uk-margin">
                        <label class="uk-form-label" for="form-horizontal-text">Email:</label>
                        <div class="uk-form-controls">
                            <input class="uk-input" name="email" id="form-horizontal-text" type="email" placeholder="Ex: juninho@gmail.com">
                        </div>
                    </div>

                    <div class="uk-margin">
                        <label class="uk-form-label" for="form-horizontal-text">Senha:</label>
                        <div class="uk-form-controls">
                            <input class="uk-input" name="senha" id="form-horizontal-text" type="password" >
                        </div>
                    </div>

                    <p class="uk-text-right">
                        <button class="uk-button uk-button-default uk-modal-close" type="button">Cancelar</button>
                        <input type="submit" value="Login" class="uk-button uk-button-primary">
                    </p>
                </form>   

            </div>
        </div>

        <div class="uk-alert" uk-alert>

            <h2>Cadastre-se para ter acesso ao conteúdo.</h2>
            <br>
            <a href="cadastro.jsp" class="uk-button uk-button-default">Cadastrar</a>   
        </div>
        <script src="js/uikit.min.js"></script>
        <script src="js/uikit-icons.min.js"></script>
    </body>
</html>
