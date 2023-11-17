<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <!-- reset css -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">

    <link rel="stylesheet" href="../yes.css">
</head>

<body>
<header>
    <nav id="header1">
        <a href="#">
            <img src="https://www.hanyang.ac.kr/html-repositories/images/custom/introduction/img_hy0104_02_0102.png" alt="이미지 없음">
        </a>

        <div id="meme">
            <a class="ttt" id= "reg" href="search_admin.jsp">
                <div>
                    수강편람
                </div>
            </a>

            <a class="ttt" id= "reg" href="coursemanage.jsp">
                <div>
                    과목설강/폐강
                </div>
            </a>

            <a class="ttt" id ="desired" href="studentinfo.jsp">
                <div>
                    학생 정보 조회
                </div>
            </a>

            <a class="ttt" id ="desired" href="#">
                <div>
                    시간표
                </div>
            </a>

            <a class="ttt" id ="desired" href="classedit.jsp">
                <div>
                    과목관리
                </div>
            </a>

            <a class="ttt" id ="desired"href="olap.jsp">
                <div>
                    통계 조회
                </div>
            </a>


        </div>

        <%
            if(session.getAttribute("adminID") == null){
        %>
        <a id = "forlogin" href ="">
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
                <%= session.getAttribute("adminID")%>님
            </p>
        </div>

        <a id = "forlogin" href ="../logout.jsp">
            <p>
                로그아웃
            </p>
        </a>

        <%
            }
        %>


        <a id = "forrevise" href ="edit.jsp">
            <p>
                학생정보 수정
            </p>
        </a>
    </nav>

</header>



</body>
</html>


