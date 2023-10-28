*
#####################################
	SCATTERPLOT #####################
;

DATA houseprice2;
	INFILE "/home/u63650566/Lessons/Data/houseprice2.txt";
	INPUT type$ price tax;
RUN;


* 
choose a different font for visualization
	The Font Arial doesn't seem to work here.
;
/* GOPTIONS FTEXT=ARIAL; */


PROC GPLOT DATA=houseprice;
	TITLE "Price v Tax of Duplex v Single";
	SYMBOL1 VALUE=dot CV=blue;
	SYMBOL2 VALUE=square CV=red;
	PLOT tax * price = type;
RUN;








*
#####################################
	BARGRAPH #####################
;

DATA houseprice2;
	INFILE "/home/u63650566/Lessons/Data/houseprice2.txt";
	INPUT type$ price tax;
RUN;


* 
choose a different font for visualization
	The Font Arial doesn't seem to work here.
;
/* GOPTIONS FTEXT=ARIAL; */


* Vertical barchart;
PROC GCHART DATA=houseprice2;
	TITLE "Price v Tax of Duplex v Single";
	FORMAT price dollar9.;
	VBAR price tax/ GROUP=type;
	PATTERN color=yellow;
RUN;


* Horizontal barchart;
PROC GCHART DATA=houseprice2;
	TITLE "Price v Tax of Duplex v Single";
	FORMAT price dollar9.;
	HBAR price tax/ GROUP=type;
	PATTERN color=yellow;
RUN;


