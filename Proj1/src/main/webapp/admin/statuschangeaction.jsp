<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>

<%@ page import="java.io.PrintWriter" %>
<%@ page import="db.dataDAO" %>
<%@ page import="db.data" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.lang.reflect.Array" %>
<%@ page import="com.sun.source.doctree.SystemPropertyTree" %>
<%@ page import="java.sql.SQLOutput" %>

<html>
<head>
  <meta charset="UTF-8">

  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>

  <!-- reset css -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">

  <link rel="stylesheet" href="../yes.css?after">
</head>

<body>
<%@include file="admin_main.jsp"%>

<%
  int uid = -1;
  if(session.getAttribute("userID") != null){
    uid = (Integer) session.getAttribute("userID");
  }

  dataDAO dataDAO = new dataDAO();

  String status = request.getParameter("status");

  int sid = Integer.parseInt(request.getParameter("sid"));

  int result = dataDAO.changestatus(sid, status);

  if(result == 1){
//    printwriter로 아래와 같이 창을 띄울 수 있다.
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('학적 변경 완료.')");
    script.println("history.back()");
    script.println("</script>");
  }


%>


</body>

</html>

