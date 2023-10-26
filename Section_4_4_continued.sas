
* 
########################################################
DO STATEMENTS WITHOUT ITERATION ########################

	In this example, SAS checks to see if the 
	IF conditional statement is filled, and then executes
	the DO statement.
;

/* DATA dataA; */
/* 	INPUT years; */
/* 	DATALINES; */
/* 4 */
/* 3 */
/* 6 */
/* 3 */
/* 9 */
/* ; */
/* RUN; */
/*  */
/* DATA dataB; */
/* 	SET dataA; * refering to an existing dataset; */
/* 	IF years > 5 THEN */
/* 		DO; */
/* 			months=years*12; */
/* 			PUT years= months= ; * printing out the data; */
/* 		END; */
/* 	ELSE yrsleft=5-years; */
/* 		PUT yrsleft= ; */
/* RUN; */




* 
########################################################
Three Methods for WHERE for SUBSETTING ########################

;

/* DATA sales; */
/* 	INPUT name$ sales_1-sales_4; */
/* 	total=SUM(sales_1, sales_2, sales_3, sales_4); */
/* 	CARDS; */
/* 		Sarah 10 2 40 0 */
/* 		Jane 15 5 10 100 */
/* 		Tina 50 10 15 50 */
/* 		Molly 20 0 5 20 */
/* 	; */
/* RUN; */


* Using WHERE with SQL ----------------------------------------
No need to print anything when using SQL;
/* PROC SQL; */
/* 	SELECT * */
/* 	FROM sales */
/* 	WHERE total > 50; */


* Using WHERE statement as a data option within parenthesis---;
/* PROC PRINT DATA=sales(WHERE=(total>50)); */
/* RUN; */

* WHERE included with DATA and PROC steps---------------------;
/* PROC PRINT DATA=sales; */
/* 	WHERE total>50; */
/* RUN; */




* 
########################################################
SORTING OBSERVATIONS ########################

;

/* DATA houseprice; */
/* 	INPUT type$ price tax; */
/* 	CARDS; */
/* 	Single 300000 0.20 */
/* 	Single 250000 0.25 */
/* 	Duplex 175000 0.15 */
/* 	; */
/* RUN; */
/*  */
/* * Simple PROC statement to PRINT the dataset; */
/* PROC PRINT DATA=houseprice; */
/* RUN; */
/*  */
/* * SORT allows us to take a dataset, sort it, */
/* 	and output it to a new dataset with the OUT statement; */
/* PROC SORT DATA=houseprice OUT=houseprice2; */
/* 	BY tax; */
/* RUN; */
/*  */
/* * Now we can print the second dataset; */
/* PROC PRINT DATA=houseprice2; */
/* RUN; */
/*  */
/* * By default SORT sorts in ascending order */
/* 	We can specify the reverse with DESCENDING; */
/* PROC SORT DATA=houseprice OUT=houseprice2; */
/* 	BY DESCENDING tax; */
/* RUN; */





* 
########################################################
MERGING DATASETS ########################

	When merging datasets:
	
	1) import both datasets in their own DATA steps
	
	2) SORT both datasets by the same criteria
	
	3) Use MERGE to combine the sorted sets by the
		same criteria
		
		* If you want DESCENDING order, just add it to each
			after the BY keyword.
;

/* DATA houseprice; */
/* 	INFILE "/home/u63650566/Lessons/Data/houseprice.txt"; */
/* 	INPUT type$ price tax; */
/* RUN; */
/*  */
/* DATA newhomes; */
/* 	INFILE "/home/u63650566/Lessons/Data/newhomes.txt"; */
/* 	INPUT type$ price tax; */
/* RUN; */
/*  */
/* PROC SORT DATA=houseprice OUT=houseprice2; */
/* 	BY DESCENDING price; */
/* RUN; */
/*  */
/* PROC SORT DATA=newhomes OUT=newhomes2; */
/* 	BY DESCENDING price; */
/* RUN; */
/*  */
/* DATA merged_homes; */
/* 	MERGE houseprice2 newhomes2; */
/* 	BY DESCENDING price; */
/* RUN; */



*
########################################################
Using SET statement to MERGE ########################

	- Make sure both dataset variables are the same
		and the same type
;

/* DATA sales1; */
/* 	INPUT name$ sales_1-sales_4; */
/* 	total=SUM(sales_1, sales_2, sales_3, sales_4); */
/* 	CARDS; */
/* 		Sarah 10 2 40 0 */
/* 		Jane 15 5 10 100 */
/* 		Tina 50 10 15 50 */
/* 		Molly 20 0 5 20 */
/* 	; */
/* RUN; */
/*  */
/* DATA sales2; */
/* 	INPUT names$ sales_1-sales_4; */
/* 	total=SUM(sales_1, sales_2, sales_3, sales_4); */
/* 	CARDS; */
/* 		Carly 17 5 40 0 */
/* 		Lori 15 12 10 100 */
/* 		Bianca 50 14 15 50 */
/* 		Candy 22 3 5 16 */
/* 	; */
/* RUN; */
/*  */
/*  */
/* DATA merge_sales; */
/* 	SET sales1 sales2(rename=(names=name)); */
/* RUN; */





*
########################################################
DATA REDUCTION ########################

	- Use DATA and SET to specify the dataset to work with
		- Use KEEP to specify the columns to include
		- Use DROP to specify the columns to not include
;

/* DATA newhomes; */
/* 	INPUT type$ price tax; */
/* 	CARDS; */
/* 	Duplex 150000 0.15 */
/* 	Duplex 160000 0.18 */
/* 	Duplex 180000 0.15 */
/* 	; */
/* RUN; */
/*  */
/* DATA reduced_new_homes; */
/* 	SET newhomes; */
/* 	KEEP type price; */
/* RUN; */
/*  */
/* DATA reduced_new_homes; */
/* 	SET newhomes; */
/* 	DROP type price; */
/* RUN; */





*
########################################################
DATA CLEANING ########################

	- RENAME allows us to rename columns
	- LABEL allows us to add descriptions to the variables
	- FREQ and TABLE allows us to create frequency tables
		for each variable
;

/* DATA newHomes; */
/* 	INPUT x$ y z; */
/* 	DATALINES; */
/* 	Duplex 150000 0.15 */
/* 	Duplex 160000 0.18 */
/* 	Duplex 180000 0.15 */
/* 	; */
/* RUN; */
/*  */
/* * RENAME to change the name of variables; */
/* DATA cleanNewHomes; */
/* 	SET newHomes; */
/* 	RENAME  */
/* 		x=type  */
/* 		y=price  */
/* 		z=tax; */
/* RUN; */
/*  */
/* 	* LABEL to add descriptions to the variables; */
/* 	DATA cleanNewHomes; */
/* 		SET cleanNewHomes; */
/* 		LABEL */
/* 			type="Type of Home"  */
/* 			price="Price of Home" */
/* 			tax="Tax Percentage of Home"; */
/* 	RUN; */
/*  */
/* 		* FREQ gets us frequency tables of the three variables; */
/* 		PROC FREQ DATA=cleanNewHomes; */
/* 			TABLE type price tax; */
/* 		RUN; */






*
########################################################
LENGTH statement ########################

	- LENGTH specifies the number of bytes for storing 
		character and numeric variables, or the number 
		of characters for storing VARCHAR variables.
	- LENGTH statement goes before INFILE 
		- can specify order of variables before the input
		
	- DSD MISSOVER assumes that a row with even a single missing value
		- This prevents the dataset from being misaligned
			where the next row's values are assumed to be the
			missing value.
			
	Example Input data:
	22
	333
	4444
	55555
	
	Missover's output:
	.
	.
	.
	55555
		
	- DSD TRUNCOVER is better than DSD MISSOVER because instead of
		assuming the entire row is a missing value, it 
		accepts what values there are for that row and
		then moves on.
			
	Example Input data:
	22
	333
	4444
	55555
	
	Truncover's output:
	22
	333
	4444
	55555
		
;

/* DATA myData1; */
/* 	LENGTH age 3 sex$ 6 bmi 8 children 3 smoker$ 3 region$ 15 charges 8; */
/* 	INFILE "/home/u63650566/Lessons/Data/insurance.csv" DSD MISSOVER FIRSTOBS=2; */
/* 	INPUT age sex$ bmi children smoker$ region$ charges; */
/* RUN; */
/*  */
/*  */
/* DATA myData2; */
/* 	LENGTH age 3 sex$ 6 bmi 8 children 3 smoker$ 3 region$ 15 charges 8; */
/* 	INFILE "/home/u63650566/Lessons/Data/insurance.csv" DSD TRUNCOVER FIRSTOBS=2; */
/* 	INPUT age sex$ bmi children smoker$ region$ charges; */
/* RUN; */



*
########################################################
COUNTING VARIABLES ########################
;

/* DATA studentScores; */
/* 	INPUT gender score; */
/* 	CARDS; */
/* 	1 48 */
/* 	1 45 */
/* 	2 50 */
/* 	2 42 */
/* 	1 41 */
/* 	2 51 */
/* 	1 52 */
/* 	1 43 */
/* 	2 52 */
/* 	; */
/* RUN; */
/*  */
/* * With no OUT statement used, the sorting */
/* 	is done directly on the original studentScores dataset; */
/* 	 */
/* PROC SORT DATA=studentScores; */
/* 	BY gender; */
/* RUN; */
/*  */
/* * first.variable_name tells sas to look at the first observation */
/* 	If we wanted the last one, we'd uses last.variable_name; */
/*  */
/* DATA studentScores1; */
/* 	SET studentScores; * Reads observations from specific dataset; */
/* 	count + 1; * Creates a variable called count, add 1 at each row; */
/* 	BY gender; * partitions the data by the different genders; */
/* 	IF first.gender THEN count=1; * if we come to the first observation of a gender's partition, then we resent the count variable to 1; */
/* RUN; */














