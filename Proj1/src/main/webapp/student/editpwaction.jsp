<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="db.editDAO" %>
<%@ page import="java.io.PrintWriter" %>

<!DOCTYPE html>
<html>
<head>


</head>
<body>

<%

    editDAO editDAO = new editDAO();


    String newpassword = request.getParameter("password");
    int sid = Integer.parseInt(request.getParameter("sid"));

    int result = editDAO.editpw(sid, newpassword);

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