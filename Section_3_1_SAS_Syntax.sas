/* SAS SYNTAX ##################################### */

/* A SAS syntax is organized into blocks of code called "Steps." */
/* Like the "Data step" or the "Proc step" */

/* SAS is not case sensitive! Capitals and lowercase are the same. */




/* DATA step NOTES ================================ */

/* The DATA step is the primary method for creating  */
/* and manipulating datasets. */

/* It is a group of SAS language statements  */
/* like INPUT, INFILE, CARDS */


DATA personnel;






/* PROC step NOTES ================================ */

/* The PROC step is used to process and analyze datasets. */
/* It can produce statistics, reports, and data visualizations. */

/* PROC is short for "procedure." */


PROC PRINT data=personnel;
	TITLE "John's Report";
 RUN;




