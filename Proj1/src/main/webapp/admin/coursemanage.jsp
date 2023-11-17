
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


<form id = "coursemanage" action="manageaction.jsp">
    설강 <input type="radio" name="type" value="make">
    </br>
    설강할 수업 정보

    <p>
        class_id<input type="number" name="classid"></br>
        수업번호<input type="number" name="classno"></br>
        학수번호<input type="text" name="courseid"></br>
        교과목명<input type="text" name="classname"></br>
        major_id<input type="text" name="majorid"></br>
        year<input type="text" name="year"></br>
        credit<input type="number" name="credit"></br>
        lecturer_id<input type="number" name="lecid"></br>
        정원<input type="number" name="maxperson"></br>
        room_id<input type="number" name="roomid"></br>
    </p>
    폐강 <input type="radio" name="type" value="delete">
    </br>
    <p>

        폐강할 classid<input type="number" name="del_classno"></br>

    </p>

    <input type = "submit" value="확인">
</form>





</body>
</html>
