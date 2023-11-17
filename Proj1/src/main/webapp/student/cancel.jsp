<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="db.registerDAO" %>
<%@ page import="java.io.PrintWriter" %>


<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content = "text/html; charset=UTF-8">

</head>
<body>
<%
    int uid = -1;
    if(session.getAttribute("userID") != null){
        uid = (Integer) session.getAttribute("userID");
    }

    registerDAO registerDAO = new registerDAO();


    int course = Integer.parseInt(request.getParameter("course"));


    int result = registerDAO.cancelcourse(uid, course);


    if(result == 1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('수강신청 취소되었습니다.')");
        script.println("location.href = 'registlist.jsp'");
        script.println("</script>");
    }else{
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('오류가 발생하였습니다.')");
        script.println("history.back()");
        script.println("</script>");
    }


%>

</body>
</html>