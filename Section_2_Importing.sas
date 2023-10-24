
/* IMPORTING .txt FILES ================== */

/* DATA salary; */
/* 	INFILE "/home/u63650566/Lessons/Data/salary.txt"; */
/* 	INPUT year salary; */
/*  RUN; */




/* IMPORTING .csv FILES ================== */

/* DATA weightgain; */
/* 	INFILE "/home/u63650566/Lessons/Data/weightgain.csv" DSD MISSOVER FIRSTOBS=2; */
/* 	INPUT id source$ type$ weightg; */
/*  RUN; */

/* NOTE: DSD gets rid of extra quotation marks */
/* NOTE: DSD lists two commas in a row as a "missing value" */
/* NOTE: MISSOVER records for where there are missing values in dataset */
/* NOTE: FIRSTOBS tells SAS that our cases start on line 2 */
/* NOTE: Add $ to INPUT words when dealing with text data */




/* IMPORTING .xlsx FILES ================== */

/* PROC IMPORT DATAFILE="/home/u63650566/Lessons/Data/Sample-Sales-Data.xlsx"  */
/* 	OUT=salesdata  */
/* 	DBMS=XLSX; */
/*  RUN; */




/* REPLACE & SPECIFIC SHEET .xlsx FILES ================== */

/* PROC IMPORT DATAFILE="/home/u63650566/Lessons/Sample-Sales-Data.xlsx"  */
/* 	OUT=salesdata  */
/* 	DBMS=XLSX */
/* 	REPLACE; */
/* SHEET="Sheet1"; */
/* RUN; */

/* NOTE: REPLACE tells SAS we are overwriting the file */
/* NOTE: SHEET or RANGE specifies the sheet you want*/
/* NOTE: DELIMITER used to specify the delimiter used if one is used*/




/* OTHER STATEMENTS .xlsx FILES ================== */

/* PROC IMPORT DATAFILE="/home/u63650566/Lessons/Data/Sample-Sales-Data.xlsx"  */
/* 	OUT=salesdata  */
/* 	DBMS=XLSX */
/* 	REPLACE; */
/* 	SHEET="Sheet1"; */
/* 	GETNAMES=NO; */
/* 	MIXED=YES; */
/*  RUN; */

/* NOTE: MIXED is used if you think the data may have been recorded inconsistantly */
/* 	It tells SAS to treat this column as a string variable if it is indeed mixed data */
/*  To ensure none of the data is lost */
/* NOTE: GETNAMES is yes by default. SAS grabs the first row as variable names.*/
/* 	but if you don't want to use the first row as variable names then "no." */








