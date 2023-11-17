package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/*
    editDAO클래스는 학생이 본인의 정보를 수정할 때 사용하는 클래스입니다.
    관리자가 학생의 정보를 수정할 때는 data클래스에서 처리했습니다.

    */
public class editDAO {

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public editDAO() {
        try {
            String dbURL = "jdbc:mysql://localhost:3307/db2021053154?serverTimezone=Asia/Seoul";
            String dbID = "root";
            String dbPassword = "ss7033";
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);

            if (conn != null) {
                System.out.println("연결 ok");
            } else System.out.println("안됨");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    /*
    학생이 본인의 비밀번호를 바꾸는 함수

    */
    public int editpw(int sid, String password){
        String SQL = "UPDATE student SET password='" + password + "'\n" +
                "WHERE student_id =" +Integer.toString(sid);
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.executeUpdate();
            return 1; //정상 업데이트 된 경우
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; //에러
    }


    /*
    학생이 본인의 이름을 바꾸는 경우
     */
    public int editname(int sid, String newname){
        String SQL = "UPDATE student SET name='" + newname + "'\n" +
                "WHERE student_id =" +Integer.toString(sid);
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.executeUpdate();
            return 1; //정상 업데이트 된 경우
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; //에러
    }

}
