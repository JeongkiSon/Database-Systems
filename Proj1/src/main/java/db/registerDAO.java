package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/*
registerDAO는 학생의 모든 수강신청과 수강취소를 처리합니다
 */
public class registerDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;


    public registerDAO(){
        try{
            String dbURL = "jdbc:mysql://localhost:3307/db2021053154?serverTimezone=Asia/Seoul";
            String dbID = "root";
            String dbPassword = "ss7033";
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

            if(conn != null){
                System.out.println("연결 ok");
            }
            else System.out.println("안됨");
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    /*
    cancelcourse는 학생의 id과 classno을 받아 그 학생의 신청을 취소해줍니다,
    신청내역에서 수강신청한 과목을 철회하고 싶을 때 사용됩니다.
     */
    public int cancelcourse(int sid, int course){
        String SQL1 ="select class_id\n" +
                "from class\n" +
                "WHERE class_no =" + Integer.toString(course) +" and opened = 2022";
        //classno으로 classid구하기 희망신청이므로 2022년도 개설되는 것만 고려

        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL1);
            rs = pstmt.executeQuery();
            String classno = null;
            if (rs.next()) {
                classno = rs.getString(1);
            }
            if (classno == null){
                return -11; //class_id에 해당하는 classno 없는 경우 오류
            }

            String SQL2 = "delete from takes where student_id =" + Integer.toString(sid) + "\n" +
                    "and class_id = " + classno;
            PreparedStatement pstmt2 = conn.prepareStatement(SQL2);
            pstmt2.executeUpdate();

            return 1; //수강신청 취소 성공
        }catch (Exception e){
            e.printStackTrace();
        }
        return -1; //데이터베이스 오류
    }


    /*
    학생이 수강신청을 처리해주는 함수입니다. 각 조건에 부합하는지 확인하는 과정이 내포되어있습니다.
     */
    public int courseregister(int login_id, int course){
        //아래만 하면 수강신청 takes에 등록되기는 함 근데 조건 추가해야함

        //조건1 : 이전 성적이 B0이상일 경우 수강 신청 불가능
        String case1 = "select grade\n" +
                "from credits\n" +
                "where student_id = " + Integer.toString(login_id) +" and\n" +
                "course_id = (select distinct course_id\n" +
                "\t\t\tfrom class\n" +
                "\t\t\tWHERE class_no = "+Integer.toString(course)+ ")";

        try{
            PreparedStatement pstmt1 = conn.prepareStatement(case1);
            ResultSet rs1 =pstmt1.executeQuery();
            String tmp1 = null;
            if(rs1.next()){
                tmp1 = rs1.getString(1);
            }
            //만약 존재해서 tmp1에 값이 할당 되면 검사
            //tmp1 이 null이 아니라는 것은 수강한 적이 있음
            //b0.compareTo(tmp1) >= 0 그리고 성적이 b0이상인 경우
            String b0 = "b0";
            if(tmp1 != null && b0.compareTo(tmp1) >= 0){
                return -11; //
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        //조건2 : 정원이 다 찼을 경우 해당 과목 수강 신청 불가능
        String case2_1 = "select count(distinct student_id)\n" +
                "from takes\n" +
                "where class_id = (select class_id\n" +
                "\t\t\t\tfrom class\n" +
                "\t\t\t\twhere class_no ="+Integer.toString(course)+" and opened = 2022)";

                //현재 2022녀 기준 수강신청 하므로 위와 같이 쿼리 처리

        String case2_2 = "select person_max\n" +
                "from class\n" +
                "where class_no =" +Integer.toString(course)+" and opened = 2022";
        try{
            PreparedStatement pstmt2_1 = conn.prepareStatement(case2_1);
            PreparedStatement pstmt2_2 = conn.prepareStatement(case2_2);
            ResultSet rs2_1 =pstmt2_1.executeQuery();
            ResultSet rs2_2 =pstmt2_2.executeQuery();
            int curr = 0; //현재 수강자 수
            int maxp = 0;   //최대 수강자 수
            if(rs2_1.next()){
                curr = rs2_1.getInt(1);
            }
            if(rs2_2.next()){
                maxp = rs2_2.getInt(1);
            }

            if(curr >= maxp){ //이 경우 수강신청 불가
                return -22;
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        //조건3 : 동일 시간대에 2개 이상의 과목 수강 신청은 불가능
        //여기부터 하기


        //조건4 : 최대 학점은 18학점으로 제한하여 초과 신청은 불가능
        String case4_1 = "select sum(credit)\n" +
                "from takes\n" +
                "join class on class.class_id = takes.class_id\n" +
                "where student_id = "+ Integer.toString(login_id)+"\n" +
                "group by student_id";

        //수강신청 하려는 과목의 학점
        String case4_2 ="select credit\n" +
                "from class\n" +
                "WHERE class_no =" + Integer.toString(course) +" and opened = 2022";
        try{
            PreparedStatement pstmt4_1 = conn.prepareStatement(case4_1);
            PreparedStatement pstmt4_2 = conn.prepareStatement(case4_2);
            ResultSet rs4_1 =pstmt4_1.executeQuery();
            ResultSet rs4_2 =pstmt4_2.executeQuery();

            int total = 0; //총 학점 수
            int curr = 0; //현재 신청하고자 하는 과목의 학점
            if(rs4_1.next()){
                total = rs4_1.getInt(1);
            }
            if(rs4_2.next()){
                curr = rs4_2.getInt(1);
            }

            if(total + curr  > 18){
                return -44;
            }

        }catch (Exception e){
            e.printStackTrace();
        }



        String SQL1 ="select class_id\n" +
                "from class\n" +
                "WHERE class_no =" + Integer.toString(course) +" and opened = 2022";

        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL1);
            rs = pstmt.executeQuery();
            String classno = null;
            if (rs.next()) {
                classno = rs.getString(1);
            }

            String SQL2 = "insert into takes (student_id, class_id)\n" +
                    "values(" + Integer.toString(login_id) + "," + classno + ")";
            PreparedStatement pstmt2 = conn.prepareStatement(SQL2);
            pstmt2.executeUpdate();

            return 1;
        }catch (Exception e){
            e.printStackTrace();
        }
        return -1;

    }


    /*
    희망 수강신청 등록해줍니다.(장바구니 기능)

     */
    public int desiredregister(int sid, int course){
        String SQL1 ="select class_id\n" +
                "from class\n" +
                "WHERE class_no =" + Integer.toString(course) +" and opened = 2022";
        //classno으로 classid구하기 희망신청이므로 2022년도 개설되는 것만 고려

        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL1);
            rs = pstmt.executeQuery();
            String classno = null;
            if (rs.next()) {
                classno = rs.getString(1);
            }
            if (classno == null){
                return -11; //class_id에 해당하는 classno 없는 경우 오류
            }

            String SQL2 = "insert into desired (student_id, class_id)\n" +
                    "values(" + Integer.toString(sid) + "," + classno + ")";
            PreparedStatement pstmt2 = conn.prepareStatement(SQL2);
            pstmt2.executeUpdate();

            return 1; //희망 신청 성공
        }catch (Exception e){
            e.printStackTrace();
        }
        return -1; //데이터베이스 오류
    }


}
