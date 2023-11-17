<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%@ page import="db.coursemanageDAO" %>
<%@ page import="java.io.PrintWriter" %>

<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content = "text/html; charset=UTF-8">
  <title>수강허용반영, 최대수강인원 증가</title>

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
    script.println("alert('선택하세요')");
    script.println("history.back()");
    script.println("</script>");
  } else if (request.getParameter("type").equals("up")) {
    //증원 = 최대 수강인원 늘리기

    int class_id = Integer.parseInt(request.getParameter("classid1"));
    int pmax = Integer.parseInt(request.getParameter("maxp"));

    int result = coursemanageDAO.increasemaxp(class_id, pmax);

    if(result == 1){
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("alert('증원 성공하였습니다.')");
      script.println("history.back()");
      script.println("</script>");
    }
  }else{
    if(request.getParameter("classid2") != null){
      int classid = Integer.parseInt(request.getParameter("classid2"));
      int sid = Integer.parseInt(request.getParameter("sid"));

      int result = coursemanageDAO.insertperson(classid, sid);

      if(result == 1){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('수강 허용 반영하였씁니다.')");
        script.println("history.back()");
        script.println("</script>");
      }
    }

  }


%>

</body>

</html>