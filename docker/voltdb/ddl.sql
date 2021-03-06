-- This file was generated by VoltDB version 9.2.1 on: 2020-06-22 13:42:54 GMT+00:00.
-- This file represents the current database schema.
-- Use this file as input to reproduce the current database structure in another database instance.
--
-- This file uses the --inlinebatch feature. Batching processes all of the DDL in a single step
-- dramatically reducing the time required to apply the schema compared to processing each
-- command separately.
--
-- If the schema declares Java stored procedures, be sure to load the .jar file
-- with the classes before loading the schema. For example:
--
-- LOAD CLASSES voltdb-procs.jar;
-- FILE ddl.sql;

file -inlinebatch END_OF_BATCH

CREATE TABLE ENGAGEMENT (
   TWEET_ID varchar(40) NOT NULL,
   ENGAGER_ID varchar(40) NOT NULL,
   IS_POSITIVE tinyint,
   PRIMARY KEY (TWEET_ID, ENGAGER_ID)
);

CREATE TABLE TWEET (
   ID varchar(40) NOT NULL,
   LANGUAGE varchar(40),
   CREATION_TIMESTAMP bigint,
   CREATOR varchar(40),
   PRIMARY KEY (ID)
);

CREATE TABLE USER (
   ID varchar(40) NOT NULL,
   VERIFIED tinyint,
   PRIMARY KEY (ID)
);

CREATE PROCEDURE GetTweetByIdProcedure AS
   SELECT *
   FROM tweet
   WHERE id = ?;

CREATE PROCEDURE GetTweetByLanguageProcedure AS
   SELECT *
   FROM tweet
   WHERE language = ?;

CREATE PROCEDURE GetCountEngagementGroupByLanguageProcedure AS
   SELECT t.language AS language, COUNT(*) AS c
   FROM tweet t INNER JOIN engagement e ON t.id=e.tweet_id
   GROUP BY t.language;

CREATE PROCEDURE GetTweetByTimestampIntervalProcedure AS
    SELECT *
    FROM tweet
    WHERE creation_timestamp BETWEEN ? AND ? ;

CREATE PROCEDURE InsertUser AS
    INSERT INTO user
    VALUES (?, ?);

CREATE PROCEDURE InsertTweet AS
    INSERT INTO tweet
    VALUES (?, ?, ?, ?);

CREATE PROCEDURE InsertEngagement AS
    INSERT INTO engagement
    VALUES (?, ?, ?);

END_OF_BATCH