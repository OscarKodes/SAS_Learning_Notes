*
###########################################
	EXCEPT - Compare Tables ########################

;

DATA staff1;
	INPUT empid$ fname$ salary;
	DATALINES;
000123 John 50000
000124 Mary 65000
000125 Lisa 95000
000126 Joseph 43000
;
RUN;

DATA staff2;
	INPUT empid$ fname$ salary;
	DATALINES;
000123 John 50000
000124 Mary 65000
000125 Lisa 95000
000126 Joseph 43000
000127 Glenn 60000
000128 Stephany 43000
;
RUN;


PROC SQL;
	SELECT *
	FROM staff2
	EXCEPT
	SELECT * FROM staff1;
QUIT;





*
###########################################
	DUPLICATE DATA ########################

;

DATA employees;
	INPUT empid$ fname$ salary;
	DATALINES;
000123 John 50000
000124 Mary 65000
000124 Mary 65000
000124 Mary 65000
000124 Mary 65000
000124 Mary 65000
000125 Lisa 95000
000126 Joseph 43000
000127 Glenn 60000
000128 Stephany 43000
000128 Stephany 43000
000128 Stephany 43000
;
RUN;

PROC SQL;

	TITLE "Duplicate Rows";

	SELECT COUNT(*) AS duplicate_count,
			*
	FROM employees
	GROUP BY empid, fname, salary
	HAVING COUNT(*) > 1;
RUN;


* show only distinct rows;
PROC SQL;

	TITLE "Distinct Rows";

	SELECT DISTINCT *
	FROM employees;
RUN;


*
###########################################
	CUSTOMIZING SORT (SUBQUERY) ########################

;


DATA staff;
	INPUT empid$ fname$ salary hiremonth$;
	DATALINES;
000123 John 50000 Sep-Dec
000124 Mary 65000 Jul-Aug
000125 Lisa 95000 Jul-Aug
000126 Joseph 43000 Jan-Mar
000127 Glenn 60000 Apr-Jun
;
RUN;

PROC SQL;
	TITLE "Ranking Employees by Order";
	
	SELECT empid,
			fname, 
			salary,
			hiremonth
	FROM (
		SELECT empid,
				fname,
				salary,
				hiremonth,
				CASE
					WHEN hiremonth = "Jan-Mar" THEN 1
					WHEN hiremonth = "Apr-Jun" THEN 2
					WHEN hiremonth = "Jul-Aug" THEN 3
					WHEN hiremonth = "Sep-Dec" THEN 4
					ELSE .
				END as hiremonthsort
		FROM staff
	)
	ORDER BY hiremonthsort;
RUN;









*
###########################################
	UPDATE TABLE CONDITIONALLY ########################

;

DATA df;
	INPUT empid$ fname$ wage salesm exp;
	DATALINES;
000123 John 80 50000 5
000124 Mary 120 75000 6
000125 Lisa 200 100000 11
000126 Joseph 70 100000 16
000127 Glenn 50 60000 1
;
RUN;

PROC SQL;
	TITLE "Total Pay Based on Sales/Exp";
	
	SELECT *
	FROM df;
QUIT;

PROC SQL;
	UPDATE df
	SET wage = 
		CASE
			WHEN salesm >= 100000 THEN wage + 10
			WHEN salesm >= 50000 THEN
				CASE
					WHEN exp BETWEEN 1 AND 5 THEN wage + 1
					WHEN exp BETWEEN 6 AND 10 THEN wage + 3
					WHEN exp BETWEEN 11 AND 20 THEN wage + 6
				END
			ELSE wage
		END;
	
	SELECT *
	FROM df;
QUIT;





*
###########################################
	ASSIGNMENT ########################

;


DATA my_data;
	INPUT state$ region$ unemp crime population salary;
	DATALINES;
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
Colorado W 4.2 12.27 567 37833 
Connecticut E 5.6 13.53 456 41097 
;
RUN;

PROC SQL;
	
	TITLE "Duplicate Rows";
	
	SELECT COUNT(*) as num_of_duplicates,
			*
	FROM my_data
	GROUP BY state, region, unemp, crime, population, salary
	HAVING COUNT(*) > 1;
QUIT;

PROC SQL;
	
	TITLE "All States Summary Statistics";
	
	SELECT DISTINCT
			AVG(salary) as average_income,
			MIN(salary) as min_income,
			MAX(salary) as max_income
	FROM my_data;
QUIT;

PROC SQL;
	
	TITLE "Regional Summary Statistics";
	
	SELECT DISTINCT region,
			AVG(salary) as average_income,
			MIN(salary) as min_income,
			MAX(salary) as max_income
	FROM my_data
	GROUP BY region;
QUIT;






