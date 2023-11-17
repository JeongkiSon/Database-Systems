<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="db.dbDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%--<jsp:useBean id="forlog" class="db.studentDTO" scope="page" />--%>
<%--<jsp:setProperty name="forlog" property="student_id" param="user_id"/>--%>
<%--<jsp:setProperty name="forlog" property="password" param="user_pw"/>--%>
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
    if(uid != -1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 로그인이 되어있습니다.')");
        script.println("location.href = './student/student_main.jsp'");
        script.println("</script>");
    }

    int uid1 = -1;
    if(session.getAttribute("adminID") != null){
        uid1 = (Integer) session.getAttribute("adminID");
    }
    if(uid1 != -1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 로그인이 되어있습니다.')");
        script.println("location.href = './admin/admin_main.jsp'");
        script.println("</script>");
    }


    dbDAO dbDAO = new dbDAO();


    int received_id = Integer.parseInt(request.getParameter("user_id"));
    String received_pw = request.getParameter("user_pw");


    int result = dbDAO.login(received_id, received_pw);

    if(result == 1){
        session.setAttribute("userID", received_id);
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href = './student/student_main.jsp'");
        script.println("</script>");
    }
    else if(result == 3){
        session.setAttribute("adminID", received_id);
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href = './admin/admin_main.jsp'");
        script.println("</script>");
    }
    else if(result == 2){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('학생 비밀번호가 틀립니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
    else if(result == 4){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('admin 비밀번호가 틀립니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
    else if(result == -1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('존재하지 않는 아이디입니당.')");
        script.println("history.back()");
        script.println("</script>");
    }
    else if(result == -2){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('데이터베이스 오류가 발생했습니다.')");
        script.println("history.back()");
        script.println("</script>");
    }

%>

</body>
</html>