CREATE DATABASE AU_535496_DAB1
USE AU_535496_DAB1


CREATE TABLE Publishers (
    ID INT PRIMARY KEY,
    Publisher NVARCHAR (50) NOT NULL UNIQUE,
    Address NVARCHAR (50)
)
CREATE TABLE Authors (
    ID INT PRIMARY KEY,
    Author NVARCHAR (50) NOT NULL UNIQUE ,
    Address NVARCHAR (50),
    BirthDay DATE,
    Sex NVARCHAR (50),
    NetValue INT
)

CREATE TABLE Sources (
    ID INT PRIMARY KEY,
    Type NVARCHAR ( 255 ) NOT NULL CONSTRAINT source_type CHECK (Type in ('Book','Website', 'Video')),
    Title NVARCHAR(255) UNIQUE NOT NULL,
    Author NVARCHAR(50) FOREIGN KEY REFERENCES Authors(Author),
    PublishedBy NVARCHAR(50) FOREIGN KEY REFERENCES Publishers(Publisher),
    URL NVARCHAR (255),
    PublishedDate DATE,
    Category NVARCHAR(255)
)

CREATE TABLE Notes (
    NoteName NVARCHAR ( 255 ) PRIMARY KEY,
    Note NVARCHAR(255),
    Index_ NVARCHAR(50),
    Source_Title NVARCHAR(255) REFERENCES Sources(Title),
    Author NVARCHAR(50) REFERENCES Authors(Author),
)

CREATE TABLE Author_shadowtable (
    Author_ID INT FOREIGN KEY REFERENCES Authors(ID),
    Sources_ID INT FOREIGN KEY REFERENCES Sources(ID),
    CONSTRAINT author_sources UNIQUE (Author_ID,Sources_ID)
)

INSERT INTO Publishers VALUES
('1','OReilly','Lorem Ipsumroad 24, California'),
('2','Alphabet','Lorem Ipsumroad 545, San Francisco'),
('3','Falmouth University','Lorem Ipsumroad 7, Falmouth'),
('4','Bloomsbury Publishing','Lorem Ipsumroad 29, California'),
('5','Les Editions Nagel','Lorem Ipsumroad 3242, Paris'),
('6','Verlag fur Jugend und Volk','Lorem Ipsumroad 24, Vienna'),
('7','PBS','Lorem Ipsumroad 24, New York'),
('8','George Allen & Unwin','Lorem Ipsumroad 56, New York')




INSERT INTO Authors VALUES
('1','Kathy Sierra','Lorem Ipsumroad 24, California', '1957-02-14','K','438912'),
('2','Larry Page', 'Lorem Ipsumroad 84, San Francisco', '1973-03-23','M', '620000000'),
('3','Ryan Mitchell ','Lorem Ipsumroad 21, New York', '1977-01-18','M','133000'),
('4','J.R.R. Tolkien','Lorem Ipsumroad 2, Bournemouth', '1892-01-03','M','120000'),
('5','Simon Brown','Lorem Ipsumroad 9, California', '1965-06-27','M','1500000'),
('6','Viktor E. Frankl','Lorem Ipsumroad 69, Vienna', '1905-03-26','K','12'),
('7','J.K. Rowling','Lorem Ipsumroad 123, London', '1965-07-31','K','132650000'),
('8','Jean-Paul Sartre','Lorem Ipsumroad 56, Paris', '1905-06-23','M','0'),
('9','Stacy Peralta','Lorem Ipsumroad 58, California', '1950-06-18','K','1615')

INSERT INTO Sources VALUES
('1','Book','Head First Design Patterns','Kathy Sierra', 'OReilly',NULL,'2004-10-18','Non-Fiction'),
('2','Website','Google','Larry Page','Alphabet','www.google.dk','1998-09-04',NULL),
('3','Book','Web Scraping with Python','Ryan Mitchell','OReilly',NULL,'2015-04-25', 'Non-Fiction'),
('4','Website','Visualising software architecture with the C4 model','Simon Brown','Falmouth University','https://www.youtube.com/watch?v=x2-rSnhpw0g&t=985s','2019-08-16', NULL),
('5','Book','Lord of the Rings','J.R.R. Tolkien','George Allen & Unwin',NULL,'1954-07-23','Fantasy'),
('6','Book','Harry Potter','J.K. Rowling','Bloomsbury Publishing',NULL,'1997-06-26','Fantasy'),
('7','Book','Being and Nothingness','Jean-Paul Sartre','Les Editions Nagel',NULL,'1943-04-22','Philosophy'),
('8','Book','Existentialism Is a Humanism','Jean-Paul Sartre','Les Editions Nagel',NULL,'1946-10-22','Philosophy'),
('9','Book','Mans Search For Meaning: An Introduction to Logotherapy','Viktor E. Frankl','Verlag fur Jugend und Volk',NULL,'1946-02-15','Philosophy'),
('10','Video','Crips and Bloods: Made in America','Stacy Peralta','PBS',NULL,'2008-01-20','Documentary')

INSERT INTO Author_shadowtable VALUES
('1','1'),
('2','2'),
('3','3'),
('5','4'),
('4','5'),
('7','6'),
('6','9'),
('8','8'),
('8','7'),
('9','10')

INSERT INTO Notes VALUES
('Software Arch Note','The C4 model is a way of describing your software in different abstractions, and...','25', 'Visualising software architecture with the C4 model','Simon Brown'),
('Note to website','This is a good site for the upcoming exam',NULL,'Google','Larry Page'),
('Note to design patterns','The observer design pattern is...','92','Head First Design Patterns','Kathy Sierra'),
('Sartre note','If youre lonely when youre alone, youre in bad company.','105','Being and Nothingness','Jean-Paul Sartre'),
('Another Sartre note','Still, somewhere in the depths of ourselves we all harbor an ashamed, unsatisfied melancholy that quietly awaits a funeral','250','Being and Nothingness','Jean-Paul Sartre'),
('Yet another Sartre note','Man is nothing else but what he makes of himself.','26','Existentialism Is a Humanism','Jean-Paul Sartre'),
('Note to movie about gangs','The gangwars were is the 90s','24','Crips and Bloods: Made in America','Stacy Peralta'),
('Note to Harry Potter','Not worth reading',NULL,'Harry Potter','J.K. Rowling'),
('Frankel note','When we are no longer able to change a situation, we are challenged to change ourselves.','118','Mans Search For Meaning: An Introduction to Logotherapy','Viktor E. Frankl')


-- Get all books (title, authors, publisher, and date) by a category or tag
SELECT * FROM Sources Where Category = 'Non-Fiction'

-- Get all notes for a specific book (title, notes) by a title
SELECT * FROM Notes WHERE Source_Title = 'Being and Nothingness'

-- All books (title, published date, publisher, and authors) by author
SELECT * FROM Sources WHERE Author = 'Jean-Paul Sartre'
-- Same using shadow table
SELECT s.Title, s.PublishedDate, s.PublishedBy, s.Author FROM Sources AS s
WHERE s.ID IN (SELECT si.Author_ID FROM Author_shadowtable AS si WHERE si.Author_ID = 8)

-- All books (title, published date, and authors) by publisher
SELECT * FROM Sources WHERE PublishedBy = 'OReilly'

-- Show all content of the different tables
SELECT * FROM Publishers
SELECT * FROM Sources
SELECT * FROM Notes
SELECT * FROM Authors




