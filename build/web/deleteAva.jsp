<%-- 
    Document   : deleteAva
    Created on : 29/05/2018, 18:32:14
    Author     : bruno
--%>

<%@page import="util.AcessoBD"%>
<%@page import="negocio.AvaliacaoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
             AvaliacaoDAO avaliacaoDAO = (AvaliacaoDAO) application.getAttribute("avaliacaodao");
            if (avaliacaoDAO == null) {
                avaliacaoDAO = new AvaliacaoDAO(new AcessoBD("projlivraria"));

                application.setAttribute("avaliacaodao", avaliacaoDAO);
            }
            
            int id= Integer.parseInt(request.getParameter("id")) ;
            
            avaliacaoDAO.excluir(id);
             response.sendRedirect("user.jsp");
            
            %>
    </body>
</html>
