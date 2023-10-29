*
############################################
	SIMPLE LINEAR REGRESSION ######################
	
	In the model below, p-value is below .05, so
	we can reject the null-hypothesis and say there
	is statistical singificance in the relationship
	b/w independent_var and dependent_var.
;

DATA screen_data;
	INFILE "/home/u63650566/Lessons/Data/7minscreen.csv"
		DSD MISSOVER FIRSTOBS=2;
	INPUT independent_var dependent_var;
RUN;

PROC REG DATA=screen_data;
	MODEL dependent_var = independent_var;
RUN;

* we can add the /ALL tag to get all possible calculations;
/* PROC REG DATA=screen_data; */
/* 	MODEL dependent_var=independent_var /ALL;  */
/* RUN; */








*
############################################
	MULTIPLE REGRESSION ######################
	
	In the model below, p-value is below .05 overall, so
	we can reject the null-hypothesis.
	
	indep_var2 seems to not contribute to the model
	because the p-value is above .05
	
	With an R-squared of 0.71, the model accounts for about
	70% of the variability in the dependent variable.
;

DATA screen_data2;
	INFILE "/home/u63650566/Lessons/Data/7minscreen_2.csv"
		DSD MISSOVER FIRSTOBS=2;
	INPUT indep_var1 indep_var2 dependent_var;
RUN;

PROC REG DATA=screen_data2;
	MODEL dependent_var = indep_var1 indep_var2;
RUN;


* Add STB if you want just beta coefficients;
PROC REG DATA=screen_data2;
	MODEL dependent_var = indep_var1 indep_var2 /STB;
RUN;


* Correlation Coefficient r;
PROC CORR DATA=screen_data2;
	VAR indep_var1 indep_var2 dependent_var;
RUN;



















