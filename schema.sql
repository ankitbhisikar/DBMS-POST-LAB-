-- Online Course Management System Database Schema
-- Version: 2.0 (QueryAcademy)

-- 1. Instructor Table
CREATE TABLE IF NOT EXISTS Instructor ( 
    Instructor_ID INTEGER PRIMARY KEY AUTOINCREMENT, 
    Name VARCHAR(100),
    Email VARCHAR(100), 
    Phone VARCHAR(20),
    Specialization VARCHAR(100), 
    Hire_Date DATE
);

-- 2. Course Table
CREATE TABLE IF NOT EXISTS Course ( 
    Course_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Title VARCHAR(200), 
    Category VARCHAR(50), 
    Status VARCHAR(50),
    Start_Date DATE, 
    End_Date DATE, 
    Instructor_ID INT,
    FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID)
);

-- 3. Department Table
CREATE TABLE IF NOT EXISTS Department ( 
    Dept_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Dept_Name VARCHAR(100), 
    Location VARCHAR(100),
    Established_Year INT,
    Course_ID INT,
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

-- 4. Student Table
CREATE TABLE IF NOT EXISTS Student ( 
    Student_ID INTEGER PRIMARY KEY AUTOINCREMENT, 
    Name VARCHAR(100),
    Gender VARCHAR(10),
    Major VARCHAR(100), 
    Course_ID INT,
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

-- 5. NEW EMPTY TABLE: Assignment (for practice)
CREATE TABLE IF NOT EXISTS Assignment (
    Assignment_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Title VARCHAR(200) NOT NULL,
    Description TEXT,
    Due_Date DATE,
    Max_Score INT,
    Course_ID INT,
    FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

-- Sample Data (existing)
INSERT OR IGNORE INTO Instructor (Instructor_ID, Name, Email, Phone, Specialization, Hire_Date) 
VALUES (1, 'Dr. Alan Turing', 'alan@cs.edu', '555-0100', 'Computer Science', '2018-08-15');

INSERT OR IGNORE INTO Instructor (Instructor_ID, Name, Email, Phone, Specialization, Hire_Date) 
VALUES (2, 'Prof. Ada Lovelace', 'ada@math.edu', '555-0200', 'Mathematics', '2015-01-20');

INSERT OR IGNORE INTO Course (Course_ID, Title, Category, Status, Start_Date, End_Date, Instructor_ID) 
VALUES (101, 'Introduction to Algorithms', 'Computer Science', 'Active', '2024-09-01', '2024-12-15', 1);

INSERT OR IGNORE INTO Course (Course_ID, Title, Category, Status, Start_Date, End_Date, Instructor_ID) 
VALUES (102, 'Calculus and Linear Algebra', 'Mathematics', 'Upcoming', '2025-01-15', '2025-05-15', 2);

INSERT OR IGNORE INTO Department (Dept_ID, Dept_Name, Location, Established_Year, Course_ID) 
VALUES (201, 'Computer Science', 'Science Building A', 1980, 101);

INSERT OR IGNORE INTO Department (Dept_ID, Dept_Name, Location, Established_Year, Course_ID) 
VALUES (202, 'Mathematics', 'Science Building B', 1970, 102);

INSERT OR IGNORE INTO Student (Student_ID, Name, Gender, Major, Course_ID) 
VALUES (501, 'Grace Hopper', 'Female', 'Computer Science', 101);

INSERT OR IGNORE INTO Student (Student_ID, Name, Gender, Major, Course_ID) 
VALUES (502, 'John von Neumann', 'Male', 'Mathematics', 102);
