*
UNDERSTANDING SAS FUNCTIONS ##############################

	A function is a component of the SAS programming language
	that can accept arguments, perform a computation 
	or other operation, and return a value.
;

* saving the results of functions into variables of a dataset;
DATA functionPractice;
	sumThis = SUM(7, 9, 13);
	varArgument = SUM(sumThis);
	numArgument = SUM(6, 8);
	expArgument = SUM(sumThis *7/2);
	varArgumentList = SUM(of var1-var5);
	dateToday = today();
RUN;

PROC PRINT DATA=functionPractice;
	FORMAT dateToday date11.;
RUN;


* 
the "&" in an INPUT statement
	tells SAS that the "name" variable value below
	still continues after spaces
		When using the "&" make sure to specify a
		character length limit like this if you want more
		variables to come after:
			LENGTH name $16
	
	Example: "Mr Ermin" is considered one value.
	
	scan(string, count)
		The scan function looks at a value with spaces,
		and it takes the part of the value that is numbered.
		
		Example: scan(name, 1)  ----> Mr
		Example: scan(name, 2)  ----> Ermin
		Example: scan(name, 1)  ----> Dedric
;
DATA splitName;
	LENGTH name $16;
	INPUT name & $;
	Prefix = scan(name, 1);
	DATALINES;
Mr Ermin Dedric 
Dr Joanna Ratner
;
RUN;






*
RAND FUNCTION ##############################

	To use the RAND function:
	
		- We first use CALL streaminit()
		to specify a "seed" 
		
		- If we don't use a "seed"
		RAND will use the specific day and
		time to randomly generate numbers
		and the results won't be reproducible
		
	With random numbers being generated from
	a normal distrubition, the more samples we
	take, the closer its histogram will look to a "normal"
	curve.
	
	RAND("Normal")
	
	RAND("Uniform")
;

* Regular SAS ------------------------------;
DATA random_data;
	CALL streaminit(12345); * set seed;
	DO i = 1 to 100; * loop for 100 iterations;
		x = RAND("Normal"); * assign X to be a random number from a normal distribution;
		OUTPUT; * display all the x values;
	END; * ends the loop;
RUN;

GOPTIONS ftext=arial; * set the graph font to arial;

PROC GCHART DATA=random_data; * use GCHART to visualize specified dataset;
	VBAR x; * VBAR creates a barchart of specified variable;
	TITLE "Random Value from N(0,1)"; * TITLE specifies title;
RUN;

PROC FREQ DATA=random_data; * Display frequency table of dataset;
RUN;


* SAS UNIVERSITY ------------------------------;

DATA random_data;
	CALL streaminit(12345);
	DO i = 1 to 100;
		x = RAND("Normal");
		OUTPUT;
	END;
RUN;

PROC SGPLOT DATA=random_data; * use SGPLOT to visualize data;
	TITLE "Random Value from N(0,1)"; * assign title;
	HISTOGRAM x; * Creates a histogram for specified dataset;
RUN;

PROC FREQ DATA=random_data;
RUN;






*
LENGTH, LENGTHN, LENGTHC FUNCTIONS ##############################

	LENGTH Returns the length of a non-blank character string, 
	excluding trailing blanks, and returns 1 for a blank character
	string.
	
	LENGTHN Returns the length of a character string, excluding 
	trailing blanks.

	LENGTHC Returns the length of a character string, 
	including trailing blanks.


	NOTE: the LENGTH statement like this is used to set the 
		character limit of incoming variables, it's different
		from the function: 
		
		LENGTH names$ 25
;

DATA lengthFunctions;
	one = "ABC   ";
	two = " "; * character missing value;
	three = "ABC   XYZ";
	length_one = LENGTH(one); * 3;
	lengthn_one = LENGTHN(one); * 3;
	lengthc_one = LENGTHC(one); * 6;
	length_two = LENGTH(two); * 1;
	lengthn_two = LENGTHN(two); * 0;
	lengthc_two = LENGTHC(two); * 1;
	length_three = LENGTH(three); * 9;
	lengthn_three = LENGTHN(three); * 9;
	lengthc_three = LENGTHC(three); * 9;
RUN;

PROC PRINT DATA=lengthFunctions;
	TITLE "Length(n)(c) Function Examples";
RUN;






*
TRIM ##############################

	Concat strings with ||
	
	TRIM Removes trailing blanks from a character string, 
	and returns one blank if the string is missing.
	
	Here TRIM is used to remove the trailing space from lastName
;

DATA trimData;
	INPUT firstName$ lastName$ age tscore;
	LENGTH name $20; * specify name character limit as 20;
	name=TRIM(lastName)||', '||firstName; * create concated variable;
	DATALINES;
Frieren Jepson 27 45
;
RUN;

PROC CONTENTS DATA=trimData;
RUN;

PROC PRINT DATA=trimData;
RUN;






*
COMPRESS ##############################

	COMPRESS Returns a character string 
	with specified characters removed from the original string.
	
	Without any characters specified, COMPRESS removes spaces
	as default.
	
	If you specify characters to remove in the second
	argument, you'll need to add a third argument "s" if you
	want to get rid of spaces as well.
	
	COMPRESS(variable_name, "characters to remove", "s")
		
;

DATA compress_data;
	INPUT phoneN$ 1-15; * the numbers here are column input;
	phone1 = COMPRESS(phoneN);
	phone2 = COMPRESS(phoneN, "(-)", "s");
	DATALINES;
(314)456-4769
(314) 453-56 78
;
RUN;

PROC PRINT DATA=compress_data;
RUN;








*
INPUT and PUT ##############################

	INPUT Returns the value that is produced when SAS converts 
	an expression using the specified informat.
	
	Format Types:
		- comma9. is numeric numbers
		- 7. is character string
		
		
	INPUT converts character variables to numeric 
	PUT converts numeric variables to character
;



* INPUT function to convert character to numeric-------;
DATA input_example;
	INPUT sale$ 9.; * 9. because the default 8 character limit wouldn't be enough;
	numSale=INPUT(sale,comma9.); * sale converted to comma9. informat;
	DATALINES;
6,515,353
;
RUN;

PROC PRINT DATA=input_example;
RUN;

PROC CONTENTS DATA=input_example;
RUN;



* PUT function to convert numeric to character-------;
DATA put_example;
	INPUT sale; * numeric;
	charSale=PUT(sale,7.); * sale converted to 7. informat;
	DATALINES;
6515353
;
RUN;

PROC PRINT DATA=put_example;
RUN;

PROC CONTENTS DATA=put_example;
RUN;








*
CATX ##############################

	CATX Removes leading and trailing blanks, 
	inserts delimiters, and returns a concatenated 
	character string.
	
	CATX(delimiter,string_1,string_2)
	
	
	CAT Does not remove leading or trailing blanks, 
	and returns a concatenated character string in order.

	CAT(string_1, string_2, string_3)
	
	
;

DATA bringItTogether;
	seperator=",";
	firstName="   Ash";
	lastName="Ketchum   ";
	result=CATX(seperator,lastName,firstName); * concats with delimiter;
	DROP seperator; * removes the variable seperator (drops the column);
RUN;

PROC PRINT DATA=bringItTogether;
RUN;



DATA bringItTogether2;
	seperator=",";
	firstName="   Ash";
	lastName="Ketchum   ";
	result=CAT(lastName,seperator,firstName); * concats all;
	DROP seperator; * removes the variable seperator (drops the column);
RUN;

PROC PRINT DATA=bringItTogether2;
RUN;








*
SCAN function ##############################

	 PROPCASE Converts all words in an argument 
	 to proper case.
	 
	 SCAN Returns the nth word from a character string.
	 
	 - Using SCAN with CATX because CATX adds a delimiter
;

DATA bringItTogether;
	seperator=",";
	firstName="   Gary";
	lastName="Oak   ";
	result=CATX(seperator,PROPCASE(lastName),PROPCASE(firstName)); 
	scanN=SCAN(result,2);
	DROP seperator; * removes the variable seperator (drops the column);
RUN;

PROC PRINT DATA=bringItTogether;
RUN;








*
COALESCE function ##############################

	 COALESCE Returns the first non-missing value 
	 from a list of numeric arguments.
	 
	 - In this example, COALESCE will check for a 
	 home number, and if there is one, that will
	 be assigned to the num_available for contacting
	 this person.
	 
	 	- If no home number is provided, COALESCE will
	 	check if there is a cell number, which will then be
	 	recorded to the num_available.
;

DATA contact_data;
	INPUT name$ home cell;
	num_available=COALESCE(home,cell);
	DATALINES;
Taylor 6578975 6448565
Britney 5555555 .
Carly . 5353535
Delia . .
Anya 1234567 7654321
;
RUN;

PROC PRINT DATA=contact_data;
RUN;








*
VERIFY function ##############################

	 VERIFY Returns the position of the first character 
	 in a string that is not in any of several other strings.
	 
	 
	 In the below example, if VERIFY returns anything all,
	 that means there is a character in variable "dna" that 
	 does not match any of the characters in "gatc"
	 
	 So then it is outputted to the "errors" data table
	 
	 Cases that do not return anything are outputted to the
	 "valid" data table
;

DATA errors valid; * two data names;
	INPUT id$ dna$ 5.; * limits to 5 characters;
	IF VERIFY(dna,"gatc") THEN OUTPUT errors;
	ELSE OUTPUT valid;
	CARDS;
001 gatcc
002 ccaad
003 gagag
004 catca
005 abcde
;
RUN;

PROC PRINT DATA=errors;
	TITLE "Error";
RUN;

PROC PRINT DATA=valid;
	TITLE "Valid";
RUN;


* Verify returns the first mismatch letter's index starting at 1
If there is no mismatch, SAS will return 0;

DATA first_mismatch_letter; 
	INPUT id$ letters$ 5.; * limits to 5 characters;
	mismatch_first=VERIFY(letters,"gatc");
	CARDS;
001 gatcc
002 ccaad
003 gagag
004 catca
005 abcde
;
RUN;

PROC PRINT DATA=first_mismatch_letter;
RUN;








*
SUBSTRING function ##############################

	SUBSTR Extracts a substring from an argument.

	SUBSTR(string_variable, start_idx, character_length)
;

DATA calendar_data;
	INPUT day_string$;
	month=SUBSTR(day_string, 3, 3);
	CARDS;
06May98
01Apr16
27Oct23
12Aug08
;
RUN;	

PROC PRINT DATA=calendar_data;
RUN;

* Use SUBSTRING to clean data -----------;

DATA calendar_data2;
	INPUT day_string$;
	SUBSTR(day_string, 6, 2) = "16"; * change all years to 2016;
	CARDS;
06May98
01Apr16
27Oct23
12Aug08
;
RUN;	

PROC PRINT DATA=calendar_data2;
RUN;

PROC PRINT DATA=calendar_data;
RUN;






















