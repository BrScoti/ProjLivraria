<%-- 
    Document   : deleteUser
    Created on : 29/05/2018, 19:17:18
    Author     : bruno
--%>

<%@page import="util.AcessoBD"%>
<%@page import="negocio.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
             UsuarioDAO usuarioDAO = (UsuarioDAO) application.getAttribute("userdao");
            if (usuarioDAO == null) {
                usuarioDAO = new UsuarioDAO(new AcessoBD("projlivraria"));

                application.setAttribute("userdao", usuarioDAO);
            }
            int id= Integer.parseInt(request.getParameter("id")) ;
            usuarioDAO.excluir(id);
             application.removeAttribute("user");
            application.removeAttribute("admin");
         
          
        %>
    </body>
</html>
