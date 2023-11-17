<%--<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>--%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <meta charset="UTF-8">
    <title>로그인 확인</title>
</head>

<body>

<%

    PrintWriter script = response.getWriter();

    int uid;
    String upw = "";

    uid = Integer.parseInt(request.getParameter("userID"));
    upw = request.getParameter("userPassword");

    Connection conn = null;
    PreparedStatement pstmt;
    ResultSet rs;

    //db연결
    try{
        String dbURL = "jdbc:mysql://localhost:3306/db2021053154?serverTimezone=Asia/Seoul";
        String dbID = "root";
        String dbPassword = "ss7033";
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

        if(conn != null){
            System.out.println("연결 ok");
        }
        else System.out.println("안됨");
    }catch(Exception e){
        e.printStackTrace();
    }

    String SQL = "SELECT password FROM student WHERE student_id =?";
    try{
        pstmt = conn.prepareStatement(SQL);
        pstmt.setInt(1, uid);
        System.out.println(SQL);
        rs = pstmt.executeQuery();
        if(rs.next()){
            if(rs.getString(1).equals(upw)){
                script.println("<script>");
                script.println("location.href = 'main.jsp'");
                script.println("</script>");
            }
            else{
                script.println("<script>");
                script.println("alert('비밀번호가 틀립니다.')");
                script.println("history.back()");
                script.println("</script>");
            }  //비밀번호 틀림
        }
        else{
            script.println("<script>");
            script.println("alert('존재하지 않는 아이디입니다.')");
            script.println("history.back()");
            script.println("</script>");
            //아이디 없는 경우
        }
    }catch (Exception e){
        e.printStackTrace();
    }
//    return -2;


%>

</body>

</html>
