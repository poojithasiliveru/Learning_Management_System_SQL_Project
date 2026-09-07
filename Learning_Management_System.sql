#Project 
create database project;
use project;
#Students(student_id PK, student_name, email, phone, city)
create table students(student_id int primary key, student_name varchar(20), email varchar(20), phone varchar(20), city varchar(20));

#Mentors(mentor_id PK, mentor_name, expertise)
create table mentors(mentor_id int primary key, mentor_name varchar(20), expertise varchar(100));

#Courses(course_id PK, mentor_id FK, course_name, category, duration)
create table courses(course_id int primary key, mentor_id int, course_name varchar(100), category varchar(100), duration int, foreign key (mentor_id) references mentors(mentor_id));

#Enrollment(enrollment_id PK, student_id FK, course_id FK, enroll_date, status)
create table enrollment(enrollment_id int primary key, student_id int, course_id int, enroll_date date, status varchar(20), foreign key(student_id) references students(student_id), foreign key(course_id) references courses(course_id));

# Assessments(assessment_id PK, module_id FK, student_id FK, score, assessment_date)
create table assessments(assessment_id int primary key, student_id int,course_id int,assessment_name varchar(50), score int, assessment_date date, foreign key(student_id) references students(student_id), foreign key(course_id) references courses(course_id));

#insert values into students table
insert into students values(101,'Aarav Sharma', 'aarav@gmail.com','9876500001','Hyderabad'),
(102,'Bhavya Reddy', 'bhavya@gmail.com','9876500002','Vijayawada'),
(103,'Charan Kumar', 'charan@gmail.com','9876500003','Visakhapatnam'),
(104,'Divya Patel', 'divya@gmail.com','9876500004','Bengaluru'),
(105,'Esha Gupta', 'esha@gmail.com','9876500005','Chennai'),
(106,'Farhan Ali', 'farhan@gmail.com','9876500006','Mumbai'),
(107,'Gopi Krishna', 'gopi@gmail.com','9876500007','Warangal'),
(108,'Harini Rao', 'harini@gmail.com','9876500008','Guntur'),
(109,'Ishaan Verma', 'ishaan@gmail.com','9876500009','Pune'),
(110,'John Mathew', 'john@gmail.com','9876500010','Kochi');
select * from students;

#insert values into mentors table
insert into mentors values(201,'Dr. Santhosh Kumar', 'Machine Learning'),
(202,'Priya Nair', 'Data Analytics'),
(203,'Rahul Mehta', 'Web Development'),
(204,'Sneha Reddy', 'Cloud Computing'),
(205,'Arjun Singh', 'Cyber Security');
select * from mentors;

#insert values into courses table
INSERT INTO Courses VALUES
(301,201,'Machine Learning','AI',60),
(302,202,'Data Analytics','Analytics',45),
(303,203,'Python Full Stack', 'Web Development',75),
(304,204,'AWS Cloud','Cloud',40),
(305,205,'Cyber Security Basics','Security',35),
(306,202,'Power BI', 'Business Intelligence',30);
select * from courses;


#insert values into enrollment table
INSERT INTO Enrollment VALUES
(501,101,301,'2026-07-01','Active'),
(502,102,302,'2026-07-02','Completed'),
(503,103,303,'2026-07-03','Active'),
(504,104,304,'2026-07-04','Completed'),
(505,105,305,'2026-07-05','Active'),
(506,106,306,'2026-07-06','Completed'),
(507,107,301,'2026-07-07','Active'),
(508,108,302,'2026-07-08','Completed'),
(509,109,303,'2026-07-09','Dropped'),
(510,110,304,'2026-07-10','Active'),
(511,101,306,'2026-07-11','Completed'),
(512,103,305,'2026-07-12','Active');
select * from enrollment;

#insert values into assessment table
INSERT INTO Assessments VALUES 
(601,101,301,'Quiz 1',85.50,'2026-07-05'), 
(602,101,301,'Final Assessment',91.00,'2026-07-15'), 
(603,102,302,'Assignment 1',78.00,'2026-07-06'), 
(604,102,302,'Final Assessment',88.50,'2026-07-16'), 
(605,103,303,'Quiz 1',81.00,'2026-07-07'), 
(606,103,303,'Project Evaluation',75.50,'2026-07-17'), 
(607,104,304,'Quiz 1',92.00,'2026-07-08'), 
(608,104,304,'Final Assessment',89.00,'2026-07-18'), 
(609,105,305,'Assignment 1',84.00,'2026-07-09'), 
(610,106,306,'Quiz 1',91.50,'2026-07-10'), 
(611,107,301,'Assignment 1',80.00,'2026-07-11'), 
(612,108,302,'Quiz 2',87.00,'2026-07-12'), 
(613,109,303,'Final Assessment',83.50,'2026-07-13'),
(614,110,304,'Project Evaluation',86.00,'2026-07-14'), 
(615,101,306,'Dashboard Project',95.00,'2026-07-20');

#------------------------QUERIES-----------------------

#1. List all students.
select * from students;

#2. Delete an inactive enrollment.
delete from enrollment where status='Inactive';

#3. Update the enrollment status of a student from 'Active' to 'Completed'
update enrollment set status='Completed' where status='Active';
set sql_safe_updates=0;

#4. Display all mentor names in uppercase and course names in lowercase.
select upper(m.mentor_name) as upper_mentor_name, lower(c.course_name) as lower_course_name from mentors m join courses c on m.mentor_id=c.mentor_id;

#5. Show first 5 characters of course names.
select left(course_name,5) as first_5_left from courses;

#6. Concatenate student name and city.
select concat(student_name,' ',city) from students;

#7. Display the last four digits of each student's phone number
select right(phone,4) as last_4_digits from students;

#8. Replace 'Python' with 'Advanced Python' in output.
select replace(course_name, 'Python', 'Advanced Python') as course_name from Courses;

#9. Find courses containing 'Data'.
select * from courses where course_name like '%Data%';

#10. Display today's assessments.
select * from assessments where assessment_date=curdate();

#11. Find the number of days since each student enrolled.
select student_id, datediff(curdate(),enroll_date) as days_since_enrollment from enrollment;

#12. Display the assessment date in the format DD-Mon-YYYY.
select date_format(assessment_date,'%d-%b-%y') as formatted_date from assessments;

#13. Show all enrollments made in July 2026.
select * from enrollment where year(enroll_date)=2026 and month(enroll_date)=7;

#14. Count the number of students enrolled in each course.
select count(student_id),course_id from enrollment group by course_id;

#15. Display the average assessment score for each course.
select avg(score),course_id from assessments group by course_id;
select * from assessments;

#16. Find the highest and lowest assessment score.
select max(score) as highest_score,min(score) as lowest_score from assessments;

#17. Display courses having more than 5 students. 
select course_id, count(student_id) as student_count from Enrollment group by course_id having count(student_id) > 5;

#18. Display student names along with their enrolled course names. 
select s.student_name,c.course_name from students s
join enrollment e on s.student_id=e.student_id
join courses c on e.course_id=c.course_id;

select * from enrollment;

#19. Display course names with their mentor names. 
select c.course_name, m.mentor_name from courses c
join mentors m on c.mentor_id=m.mentor_id;

#20. Display student names, course names, and enrollment status. 
select s.student_name, c.course_name, e.status from students s
join enrollment e on s.student_id=e.student_id
join courses c on c.course_id=e.course_id;

#21. Display assessment details along with student and course names. 
select a.*,s.student_name, c.course_name from assessments a
join students s on s.student_id=a.student_id
join courses c on c.course_id=a.course_id;

#22. Display mentor names along with the courses they teach. 
select m.mentor_name, c.course_name from mentors m
join courses c on m.mentor_id=c.mentor_id;

#23. Students without enrollments. 
select s.* from Students s left join Enrollment e on s.student_id = e.student_id where e.student_id is null;

#26. Find students who scored higher than the average assessment score. 
select s.student_name, a.score from Students s 
join Assessments a on s.student_id = a.student_id
where a.score > (select avg(score) from Assessments);

#27. Display the course having the maximum duration. 
select max(duration) from courses;

#28. Correlated subquery for top scorer per course. 
select s.student_name, a.course_id, a.score from Students s 
join Assessments a on s.student_id = a.student_id
where a.score = (select MAX(a2.score) from Assessments a2 where a2.course_id = a.course_id);

#29. Create a view to display student names, course names, and enrollment status. 
create view student_course_enrollment as
select s.student_name, c.course_name, e.status from students s
join enrollment e on s.student_id=e.student_id
join courses c on c.course_id=e.course_id;

select * from student_course_enrollment;

#30. Create a view to display assessment results with student and course details. 
create view assessment_results as select a.assessment_id, s.student_name, c.course_name, a.score from Assessments a
join Students s on a.student_id = s.student_id
join Courses c on a.course_id = c.course_id;

select * from assessment_results;

#31. Retrieve all records from both created views. 
select * from student_course_enrollment;
select * from assessment_results;

#32.  Start a transaction and update the enrollment status of a student.  
start transaction;
update enrollment set status='active' where enrollment_id=502;
commit;
select * from enrollment;

#33.  Create a SAVEPOINT after updating assessment scores.
select * from assessments;
start transaction;
update assessments set score=90 where assessment_id=602;
savepoint score_update;
commit;

#34. Roll back to the SAVEPOINT.  
start transaction;
update assessments set score = 80 where assessment_id = 604;
savepoint sp1;
update Assessments set score = 90 where assessment_id = 605;
rollback to savepoint sp1;

#35. Commit the transaction.  
start transaction;
update Assessments set score = 100 where assessment_id = 606;
savepoint sp1;
rollback to savepoint sp1;
commit;

#36. Delete an assessment record and roll back the transaction. 
start transaction;
delete from assessments where assessment_id = 615;
rollback;

#37. Create a stored procedure to display all courses belonging to a particular category. Input: category  
call GetCoursesByCategory('AI');

#38.  Create a stored procedure to find the average assessment score of a particular student. Input: student_id 
call GetStudentAverageScore(101);

#39. Create a trigger on Assessments to store newly added assessment details in an Assessment_Log table. 
create table  assessment_log(assessment_id int primary key, student_id int, course_id int, assessment_name varchar(50), score int, assessment_date date,  foreign key(student_id) references students(student_id), foreign key(course_id) references courses(course_id));

insert into assessments values(622,102, 301,'quiz', 85,'2026-07-13');

select * from assessment_log;
select * from assessments;

#40.  Create an AFTER UPDATE trigger on Enrollment to store the old and new enrollment status in an Enrollment_Status_History table.
create table Enrollment_Status_History(enrollment_id int,student_id int, old_status varchar(20),new_status varchar(20));
select * from Enrollment_Status_History;

update enrollment set status='active' where enrollment_id=511;

select * from enrollment;

