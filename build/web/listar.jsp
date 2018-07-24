<%@page import="negocio.AvaliacaoDAO"%>
<%@page import="modelo.Avaliacao"%>
<%@page import="modelo.Avaliacao2"%>
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

            .uk-navbar-container{
                background-color:  #333333 !important; 

            }
            .active{
                color:white !important;
            }
            
            .livro,.user{
                position: relative;
                display: none;
                z-index: 1;
            }
            .avaliacao{
                margin-left: 2%;
                float: left;
                position: relative;
                display: none;
                z-index: 1;   
            }
            .mostra_avali{
                display: none;
                z-index: 2;
                position: relative;
                width: 58%;
                float: right;
                margin-right:  2%;
            }
            
            
            .buttons{
                margin-top: 1%;
                position: fixed;
                left: 38%;
            }
            .form{
                color: #ffffff !important;
            }

            .br-theme-bars-reversed .br-widget a {
                background-color: pink;
            }

            .br-theme-bars-reversed .br-widget a.br-active,
            .br-theme-bars-reversed .br-widget a.br-selected {
                background-color: #ff446a;
            }

            .br-theme-bars-reversed .br-widget .br-current-rating {
                color: #ff446a;
                font-size: 20px;  
            }
        </style>    
        <script>

        </script>
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
                        <a href="listar.jsp" class="active" >Listar</a>
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

                        } else {
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

        <div class="uk-inline">
            <div class="buttons">
                <% if (application.getAttribute("user") != null) {
                %>
                <h3>Clique no botão para o que você deseja listar!</h3>

                <div class="uk-button-group ">

                    <button class="uk-button uk-button-secondary userButton">Usuário</button>

                    <button class="uk-button uk-button-secondary avaliacoesButton ">Avaliações</button>

                    <button class="uk-button uk-button-secondary livrosButton ">Livros</button>

                </div>
                <%
                    } else {
                        response.sendRedirect("cadastro.jsp");
                    }
                %>

            </div>
        </div>
        <br><br><br><br><br>
        <br>
        <div class="uk-alert user" uk-alert>
            <table class="uk-table uk-table-hover uk-table-divider">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Nome</th>
                        <th>Email</th>
                    </tr>
                </thead>

                <tbody>
                    <%
                        for (Usuario u : usuarioDAO.listarTodos()) {

                    %>
                    <tr>
                        <td>
                            <%= u.getId()%>  
                        </td>     
                        <td>
                            <%= u.getNome()%>  
                        </td>   
                        <td>
                            <%= u.getEmail()%>  
                        </td>   
                    </tr>

                    <%
                        }

                    %>

                </tbody>

            </table>
        </div>
        <%--Listar Avaliacao --%> 

        <div class="avaliacao " >

            <button class="uk-button uk-button-secondary avali_tot "> Avaliações Totais</button>
            <br><br><br>


            <button class="uk-button uk-button-secondary avali_user "> Avaliações por Usuário</button>




            <select id="iduser" class="uk-select uk-form-width-medium" name="idUser"class="idUser">
                <% for (Usuario u : usuarioDAO.listarTodos()) {

                %>
                <option  data-status="<%= u.getNome()%>"> <%=u.getNome()%> - <%=u.getId()%> </option> 
                <%

                    }


                %>
            </select>   



            <div class="select-livro ">
                <br>
                <button class="uk-button uk-button-secondary  avali_livro">Avaliações por Livro</button>


                <select class="uk-select uk-form-width-medium" id="idlivro"  name="idLivro">
                    <%                                     for (Livro l : livroDAO.listarTodos()) {

                    %>
                    <option data-status="<%= l.getNome()%>"> <%=l.getNome()%> - <%= l.getId()%></option> 
                    <%

                        }


                    %>
                </select>

            </div>


        </div>
        <div class="mostra_avali uk-alert " uk-alert>
            <table class="uk-table uk-table-hover uk-table-divider table_avali">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Nome do Usuário</th>
                        <th>Nome do Livro</th>
                        <th>Descricão</th>
                        <th>Nota</th>
                    </tr>
                </thead>

                <tbody>
                    <%                        for (Avaliacao2 a : avaliacaoDAO.listarTodosPorNome()) {

                    %>
                    <tr>
                        <td>
                            <%= a.getId()%>  
                        </td>     
                        <td>
                            <%= a.getNomeLivro()%>  
                        </td>   
                        <td>
                            <%= a.getNomeUser()%>  
                        </td> 
                        <td>
                            <%= a.getDescricao()%>  
                        </td>
                        <td>
                            <%= a.getNota()%>  
                        </td>   
                    </tr>

                    <%
                        }

                    %>

                </tbody>

            </table>

        </div>



        <%--Listar Livro --%> 
        <div class="uk-alert livro " uk-alert>
            <table class="uk-table uk-table-hover uk-table-divider">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Nome</th>
                        <th>Email</th>
                    </tr>
                </thead>

                <tbody>
                    <%                            for (Livro l : livroDAO.listarTodos()) {

                    %>
                    <tr>
                        <td>
                            <%= l.getId()%>  
                        </td>     
                        <td>
                            <%= l.getNome()%>  
                        </td>   
                        <td>
                            <%= l.getAutor()%>  
                        </td>   
                    </tr>

                    <%
                        }

                    %>

                </tbody>

            </table>
        </div> 






        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

        <script src="js/script.js"></script>
        <script src="js/uikit.min.js"></script>
        <script src="js/uikit-icons.min.js"></script>
    </body>
</html>
