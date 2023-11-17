package db;
//수강편람이나 수강신청에서 각 과목별로 정보를 출력하기 위해 만든 DTO입니다
public class data {
    private int classno; //수업번호
    private String courseid; //학수번호
    private String classname; //교과목명
    private String lec_name; //교강사
    private int period1;//기간1
    private String p1st; //시작시간
    private String p1et; //끝시간

    private int period2;
    private String p2st; //시작시간
    private String p2et; //끝시간


    private int maxperson; //정원
    private int takep; //듣는사람

    //강의실(건물+호수)
    private int room_id; //방호수
    private String build_name; //건물명


    public int getClassno() {
        return classno;
    }

    public void setClassno(int classno) {
        this.classno = classno;
    }

    public String getCourseid() {
        return courseid;
    }

    public void setCourseid(String courseid) {
        this.courseid = courseid;
    }

    public String getClassname() {
        return classname;
    }

    public void setClassname(String classname) {
        this.classname = classname;
    }

    public String getLec_name() {
        return lec_name;
    }

    public void setLec_name(String lec_name) {
        this.lec_name = lec_name;
    }

    public int getPeriod1() {
        return period1;
    }

    public void setPeriod1(int period1) {
        this.period1 = period1;
    }

    public String getP1st() {
        return p1st;
    }

    public void setP1st(String p1st) {
        this.p1st = p1st;
    }

    public String getP1et() {
        return p1et;
    }

    public void setP1et(String p1et) {
        this.p1et = p1et;
    }

    public int getPeriod2() {
        return period2;
    }

    public void setPeriod2(int period2) {
        this.period2 = period2;
    }

    public String getP2st() {
        return p2st;
    }

    public void setP2st(String p2st) {
        this.p2st = p2st;
    }

    public String getP2et() {
        return p2et;
    }

    public void setP2et(String p2et) {
        this.p2et = p2et;
    }

    public int getMaxperson() {
        return maxperson;
    }

    public void setMaxperson(int maxperson) {
        this.maxperson = maxperson;
    }

    public int getTakep() {
        return takep;
    }

    public void setTakep(int takep) {
        this.takep = takep;
    }

    public int getRoom_id() {
        return room_id;
    }

    public void setRoom_id(int room_id) {
        this.room_id = room_id;
    }

    public String getBuild_name() {
        return build_name;
    }

    public void setBuild_name(String build_name) {
        this.build_name = build_name;
    }
}
