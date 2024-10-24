-- Active: 1729484795773@@127.0.0.1@5432@university_db

-- Create a fresh database titled "university_db"
CREATE DATABASE university_db;

-- Create students table
CREATE TABLE students (
    student_id INTEGER PRIMARY KEY UNIQUE,
    student_name VARCHAR(50) NOT NULL,
    age INT,
    email VARCHAR(100) UNIQUE,
    frontend_mark INT,
    backend_mark INT,
    status VARCHAR(50)
);

-- Create courses table
CREATE TABLE courses (
    course_id INTEGER PRIMARY KEY UNIQUE,
    course_name VARCHAR(255) NOT NULL UNIQUE,
    credits INT NOT NULL
);

-- Create "enrollment" table
CREATE TABLE enrollments (
    enrollment_id INTEGER PRIMARY KEY UNIQUE,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id)
);

-- Insert data into the "students" table
INSERT INTO students (student_id, student_name, age, email, frontend_mark, backend_mark, status) VALUES 
(1, 'Sameer', 21, 'sameer@example.com', 48, 60, NULL),
(2, 'Zoya', 23, 'zoya@example.com', 52, 58, NULL),
(3, 'Nabil', 22, 'nabil@example.com', 37, 46, NULL),
(4, 'Rafi', 24, 'rafi@example.com', 41, 40, NULL),
(5, 'Sophia', 22, 'sophia@example.com', 50, 52, NULL),
(6, 'Hasan', 23, 'hasan@gmail.com', 43, 39, NULL);

-- Insert data into the "courses" table:
INSERT INTO courses (course_id, course_name, credits) VALUES
(1, 'Next.js', 3),
(2, 'React.js', 4),
(3, 'Databases', 3),
(4, 'Prisma', 3);


-- Insert data into the "enrollment" table:
INSERT INTO enrollments (enrollment_id, student_id, course_id) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 3, 2);

-- Query 1:
-- Insert a new student record
INSERT INTO students (student_id, student_name, age, email, frontend_mark, backend_mark, status) VALUES
    (7, 'John Doe', 25, 'johndoe@example.com', 65, 70, NULL);


-- Query 2:
-- Retrieve the names of all students who are enrolled in the course titled 'Next.js'.
SELECT student_name from enrollments JOIN students USING(student_id) JOIN courses USING(course_id) WHERE course_name ILIKE 'next.Js';


-- Query 3:
-- Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.
UPDATE students set "status" = 'awarded' where student_id = (SELECT student_id FROM students ORDER BY (frontend_mark+backend_mark) DESC LIMIT 1);


-- Query 4:
-- Delete all courses that have no students enrolled.
DELETE FROM courses WHERE course_id IN (SELECT course_id FROM courses LEFT JOIN enrollments USING(course_id) WHERE student_id is NULL);


-- Query 5:
-- Retrieve the names of students using a limit of 2, starting from the 3rd student.
SELECT student_name FROM students LIMIT 2 OFFSET 2;

-- Query 6:
-- Retrieve the course names and the number of students enrolled in each course.
SELECT course_name, count(student_id) from enrollments RIGHT JOIN courses USING(course_id) GROUP BY course_id;


-- Query 7:
-- Calculate and display the average age of all students.
select round(avg(age), 2) as average_age FROM students;

-- Query 8:
-- Retrieve the names of students whose email addresses contain 'example.com'.
select student_name from students WHERE email ILIKE '%example.com';