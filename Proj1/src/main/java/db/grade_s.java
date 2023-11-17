package db;
//관리자가 학생을 조회할 때, 학생의 모든 과거 성적을 보여줄 때 사용될 DTO입니다
public class grade_s {

    String course_id;
    String name;
    int year;
    String grade;

    public String getCourse_id() {
        return course_id;
    }

    public void setCourse_id(String course_id) {
        this.course_id = course_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }
}
