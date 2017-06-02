-- The comment lines starting --! are used by the automatic testing tool to
-- help mark your coursework. You must not modify them or add further lines
-- starting with --!. Of course you can create comments of your own, just use
-- the normal -- to start them.

--! !elections!

--! TASK1

DROP TABLE IF EXISTS Candidate;
DROP TABLE IF EXISTS Ward;
DROP TABLE IF EXISTS Party;

CREATE TABLE Party (
id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
CONSTRAINT pName_unique UNIQUE (name)
);

CREATE TABLE Ward (
id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
electorate INTEGER NOT NULL,
CONSTRAINT wName_unique UNIQUE (name)
);

CREATE TABLE Candidate (
id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
party INTEGER,
ward INTEGER ,
votes INTEGER,
CONSTRAINT cName_unique UNIQUE (name),
FOREIGN KEY (party) REFERENCES Party (id),
FOREIGN KEY (ward) REFERENCES Ward (id)
);

INSERT INTO Party (name) SELECT DISTINCT Rawdata2015.party FROM Rawdata2015;
INSERT INTO Ward (name, electorate) SELECT DISTINCT Rawdata2015.ward, Rawdata2015.electorate FROM Rawdata2015;
INSERT INTO Candidate (name, party, ward, votes) SELECT DISTINCT Rawdata2015.candidate, Party.id, Ward.id,
Rawdata2015.votes FROM Rawdata2015 INNER JOIN (Party, Ward) ON (Rawdata2015.party = Party.name AND
Rawdata2015.ward = Ward.name);

-- For each part of task 2, your solution must be a single SQL statement
-- and it must come after the appropriate --! line.
-- You may of course split your SQL statement over multiple lines,
-- you may include empty lines and you may include comments of your own.

--! TASK2.1

-- solution to task 2.1 goes here; delete this line

--! TASK2.2

-- solution to task 2.2 goes here; delete this line

--! TASK2.3

-- solution to task 2.3 goes here; delete this line

--! TASK2.4

-- solution to task 2.4 goes here; delete this line

--! TASK2.5

-- solution to task 2.5 goes here; delete this line

--! !end!
