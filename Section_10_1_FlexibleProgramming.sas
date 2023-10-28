
*
#############################################################
METHODS TO IMPORT DATASETS AS ONE MERGED DATASET ############
;



* 
FILENAME with INFILE fileref =============================

	importing data with filename 
	
	adding a "*" at the end of the path name will
	
	result in all txt files being imported
;

FILENAME mon_data "/home/u63650566/Lessons/Data/mon*.txt";

DATA rolling_qr;
	INFILE mon_data DLM=",";
	INPUT customer_id$ order_id$ order_type$ : date9. delivery_date : date9.;
RUN;

PROC PRINT DATA=rolling_qr;
RUN;




* 
Using INFILE statement with FILEVAR =============================

	Import multiple files at a time using 
	
	DO loops and FILEVAR
;

DATA rolling_qr2;
	DROP i; * dropping the variable i incase it's already assigned;
	LENGTH customer_id $40 order_id 4 order_type 4 delivery_date 4;
	DO i=5 TO 7;
		next_file=CATS("/home/u63650566/Lessons/Data/mon", i, ".txt");
		INFILE ORD FILEVAR=next_file DLM="," END=LastObs;
		DO WHILE (NOT LastOBS);
			INPUT customer_id$ order_id order_type : date9. delivery_date : date9.;
			OUTPUT;
		END;
	END;
	STOP;
RUN;






* 
The MONTH Function =============================

	MONTH() is used to get the month number of a date
	TODAY() gets today's date
	
	
	
	THIS THIRD METHOD IS WEIRD AND DOES NOT WORK.
;

/* DATA rolling_qr3; */
/* 	DROP i; * dropping the variable i incase it's already assigned; */
/* 	LENGTH customer_id $40 order_id 4 order_type 4 delivery_date 4; */
/* 	mon_num = MONTH(TODAY()); */
/* 	mid_mon = mon_num - 1; */
/* 	DO i = mon_num, mid_mon, mon_last; */
/* 		next_file=CATS("/home/u63650566/Lessons/Data/mon", i, ".txt"); */
/* 		INFILE ORD FILEVAR=next_file DLM="," END=LastObs; */
/* 		DO WHILE (NOT LastOBS); */
/* 			INPUT customer_id$ order_id order_type : date9. delivery_date : date9.; */
/* 			OUTPUT; */
/* 		END; */
/* 	END; */
/* 	STOP; */
/* RUN; */






