#!/bin/bash
# Create an import script for the census database with correct paths.
PWD=$(pwd)
cat > import-census.sql <<END
LOAD DATA INFILE '${PWD}/Country.csv' INTO TABLE Country FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"'
    ESCAPED BY '\\\\' LINES TERMINATED BY '\n'; 
LOAD DATA INFILE '${PWD}/Region.csv' INTO TABLE Region FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"'
    ESCAPED BY '\\\\' LINES TERMINATED BY '\n'; 
LOAD DATA INFILE '${PWD}/County.csv' INTO TABLE County FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"'
    ESCAPED BY '\\\\' LINES TERMINATED BY '\n'; 
-- The following line contains some magic to deal with NULLable FKs.
LOAD DATA INFILE '${PWD}/Ward.csv' INTO TABLE Ward FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"'
    ESCAPED BY '\\\\' LINES TERMINATED BY '\n' (code, name, @parent) SET parent=nullif(@parent, ''); 
LOAD DATA INFILE '${PWD}/Occupation.csv' INTO TABLE Occupation FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"'
    ESCAPED BY '\\\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE '${PWD}/Statistic.csv' INTO TABLE Statistic FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"'
    ESCAPED BY '\\\\' LINES TERMINATED BY '\n'; 
END
