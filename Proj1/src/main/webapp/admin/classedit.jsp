<%--과목관리용 탭--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <!-- reset css -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">

    <link rel="stylesheet" href="../yes.css?after">
    <title>Title</title>
</head>

<body>


<form id = "cc" action="classeditaction.jsp">
    과목 증원 <input type="radio" name="type" value="up">
    </br>
    </br>
    증원할 과목 정보
    <p>
        class_id<input type="number" name="classid1"></br>
        변경 최대 수강인원<input type="number" name="maxp"></br>
        </br>

    </p>
    </br>

    수강허용 반영 <input type="radio" name="type" value="ok">
    </br>

    <p>

        classid<input type="number" name="classid2"></br>
        학생 학번<input type="number" name="sid"></br>

    </p>

    <input type = "submit" value="확인">
</form>





</body>
</html>
