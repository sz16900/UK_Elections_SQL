LOAD DATA INFILE '/home/seth/CS_conversion_Spring17/Databases/Census/census/Country.csv' INTO TABLE Country FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"'
    ESCAPED BY '\\' LINES TERMINATED BY '\n'; 
LOAD DATA INFILE '/home/seth/CS_conversion_Spring17/Databases/Census/census/Region.csv' INTO TABLE Region FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"'
    ESCAPED BY '\\' LINES TERMINATED BY '\n'; 
LOAD DATA INFILE '/home/seth/CS_conversion_Spring17/Databases/Census/census/County.csv' INTO TABLE County FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"'
    ESCAPED BY '\\' LINES TERMINATED BY '\n'; 
-- The following line contains some magic to deal with NULLable FKs.
LOAD DATA INFILE '/home/seth/CS_conversion_Spring17/Databases/Census/census/Ward.csv' INTO TABLE Ward FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"'
    ESCAPED BY '\\' LINES TERMINATED BY '\n' (code, name, @parent) SET parent=nullif(@parent, ''); 
LOAD DATA INFILE '/home/seth/CS_conversion_Spring17/Databases/Census/census/Occupation.csv' INTO TABLE Occupation FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"'
    ESCAPED BY '\\' LINES TERMINATED BY '\n';
LOAD DATA INFILE '/home/seth/CS_conversion_Spring17/Databases/Census/census/Statistic.csv' INTO TABLE Statistic FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"'
    ESCAPED BY '\\' LINES TERMINATED BY '\n'; 
