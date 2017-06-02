#!/bin/bash
# Create an import script for the elections database with correct paths.
PWD=$(pwd)
cat > import-elections.sql <<END
LOAD DATA INFILE '${PWD}/elections-2014.csv'
INTO TABLE Rawdata2014
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' ESCAPED BY '\\\\'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '${PWD}/elections-2015.csv'
INTO TABLE Rawdata2015
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' ESCAPED BY '\\\\'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
END
