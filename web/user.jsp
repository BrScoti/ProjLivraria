<%@page import="negocio.AvaliacaoDAO"%>
<%@page import="modelo.Avaliacao"%>
<%@page import="modelo.Livro"%>
<%@page import="negocio.LivroDAO"%>
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
        <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
        <link href="http://www.cssscript.com/wp-includes/css/sticky.css" rel="stylesheet" type="text/css">
        <style>
            div.stars {
                width: 270px;
                display: inline-block;
            }

            input.star { display: none; }

            label.star {
                float: right;
                padding: 10px;
                font-size: 30px;
                color: #444;
                transition: all .2s;
            }

            input.star:checked ~ label.star:before {
                content: '\f005';
                color: #FD4;
                transition: all .25s;
            }

            input.star-5:checked ~ label.star:before {
                color: #FE7;

            }

            input.star-1:checked ~ label.star:before { color: #F62; }

            label.star:before {
                content: '\f006';
                font-family: FontAwesome;
            }
            .nav{
                z-index: 2;
            }
            .avali{
                width: 75%;
                margin-left: 13%;
            }
            .avali p{

                position: relative;
                margin-top: 10%;

            }
            .avali table{
                position: relative;


            }
            .deleteUser{
                margin-top: 1%;
                position: relative;
                float: right;
            }
        </style>    

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
            if (application.getAttribute("user") == null) {
                response.sendRedirect("index.jsp");

            } else {


        %>
        <nav class="uk-navbar-container nav" uk-navbar>
            <div class="uk-navbar-left">

                <ul class="uk-navbar-nav ">
                    <li><a href="index.jsp" >Home</a></li>
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
                    <li class="active" ><a href="user.jsp" class="active"><%=usuarioDAO.listarUsuario((String) application.getAttribute("user")).getEmail()%></a></li>
                    <li><a class="uk-button active " href="logout.jsp">Logout</a></li>

                    <%
                    } else {

                    %>
                    <li><button class="uk-button uk-button-primary" uk-toggle="target: #modal-example">Login</button></li>
                        <%                        }
                        %> 

                </ul>
            </div>
        </nav>
        <%
            Usuario u = usuarioDAO.listarUsuario((String) application.getAttribute("user"));
            
        %>
        <div class="uk-alert-primary usuario uk-alert uk-position-large uk-position-top-center uk-overlay uk-overlay-default uk-position-z-index" uk-alert>
            <h1 class="">
                <%= u.getEmail()%>
            </h1>
            

            <h3 class="nome">
                <%= u.getNome()%>
            </h3>

        </div>
            <div class="deleteUser">
                <button class="uk-button uk-button-danger" onclick="excluirUser(<%=u.getId()%>)"> Excluir sua conta</button>
            </div>
        <div class="avali">
            <p>Suas avaliações:</p>

            <table class="uk-table uk-table-small uk-table-divider">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Id do Livro</th>
                        <th>Descricao</th>
                        <th>Nota</th>
                        <th>Excluir</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Avaliacao a : usuarioDAO.listAvaliacaoUser(u.getId())) {

                    %>
                    <tr>
                        <td><%=a.getId()%></td>
                        <td><%=a.getIdLivro()%></td>
                        <td><%=a.getDescricao()%></td>
                        <td><%=a.getNota()%></td>
                        <td><a class="delete " onclick="excluir(<%=a.getId()%>)" href="#"><img src="imgs/delete.png"></a></td>
                    </tr>

                    <% }%>
                </tbody>
            </table>
            
        </div>

        <script>
            function excluir(val) {
                if (confirm("Tem certeza que deseja excluir?")) {
                    window.location.href = "deleteAva.jsp?id=" + val;
                } else {

                }
            }
            function excluirUser(val) {
                if (confirm("Tem certeza que deseja excluir sua conta?")) {
                    window.location.href = "deleteUser.jsp?id=" + val;
                } else {

                }
            }
        </script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>


        <script src="js/script.js"></script>
        <script src="js/uikit.min.js"></script>
        <script src="js/uikit-icons.min.js"></script>
        <%}
        %>
    </body>
</html>
