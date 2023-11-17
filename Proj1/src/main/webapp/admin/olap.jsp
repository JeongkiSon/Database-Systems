

<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>


<%@ page import="db.olapDAO" %>
<%@ page import="db.olap" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>

<body>
<p>
    평점 평균과 특정 과목의 학점 간 차이(평점평균-과목학점)가 가장 큰 Top10 과목
</p>

<%
    olapDAO olapDAO = new olapDAO();


    ArrayList<olap> list = olapDAO.classavg();

    for(int i = 0; i < list.size() ; i++){


%>

<p>
        <%= list.get(i).getCourse_id()%>
        <%= list.get(i).getClassname()%>
        <%= list.get(i).getAvg()%>
</p>

<%
    }
%>

</body>

</html>
