DROP DATABASE IF EXISTS department_staff;
CREATE DATABASE department_staff;
USE department_staff;

DROP TABLE IF EXISTS subjects;
CREATE TABLE subjects (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40),
    course INT
);

DROP TABLE IF EXISTS academic_rank;
CREATE TABLE academic_rank (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(40)
);

DROP TABLE IF EXISTS employee;
CREATE TABLE employee (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20),
    surname VARCHAR(20),
	work_experience DOUBLE,
    passport_code VARCHAR(30),
    academic_rank_id INT,
    subject_id INT
);

INSERT INTO subjects (name, course)
VALUES 
("alghorithms", 2),
("databases", 2),
("webprogramming", 2);

INSERT INTO academic_rank (name)
VALUES 
("rank1"),
("rank2"),
("rank3");

INSERT INTO employee (name, surname, work_experience, passport_code, academic_rank_id, subject_id)
VALUES
("Андрій", "Кавкало", 20.5, "ad 349423", 1, 1),
("Оля", "Польова", 12.3, "ad 342423", 2, 2),
("Оксана", "Борейко", 10, "ad 342423", 3, 3);



