<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<header>
    <nav id="header1">
        <a href="#">
            <img src="https://www.hanyang.ac.kr/html-repositories/images/custom/introduction/img_hy0104_02_0102.png" alt="이미지 없음">
        </a>

        <div id="meme">
            <a class="ttt" id= "reg" href="search.jsp">
                <div>
                    수강편람
                </div>
            </a>

            <a class="ttt" id= "reg" href="student/courseregister.jsp">
                <div>
                    수강신청
                </div>
            </a>

            <a class="ttt" id ="desired" href="#">
                <div>
                    희망신청
                </div>
            </a>

            <a class="ttt" id ="desired" href="#">
                <div>
                    시간표
                </div>
            </a>

            <a class="ttt" id ="desired"href="student/registlist.jsp">
                <div>
                    신청내역
                </div>
            </a>


        </div>

        <%
            if(session.getAttribute("userID") == null){
        %>
            <a id = "forlogin" href ="login.jsp">
                <p>
                    로그인
                </p>
            </a>

        <%
            }else{

        %>
        <div>

        </div>
        <div id = "info">
            <p>
                <%= session.getAttribute("userID")%>님
            </p>
        </div>

        <a id = "forlogin" href ="logout.jsp">
            <p>
                로그아웃
            </p>
        </a>

        <%
            }
        %>


        <a id = "forrevise" href ="login.jsp">
            <p>
                회원정보 수정
            </p>
        </a>
    </nav>

</header>



</body>
</html>


