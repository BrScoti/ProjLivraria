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


        %>
        <nav class="uk-navbar-container" uk-navbar>
            <div class="uk-navbar-left">

                <ul class="uk-navbar-nav ">
                    <li><a href="index.jsp" >Home</a></li>
                    <li>
                        <a href="cadastro.jsp" class="active">Cadastrar</a>
                        <div class="uk-navbar-dropdown">
                            <ul class="uk-nav uk-navbar-dropdown-nav">

                                <li class="uk-active"><a href="cadastro.jsp">Usuários</a></li>
                                    <% 
                                        if (application.getAttribute("user") != null) {
                                    %>
                                <li class="uk-active"><a href="cadastro.jsp">Avaliações</a></li>

                                <%
                                    if (application.getAttribute("user").equals("Admin")) {
                                %>
                                <li class="uk-active"><a href="cadastro.jsp">Livros</a></li>

                                <%
                                    }
                               
                               
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
                <h3>Clique no botão para o que você deseja cadastrar!</h3>

                <div class="uk-button-group ">

                    <button class="uk-button uk-button-secondary userButton">Usuário</button>
                    <% if (application.getAttribute("user") != null) {

                            if (!application.getAttribute("user").equals("Admin")) {
                    %>
                   
                    <button class="uk-button uk-button-secondary avaliacoesButton ">Avaliações</button>
                    <%
                        }
                        if (application.getAttribute("user").equals("Admin")) {

                    %>

                    <button class="uk-button uk-button-secondary livrosButton ">Livros</button>
                    <% }
                        }
                    %>
                </div>
            </div>
            <br><br><br><br><br>

            <div class="uk-alert user" uk-alert>
                <form class="uk-form-horizontal uk-margin-large" action="cadastroUser.jsp" method="post">

                    <h2>Insira suas informações!</h2>

                    <div class="uk-margin">
                        <label class="uk-form-label" for="form-horizontal-text">Email:</label>
                        <div class="uk-form-controls">
                            <input class="uk-input" name="email" id="form-horizontal-text" type="email" placeholder="Ex: juninho@gmail.com">
                        </div>
                    </div>
                    <div class="uk-margin">
                        <label class="uk-form-label" for="form-horizontal-text">Nome:</label>
                        <div class="uk-form-controls">
                            <input class="uk-input" name="nome" id="form-horizontal-text" type="text" placeholder="Ex: Juninho Almeida">
                        </div>
                    </div>
                    <div class="uk-margin">
                        <label class="uk-form-label" for="form-horizontal-text">Senha:</label>
                        <div class="uk-form-controls">
                            <input class="uk-input" name="senha" id="form-horizontal-text" type="password" >
                        </div>
                    </div>

                    <p class="uk-text-right">

                        <input type="submit" value="Cadastrar" class="uk-button uk-button-primary">
                    </p>
                </form>
            </div>

            <div class="uk-alert avaliacao " uk-alert>
                <form class="uk-form-horizontal uk-margin-large" action="cadastroAvaliacao.jsp" method="post">

                    <h3>Insira as informações da avaliação!</h3>


                    <input type="hidden" value="">
                    <div class="uk-margin">
                        <label class="uk-form-label" for="form-horizontal-text">Livro:</label>
                        <div class="uk-form-controls">
                            <select class="uk-select" name="idLivro">
                                <%
                                    for (Livro l : livroDAO.listarTodos()) {

                                %>
                                <option value="<%= l.getId()%>"> <%=l.getNome()%></option> 
                                <%

                                    }


                                %>
                            </select>
                        </div>
                    </div>
                   
                    <div class="uk-margin">
                        <label class="uk-form-label" for="form-horizontal-text">Descrição:</label>
                        <div class="uk-form-controls">
                            <textarea class="uk-textarea" name="descricao" rows="5" ></textarea>
                        </div>
                    </div>
                    <div class="uk-margin">
                        <label class="uk-form-label" for="form-horizontal-text">Nota:</label>
                        <div class="uk-form-controls">
                            <div class="stars">

                                <input value="5" class="star star-5" id="star-5" type="radio" name="nota"/>
                                <label class="star star-5" for="star-5"></label>
                                <input value="4" class="star star-4" id="star-4" type="radio" name="nota"/>
                                <label class="star star-4" for="star-4"></label>
                                <input value="3" class="star star-3" id="star-3" type="radio" name="nota"/>
                                <label class="star star-3" for="star-3"></label>
                                <input value="2" class="star star-2" id="star-2" type="radio" name="nota"/>
                                <label class="star star-2" for="star-2"></label>
                                <input value="1" class="star star-1" id="star-1" type="radio" name="nota"/>
                                <label class="star star-1" for="star-1"></label>

                            </div>
                        </div>
                    </div>   
                    <p class="uk-text-right">

                        <input type="submit" value="Cadastrar" class="uk-button uk-button-primary">
                    </p>
                </form>
            </div>
            <div class="uk-alert livro " uk-alert>
                <form class="uk-form-horizontal uk-margin-large" action="cadastroLivro.jsp" method="post">

                    <h2>Insira as informações do livro!</h2>


                    <div class="uk-margin">
                        <label class="uk-form-label" for="form-horizontal-text">Nome:</label>
                        <div class="uk-form-controls">
                            <input class="uk-input" name="nome" id="form-horizontal-text" type="text" placeholder="Ex: Harry Potter">
                        </div>
                    </div>
                    <div class="uk-margin">
                        <label class="uk-form-label" for="form-horizontal-text">Autor:</label>
                        <div class="uk-form-controls">
                            <input class="uk-input" name="autor" id="form-horizontal-text" type="text" placeholder="Ex: J. K. Rowling">
                        </div>
                    </div>

                    <p class="uk-text-right">

                        <input type="submit" value="Cadastrar" class="uk-button uk-button-primary">
                    </p>
                </form>
            </div>    


        </div>   
        <div id="modal-example" uk-modal>
            <div class="uk-modal-dialog uk-modal-body">
                <h2 class="uk-modal-title">Digite seu email e senha para fazer o login</h2>
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

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="js/script.js"></script>
        <script src="js/uikit.min.js"></script>
        <script src="js/uikit-icons.min.js"></script>
    </body>
</html>
