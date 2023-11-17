package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class olapDAO {

    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;


    public olapDAO(){
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

    //각 학생의 gpa를 내주는 함수입니다.
    //자세한 SQL설명은 wiki에 있습니다
    public ArrayList<olap> studentgpa() {
        String SQL = "select s1.student_id,  \n" +
                "round(sum((case grade \n" +
                "when 'A+' then 4.5\n" +
                "when 'A0' then 4.0\n" +
                "when 'B+' then 3.5\n" +
                "when 'B0' then 3.0\n" +
                "when 'C+' then 2.5\n" +
                "when 'C0' then 2.0\n" +
                "when 'D+' then 1.5\n" +
                "when 'D0' then 1.0\n" +
                "when 'F' then 0\n" +
                "end ) * co1.credit) / sum(co1.credit) , 2) as intgrade\n" +
                "from credits c1\n" +
                "join student s1 on c1.student_id = s1.student_id\n" +
                "join course co1 on co1.course_id = c1.course_id\n" +
                "group by s1.student_id;\n";
        //각 학생마다(id)의 평균 학점 출력 i.e., 3.47, 2,89, 4,38 ...

        ArrayList<olap> list = new ArrayList<olap>();
        try {
            pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                olap store = new olap();
                store.setStudent_id(rs.getInt(1));
                store.setGpa(rs.getDouble(2));

                list.add(store);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    // olap
    // 평점 평균과 특정 과목의 학점 간 차이(평점평균-과목학점)가 가장 큰 Top10 과목 추출
    // 학생들의 gpa 평균에서 해당 과목만의 학점(성적)을 뺀 값의 과목별 평균을 구한다
    public ArrayList<olap> classavg() {
        String SQL = "select c.course_id,\n" +
                "cc.name, \n" +
                "\t(case grade \n" +
                "      when 'A+' then 4.5\n" +
                "\t  when 'A0' then 4.0\n" +
                "      when 'B+' then 3.5\n" +
                "        when 'B0' then 3.0\n" +
                "        when 'C+' then 2.5\n" +
                "        when 'C0' then 2.0\n" +
                "        when 'D+' then 1.5\n" +
                "        when 'D0' then 1.0\n" +
                "        when 'F' then 0\n" +
                "   End) as eachgpa, \n" +
                "   round(g.gpa - (case grade \n" +
                "      when 'A+' then 4.5\n" +
                "\t  when 'A0' then 4.0\n" +
                "      when 'B+' then 3.5\n" +
                "        when 'B0' then 3.0\n" +
                "        when 'C+' then 2.5\n" +
                "        when 'C0' then 2.0\n" +
                "        when 'D+' then 1.5\n" +
                "        when 'D0' then 1.0\n" +
                "        when 'F' then 0\n" +
                "   End) , 2) as calculate,\n" +
                "   avg(round(g.gpa - (case grade \n" +
                "      when 'A+' then 4.5\n" +
                "\t  when 'A0' then 4.0\n" +
                "      when 'B+' then 3.5\n" +
                "        when 'B0' then 3.0\n" +
                "        when 'C+' then 2.5\n" +
                "        when 'C0' then 2.0\n" +
                "        when 'D+' then 1.5\n" +
                "        when 'D0' then 1.0\n" +
                "        when 'F' then 0\n" +
                "   End) , 2)) as avg\n" +
                "from credits c\n" +
                "join gpa g on g.student_id = c.student_id\n" +
                "join class cc on cc.course_id = c.course_id\n" +
                "group by c.course_id\n" +
                "order by avg desc\n" +
                "limit 10;";

        // column 값
        // course_id, name(과목명), eachgpa, calculate(빼기 연산), avg

        ArrayList<olap> list = new ArrayList<olap>();

        try {
            pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                olap store = new olap();
                store.setCourse_id(rs.getString(1));
                store.setClassname(rs.getString(2));
                store.setAvg(rs.getDouble(5));


                list.add(store);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


}
