
*
###########################################################
INDEPENDENT SAMPLES t-TEST ################################

	Interpretting the t-Test below.
	
	Null-Hypothesis: The self-esteem of boys is not higher than girls.
	
	Hypothesis: The self-esteem of boys is higher than girls.
	(One-tailed test)
	
	First we look at the Equality of Variances table
		- It's important that the variances for the two
			groups we're coming to be equal
			- (and variances can be off especially when the
				n is not the same for both groups)
		- In the resulting table, we see our p > 0.05,
			so the Equality of Variances table tells us 
			the variances are equal.
			
	Then we look at the Satterthwaite "Unequal" p-value
		- In this case p-value=0.0167, so it is less than 0.05,
			so we can reject the null-hypothesis.
;

DATA quality_of_life;
	INFILE "/home/u63650566/Lessons/Data/qualityoflife.txt";
	INPUT socio_economic_status$ QLI;
RUN;

PROC TTEST DATA=quality_of_life;
	TITLE "Socioeconomic Status v Quality of Life";
	CLASS socio_economic_status; * independent variable;
	VAR QLI; * dependent variable;
RUN;









*
###########################################################
CHI-SQUARE TEST ################################

	Is there a statical relationship b/w gender and political party?
	
	alpha level = .05
	
	Null-Hypothesis: No relationship b/w the two variables.
	
	Alternative-Hypothesis: There is a relationship b/w the 
		two variables.
	
	Results:
		In this dataset, females seem to lean toward Republican.
		Males seem to lean more toward Independent.
		The p-value is below .05, so we can reject the null-hypothesis.
		There seems to be a statistically significant relationship
		here b/w gender and political party.
;
	

DATA political_party;
	INPUT gender$ party$ count;
	DATALINES;
male republican 100
male independent 120
male democrat 60
female republican 350
female independent 200
female democrat 90
;
RUN;

PROC FREQ DATA=political_party;
	TABLES gender * party / CHISQ;
	WEIGHT count;
RUN;


* experimenting with the numbers below;

DATA political_party2;
	INPUT gender$ party$ count;
	DATALINES;
male republican 121
male independent 102
male democrat 83
female republican 64
female independent 95
female democrat 136
;
RUN;

PROC FREQ DATA=political_party2;
	TABLES gender * party / CHISQ;
	WEIGHT count;
RUN;





