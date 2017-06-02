-- The comment lines starting --! are used by the automatic testing tool to
-- help mark your coursework. You must not modify them or add further lines
-- starting with --!. Of course you can create comments of your own, just use
-- the normal -- to start them.

--! !elections!

--! TASK1

DROP TABLE IF EXISTS Candidate;
DROP TABLE IF EXISTS Party;
DROP TABLE IF EXISTS Ward;

CREATE TABLE Party (
        id INTEGER AUTO_INCREMENT,
        name VARCHAR(100) NOT NULL,
        PRIMARY KEY(id),
        CONSTRAINT party_name_unique UNIQUE (name)
);

CREATE TABLE Ward (
        id INTEGER AUTO_INCREMENT,
        name VARCHAR(100) NOT NULL,
        electorate INTEGER NOT NULL,
        PRIMARY KEY(id),
        CONSTRAINT ward_name_unique UNIQUE (name)
);

CREATE TABLE Candidate (
    id INTEGER AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    party INTEGER,
    ward INTEGER,
    votes INTEGER,
    FOREIGN KEY (party) REFERENCES Party(id),
    FOREIGN KEY (ward) REFERENCES Ward(id),
    PRIMARY KEY(id),
    CONSTRAINT candidate_name_unique UNIQUE (name)
);

INSERT INTO Party (name) SELECT DISTINCT party FROM Rawdata2014;
INSERT INTO Ward (name, electorate) SELECT DISTINCT ward, electorate FROM Rawdata2014;

INSERT INTO Candidate (name, party, ward, votes) SELECT candidate, Party.id, Ward.id, votes FROM
Rawdata2014
JOIN Party ON Party.name = Rawdata2014.party
JOIN Ward ON Ward.name = Rawdata2014.ward;

-- For each part of task 2, your solution must be a single SQL statement
-- and it must come after the appropriate --! line.
-- You may of course split your SQL statement over multiple lines,
-- you may include empty lines and you may include comments of your own.

--! TASK2.1

SELECT Candidate.votes AS votes FROM Candidate
JOIN
Party ON Candidate.party = Party.id
JOIN
Ward ON Candidate.ward = Ward.id
WHERE Party.name = "Liberal Democrat" AND Ward.name = "Bedminster";

--! TASK2.2

SELECT Party.name AS `party`, Candidate.votes AS `votes` FROM Candidate
JOIN
Party ON Candidate.party = Party.id
JOIN
Ward ON Candidate.ward = Ward.id
WHERE Ward.name = "Bedminster"
ORDER BY votes DESC;

--! TASK2.3

SELECT COUNT(table1.votes) AS `Labour's Vote Rank` FROM
(SELECT Candidate.votes AS votes FROM Candidate
    JOIN
    Ward ON Candidate.ward = Ward.id
    WHERE votes >=
        (SELECT Candidate.votes AS labourVotes FROM Candidate
        JOIN
        Party ON Candidate.party = Party.id
        JOIN
        Ward ON Candidate.ward = Ward.id
        WHERE Ward.name = "Southville" AND Party.name = "Labour")
    AND Ward.name = "Southville")
AS table1;

--! TASK2.4

SELECT table1.name AS `Ward Name`, ((table1.greenVotes / table2.totalVotes) * 100) AS `% of Green Votes` FROM
    (SELECT Ward.name AS name, SUM(Candidate.votes) AS totalVotes FROM Candidate
        JOIN
        Party ON Candidate.party = Party.id
        JOIN
        Ward ON Candidate.ward = Ward.id
        GROUP BY Ward.name)
    AS table2
JOIN
    (SELECT Ward.name AS name, SUM(Candidate.votes) AS greenVotes FROM Candidate
        JOIN
        Party ON Candidate.party = Party.id
        JOIN
        Ward ON Candidate.ward = Ward.id
        WHERE Party.name = "Green"
        GROUP BY Ward.name)
    AS table1
ON table1.name = table2.name;

--! TASK2.5

SELECT table1.name AS `name`, (table2.greenVotes - table1.labourVotes) AS `abs`,
((table2.greenVotes - table1.labourVotes) / table1.electorate)*100 AS rel FROM
    (SELECT Ward.name AS name, Candidate.votes AS greenVotes FROM Candidate
        JOIN
        Party ON Candidate.party = Party.id
        JOIN
        Ward ON Candidate.ward = Ward.id
        WHERE Party.name = "Green"
        GROUP BY Ward.name)
    AS table2
JOIN
    (SELECT Ward.name AS name, Candidate.votes AS labourVotes, Ward.electorate AS electorate FROM Candidate
        JOIN
        Party ON Candidate.party = Party.id
        JOIN
        Ward ON Candidate.ward = Ward.id
        WHERE Party.name = "Labour"
        GROUP BY Ward.name)
    AS table1
ON table1.name = table2.name
WHERE table2.greenVotes > table1.labourVotes;

--! !end!
