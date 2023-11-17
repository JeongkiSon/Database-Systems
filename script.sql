DROP DATABASE IF EXISTS db2021053154;
CREATE DATABASE IF NOT EXISTS db2021053154;
USE db2021053154;



CREATE TABLE student(
	student_id int,
    password varchar(64),
    name nvarchar(50),	
    sex varchar(10),
    major_id int,
    lecturer_id int,
    year int
);


CREATE TABLE lecturer(
	lecturer_id int,
    name varchar(50),
    major_id int
);


CREATE TABLE building(
	building_id int,
    name nvarchar(30),
    admin nvarchar(30),
    rooms int
);

CREATE TABLE class(
	class_id int,
    class_no int,
    course_id varchar(10),
    name nvarchar(30),
    major_id int,
    year int,
    credit int,
    lecturer_id int,
    person_max int,
    opened int,
    room_id int
);

CREATE TABLE course(
	course_id varchar(10),
    name nvarchar(30),
    credit int
);

CREATE TABLE credits(
	credits_id int,
    student_id int,
    course_id varchar(10),
    year int,
    grade varchar(5)
);

CREATE TABLE major(
	major_id int,
    name nvarchar(30)
);

CREATE TABLE room(
	room_id int,
    building_id int,
    occupancy int
);

CREATE TABLE time(
	time_id int,
    class_id int,
    period int,
    begin varchar(45),
    end varchar(45)
);

CREATE TABLE takes(
	takes_id int,
    student_id int,
    class_id int

);

-- CREATE TABLE taken(
-- 	taken_id int,
--     student_id int,
--     course_id int,
--     credits_id int
-- );

CREATE TABLE desired(
	desired_id int,
    student_id int,
    class_id int
);


CREATE TABLE admin(
	admin_id int,
    admin_pw varchar(64)
);

CREATE TABLE gpa(
	student_id int,
    gpa double
);


#primary key 설정

ALTER TABLE student ADD PRIMARY KEY (student_id);
ALTER TABLE building ADD PRIMARY KEY (building_id);
ALTER TABLE room ADD PRIMARY KEY (room_id);
ALTER TABLE time ADD PRIMARY KEY (time_id);
ALTER TABLE class ADD PRIMARY KEY (class_id);
ALTER TABLE major ADD PRIMARY KEY (major_id);
ALTER TABLE lecturer ADD PRIMARY KEY (lecturer_id);
ALTER TABLE course ADD PRIMARY KEY (course_id);
ALTER TABLE credits ADD PRIMARY KEY (credits_id);

ALTER TABLE takes ADD PRIMARY KEY (takes_id);
ALTER TABLE desired ADD PRIMARY KEY (desired_id);
ALTER TABLE gpa ADD PRIMARY KEY (student_id);
ALTER TABLE admin ADD PRIMARY KEY (admin_id);


#on update cascade 등의 옵션을 따로 걸지 않으면 
#No action 으로 restrict로 참조하고 있을 경우 삭제나 업데이트가
#불가하게 된다

ALTER TABLE student ADD FOREIGN KEY (major_id)
REFERENCES major(major_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE student ADD FOREIGN KEY (lecturer_id)
REFERENCES lecturer(lecturer_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE lecturer ADD FOREIGN KEY (major_id)
REFERENCES major(major_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE credits ADD FOREIGN KEY (student_id)
REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE credits ADD FOREIGN KEY (course_id)
REFERENCES course(course_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE class ADD FOREIGN KEY (course_id)
REFERENCES course(course_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE class ADD FOREIGN KEY (lecturer_id)
REFERENCES lecturer(lecturer_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE class ADD FOREIGN KEY (room_id)
REFERENCES room(room_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE time ADD FOREIGN KEY (class_id)
REFERENCES class(class_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE room ADD FOREIGN KEY (building_id)
REFERENCES building(building_id) ON DELETE CASCADE ON UPDATE CASCADE;

#새로 추가한 테이블
ALTER TABLE takes ADD FOREIGN KEY (student_id)
REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE takes ADD FOREIGN KEY (class_id)
REFERENCES class(class_id) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE desired ADD FOREIGN KEY (student_id)
REFERENCES student(student_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE desired ADD FOREIGN KEY (class_id)
REFERENCES class(class_id) ON DELETE CASCADE ON UPDATE CASCADE;

insert into admin values(111, "sss");
insert into admin values(112, "sss2");
insert into admin values(2021053154, "son");
insert into admin values(1987111111, "admin111");

select s1.student_id,  
round(sum((case grade 
when 'A+' then 4.5
when 'A0' then 4.0
when 'B+' then 3.5
when 'B0' then 3.0
when 'C+' then 2.5
when 'C0' then 2.0
when 'D+' then 1.5
when 'D0' then 1.0
when 'F' then 0
end ) * co1.credit) / sum(co1.credit) , 2) as intgrade
from credits c1
join student s1 on c1.student_id = s1.student_id
join course co1 on co1.course_id = c1.course_id
group by s1.student_id;
#위 쿼리의 결과가 gpa테이블 입니다.
 

