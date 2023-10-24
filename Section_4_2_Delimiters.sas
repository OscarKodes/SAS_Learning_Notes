* DELIMITERS;

* Any characters used to seperate values;
* Typically spaces by default in SAS for txt files;

* We can specify a different delimiter with DLM ;

DATA salary_dot;
	INFILE '/home/u63650566/Lessons/Data/salary_dots.txt' DLM='.';
	INPUT year salary;
RUN;

DATA salary;
	INFILE '/home/u63650566/Lessons/Data/salary.txt';
	INPUT year salary;
RUN;

