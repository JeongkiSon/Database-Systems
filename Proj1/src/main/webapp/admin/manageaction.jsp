<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%@ page import="db.coursemanageDAO" %>
<%@ page import="java.io.PrintWriter" %>

<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content = "text/html; charset=UTF-8">
  <title>강의 설강,폐강 관리</title>

</head>
<body>
<%
  int uid = -1;
  if(session.getAttribute("userID") != null){
    uid = (Integer) session.getAttribute("userID");
  }

  coursemanageDAO coursemanageDAO = new coursemanageDAO();



  if(request.getParameter("type") == null){
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('설강/폐강 선택하세요')");
    script.println("history.back()");
    script.println("</script>");
  } else if (request.getParameter("type").equals("make")) {
    //설강
    int class_id = Integer.parseInt(request.getParameter("classid"));
    int classno = Integer.parseInt(request.getParameter("classno"));
    String courseid = request.getParameter("courseid");
    String classname = request.getParameter("classname");
    int major = Integer.parseInt(request.getParameter("majorid"));
    int year = Integer.parseInt(request.getParameter("year"));
    int credit = Integer.parseInt(request.getParameter("credit"));
    int lecid = Integer.parseInt(request.getParameter("lecid"));
    int pmax = Integer.parseInt(request.getParameter("maxperson"));
    int room = Integer.parseInt(request.getParameter("roomid"));

    int result = coursemanageDAO.makecourse(class_id, classno, courseid, classname,major,year,credit, lecid,pmax,room);

    if(result == 1){
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("alert('해당강좌 설강하였습니다.')");
      script.println("history.back()");
      script.println("</script>");
    } else if (result == -11) {
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("alert('수강정원보다 강의실 수용인원이 적습니다.')");
      script.println("history.back()");
      script.println("</script>");
    }

  }else{
    if(request.getParameter("del_classno") != null){
      int a = Integer.parseInt(request.getParameter("del_classno"));
      int result = coursemanageDAO.deletecourse(a);

      if(result == 1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('해당강좌 폐강하였습니다.')");
        script.println("history.back()");
        script.println("</script>");
      }
    }

  }


%>

</body>

</html>