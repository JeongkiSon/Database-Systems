<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content = "text/html; charset=UTF-8">

  <link rel = "stylesheet" href="css/bootstrap.css">
  <title> 수강신청 손정기 </title>
</head>

<body>

<form action = "loginaction.jsp" method="post">
  <p> 아이디: <input type = "text" name="user_id" maxlength="20"> </p>
  <p> 비밀번호: <input type="password" name="user_pw" maxlength="20"> </p>
  <input type="submit" value="로그인">
</form>




  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script src="js/bootstrap.js"></script>
</body>
</html>