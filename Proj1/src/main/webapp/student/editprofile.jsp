
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

<p>학번(ID), 성별, 학적은 변경할 수 없습니다.</p>

<form action="editpwaction.jsp"  >
    본인 확인용 학번 입력 <input type="text" name="sid"> </br>

    비밀번호 변경 </br>

    <input type="text" name="password">

    <input type="submit" value="비밀번호 변경">
</form>
</br>
</br>
</br>
</br>
<form action="editnameaction.jsp" name="ename" >
    본인 확인용 학번 입력 <input type="text" name="sid"> </br>
    이름 변경 </br>
    <input type="text" name="name">

    <input type="submit" value="이름 변경">
</form>


</body>

</html>
