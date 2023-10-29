
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


