
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>

<body>

<%
    int uid = -1;
    if(session.getAttribute("userID") != null){
        uid = (Integer) session.getAttribute("userID");
    }
%>

<p>학생정보 변경</p>

<form action="editaction.jsp" >
    학적 변경 </br>
    변경할 학생 학번 <input type="text" name="sid">

    재학<input type="radio" name="status" value ="ok">
    휴학<input type="radio" name="status" value ="takeoff">
    자퇴<input type="radio" name="status" value ="dropout">

    <input type="submit" value="학생정보 변경">
</form>


</body>

</html>
