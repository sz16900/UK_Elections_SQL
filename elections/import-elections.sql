LOAD DATA INFILE '/home/seth/CS_conversion_Spring17/Databases/Census/elections/elections-2014.csv'
INTO TABLE Rawdata2014
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' ESCAPED BY '\\'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '/home/seth/CS_conversion_Spring17/Databases/Census/elections/elections-2015.csv'
INTO TABLE Rawdata2015
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' ESCAPED BY '\\'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
