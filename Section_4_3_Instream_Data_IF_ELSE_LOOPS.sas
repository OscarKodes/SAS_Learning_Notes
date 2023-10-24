* ###################################################### ;
* READING DATA INSTREAM #################### ;

* CARDS shows data lines will be following;


* FREE FORMATTED ---------------------------;

* Free formatted data tends to have a blank space like a delimiter;

/* DATA beer_free; */
/* 	INPUT brand$ origin$ price; */
/* 	CARDS; */
/* Budweiser USA 14.99 */
/* Heineken NED 13.99 */
/* Corona MEX 12.99 */
/* SamAdams USA 14.79 */
/* Guinness IRE 17.99 */
/* ; */
/* RUN; */


* FIXED FORMATTED ----------------------------;

* SAS seperates the data based on the given character counts;
* The counts are called column definitions;

/* DATA beer_fixed; */
/* 	INPUT brand$ 1-9 origin$ 10-12 price 13-17; */
/* 	CARDS; */
/* BudweiserUSA14.99 */
/* Heineken NED13.99 */
/* Corona   MEX12.99 */
/* SamAdams USA14.79 */
/* Guinness IRE17.99 */
/* ; */
/* RUN; */



* ###################################################### ;
* READING DATE DATA #################### ;

* "date11." Is needed for reading in date data.;

/* DATA dates; */
/* 	INPUT name$ bday date11.; */
/* 	CARDS; */
/* Eric 4 Mar 1985 */
/* Doug 15 Feb 1976 */
/* Sean 14 Jun 1975 */
/* Lisa 5 Jan 1988 */
/* ; */
/* RUN; */

* PROC PRINT prints out specific data;
* FORMAT give us the date in a specific format "date9.";

/* PROC PRINT DATA=dates;  */
/* 	FORMAT bday date9.;  */
/* RUN; */



* ###################################################### ;
* CREATING VARIABLES / CALCULATIONS ######## ;

/* DATA houseprice; */
/* 	INFILE "/home/u63650566/Lessons/Data/houseprice.txt"; */
/* 	INPUT type$ price tax; */
/* 	actual_tax_amount = ROUND(price * tax); * variable created; */
/* RUN; */


* To create a variable with instream data ---------;

/* DATA houseprice; */
/* 	INPUT type$ price tax; */
/* 	actual_tax_amount = ROUND(price * tax); * variable created; */
/* 	DATALINES; */
/* Single 300000 0.20 */
/* Single 250000 0.25 */
/* Duplex 175000 0.15 */
/* ; */
/* RUN; */



* ###################################################### ;
* MORE ON CREATING VARIABLES ######## ;

* You can name columns with iterating numbers by adding a dash;
* in between them. ;
* Like instead of "sales_1, sales_2, sales_3, sales4" ;
* We can do it as "sales_1-sales_4" ;

/* DATA sales; */
/* 	INPUT name$ sales_1-sales_4; */
/* 	total = sales_1 + sales_2 + sales_3 + sales_4; * Create variable; */
/* 	CARDS; */
/* Greg 10 2 40 0 */
/* John 15 5 10 100 */
/* Lisa 50 10 15 50 */
/* Mark 20 0 5 20 */
/* ; */
/* RUN; */

* Another way to get the sum is with SUM();

/* DATA sales; */
/* 	INPUT name$ sales_1-sales_4; */
/* 	total = SUM(sales_1, sales_2, sales_3, sales_4); */
/* 	CARDS; */
/* Greg 10 2 40 0 */
/* John 15 5 10 100 */
/* Lisa 50 10 15 50 */
/* Mark 20 0 5 20 */
/* ; */
/* RUN; */



* ###################################################### ;
* CREATING VARIABLES / CALCULATIONS ######## ;

/* DATA houseprice; */
/* 	INFILE "/home/u63650566/Lessons/Data/houseprice.txt"; */
/* 	INPUT type$ price tax; */
/* 	actual_tax_amount = ROUND(price * tax); * variable created; */
/* RUN; */


* To create a variable with instream data ---------;

/* DATA houseprice; */
/* 	INPUT type$ price tax; */
/* 	actual_tax_amount = ROUND(price * tax); * variable created; */
/* 	DATALINES; */
/* Single 300000 0.20 */
/* Single 250000 0.25 */
/* Duplex 175000 0.15 */
/* ; */
/* RUN; */



* ###################################################### ;
* AUTOMATIC VARIABLES ######## ;

* Automatic variables happen on their own in the background;
* Examples: "_Error_" and "_n_" ;

* These two automatic variables can be used to make it more;
* clear where your code is.;

* _Error_ records the number of errors

* _n_ is the line number when a PUT message is used

* PUT returns a message like console.log();

/* DATA test; */
/* 	INPUT x y; */
/* 	IF _error_ = 1 THEN */
/* 		PUT "** Error in row" _n_ " **"; */
/* 	DATALINES; */
/* 1 1 */
/* 2 3 */
/* 3 n */
/* 4 4 */
/* ; */
/* RUN; */




* ###################################################### ;
* FILTERING OBSERVATIONS ######## ;

* Importing data to work with;
/* DATA house_data; */
/* 	INFILE "/home/u63650566/Lessons/Data/houseprice.txt"; */
/* 	INPUT type$ price$ tax; */
/* RUN; */

* SET specifies which dataset to read;
* Then we can use IF statements to filter that data;

/* DATA filter; */
/* 	SET house_data;  */
/* 	IF price < 200000; */
/* RUN; */




* ###################################################### ;
* IF, ELSE ######## ;

* IF condition THEN action;
* ELSE IF condition THEN action;
* ELSE IF condition THEN action;
* ELSE action;

/* DATA sales; */
/* 	INPUT name$ sales_1-sales_4; */
/* 	total = sales_1 + sales_2 + sales_3 + sales_4; */
/* 	performance='____'; */
/* 	IF total>=100 THEN performance='good'; */
/* 		ELSE IF total>= 50 THEN performance ='fair'; */
/* 		ELSE performance = 'bad'; */
/* 	CARDS; */
/* Greg 10 2 40 0 */
/* John 15 5 10 100 */
/* Lisa 50 10 15 50 */
/* Mark 20 0 5 20 */
/* ; */
/* RUN; */




* ###################################################### ;
* FILTERING OBSERVATIONS ######## ;

* Importing data to work with;
/* DATA house_data; */
/* 	INFILE "/home/u63650566/Lessons/Data/houseprice.txt"; */
/* 	INPUT type$ price$ tax; */
/* RUN; */

* SET specifies which dataset to read;
* Then we can use IF statements to filter that data;

/* DATA filter; */
/* 	SET house_data;  */
/* 	IF price < 200000; */
/* RUN; */




* ###################################################### ;
* LOOPS -  DO LOOP - DO WHILE - DO UNTIL ######## ;

* 
DO WHILE loops only iterate when the condition is met
so it might not loop at all

DO UNTIL loops iterate at least once
and will keep going until the condition is met

WHILE executes for as long as a condition holds true,
UNTIL executes only until a certain condition holds.

OUTPUT is needed to show the variable values for each
iteration. Without OUTPUT, it only shows final variable values
;


* DO LOOP -----------------------------;

/* DATA my_data; */
/* 	DO i = 1 to 5; * How many iterations we want; */
/* 		y = i * 2; * Create variable y to hold values; */
/* 		OUTPUT;  */
/* 	END; */
/* RUN; */


/* DATA my_data; */
/* 	DO i = 1 TO 5 BY 0.5; *We can choose how much to increment; */
/* 		y = i * 2;  */
/* 		OUTPUT;  */
/* 	END; */
/* RUN; */



* DO WHILE ------------------------------;

* 
This keeps iterating until the y variable is
no longer less than 10. It will still record
the very last iteration where y becomes equal 
to or greater than 10.
;

/* DATA my_data; */
/* 	DO i = 1 TO 20 BY 2 WHILE(y < 10); */
/* 		y = i * 2;  */
/* 		OUTPUT;  */
/* 	END; */
/* RUN; */



* DO UNTIL ------------------------------;

* 
This keeps iterating until the y variable is
greater than 10. It will still record
the very last iteration where y becomes greater than 10.
;

DATA my_data;
	DO i = 1 TO 20 BY 2 UNTIL(y > 10);
		y = i * 2; 
		OUTPUT; 
	END;
RUN;



* FOR LOOP ------------------------------;

* 
Iterate over each value in a collection/set/array/list
;

DATA my_data;
	DO v = 1, 5, 9, 10, 15;
		y = v * 2; 
		OUTPUT; 
	END;
RUN;










