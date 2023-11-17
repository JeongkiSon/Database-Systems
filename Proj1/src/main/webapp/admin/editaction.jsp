
<%@ page import="db.dataDAO" %>
<%@ page import="java.io.PrintWriter" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>

<body>


<%
    dataDAO dataDAO = new dataDAO();

    int sid = Integer.parseInt(request.getParameter("sid"));

    String status = request.getParameter("status");

    int result = dataDAO.editstatus(sid, status);

    if(result == 1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('정보 변경 완료.')");
        script.println("history.back()");
        script.println("</script>");
    }else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('오류가 발생하였습니다.')");
        script.println("history.back()");
        script.println("</script>");
    }

%>

</body>


</html>
