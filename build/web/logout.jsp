<%-- 
    Document   : logout
    Created on : 22/05/2018, 10:17:46
    Author     : aluno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>

        <%
            application.removeAttribute("user");
            application.removeAttribute("admin");
            response.sendRedirect("index.jsp");
            
        %>
    </body>
</html>
