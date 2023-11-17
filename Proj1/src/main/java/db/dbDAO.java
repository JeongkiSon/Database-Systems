package db;

import java.sql.*;

public class dbDAO { //dbDAO는 가장 기본적인 클래스로 로그인과 관련된 action을 수행합니다

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;


    private PreparedStatement pstmt1;
    private ResultSet rs1;



    /*
    여타 다른 DAO클래스에도 다음과 같은 생성자가 존재합니다. 이 생성자는 우리가 SQL문으로 DB에 접근해서
    작업을 수앻하기 위해 DB와 연결해주는 역할을 합니다.
    */

    public dbDAO(){
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
    로그인을 수행하는 함수입니다. login페이지에서 받은 아이디와 비밀번호를 바탕으로
    SQL문을 수행해서 만약 그 아이디가 학생의 아이디이면 loginaction 페이지에서 학생 페이지로 이동시킬 수 있게
    1을 리턴하고, admin이라면 3을 리턴합니다. 그외의 경우에는 비밀번호가 틀렸거나, 존재하지 않는 아이디이거나
    오류가 발생한 경우입니다,
    */

    public int login(int login_id, String login_pw){
        String SQL = "SELECT password FROM student WHERE student_id =?";
        try{
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, login_id);
            System.out.println(SQL);

            rs = pstmt.executeQuery();
            if(rs.next()){
                System.out.println("herere");
                if(rs.getString(1).equals(login_pw)){
                    return 1; //학생 로그인 성공
                }
                else
                    return 2; //학생 비밀번호 틀림
            }
            else{
                System.out.println("here");
                SQL = "SELECT admin_pw FROM admin WHERE admin_id =?";
                pstmt1 = conn.prepareStatement(SQL);
                pstmt1.setInt(1, login_id);
                System.out.println(SQL);
                rs1 = pstmt1.executeQuery();
                System.out.println("223322");
                if(rs1.next()){
                    System.out.println("why");
                    if(rs1.getString(1).equals(login_pw)){
                        return 3; //admin 로그인 성공
                    }
                    else
                        return 4; //admin 비밀번호 틀림
                }
            }
            System.out.println("here44");
            return -1; //아이디 없는 경우
        }catch (Exception e){
            e.printStackTrace();
        }
        return -2; //데이터베이스 오류

    }




}
