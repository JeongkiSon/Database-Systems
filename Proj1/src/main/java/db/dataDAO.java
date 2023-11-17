package db;

import org.jetbrains.annotations.NotNull;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.io.PrintWriter;


public class dataDAO {

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public dataDAO() {
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
    수강편람 또는 수강신청에서 수업번호를 선택했을 때 해당 수업번호에 해당하는 수업을 리스트로 반환해주는 함수입니다,
    SQL에 대한 설명은 wiki에 있습니다. 이 SQL문을 실행한 결과를 rs.next()를 이용하여
    한 튜플씩 차례로 배열에 담아줍니다. 그 후에 배열을 리턴합니다.

     */
    public ArrayList<data> classnoList(int classno) {
        String SQL = "select class_no, course_id, class.name, lecturer.name,\n" +
                "t1.period, t1.begin, t2.end, t2.begin, t2.end, person_max,\n" +
                "building.name, room.room_id, count(distinct takes.student_id)\n" +
                "from class\n" +
                "LEFT JOIN takes ON class.class_id = takes.class_id\n" +
                "JOIN lecturer ON lecturer.lecturer_id = class.lecturer_id\n" +
                "JOIN time t1 ON t1.class_id = class.class_id and t1.period = 1\n" +
                "left JOIN time t2 ON t2.class_id = class.class_id and t2.period = 2\n" +
                "JOIN room ON room.room_id = class.room_id\n" +
                "JOIN building ON room.building_id=building.building_id\n" +
                "where class_no = " + Integer.toString(classno) + "\n" +
                "group by class_no";
        ArrayList<data> list = new ArrayList<data>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                data store = new data();

                store.setClassno(rs.getInt(1)); //수업번호
                store.setCourseid(rs.getString(2)); //학수번호
                store.setClassname(rs.getString(3)); //교과목명
                store.setLec_name(rs.getString(4));
                store.setPeriod1(rs.getInt(5));
                store.setP1st(rs.getString(6));
                store.setP1et(rs.getString(7));
                store.setP2st(rs.getString(8));
                store.setP2et(rs.getString(9));
                store.setMaxperson(rs.getInt(10));
                store.setBuild_name(rs.getString(11));
                store.setRoom_id(rs.getInt(12));
                store.setTakep(rs.getInt(13));

                list.add(store);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    /*
    classnolist와 마찬가지의 기능을 수행합니다. 다른점은 학수번호(courseid)를 선택하고 검색하였을 때라는
    점입니다,
     */
    public ArrayList<data> courseidList(String courseid) {
        String SQL = "select class_no, course_id, class.name, lecturer.name,\n" +
                "t1.period, t1.begin, t2.end, t2.begin, t2.end, person_max,\n" +
                "building.name, room.room_id, count(distinct takes.student_id)\n" +
                "from class\n" +
                "LEFT JOIN takes ON class.class_id = takes.class_id\n" +
                "JOIN lecturer ON lecturer.lecturer_id = class.lecturer_id\n" +
                "JOIN time t1 ON t1.class_id = class.class_id and t1.period = 1\n" +
                "left JOIN time t2 ON t2.class_id = class.class_id and t2.period = 2\n" +
                "JOIN room ON room.room_id = class.room_id\n" +
                "JOIN building ON room.building_id=building.building_id\n" +
                "where course_id = ?\n" +
                "group by class_no";
        ArrayList<data> list = new ArrayList<data>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, courseid);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                data store = new data();

                store.setClassno(rs.getInt(1)); //수업번호
                store.setCourseid(rs.getString(2)); //학수번호
                store.setClassname(rs.getString(3)); //교과목명
                store.setLec_name(rs.getString(4));
                store.setPeriod1(rs.getInt(5));
                store.setP1st(rs.getString(6));
                store.setP1et(rs.getString(7));
                store.setP2st(rs.getString(8));
                store.setP2et(rs.getString(9));
                store.setMaxperson(rs.getInt(10));
                store.setBuild_name(rs.getString(11));
                store.setRoom_id(rs.getInt(12));
                store.setTakep(rs.getInt(13));

                list.add(store);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }



    /*
    위 함수들과 같은 기능을 수행합니다. 다른 점은 교과목명(classname)을 서낵하고 검색했을 경우라는 점입니다
     */
    public ArrayList<data> classnameList(String classname) {
        String SQL = "select class_no, course_id, class.name, lecturer.name,\n" +
                "t1.period, t1.begin, t2.end, t2.begin, t2.end, person_max,\n" +
                "building.name, room.room_id, count(distinct takes.student_id)\n" +
                "from class\n" +
                "LEFT JOIN takes ON class.class_id = takes.class_id\n" +
                "JOIN lecturer ON lecturer.lecturer_id = class.lecturer_id\n" +
                "JOIN time t1 ON t1.class_id = class.class_id and t1.period = 1\n" +
                "left JOIN time t2 ON t2.class_id = class.class_id and t2.period = 2\n" +
                "JOIN room ON room.room_id = class.room_id\n" +
                "JOIN building ON room.building_id=building.building_id\n" +
                "where class.name like " + "\"" + "%" + classname + "%" + "\"" +
                "group by class_no";
        ArrayList<data> list = new ArrayList<data>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);

            rs = pstmt.executeQuery();
            while (rs.next()) {
                data store = new data();
                store.setClassno(rs.getInt(1)); //수업번호
                store.setCourseid(rs.getString(2)); //학수번호
                store.setClassname(rs.getString(3)); //교과목명
                store.setLec_name(rs.getString(4));
                store.setPeriod1(rs.getInt(5));
                store.setP1st(rs.getString(6));
                store.setP1et(rs.getString(7));
                store.setP2st(rs.getString(8));
                store.setP2et(rs.getString(9));
                store.setMaxperson(rs.getInt(10));
                store.setBuild_name(rs.getString(11));
                store.setRoom_id(rs.getInt(12));
                store.setTakep(rs.getInt(13));

                list.add(store);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    /*
    받은 uid(=userid=학번=studentid)를 바탕으로 해당 학생이 어떤 과목을 수강하는지를 배열형태로 반환합니다.
    향후 관리자가 학생의 정보를 조회할 때 또는 학생이 본인의 신청내역을 확인할 때 쓰입니다.

     */
    public ArrayList<data> getlist(int uid) {
        String SQL = "select class_no, course_id, class.name, lecturer.name,\n" +
                "t1.period, t1.begin, t2.end, t2.begin, t2.end, person_max,\n" +
                "building.name, room.room_id, count(distinct takes.student_id)\n" +
                "from class\n" +
                "LEFT JOIN takes ON class.class_id = takes.class_id\n" +
                "JOIN lecturer ON lecturer.lecturer_id = class.lecturer_id\n" +
                "JOIN time t1 ON t1.class_id = class.class_id and t1.period = 1\n" +
                "left JOIN time t2 ON t2.class_id = class.class_id and t2.period = 2\n" +
                "JOIN room ON room.room_id = class.room_id\n" +
                "JOIN building ON room.building_id=building.building_id\n" +
                "where takes.student_id = " + Integer.toString(uid) + "\n" +
                "group by class_no;";
        ArrayList<data> list = new ArrayList<data>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);

            rs = pstmt.executeQuery();
            while (rs.next()) {
                data store = new data();
                store.setClassno(rs.getInt(1)); //수업번호
                store.setCourseid(rs.getString(2)); //학수번호
                store.setClassname(rs.getString(3)); //교과목명
                store.setLec_name(rs.getString(4));
                store.setPeriod1(rs.getInt(5));
                store.setP1st(rs.getString(6));
                store.setP1et(rs.getString(7));
                store.setP2st(rs.getString(8));
                store.setP2et(rs.getString(9));
                store.setMaxperson(rs.getInt(10));
                store.setBuild_name(rs.getString(11));
                store.setRoom_id(rs.getInt(12));
                store.setTakep(rs.getInt(13));

                list.add(store);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /*
    getlecname은 해당 학생의 지도교수를 반환해줍니다
     */
    public String getlecname(int sid) {
        String SQL = "select l1.name\n" +
                "from student s1\n" +
                "join lecturer l1 on s1.lecturer_id = l1.lecturer_id\n" +
                "where s1.student_id = " + Integer.toString(sid);
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            String lecname = null;
            if (rs.next()) {
                lecname = rs.getString(1);
            }
            return lecname;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /*
    getstatus는 해당 학생의 학적 상태를 반환해줍니다.
    향후 관리자가 해당 학생의 정보를 조회할 때 어떤 학적상태인지 보여줄 때 사용됩니다.
     */
    public String getstatus(int sid) {
        String SQL = "select status\n" +
                "from student\n" +
                "where student_id =" + Integer.toString(sid);
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            String status = null;
            if (rs.next()) {
                status = rs.getString(1);
            }
            return status;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    //    changestatus : 학생의 학적을 변경하는 함수 -> editstatus 이용
    public int changestatus(int sid, String chstatus) {
        String SQL = "update student set status = " + chstatus + "\n" +
                "where student_id = " + Integer.toString(sid);
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.executeUpdate();

            return 1; //정상 업데이트 된 경우
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; //에러
    }



    /*
    학생의 과거 성적들을 배열로 반환해주는 함수입니다.
    향후 관리가자 학생정보를 조회할 때 학생 성적을 보여줄 때 사용됩니다.

     */
    public ArrayList<grade_s> getgradelist(int sid) {
        String SQL = "select cr.course_id, co.name, cr.year, grade\n" +
                "from credits cr\n" +
                "join course co on co.course_id = cr.course_id\n" +
                "where student_id = " + Integer.toString(sid);

        ArrayList<grade_s> list = new ArrayList<grade_s>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);

            rs = pstmt.executeQuery();
            while (rs.next()) {
                grade_s store = new grade_s();
                store.setCourse_id(rs.getString(1));
                store.setName(rs.getString(2));
                store.setYear(rs.getInt(3));
                store.setGrade(rs.getString(4));

                list.add(store);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }





    /*
    desiredlist는 학생의 희망 수업들을 리턴해줍니다.
    학생의 희망수강(장바구니)를 보여주기 위해 사용됩니다.
     */
    public ArrayList<data> desiredlist(int uid) {
        String SQL = "select class_no, course_id, class.name, lecturer.name,\n" +
                "t1.period as period1, t1.begin, t2.end, t2.period as period2, t2.begin, t2.end, person_max,\n" +
                "building.name, room.room_id\n" +
                "from class\n" +
                "JOIN desired ON class.class_id = desired.class_id\n" +
                "JOIN lecturer ON lecturer.lecturer_id = class.lecturer_id\n" +
                "JOIN time t1 ON t1.class_id = class.class_id and t1.period = 1\n" +
                "left JOIN time t2 ON t2.class_id = class.class_id and t2.period = 2\n" +
                "JOIN room ON room.room_id = class.room_id\n" +
                "JOIN building ON room.building_id=building.building_id\n" +
                "where desired.student_id = " + Integer.toString(uid) + "\n" +
                "group by class_no";

        ArrayList<data> list = new ArrayList<data>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);

            rs = pstmt.executeQuery();
            while (rs.next()) {
                data store = new data();
                store.setClassno(rs.getInt(1)); //수업번호
                store.setCourseid(rs.getString(2)); //학수번호
                store.setClassname(rs.getString(3)); //교과목명
                store.setLec_name(rs.getString(4));
                store.setPeriod1(rs.getInt(5));
                store.setP1st(rs.getString(6));
                store.setP1et(rs.getString(7));
                store.setPeriod2(rs.getInt(8));
                store.setP2st(rs.getString(9));
                store.setP2et(rs.getString(10));
                store.setMaxperson(rs.getInt(11));
                store.setBuild_name(rs.getString(12));
                store.setRoom_id(rs.getInt(13));

                list.add(store);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /*
    editstatus는 관리자가 학생의 학적을 변경할 때 사용됩니다.
    입력 받은 값을 바탕으로 다른 함수와 마찬가지로 SQL문으로 학생의 학적상태를 변경합니다.
     */
    public int editstatus(int sid, String status){
        String newstatus = null;
        if(status.equals("ok")){
            newstatus = "재학";
        } else if (status.equals("takeoff")) {
            newstatus = "휴학";
        } else if (status.equals("dropout")) {
            newstatus = "자퇴";
        }
        String SQL = "UPDATE student SET status='" + newstatus + "'\n" +
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
