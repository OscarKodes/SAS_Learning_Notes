*
########################################################
3 MAJOR STEPS IN PREDICTIVE MODELING #####################

	1) Algorithm Selection
		- Which algorithm do we want to use?
		- Do we have a dependent response variable?
			- If yes, we do supervised learning like
				logistic regression
			- If no, we do unsupervised learning like
				K-means clustering
	   	- Is the dependent variable
			- continuous or categorical?
			- 0 or 1 is binary (categorical)
			
	2) Training the model
		- Train the model on the train test
			- Learns the associations b/w
				the independent variables and the
				dependent variable
				
	3) Prediction
		- Estimate the dependent variables of the test set
			using your model
;




*
########################################################
INTUITIVE UNDERSTANDING OF LOGISTIC REGRESSION ######

	- Algorithm for binary outcome variables
	
	- Logistic Regression returns the odds ratio
		- The probability the outcome variable is true
		- or the probability y=1 (as opposed to 0)
		- The probability returned will always be somewhere
			b/w 0 and 1.
			- It can be convered to True if the probability is
				50% or above
				- And False if less than 50%
				- This leads us to classification
;





*
########################################################
PROBLEM STATEMENT / HYPOTHESIS GENERATION ######

	- Create model to classify customers as
		elegible for a loan or not eligable
	
	- Should generally not look at the testset
		- (we don't want to be biased)
;

* create a file to save data permanantly;
LIBNAME bank "/home/u63650566/";

* import train set;
DATA bank.train;
	INFILE "/home/u63650566/Lessons/Data/train.csv"
		DSD MISSOVER FIRSTOBS=2;
	INPUT loan_id$ gender$ married$ dependents$ educ$ 
		self_employed$ applicant co_applicant loan_amount
		l_amount_term credit_history property$ loan_status$;
RUN;

* import a test set;
DATA bank.test;
	INFILE "/home/u63650566/Lessons/Data/test.csv"
		DSD MISSOVER FIRSTOBS=2;
	INPUT loan_id$ gender$ married$ dependents$ educ$ 
		self_employed$ applicant co_applicant loan_amount
		l_amount_term credit_history property$ loan_status$;
RUN;

* look at the information on the dataset (data audit)
	make sure all the variables and rows imported as expected;
PROC CONTENTS DATA=bank.train;
RUN;

* Check the first 20 observations just to make sure all
	the data is as expected;
PROC PRINT DATA=bank.train (OBS=20);
RUN;


*
############################################################
UNIVARIATE ANALYSIS ########################################
;

* create a barchart to check how many people were 
	approved of loans and not approved;
PROC GCHART DATA=bank.train;
	VBAR loan_status;

* check the other categorical variables;
PROC GCHART DATA=bank.train;
	VBAR gender self_employed married credit_history;

* ordinal variables (categorical variable with rank order)
	like education level
;
PROC GCHART DATA=bank.train;
	VBAR dependents educ property;

* look at the distribution of the applicant incomes
	It seems to be skewed to the right
	- we should use /normal to normalize the data
		(make it more bellshaped so the machine learning
			can operate better)
;
PROC UNIVARIATE DATA=bank.train;
	VAR applicant; 
	HISTOGRAM /NORMAL; * create a histogram, with "normal" option;


* Below: look at applicant incomes based on education
	- first sort it by education, so SAS
		knows to group them by education
	- the boxplot will look like there are many outliers
		but in actuality it is because many of the graduates
		have higher incomes
;
PROC SORT DATA=bank.train;
	BY educ;

PROC BOXPLOT DATA=bank.train;
	PLOT applicant*educ;



*
############################################################
BIVARIATE ANALYSIS ########################################
;

* create a barchart with genders divided by loan status
	and in percentages
	
	The proportion of females that had their loans approved
	vs the proportion of males
		- result: approximately the same thing
	;
PROC GCHART DATA=bank.train;
	VBAR gender /SUBGROUP=loan_status TYPE=percent;


PROC GCHART DATA=bank.train;
	VBAR married /SUBGROUP=loan_status TYPE=percent;

*
	The proportion of each applicant income group
		that were approved seem to be the same
;
PROC GCHART DATA=bank.train;
	VBAR applicant /SUBGROUP=loan_status;

* Create new variable combining applicants with
	co_applicants incomes;
DATA app_income_and_co;
	SET bank.train;
	total_income=applicant+co_applicant;
RUN;

* modify train set;
PROC DATASETS LIBRARY=bank;
	MODIFY train;
RUN;

* create a proc format to create income bins;
PROC FORMAT;
	VALUE income_group
	  LOW -< 2750 = 'Low'
	 2750 -< 4000 = 'Average'
	 4000 -< 6000 = 'High'
	 6000 -  HIGH = 'Very High'
;

* Create a barchart of the income groups vs loan status
	- It seems the proporation of loan_status is the same
		across all income groups;
PROC GCHART DATA=bank.train;

	FORMAT applicant income_group.; * format incomes /w our bins;
	
	VBAR applicant /
		COUTLINE=black
		SUBGROUP=loan_status
	
	LEGEND=legend1
		TYPE=freq
		WIDTH=8
		MAXIS=axis1
		RAXIS=axis2
		DISCRETE;




* create income groups for coapplicants;
PROC FORMAT;
	VALUE income_group
	  LOW -< 1000 = 'Low'
	 1000 -< 3000 = 'Average'
	 3000 -< 42000 = 'High'
;

* Create a barchart of the income groups vs loan status
	- THIS TIME USE CO_APPLICANTS
	- It seems the proporation of loan_status is the same
		across all income groups;
PROC GCHART DATA=bank.train;

	FORMAT co_applicant income_group.; * format incomes /w our bins;
	
	VBAR co_applicant /
		COUTLINE=black
		SUBGROUP=loan_status
	
	LEGEND=legend1
		TYPE=freq
		WIDTH=8
		MAXIS=axis1
		RAXIS=axis2
		DISCRETE;



* using applicant and co-applicant combined;
PROC FORMAT;
	VALUE income_group
	  LOW -< 2750 = 'Low'
	 2750 -< 4000 = 'Average'
	 4000 -< 6000 = 'High'
	 6000 -  HIGH = 'Very High'
;

LEGEND1 LABEL=("Loan Status") FRAME;

AXIS2 LABEL=("Percentage" ANGLE=90)
	ORDER=(0 TO 25 BY 5)
	VALUE=("0" "20" "40" "60" "80" "100");

AXIS1 LABEL=("Applicant");

PATTERN1 V=msolid C=lightblue;
PATTERN2 V=msolid C=orange;


* TOTAL INCOME BARCHART
	people in low total income groups probably asked for
	smaller sums of money, which caused them to have 
	a higher proportion of loan approvals
;
PROC GCHART DATA=app_income_and_co;

	FORMAT total_income income_group.; * format incomes /w our bins;
	
	VBAR total_income /

	COUTLINE=black

	SUBGROUP=loan_status
	
	LEGEND=LEGEND1
		
	TYPE=FREQ
		
	WIDTH=8
		
	MAXIS=AXIS1
		
	RAXIS=AXIS2
		
	OUTSIDE=pct
		
	INSIDE=FREQ
		
	DISCRETE;



* ###########################################################
	PREPARING VARIABLES FOR MACHINE LEARNING 
	Data Prepartion / Data Cleaning####
;

DATA train_t;

	* turning loan_status into lo_status
		from "N" and "Y" to 0 and 1 for a proper binary var;
	SET bank.train(RENAME=(loan_status=l_status));
	IF l_status="N" THEN l_status=0; 
	ELSE l_status=1;
	DROP loan_status;
	lo_status=INPUT(l_status,8.); * change from character to numeric;
	DROP l_status;
	
	* removes the "+" character; 
	n_dependents=COMPRESS(dependents, "+");
	DROP dependents;
	
	* converts loan amount to logarithmic form;
	loan_Amount=LOG(loan_Amount);
	DROP loan_id;
RUN;



* EXTRA SAS CODE #############################################;

* creating the test set 
	first copying the bank.test dataset
	then modifying it just like the traint set;
data test_d;

	set bank.test;
	
	N_Dependents = compress(dependents, '+');
	drop Dependents;
	
	Loan_Amount=log(Loan_Amount);
	drop Loan_ID;

run;


/* Partition data*/

data train_d valid;

	set train_t;
	
	* just randomizing which cases from 
		traint to put into traind;
	if ranuni(7) <=.6 then output train_d; 
	else output valid;
run;








