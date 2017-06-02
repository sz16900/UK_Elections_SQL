DROP TABLE IF EXISTS Rawdata2014;

CREATE TABLE Rawdata2014 (
    date DATE, ward VARCHAR(100),
    electorate INTEGER, candidate VARCHAR(100),
    party VARCHAR(100), votes INTEGER,
    percent DECIMAL(5,2)
);

DROP TABLE IF EXISTS Rawdata2015;

CREATE TABLE Rawdata2015 (
    date DATE, ward VARCHAR(100),
    electorate INTEGER, candidate VARCHAR(100),
    party VARCHAR(100), votes INTEGER,
    percent DECIMAL(5,2)
);

