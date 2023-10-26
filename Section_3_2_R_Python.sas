
*
Capabilities to use R and Python in SAS. =============

This only works if you are using the desktop version of the software.
It does not work on the online version.
Unfortunately, SAS is no longer offered for free offline.

So the code below won't work on the online version.
;

OPTIONS SET = R_HOME "C:\Program Files\R\R-4.0.0"; * Wherever R is located on your computer;

OPTIONS SET = PYTHONHOME "C:\Users\Oscar\anaconda3"; * Wherever Python is located on your computer;



*
Using R code in SAS ==================
;

PROC R;

SUBMIT;

first_name <- c("Jordan", "Larry", "Sarah")
last_name <- c("Latner", "Benner", "Perri")
age <- c(27, 33, 45)

df <- data.frame(first_name, last_name, age)
print(df)

ENDSUBMIT;

RUN;



*
Using Python code in SAS ==================
;

PROC PYTHON;

SUBMIT;

import pandas as pd
import numpy as np

data = {
	"first_name": ["Jordan", "Larry", "Sarah"],
	"last_name": ["Latner", "Benner", "Perri"],
	"age": [27, 33, 45]
}

df = pd.DataFrame(data)
print(df)

ENDSUBMIT;

RUN;




*
The same code in SAS ==================
;

DATA personnel;
	INPUT first_name$ last_name$ age;
	DATALINES; * This tells SAS there we'll be providing lines of data;
	Jordan Latner 27
	Larry Benner 33
	Sarah Perri 45
	;
RUN;



















