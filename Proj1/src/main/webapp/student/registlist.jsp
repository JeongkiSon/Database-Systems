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
<%@include file="student_main.jsp"%>

<%

    int uid = -1;
    if(session.getAttribute("userID") != null){
        uid = (Integer)session.getAttribute("userID");
    }
    else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('로그인하세요.')");
        script.println("location.href = 'login.jsp'");
        script.println("</script>");
    }

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
    dataDAO datadao = new dataDAO();

    ArrayList<data> list;

    list = datadao.getlist(uid);

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
<%--<%= list.size()%>--%>
<tr>
    <th><%= list.get(i).getClassno() %></th>
    <th><%= list.get(i).getCourseid() %></th>
    <th><%= list.get(i).getClassname() %></th>
    <th><%= list.get(i).getLec_name() %></th>
    <th><%= tt %></th>
    <th><%= Integer.toString(list.get(i).getTakep()) +"/"+Integer.toString(list.get(i).getMaxperson()) %></th>
    <th><%= place %></th>
    <th>
        <form action= "cancel.jsp" >
            <button type="submit">취소</button>
            <input type="hidden" name="course" value= <%= list.get(i).getClassno()%>>
            <input type="hidden" name="who" value= <%= session.getAttribute("userID")%>>
        </form>
    </th>
</tr>
<%
    }
%>


</tbody>

</table>






</body>

</html>
