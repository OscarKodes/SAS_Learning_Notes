
*
###############################################
LIST INPUT ####################################

	- List input rules:
		- when you "list" the variables with the INPUT statement
		- when you seperate your datalines with blank spaces
		- missing data has to be indicated with a "."
		- no strings greater than 7 characters in length
			- Otherwise it will be cut off to just 7 characters
		- if the file contains any dates (or other uncommon values)
			then list input may not be the best method
;

* Dataset to be used;
DATA sales1;
	INPUT names$ sales_1-sales_4;
	CARDS;
	Carlyololyos 17 . 40 0
	Lori 15 12 10 100
	Biancada 50 14 15 50
	Candy 22 3 5 16
	;
RUN;





*
###############################################
COLUMN INPUT ####################################

	- Column input rules:
		- Can use as long as all the values are 
			characters or standard numeric
			- Standard numeric
				Yes: integers, floats, decimals, negatives
				No: Currency with commas, percent, fractions
		- Your missing values can be left blank?
;

* Dataset to be used;
DATA sales1;
	INPUT names$ 1-6 sales_1-sales_4 7;
	CARDS;
Carly 10 2  40 0
Lori  15 12 10 100
Bianca50 14 15 50
Candy 22 3 5 16
;
RUN;





*
###############################################
FORMATTED INPUT ####################################

	- Format input rules:
		- Three types of informats:
			Character, Numeric, Dates
		- Informats give instructions to how to read the data
		
	(Example for Informats)
	- INPUT BirthDate MMDDYY10.
	
	- Informats and LENGTH are not the same!
		- Informats assign the specific type of an variable
		- Length assigns the byte limit or character limit

	(About LENGTH)
	- Without specifying character length & byte limits,
		the default lengths will be used and your data values
		can be cutoff
	
	
;

* Dataset to be used;
DATA policel;
	INFILE "/home/u63650566/Lessons/Data/londonoutcomes.csv" DSD MISSOVER FIRSTOBS=2;
	LENGTH CrimeID $25 ReportedF $25 FallsW $25 Longitude 4 Latitude 4 Location $25 LSOAC $25 LSOAN $25 OutcomeT $25;
	INPUT CrimeID$ ReportedF$ FallsW$ Longitude Latitude Location$ LSOAC$ LSOAN$ OutcomeT$;
RUN;






/*
###############################################
USER DEFINED FORMATS ####################################

	Example:
		PROC FORMAT;    
			VALUE $codetwo
		
	- PROC FORMAT to define our own formats
	- VALUE allows us to name our format
		- First $ is placed to show the data type
			- If not character type, no need $
		- Then the name of the format is specified
	
	
*/

* Dataset to be used;
DATA disease;
	INPUT diagCode$;
	DATALINES;
001
290
335
800
;
RUN;

PROC PRINT DATA=disease;
RUN;

* create new format;
PROC FORMAT;
	VALUE $codeTwo
	"001" = "Malaria"
	"290"-"349" = "Psychiatric Disorder"
	"800" = "Leg Injury";  * list the code equal to the meaning;
RUN;

* using the new format;
PROC PRINT DATA=disease;
	FORMAT diagCode $codeTwo.;
RUN;


* Below is a way to put the codes & the descriptions side by side

	SET reads in the dataset
	
	INPUT function converts character variable to a numeric variable
	PUT function converts numeric variable to character variable
	
	PUT(the_variable_we_want, the_format_to_convert_it_to.)
;

DATA diseaseReal;
	SET disease; 
	diagDesc=PUT(diagCode,$codeTwo.); 
RUN;
	
PROC PRINT DATA=diseaseReal;
RUN;












