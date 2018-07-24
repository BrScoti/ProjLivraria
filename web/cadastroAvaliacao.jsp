
<%@page import="modelo.Avaliacao"%>
<%@page import="negocio.AvaliacaoDAO"%>
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

    </head>
    <body>
        <nav class="uk-navbar-container" uk-navbar>
            <div class="uk-navbar-left">

                <ul class="uk-navbar-nav">
                    <li><a href="#">Home</a></li>
                    <li>
                        <a href="#">Cadastrar</a>
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
            AvaliacaoDAO avaliacaoDAO = (AvaliacaoDAO) application.getAttribute("avaliacaodao");
            if (avaliacaoDAO == null) {
                avaliacaoDAO = new AvaliacaoDAO(new AcessoBD("projlivraria"));

                application.setAttribute("avaliacaodao", avaliacaoDAO);
            }
            
            UsuarioDAO usuarioDAO = (UsuarioDAO) application.getAttribute("userdao");
            if (usuarioDAO == null) {
                usuarioDAO = new UsuarioDAO(new AcessoBD("projlivraria"));

                application.setAttribute("userdao", usuarioDAO);
            }
           
            
            String nome=  (String)application.getAttribute("user");
             
            if(nome== null){
                response.sendRedirect("cadastro.jsp"); 
            }
            
            
            
           Usuario u= usuarioDAO.listarUsuario(nome);
            
            
             Avaliacao a = new Avaliacao(u.getId(),
                    Integer.parseInt(request.getParameter("idLivro")),
                    request.getParameter("descricao"),
                    Integer.parseInt(request.getParameter("nota")));
            avaliacaoDAO.inserir(a);
            
             response.sendRedirect("cadastro.jsp"); 

        %>


        <script src="js/uikit.min.js"></script>
        <script src="js/uikit-icons.min.js"></script>
    </body>
</html>
