/*
###############################################
ARRAYS - RECODING VARIABLES ####################################

	- Arrays allows you to group all the values in a column
		- You can easily modify all the values in an ARRAY
			using DO loops
*/

DATA sixvar;
	INFILE "/home/u63650566/Lessons/Data/6var.txt";
	INPUT var1 var2 var3 var4 var5 var6;
RUN;


* 
	IF-THEN method of creating variables (Long way)
	This would take 6 statements to recode all the variables
;
DATA recode;
	SET sixvar;
	IF var2 < 5 THEN var2=.;
RUN;


*
	The array method of recoding. (Faster)
	
	ARRAY name_of_new_array(num_of_variables) variable1-variable6
	
	Use ARRAY to create the arrray, name it, 
		specify number of variables,
		specify the names of the variables
;

DATA recodeArray;
	SET sixvar;
	ARRAY recodeArr(6) var1-var6;
	DO i = 1 to 6;
		IF recodeArr(i) < 40 then recodeArr(i)=.;
	END;
RUN;

* VAR selects the specific variables to print;
PROC PRINT DATA=recodeArray;
	VAR var1-var6;
RUN;







/*
###############################################
ARRAYS - CONSTRUCTING NEW VARIABLES ####################################

	- Create entirely new variables using ARRAY
*/


DATA sixVar;
	INFILE "/home/u63650566/Lessons/Data/6var.txt";
	INPUT var1-var6;
RUN;

DATA newVar;
	SET sixVar;
	ARRAY varArr(6) var1-var6;
	ARRAY taxArr(6) tax1-tax6; 
	DO i = 1 to 6;
		taxArr(i) = varArr(i) * 0.05;
	END;
RUN;

PROC PRINT DATA=newVar;
	VAR var1-var6 tax1-tax6;
RUN;











