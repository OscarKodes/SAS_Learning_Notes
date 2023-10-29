
* 
#################################################
CASE STUDIES - HEALTH CARE ###############

	Example:
		We are a healthcare provider.
		Providing coordination of services to
		patients with issues like diabetes,
		asthma, hiv, etc.
;

* LIBNAME allows us to create a permanant dataset;
LIBNAME my_data "/home/u63650566/Lessons/Data/";

* Below we import the data;
DATA my_data.id_conditions;
	INFILE "/home/u63650566/Lessons/Data/casestudy.csv"
		DSD MISSOVER FIRSTOBS=2;
	INPUT id$ sex$ DOB pdx dx2 dx3 dx4;
	INFORMAT DOB ddmmyy10.; * tells sas how to input the data properly;
RUN;

* below we sort the data by id and save it as a new dataset;
PROC SORT OUT=my_data.id_conditions2
	DATA=my_data.id_conditions;
	BY id;
RUN;

* below we just print out the new sorted dataset;
PROC PRINT DATA=my_data.id_conditions2;
	FORMAT DOB ddmmyy10.;
RUN;


* here we create a new data table;
DATA my_data.member_conditions;

	* below we specify which dataset to work with
		the character lengths of each variable;
	SET my_data.id_conditions2;
	BY id;
	LENGTH diabetes depression COPD asthma
	CKD HIV schizophrenia hyptertension migraine $14 conditions $50;
	
	*If the same patient is in the next row, we want to accumulate their diagnosises
		in these variables;
	RETAIN diabetes depression COPD asthma CKD HIV schizophrenia 
	hyptertension migraine conditions; 

	* if new patient id, then we reset the values;
	IF FIRST.id THEN
		DO;
			diabetes = "";
			depression = "";
			COPD = "";
			asthma = "";
			CKD = "";
			HIV = "";
			hypertension = "";
			migraine = "";
		END;
	
	* create array with four variables & these names;
	ARRAY DIAG(4) pdx dx2 dx3 dx4;
		
		* look through variables in array
			replace the code values for the actual names
			of the diagnosis;
		DO i= 1 to 4;
			IF DIAG(i) IN: ("25000") THEN diabetes="diabetes";
			IF DIAG(i) IN: ("29620") THEN depression="depression";
			IF DIAG(i) IN: ("4912") THEN COPD="COPD";
			IF DIAG(i) IN: ("493") THEN asthma="asthma";
			IF DIAG(i) IN: ("40300") THEN diabetes="diabetes";
			IF DIAG(i) IN: ("042") THEN CKD="CKD";
			IF DIAG(i) IN: ("3310") THEN HIV="HIV";
			IF DIAG(i) IN: ("5723") THEN hypertension="hypertension";
			IF DIAG(i) IN: ("34631") THEN migraine="migraine";
		END;
	
	* below we count all the diagnosises a patient has
		when we reach their last row. We use SUM to total
		all the values created using "ne" which stands for
		"not equal" which will result in a value of 1 or 0.
		1 if true. 0 if false;
	IF LAST.id THEN DO;
		total_conditions=SUM(
			(diabetes ne ""),
			(depression ne ""),
			(COPD ne ""),
			(asthma ne ""),
			(diabetes ne ""),
			(CKD ne ""),
			(HIV ne ""),
			(hypertension ne ""),
			(migraine ne "")
		);
	
	* Concat all the conditions together with a comma;
	conditions = CATX(", ", diabetes, depression, COPD, asthma, CKD, HIV, schizophrenia, hypertension, migraine);
	OUTPUT;
	END;
	
	* Keep only the columns listed below;
	KEEP id sex DOB total_conditions conditions;
	RUN;
	
	* Print out this newly created table;
	PROC PRINT DATA=my_data.member_conditions;
	FORMAT DOB ddmmyy10.;
RUN;
	
	
	
	
	
	
	
	
	
	