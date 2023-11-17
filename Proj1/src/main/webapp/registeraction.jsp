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


    int result = registerDAO.courseregister(uid, course);


    if(result == 1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('수강신청 성공.')");
        script.println("history.back()");
        script.println("</script>");
    } else if (result == -11) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('과거 B0이상 획득')");
        script.println("history.back()");
        script.println("</script>");
    } else if (result == -22) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('정원 다 찼습니다')");
        script.println("history.back()");
        script.println("</script>");
    } else if (result == -44) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('신청 가능 학점 초과')");
        script.println("history.back()");
        script.println("</script>");

    }


%>

</body>
</html>