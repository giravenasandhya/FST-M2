-- Load input file from HDFS
inputFile = LOAD 'hdfs:///user/denisha/input.txt' AS (lines:chararray);
-- Tokenize each word in the file (Map)
words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(lines)) AS word;
-- Combine the words from the above stage
grpd = GROUP words BY word;
-- Count the occurence of each word (Reduce)
totalCount = FOREACH grpd GENERATE $0 AS word, COUNT($1) AS no_of_words;

rmf hdfs:///user/denisha/PigOutput1;
-- Store the result in HDFS
STORE totalCount INTO 'hdfs:///user/denisha/PigOutput1';
