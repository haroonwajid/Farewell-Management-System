# Database created for Welcome Party
create database Welcome_Party;
use Welcome_Party;
drop database welcome_party;

# based off of erd
create table Student (
  Student_ID varchar(10) primary key,    # student ID must be like 21i-XXXX. also will be considered login username
  Student_Name varchar(50) not null,
  PhoneNo varchar(15) not null,
  Address varchar(255) not null,
  Family_Attending int(10) not null,
  Email varchar(50) not null unique,
  Dietary_Preferences varchar(255),
  Password varchar(50) not null
);

create table Teacher (
  Teacher_ID varchar(10) primary key,	# is considered login username
  Teacher_Name varchar(50) not null,
  NoOfAttendingFamily  int(10) not null,
  PhoneNo varchar(15) not null,
  Password varchar(50) not null
);

create table Menu (
  Menu_ID int(10) primary key auto_increment,
  Menu_Name varchar(50) not null,
  Description varchar(250) not null,
  Votes int(10) not null
);

create table Task (
  Task_ID int(10) primary key auto_increment,
  Assigned_To varchar(50) not null,
  Status Varchar(50) not null,
  Description varchar(255)
);

create table Organizer (
  Organizer_ID int(10) primary key auto_increment,
  Orginizer_Name varchar(50) not null,
  Status varchar(50) not null,
  Progress_Tracking varchar(120)
);

create table Budget_Item (
  Item_ID int(10) primary key auto_increment,
  Decoration varchar(50) not null,
  Venue varchar(50) not null,
  Quantity int(10)  not null, 
  Price int(10) not null
);

CREATE TABLE Attendance_Student (
  Ticket_ID INT(10) NOT NULL,
  Student_ID varchar(10),
  Status VARCHAR(10),
  PRIMARY KEY (Student_ID),
  FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID)
);

create table Attendance_Teacher (
  Ticket_ID INT(10) NOT NULL,
  Teacher_ID varchar(10),
  Status VARCHAR(10),
  PRIMARY KEY (Teacher_ID),
  FOREIGN KEY (Teacher_ID) REFERENCES Teacher(Teacher_ID)
);

create table Performance (
  Proposal_ID int(10) primary key auto_increment not null,
  Student_ID varchar(10), 
  Performance_Type varchar(50),
  Votes int(10) not null,
  Duration INT not null,
  FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID)
);

# extra tables made from erd i.e., from M-N relationships etc
create table Special_request (
  Proposal_ID int(10) auto_increment not null,
  Special_Request varchar(250) not null,
  FOREIGN KEY (Proposal_ID) REFERENCES Performance(Proposal_ID)
);

Create table Task_Assigned (
  Task_ID int(10) primary key auto_increment,
  Organizer_ID int(10) ,
  Task_Assigned varchar(50) not null,
  foreign key (Organizer_ID) references Organizer(Organizer_ID),
  foreign key (Task_ID) references Task(Task_ID)
);

create table Student_Task (
  Student_ID varchar(10),
  Task_ID  INT(10),
  PRIMARY KEY (Student_ID, Task_ID),
  FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
  FOREIGN KEY (Task_ID) REFERENCES Task(Task_ID)
);

create table Task_Organizer (
  Organizer_ID int(10) ,
  Task_ID  INT(10),
  PRIMARY KEY (Organizer_ID, Task_ID),
  FOREIGN KEY (Organizer_ID) REFERENCES Organizer(Organizer_ID),
  FOREIGN KEY (Task_ID) REFERENCES Task(Task_ID)
);

create table Student_Organizer (
  Student_ID varchar(10),
  Organizer_ID int(10) ,
  PRIMARY KEY (Student_ID,Organizer_ID ),
  FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
  FOREIGN KEY (Organizer_ID) REFERENCES Organizer(Organizer_ID)
);

create table Organizer_Budget (
  Organizer_ID int(10) ,
  Item_ID int(10),
  PRIMARY KEY (Item_ID,Organizer_ID ),
  FOREIGN KEY (Item_ID) REFERENCES Budget_Item(Item_ID),
  FOREIGN KEY (Organizer_ID) REFERENCES Organizer(Organizer_ID)
);

create table Student_Menu (
  Student_ID varchar(10),
  Menu_ID int(10),
  PRIMARY KEY (Menu_ID,student_ID ),
  FOREIGN KEY (Menu_ID) REFERENCES Menu(Menu_ID),
  FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID)
);

select * from attendance_student;
select * from attendance_teacher;
select * from budget_item;
select * from menu;
select * from organizer;
select * from organizer_budget;
select * from performance;
select * from special_request;
select * from student;
select * from student_menu;
select * from student_organizer;
select * from student_task;
select * from task;
select * from task_organizer;
select * from task_assigned;
select * from teacher;

-- Inserting values into the Student table
INSERT INTO Student (Student_ID, Student_Name, PhoneNo, Address, Family_Attending, Email, Dietary_Preferences, Password)
VALUES
  ('21i-0001', 'Asim Azhar', '1234567890', '123 Main St, Karachi', 3, 'asim.a@example.com', 'Vegetarian', 'password123'),
  ('21i-0002', 'Aima Baig', '9876543210', '456 Lim St, Golra', 2, 'aima.g@example.com', 'No preferences', 'securepass'),
  ('21i-0003', 'Faris Shafi', '5551234567', '789 Yo St, Said Pur Village', 4, 'fshafi@example.com', 'Vegan', 'p@ssw0rd'),
  ('21i-0004', 'Eman Furrukh', '3339998888', '101 Hi St, E11', 1, 'mano@example.com', 'Gluten-free', 'pass123word'),
  ('21i-0005', 'Shamail Aamir Khan', '7773331111', '202 Hello St, F6', 2, 'mak@example.com', 'No preferences', 'eva_pass');
  
-- Inserting values into the Teacher table
INSERT INTO Teacher (Teacher_ID, Teacher_Name, NoOfAttendingFamily, PhoneNo, Password)
VALUES
  ('tchr-001', 'Ali Khan', 3, '1234567890', 'teacherpass123'),
  ('tchr-002', 'Saba Ahmed', 2, '9876543210', 'saba_pass'),
  ('tchr-003', 'Rizwan Malik', 4, '5551234567', 'rizwanpass@123'),
  ('tchr-004', 'Nadia Abbas', 1, '3339998888', 'nadia_securepass'),
  ('tchr-005', 'Faisal Aziz', 2, '7773331111', 'faisal123pass');

-- Inserting values into the Menu table
INSERT INTO Menu (Menu_Name, Description, Votes)
VALUES
  ('Biryani', 'A flavorful rice dish with aromatic spices and tender meat.', 1),
  ('Haleem', 'A slow-cooked stew made with wheat, barley, and meat.', 0),
  ('Nihari', 'A slow-cooked stew made with meat, spices, and marrow.', 1),
  ('Spaghetti Bolognese', 'Italian pasta dish with a rich meaty sauce.', 2),
  ('Chicken Alfredo', 'Creamy pasta dish with grilled chicken and Alfredo sauce.', 1);

-- Inserting values into the Task table
INSERT INTO Task (Assigned_To, Status, Description)
VALUES
  ('Aima Baig', 'In Progress', 'Compile and analyze votes for the welcome party menu.'),
  ('Alice Smith', 'Pending', 'Prepare budgeting and financial planning for the welcome party.'),
  ('Mohammed Ali', 'Completed', 'Coordinate and oversee venue arrangements for the welcome party.'),
  ('Sara Khan', 'To Do', 'Plan and execute decorations for the welcome party.'),
  ('Faris Shafi', 'In Progress', 'Provide tickets and coordinate attendance for teachers at the welcome party.');
  
-- Inserting values into the Organizer table
INSERT INTO Organizer (Orginizer_Name, Status, Progress_Tracking)
VALUES
  ('EventMaster 5000', 'Active', 'Managing overall event planning and execution.'),
  ('Decoration Guru', 'In Progress', 'Coordinating and overseeing decoration arrangements.'),
  ('Budgeting Pro', 'Completed', 'Successfully managed and executed the event budget.'),
  ('Logistics Wizard', 'Pending', 'Planning logistics and coordinating with vendors.'),
  ('Ticketing Champ', 'In Progress', 'Handling ticket distribution and attendance tracking.');

-- Inserting values into the Budget_Item table
INSERT INTO Budget_Item (Decoration, Venue, Quantity, Price)
VALUES
  ('Flower Arrangements', 'Grand Hall', 20, 5000),
  ('Balloons and Streamers', 'Outdoor Area', 15, 3000),
  ('Stage Backdrop', 'Auditorium', 1, 8000),
  ('Lighting Setup', 'Main Entrance', 10, 6000),
  ('Table Centerpieces', 'Dining Area', 25, 4000);
  
-- Inserting values into the Attendance_Student table
INSERT INTO Attendance_Student (Ticket_ID, Student_ID, Status)
VALUES
  (1001, '21i-0001', 'Present'),
  (1002, '21i-0002', 'Absent'),
  (1003, '21i-0003', 'Present'),
  (1004, '21i-0004', 'Present'),
  (1005, '21i-0005', 'Absent');

-- Assuming these are the teacher IDs from the Teacher table
-- Replace these with the actual teacher IDs from your system
INSERT INTO Attendance_Teacher (Ticket_ID, Teacher_ID, Status)
VALUES
  (2001, 'tchr-001', 'Present'),
  (2002, 'tchr-002', 'Absent'),
  (2003, 'tchr-003', 'Present'),
  (2004, 'tchr-004', 'Present'),
  (2005, 'tchr-005', 'Present');

INSERT INTO Performance (Student_ID, Performance_Type, Votes, Duration)
VALUES
  ('21i-0001', 'Dance', 1, 1.30),
  ('21i-0002', 'Music', 2, 1.30),
  ('21i-0003', 'Comedy', 1, 2.0),
  ('21i-0004', 'Drama', 0, 4.0),
  ('21i-0005', 'Magic Show', 1, 2.0);

INSERT INTO Special_request (Proposal_ID, Special_Request)
VALUES
  (6, 'Requires a special lighting setup.'),
  (7, 'Needs additional sound equipment.'),
  (8, 'Requests a specific stage setup.'),
  (9, 'Requires costume changes.'),
  (10, 'Has specific prop requirements.');

INSERT INTO Task_Assigned (Task_ID, Organizer_ID, Task_Assigned)
VALUES
  (1, 1, 'Compiling votes for the menu'),
  (2, 2, 'Budgeting for the event'),
  (3, 3, 'Taking care of venue arrangements'),
  (4, 4, 'Handling decorations responsibility'),
  (5, 5, 'Providing tickets for teachers');

INSERT INTO Student_Task (Student_ID, Task_ID)
VALUES
  ('21i-0001', 1),
  ('21i-0002', 2),
  ('21i-0003', 3),
  ('21i-0004', 4),
  ('21i-0005', 5);

INSERT INTO Task_Organizer (Organizer_ID, Task_ID)
VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5);

INSERT INTO Student_Organizer (Student_ID, Organizer_ID)
VALUES
  ('21i-0001', 1),
  ('21i-0002', 2),
  ('21i-0003', 3),
  ('21i-0004', 4),
  ('21i-0005', 5);

INSERT INTO Organizer_Budget (Organizer_ID, Item_ID)
VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5);

INSERT INTO Student_Menu (Student_ID, Menu_ID)
VALUES
  ('21i-0001', 1),
  ('21i-0002', 2),
  ('21i-0003', 3),
  ('21i-0004', 4),
  ('21i-0005', 5);


# Report for Teachers
SELECT Teacher_ID, Teacher_Name, NoOfAttendingFamily, PhoneNo FROM Teacher;
SELECT t.Teacher_ID, t.Teacher_Name, a.Status
FROM Teacher t
JOIN Attendance_Teacher a ON t.Teacher_ID = a.Teacher_ID;

# Report for Students
SELECT Student_ID, Student_Name, PhoneNo, Address, Family_Attending, Email, Dietary_Preferences
FROM Student;
SELECT s.Student_ID, s.Student_Name, a.Status
FROM Student s
JOIN Attendance_Student a ON s.Student_ID = a.Student_ID;
SELECT p.Proposal_ID, s.Student_Name, p.Performance_Type, p.Votes, p.Duration
FROM Performance p
JOIN Student s ON p.Student_ID = s.Student_ID;

# Report for Organizers
SELECT Organizer_ID, Orginizer_Name, Status, Progress_Tracking
FROM Organizer;
SELECT o.Organizer_ID, o.Orginizer_Name, t.Task_Assigned
FROM Organizer o
JOIN Task_Assigned t ON o.Organizer_ID = t.Organizer_ID;
SELECT o.Organizer_ID, o.Orginizer_Name, b.Decoration, b.Venue, b.Quantity, b.Price
FROM Organizer o
JOIN Organizer_Budget ob ON o.Organizer_ID = ob.Organizer_ID
JOIN Budget_Item b ON ob.Item_ID = b.Item_ID;
SELECT Organizer_ID, Orginizer_Name, Status, Progress_Tracking
FROM Organizer;


# merging reports for the three
# tells us attendance status for both teachers and students 
SELECT 'Student' AS Attendee_Type, s.Student_ID AS ID, s.Student_Name AS Name, a.Status
FROM Student s
JOIN Attendance_Student a ON s.Student_ID = a.Student_ID
UNION
SELECT 'Teacher' AS Attendee_Type, t.Teacher_ID AS ID, t.Teacher_Name AS Name, a.Status
FROM Teacher t
JOIN Attendance_Teacher a ON t.Teacher_ID = a.Teacher_ID;

# tells us which organizer assigned what task to what student 
SELECT o.Organizer_ID, o.Orginizer_Name, t.Task_Assigned, s.Student_Name
FROM Organizer o
LEFT JOIN Task_Assigned t ON o.Organizer_ID = t.Organizer_ID
LEFT JOIN Student_Task st ON t.Task_ID = st.Task_ID
LEFT JOIN Student s ON st.Student_ID = s.Student_ID;

# tells us students details of performances and special requests
SELECT p.Proposal_ID, s.Student_Name, p.Performance_Type, p.Votes, p.Duration, sr.Special_Request
FROM Performance p
JOIN Student s ON p.Student_ID = s.Student_ID
LEFT JOIN Special_request sr ON p.Proposal_ID = sr.Proposal_ID;

# price each teacher must pay for the ticket
SELECT
    t.Teacher_ID,
    t.Teacher_Name,
    COUNT(at.Ticket_ID) AS Tickets_Bought,
    COUNT(at.Ticket_ID) * 500 AS Total_Price
FROM
    Teacher t
LEFT JOIN
    Attendance_Teacher at ON t.Teacher_ID = at.Teacher_ID
GROUP BY
    t.Teacher_ID, t.Teacher_Name;
