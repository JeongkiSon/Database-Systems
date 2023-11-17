package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/*
coursemanageDAO는 admin이 강좌를 개설/폐강 등 강좌를 관리하기 위해 사용됩니다
 */
public class coursemanageDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;


    public coursemanageDAO(){
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
    classid로 받은 해당 강좌를 삭제시켜주는 함수입니다
     */
    public int deletecourse(int classid){
        String SQL1 ="delete from class where class_id = " + Integer.toString(classid);

        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL1);
            pstmt.executeUpdate();

            return 1;
        }catch (Exception e){
            e.printStackTrace();
        }
        return -1;
    }

    public int makecourse(int classid, int class_no, String course_id, String classname, int majorid, int year,
                          int credit, int lecid, int personmax, int roomid ){

//        제약 조건 처리
        String case1 = "select occupancy\n" +
                "from room\n" +
                "where room_id = " + Integer.toString(roomid);

        try{
            PreparedStatement pstmt1 = conn.prepareStatement(case1);

            ResultSet rs1 =pstmt1.executeQuery();

            int occupancy = 0; // room의 최대 수용인원

            if(rs1.next()){
                occupancy = rs1.getInt(1);
            }

            if(personmax > occupancy){ //이 경우 강좌 개설 불가
                return -11;
            }
        }catch (Exception e){
            e.printStackTrace();
        }





        String class_id = Integer.toString(classid);
        String classno = Integer.toString(class_no);
        String major = Integer.toString(majorid);
        String yy = Integer.toString(year);
        String creditt = Integer.toString(credit);
        String lecturerid = Integer.toString(lecid);
        String pmax = Integer.toString(personmax);
        String room = Integer.toString(roomid);

        String SQL1 ="INSERT INTO class VALUES (" +class_id+ "," +classno+ "," +
                "'"+course_id+"'"+","+"'" + classname+"'"+","+major+","+yy+","+creditt
                +","+lecturerid+","+pmax+","+"2022"+","+room+");";


        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL1);
            pstmt.executeUpdate();

            return 1;
        }catch (Exception e){
            e.printStackTrace();
        }
        return -1;
    }

    public int increasemaxp(int classid, int maxp){
        String class_id = Integer.toString(classid);

        String pmax = Integer.toString(maxp);


        String SQL1 ="UPDATE class SET person_max =" +pmax +"\n" +
                "WHERE class_id = " + class_id;

        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL1);
            pstmt.executeUpdate();

            return 1;
        }catch (Exception e){
            e.printStackTrace();
        }
        return -1;
    }


    public int insertperson(int classid, int sid){
        String class_id = Integer.toString(classid);

        String studentid = Integer.toString(sid);


        String SQL1 = "insert into takes (student_id, class_id)\n" +
                "values("+studentid+","+class_id +")";

        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL1);
            pstmt.executeUpdate();

            return 1;
        }catch (Exception e){
            e.printStackTrace();
        }
        return -1;
    }




}

