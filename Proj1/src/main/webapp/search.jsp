<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>

<%@ page import="java.io.PrintWriter" %>
<%@ page import="db.dataDAO" %>
<%@ page import="db.data" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.lang.reflect.Array" %>
<%@ page import="com.sun.source.doctree.SystemPropertyTree" %>
<%@ page import="java.sql.SQLOutput" %>

<!DOCTYPE html>
<html>
<head>

  <meta charset="UTF-8">

  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>

  <!-- reset css -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">

  <link rel="stylesheet" href="yes.css?after">
</head>

<body>



<%@include file="header.jsp"%>



<div id="header2">
  <form id = "iii">
    수업번호 <input type="radio" name="what" value="classno">
    학수번호 <input type="radio" name="what" value="courseid">
    교과목명 <input type="radio" name="what" value="classname">

    <input type="text" name="vvv">

    <input type="submit" value="검색">
  </form>

</div>

<%
  String type_what = request.getParameter("what");

%>



<table class="print">
  <thead>
  <tr>
    <th class="hi">수업번호</th>
    <th class="hi">학수번호</th>
    <th class="hi">교과목명</th>
    <th class="hi">교강사</th>
    <th class="hi">수업시간</th>
    <th class="hi">신청/정원</th>
    <th class="hi">강의실</th>
  </tr>
  </thead>

  <tbody>
  <%
    PrintWriter script = response.getWriter();

    dataDAO datadao = new dataDAO();

    String temp = request.getParameter("vvv");
    //typewhat

    ArrayList<data> list;

    if(temp != null){
      if(type_what.equals("classno")){
        int a = Integer.parseInt(temp);
        list = datadao.classnoList(a);
      } else if (type_what.equals("courseid")) {
        String a = temp;
        list = datadao.courseidList(a);
      }
      else{
        String a =temp;
        list = datadao.classnameList(a);
      }


    for(int i = 0; i < list.size(); i++){
      if(list.get(i).getP1st() == null || list.get(i).getP1et() == null){
        continue;
      }


      String tt = "";
      if (list.get(i).getP1st().substring(9, 10).equals("1")) {
        tt = tt + "월(";
      } else if (list.get(i).getP1st().substring(9, 10).equals("2")) {
        tt = tt + "화(";
      } else if (list.get(i).getP1st().substring(9, 10).equals("3")) {
        tt = tt + "수(";
      } else if (list.get(i).getP1st().substring(9, 10).equals("4")) {
        tt = tt + "목(";
      } else if (list.get(i).getP1st().substring(9, 10).equals("5")) {
        tt = tt + "금(";
      } else if (list.get(i).getP1st().substring(9, 10).equals("6")) {
        tt = tt + "토(";
      }

      tt = tt + list.get(i).getP1st().substring(11, 13) + ":";
      tt = tt + list.get(i).getP1st().substring(14, 16);

      tt = tt + "-";

      tt = tt + list.get(i).getP1et().substring(11, 13) + ":";
      tt = tt + list.get(i).getP1et().substring(14, 16);
      tt = tt + ")";

      if(list.get(i).getP2st() != null && list.get(i).getP2et() != null) {

        if (list.get(i).getP2st().substring(9, 10).equals("1")) {
          tt = tt + "월(";
        } else if (list.get(i).getP2st().substring(9, 10).equals("2")) {
          tt = tt + "화(";
        } else if (list.get(i).getP2st().substring(9, 10).equals("3")) {
          tt = tt + "수(";
        } else if (list.get(i).getP2st().substring(9, 10).equals("4")) {
          tt = tt + "목(";
        } else if (list.get(i).getP2st().substring(9, 10).equals("5")) {
          tt = tt + "금(";
        } else if (list.get(i).getP2st().substring(9, 10).equals("6")) {
          tt = tt + "토(";
        }

        tt = tt + list.get(i).getP2st().substring(11, 13) + ":";
        tt = tt + list.get(i).getP2st().substring(14, 16);

        tt = tt + "-";

        tt = tt + list.get(i).getP2et().substring(11, 13) + ":";
        tt = tt + list.get(i).getP2et().substring(14, 16);
        tt = tt + ")";

      }

      String place = "";
      place = list.get(i).getBuild_name() + Integer.toString(list.get(i).getRoom_id());

  %>

  <tr>
    <th><%= list.get(i).getClassno() %></th>
    <th><%= list.get(i).getCourseid() %></th>
    <th><%= list.get(i).getClassname() %></th>
    <th><%= list.get(i).getLec_name() %></th>
    <th><%= tt %></th>
    <th><%= Integer.toString(list.get(i).getTakep()) +"/"+Integer.toString(list.get(i).getMaxperson()) %></th>
    <th><%= place %></th>

  </tr>
  <%
    }
  %>
  <%
    }
  %>





  </tbody>

</table>






<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script> -->
</body>

</html>


