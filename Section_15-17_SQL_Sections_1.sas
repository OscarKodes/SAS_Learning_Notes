
*
###################################################
SQL Syntax ###############################################
;

DATA employeeSales;
	INPUT empid$ fname$ payperhr salesm experience;
	DATALINES;
000123 John 80 50000 5
000124 Mary 120 75000 6
000125 Lisa 200 100000 11
000126 Joseph 70 100000 16
000131 Glenn 50 60000 1
;
RUN;


* to tell sas to start using sql;
PROC SQL;

	SELECT *
	FROM employeeSales
	WHERE payperhr BETWEEN 50 AND 100
	ORDER BY fname;

	SELECT COUNT(*) AS num_of_employees,
			payperhr
	FROM employeeSales
	GROUP BY payperhr;
	
QUIT; * tells sas to stop reading sql;








*
###################################################
SQL Assignment 1 ###############################################

	Produce output that includes all columns, 
	ordered by Avgincome with the highest incomes on top/first. 
	I also want some summary statistics (average income) 
	based on Zone, while only showing AvgIncome of 30000 or more.
;

DATA state_df;
	LENGTH state $ 25 ;
	INPUT state zone$ unemp wage crime income;
	CARDS;
Alabama S 6.0 10.75 780 27196
Arizona S 6.4 11.17 715 31293
Arkansas S 5.3 9.65 593 25565
California W 8.6 12.44 1078 35331
Colorado W 4.2 12.27 567 37833
Connecticut E 5.6 13.53 456 41097
Delaware E 4.9 13.90 686 35873
Florida S 6.6 9.97 1206 29294
Georgia S 5.2 10.35 723 31467
Idaho N 5.6 11.88 282 31536
Illinois N 5.7 12.26 960 35081
Indiana S 4.9 13.56 489 27858
Iowa N 3.7 12.47 326 33079
Kansas S 5.3 12.14 469 28322
Kentucky S 5.4 11.82 463 26595
Louisiana S 8.0 13.13 1062 25676
Maine E 7.4 11.68 126 30316
Maryland E 5.1 13.15 998 39198
Massachusetts E 6.0 12.59 805 40500
Michigan N 5.9 16.13 792 35284
Minnesota N 4.0 12.60 327 33644
Mississippi S 6.6 9.40 434 25400
Missouri N 4.9 11.78 744 30190
Montana N 5.1 12.50 178 27631
Nebraska N 2.9 10.94 339 31794
Nevada W 6.2 11.83 875 35871
New_Hampshire E 4.6 11.73 138 35245
New_Jersey E 6.8 13.38 627 42280
New_Mexico W 6.3 10.14 930 26905
New_York E 6.9 12.19 1074 31899
North_Carolina S 4.4 10.19 679 30114
North_Dakota N 3.9 10.19 82 28278
Ohio N 5.5 14.38 504 31855
Oklahoma S 5.8 11.41 635 26991
Oregon W 5.4 12.31 503 31456
Pennsylvania N 6.2 12.49 418 32066
Rhode_Island E 7.1 10.35 402 31928
South_Carolina S 6.3 9.99 1023 29846
South_Dakota N 3.3 9.19 208 29733
Tennessee S 4.8 10.51 766 28639
Texas S 6.4 11.14 762 30775
Utah W 3.7 11.26 301 35716
Vermont E 4.7 11.54 114 35802
Virginia E 4.9 11.25 372 37647
Washington E 6.4 14.42 515 33533
West_Virginia S 8.9 12.60 208 23564
Wisconsin N 4.7 12.41 264 35388
Wyoming N 5.3 11.81 286 33140
;
RUN;

PROC SQL;
	SELECT *,
		AVG(income)
	FROM state_df
	GROUP BY zone
	HAVING AVG(income) >= 30000
	ORDER BY 2 DESC;
QUIT;







*
###################################################
SQL Assignment 2 ###############################################

	Produce output that includes all columns, 
	ordered by Avgincome with the highest incomes on top/first. 
	I also want some summary statistics (average income) 
	based on Zone, while only showing AvgIncome of 30000 or more.
;

DATA states1;
	LENGTH state $ 25 ;
	INPUT state zone$ unemp;
	CARDS;
Alabama S 6.0 
Arizona S 6.4 
Arkansas S 5.3 
California W 8.6 
Colorado W 4.2 
Connecticut E 5.6 
Delaware E 4.9 
Florida S 6.6 
Georgia S 5.2 
Idaho N 5.6 
;
RUN;

DATA states2;
	LENGTH state $ 25 ;
	INPUT state wage crime income;
	CARDS;
Alabama 10.75 780 27196 
Arizona 11.17 715 31293 
Arkansas 9.65 593 25565 
California 12.44 1078 35331
Colorado 12.27 567 37833 
Connecticut 13.53 456 41097 
Delaware 13.90 686 35873
Florida 9.97 1206 29294
Georgia 10.35 723 31467
Idaho 11.88 282 31536 
;
RUN;


PROC SQL;
	SELECT s1.*,
		s2.wage,
		s2.crime,
		s2.income
	FROM states1 s1
	JOIN states2 s2
	ON s1.state = s2.state;
QUIT;







*
###################################################
SQL Create Table ###############################################
;

DATA info;
	INPUT empid$ fname$ height;
	DATALINES;
000123 John 175
000124 Mary 155
000125 Lisa 190
000126 Joseph 187
;
RUN;

DATA info2;
	INPUT empid$ weight;
	DATALINES;
000123 150
000124 120
000125 180
000126 160
;
RUN;

* Create a new SAS table from two tables using SQL;
PROC SQL;

	TITLE "Final Table";
	
	CREATE TABLE final AS
		SELECT i.empid "Employee ID" format$6.,
				fname,
				height,
				weight
		FROM info i
		JOIN info2 i2
		ON i.empid = i2.empid;

	
	SELECT *
	FROM final;
	
QUIT;


* Create table with the same columns as an existing table;
PROC SQL;
	CREATE TABLE newfinal
		LIKE final;
QUIT;


* ALTERING COLUMNS - Create a new column;
PROC SQL;
	ALTER TABLE final
	ADD bmi INT
		LABEL="BMI";
		
	SELECT *
	FROM final;
QUIT;


* ALTERING COLUMNS - Fill the new column with data;
PROC SQL;
	UPDATE final
	SET bmi = (weight / (height/2.54)**2) * 703;
	
	SELECT *
	FROM final;
QUIT;

* Change column label;
PROC SQL;
	ALTER TABLE final
	MODIFY bmi LABEL="Body Mass Index";
	
	SELECT *
	FROM final;
QUIT;





*
###################################################
SQL INSERT ROWS ###############################################

	QUERY & SET
;


* Create table with the same columns as an existing table above;
PROC SQL;
	CREATE TABLE newfinal
		LIKE final;
QUIT;

* Take cases from an existing table & put them into another table;
PROC SQL;
	INSERT INTO newfinal
	SELECT *
	FROM final;
	
	SELECT *
	FROM newfinal;
QUIT;

* manually enter row into table;
PROC SQL;
	INSERT INTO newfinal
	SET empid="000127",
		fname="Sara",
		height=175,
		weight=152;

	SELECT *
	FROM newfinal;
QUIT;

* delete record from a table;
PROC SQL;
	DELETE FROM final
	WHERE fname LIKE 'J%'; * any name that starts with J;

	SELECT *
	FROM final;
QUIT;


* manually enter multiple rows into table;
PROC SQL;
	INSERT INTO newfinal (empid, fname, height, weight)
		VALUES ("022345", "Carly", 120, 100)
		VALUES ("012146", "Anya", 120, 100)
		VALUES ("032347", "Vanessa", 120, 100)
		VALUES ("014348", "Demi", 120, 100)
		VALUES ("052549", "Winona", 120, 100);

	SELECT *
	FROM newfinal;
QUIT;


* delete columns from a table;
PROC SQL;
	ALTER TABLE newfinal
	DROP COLUMN bmi;

	SELECT *
	FROM newfinal;
QUIT;





*
###################################################
SQL ASSIGNMENT 3 ###############################################

;


DATA state_df;
	LENGTH state $ 25 ;
	INPUT state zone$ unemp wage crime income;
	CARDS;
Alabama S 6.0 10.75 780 27196
Arizona S 6.4 11.17 715 31293
Arkansas S 5.3 9.65 593 25565
California W 8.6 12.44 1078 35331
Colorado W 4.2 12.27 567 37833
Connecticut E 5.6 13.53 456 41097
Delaware E 4.9 13.90 686 35873
Florida S 6.6 9.97 1206 29294
Georgia S 5.2 10.35 723 31467
Idaho N 5.6 11.88 282 31536
Illinois N 5.7 12.26 960 35081
Indiana S 4.9 13.56 489 27858
Iowa N 3.7 12.47 326 33079
Kansas S 5.3 12.14 469 28322
Kentucky S 5.4 11.82 463 26595
Louisiana S 8.0 13.13 1062 25676
Maine E 7.4 11.68 126 30316
Maryland E 5.1 13.15 998 39198
Massachusetts E 6.0 12.59 805 40500
Michigan N 5.9 16.13 792 35284
Minnesota N 4.0 12.60 327 33644
Mississippi S 6.6 9.40 434 25400
Missouri N 4.9 11.78 744 30190
Montana N 5.1 12.50 178 27631
Nebraska N 2.9 10.94 339 31794
Nevada W 6.2 11.83 875 35871
New_Hampshire E 4.6 11.73 138 35245
New_Jersey E 6.8 13.38 627 42280
New_Mexico W 6.3 10.14 930 26905
New_York E 6.9 12.19 1074 31899
North_Carolina S 4.4 10.19 679 30114
North_Dakota N 3.9 10.19 82 28278
Ohio N 5.5 14.38 504 31855
Oklahoma S 5.8 11.41 635 26991
Oregon W 5.4 12.31 503 31456
Pennsylvania N 6.2 12.49 418 32066
Rhode_Island E 7.1 10.35 402 31928
South_Carolina S 6.3 9.99 1023 29846
South_Dakota N 3.3 9.19 208 29733
Tennessee S 4.8 10.51 766 28639
Texas S 6.4 11.14 762 30775
Utah W 3.7 11.26 301 35716
Vermont E 4.7 11.54 114 35802
Virginia E 4.9 11.25 372 37647
Washington E 6.4 14.42 515 33533
West_Virginia S 8.9 12.60 208 23564
Wisconsin N 4.7 12.41 264 35388
Wyoming N 5.3 11.81 286 33140
;
RUN;

* Create new table based on existing dataset;
PROC SQL;

	TITLE "Final Stats";
	
	CREATE TABLE finalstats AS
		SELECT *,
				CASE WHEN unemp < 3 THEN 1
					WHEN unemp < 4.5 THEN 2
					WHEN unemp < 6 THEN 3
					WHEN unemp < 7.5 THEN 4
				ELSE 5
				END AS UnemploymentR
  		FROM state_df;

	SELECT *
	FROM finalstats;
QUIT;

* ALTERING COLUMNS - Create a new column;
PROC SQL;
	ALTER TABLE finalstats
	ADD OverallCrimeRisk INT
		LABEL="OverallCrimeRisk(label)";
		
	SELECT *
	FROM finalstats;
QUIT;

* Add new column;
PROC SQL;
	UPDATE finalstats
	SET OverallCrimeRisk = UnemploymentR * crime / 100;
	
	SELECT *
	FROM finalstats;
QUIT;

* Change column label;
PROC SQL;
	ALTER TABLE finalstats
	MODIFY OverallCrimeRisk LABEL="OverallCrimeRisk(OCR)";
	
	SELECT *
	FROM finalstats;
QUIT;















