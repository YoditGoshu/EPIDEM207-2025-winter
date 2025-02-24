/*************************************************************
Name: 
Date: February 3, 2025
Topic: EPI 207 Group Project
Objective: To reproduce data
*****************************************************************/

libname g '/home/u63767022/EPI 207';


/********************************************************
******************** Cleaning Data ********************
*******************************************************/

Data g.project2;
	set g.adult (keep = AJ31 AC115 AC116_P1 SRAGE_P1 SRSEX OMBSRR_P1 SREDUC AK22_P1 WRKST_P1 MARIT UR_CLRT2 SMOKING ILLIDRUG AC117V2 
				rakedw0 rakedw1-rakedw80);
	where AC115 =1 ;
	
	if 1 <= AJ31 <= 4 then AJ31_bin = 1;
	if AJ31 = 5 then AJ31_bin = 2;
	if AJ31 = -2 then delete;		/**MISSING**/
	
	if 1 <= AJ31 <= 2 then AJ31_level = 1;
	if 3 <= AJ31 <= 4 then AJ31_level = 2;
	if AJ31 = 5 then AJ31_level = 3;
	if AJ31 = -2 then delete;			
	
	if AC116_P1=1 then AC116_bin = 1;
	if 2<= AC116_P1 <=6 then AC116_bin = 2;
	
	if 18<= SRAGE_P1 <= 34 then SRAGE_P1 = 1;
	if 35<= SRAGE_P1 <= 49 then SRAGE_P1 = 2;
	if 50<= SRAGE_P1 <= 64 then SRAGE_P1 = 3;
	if 65<= SRAGE_P1 <= 110 then SRAGE_P1 = 4;
	
	if 1<= WRKST_P1 <=3 then WRKST_P1 = 1;
	if 4<= WRKST_P1 <=5 then WRKST_P1 = 2; 
	
	if 1<= SREDUC <=2 then SREDUC = 1;
	
	if 1<= AK22_P1 <=5 then AK22_P1 =1;
	if 6<= AK22_P1 <=10 then AK22_P1 =2;
	if 11<= AK22_P1 <=19 then AK22_P1 =3;
	
	
	if OMBSRR_P1 = 1 then OMBSRR_P1 = 1;   
	if OMBSRR_P1 = 2 then OMBSRR_P1 = 2;
	if OMBSRR_P1 = 3 then OMBSRR_P1 = 3;
	if OMBSRR_P1 in (4, 6) then OMBSRR_P1 = 4;
	if OMBSRR_P1 = 5 then OMBSRR_P1 = 5;

	run;
	
proc freq data=g.project2;
tables AJ31 AJ31_bin AJ31_level AC115 AC116_P1 AC116_bin WRKST_P1 SREDUC AC117V2;
RUN;

Proc contents data = g.project2;
run;


proc format;
	value AJ31ft
		1 = 'All of the time' 
		2 = 'Most of the time'  
		3 = 'Some of the time'  
		4 = 'A little of the time'   
		5 = 'Not at all'; 
		
	value AJ31_binft
		1 = 'Any Restlessness' 
		2 = 'No restlessness';
		
	value AJ31_levelft
		1 = 'High levels of restlessness'
		2 = 'Low levels of restlessness'
		3 = 'No levels of restlessness';
		
	value AC116_P1ft
		1 = 'Past 30 days'
		2 = 'More than 1 month to a year ago'
		3 = 'More than 1 yr to 5 yrs ago'
		4 = 'More than 5 yrs to 10 yrs ago'
		5 = 'More than 10 yrs to 15 yrs ago'
		6 = 'More than 15 yrs ago';		
		
	value AC116_binft
		1 = 'Marijuana use within past month'
		2 = 'Marijuana use ever';

	value SRAGE_P1ft
        1 = '18-34'
        2 = '35-49'
        3 = '50-64'
        4 = '65+';
 
 	value SRSEXft
        1 = 'Male'
        2 = 'Female';      
        
    value OMBSRR_P1ft
    	1 = 'Hispanic or Latino'
		2 = 'Non-Hispanic White'
		3 = 'Non-Hispanic Black'
		4 = 'Non-Hispanic American Indian/Alaskan Native/Other' 
		5 = 'Non-Hispanic Asian';
	
	value SREDUCft
		1	= 'High school or less'
		3 	= 'Some college'
		4 	= 'University degree or higher';
		
	value AK22_P1ft
		1 	= 'Less than $50,000'
		2 	= '$50,000-$99,999'
		3	= 'Greater than or equal to $100,000';

	value WRKST_P1ft
		1 = 'Employed' 
		2 = 'Unemployed';
		
	value MARITft
		1 = 'Married'
		2 = 'Widowed/Divorced/Living with partner'
		3 = 'Never Married';
		
	value UR_CLRT2ft
 		1 = 'Urban' 
		2 = 'Rural';

	value Smokingft
		1 = 'Currently smokes'
		2 = 'Quit smoking'
		3 = 'Never smoked regularly';
		
	value ILLIDRUGft
		1 = 'Yes' 
		2 = 'No';
		
	value AC117V2ft
 	   -1 = 'Did not use in last 30 days' 
		1 = '0 Days' 
		2 = '1-2 Days' 
		3 = '3-5 Days' 
		4 = '6-9 Days' 
		5 = '10-19 Days' 
		6 = '20-29 Days' 
		7 = '30 Days or more';	
		

run;


/**Frequency distributions of Exposure and Outcome**/
proc freq data = g.project2 ;
tables AJ31 AJ31_bin AJ31_level AC116_P1 AC116_bin;
format AJ31 AJ31ft. AJ31_bin AJ31_binft. AJ31_level AJ31_levelft. AC116_P1 AC116_P1ft. AC116_bin AC116_binft.;
run;

/**Frequency distributions of Covariate**/
proc freq data = g.project2;
tables SRAGE_P1 SRSEX OMBSRR_P1 SREDUC AK22_P1 WRKST_P1 MARIT UR_CLRT2 SMOKING ILLIDRUG AC117V2 ;
format SRAGE_P1 SRAGE_P1ft. SRSEX SRSEXft. OMBSRR_P1 OMBSRR_P1ft. SREDUC SREDUCft. AK22_P1 AK22_P1ft. WRKST_P1 WRKST_P1ft.
		MARIT MARITft. UR_CLRT2 UR_CLRT2ft. SMOKING SMOKINGft. ILLIDRUG ILLIDRUGft. AC117V2 AC117V2ft.;
run;

Proc contents data = g.project2;
run;

/**Table 1 prep with no sample weights**/
proc freq data=g.project2;
    tables AC116_P1*AJ31_bin AC116_bin*AJ31_bin SRAGE_P1*AJ31_bin SRSEX*AJ31_bin OMBSRR_P1*AJ31_bin SREDUC*AJ31_bin AK22_P1*AJ31_bin 
    	WRKST_P1*AJ31_bin MARIT*AJ31_bin UR_CLRT2*AJ31_bin SMOKING*AJ31_bin ILLIDRUG*AJ31_bin AC117V2*AJ31_bin;
    format AC116_P1 AC116_P1ft. AC116_bin AC116_binft. SRAGE_P1 SRAGE_P1ft. aj31 aj31ft. SRSEX SRSEXft. OMBSRR_P1 OMBSRR_P1ft. SREDUC SREDUCft. AK22_P1 AK22_P1ft. WRKST_P1 WRKST_P1ft.
		MARIT MARITft. UR_CLRT2 UR_CLRT2ft. SMOKING SMOKINGft. ILLIDRUG ILLIDRUGft. AC117V2 AC117V2ft. AJ31_bin AJ31_binft.;
run;


data g.chis2020clean;
	set g.project2;
run;

proc contents data=g.chis2020clean;
run;




/********************************************************
****************** Data Dictionary *********************
*******************************************************/

proc datasets library=g;
modify chis2020clean;
	xattr set var
	
			AC115		(Values = "1 = Yes, 2= No")
			AJ31		(Values = "1 = All of the time, 2 = Most of the time, 3 = Some of the time, 4 = A little of the time, 5 = Not at all")
			AJ31_bin 	(Values = "1 = Any restlessness, 2 = No Restlessness")
			AJ31_level	(Values = "1 = High levels of restlessness, 2 = Low levels of restlessness, 3 = No levels of restlessness")
			AC116_P1 	(Values = "1 = Past 30 days, 2 = More than 1 month to a year ago, 3 = More than 1 yr to 5 yrs ago, 4 = More than 5 yrs to 10 yrs ago, 5 = More than 10 yrs to 15 yrs ago, 6 = More than 15 yrs ago")
			AC116_bin	(Values = "1 = Marijuana use within past month, 2 = Marijuana use ever")
			SRAGE_P1 	(Values = "1 = 18-34, 2 = 35-49, 3 = 50-64, 4 = 65+")
			SRSEX 		(Values = "1 = Male, 2 = Female")
			OMBSRR_P1 	(Values = "1 = Hispanic or Latino, 2 = Non-Hispanic White, 3 = Non-Hispanic Black, 4 = Non-Hispanic American Indian/Alaskan Native, 5 = Non-Hispanic Asian, 6 = Other/ Two or more races")
			SREDUC 		(Values = "1 = High school or less, 2 = Some college, 3 = University degree or higher")
			AK22_P1 	(Values = "1 = Less than $50,000; 2 = $50,000 - $99,999; 3 = Greater than or equal to $100,000")
			WRKST_P1 	(Values = "1 = Employed, 2= Unemployed")
			MARIT 		(Values = "1 = Married, 2 = Other/Separated/Divorced/Living with Partner, 3 = Never Married")
			UR_CLRT2 	(Values = "1 = Urban, 2= Rural")
			SMOKING 	(Values = "1 = Currently smokes, 2 = Quit smoking, 3 = 'Never smoked regularly")
			ILLIDRUG 	(Values = "1 = Yes, 2= No")
			AC117V2		(Values = "1 = 0 Days, 2= 1-2 Days, 3= 3-5 Days, 4= 6-9 Days, 5= 10-19 Days, 6= 20-29 Days, 7= 30 Days or more")
	;
quit;

ods output variables = varlist;
ods output ExtendedAttributesVar=exvarlist;

proc contents data=g.chis2020clean; run;	

proc sort data=exvarlist; by attributevariable; run;

proc transpose data=exvarlist out=exvarlist2;
	by attributevariable;
	id extendedattribute;
	var AttributeCharValue;
run;

proc datasets library=work;
modify exvarlist2;
	rename attributevariable = variable;
run;
quit;

proc sort data=varlist; by variable; run;
proc sort data=exvarlist2; by variable; run;

data g.datadictionary;
	merge varlist (drop=member pos num) exvarlist2(drop=_NAME_ _Label_);
	by variable;
run;

proc datasets library=g;
modify datadictionary;
	label variable = "Variable Name"
		  type = "Variable Type"
		  len = "Variable Length"
		  label = "Variable Description"
		 
		  values = "Possible Values";
run;
quit;

proc sort data=g.datadictionary;
	by variable;
run;

proc print data=g.datadictionary noobs label; run;

proc export data=g.datadictionary
	outfile = '/home/u63767022/EPI 207/Dictionary3.xlsx'
	dbms=xlsx
	replace;
run;





/********************************************************
**************** Unweighted codebook ******************
*******************************************************/


proc datasets lib=g ;
   modify chis2020clean;
     attrib _all_ format=;
run;
quit;

/***Codebook, with unweighted frequencies***/

ods excel file="/home/u63767022/EPI 207/EPI207 Assignment 2 Codebook.xlsx" options (sheet_interval="none" sheet_name="Variables of Interest");
ods noptitle;

*Macro for codebook;
%macro codebook;
%let varlist = AJ31 AJ31_bin AJ31_level AC115 AC116_P1 AC116_bin SRAGE_P1 SRSEX OMBSRR_P1 SREDUC AK22_P1 WRKST_P1 MARIT UR_CLRT2 SMOKING ILLIDRUG AC117V2;

*For the categorical variables;
%do i=1 %to %sysfunc(countw(&varlist));
%let var = %scan(&varlist, &i);

proc print data=g.datadictionary noobs;
	var variable label values;
	where variable="&var";
run;

proc freq data=g.chis2020clean;
	tables &var;
run;

%end;

*For the weighting variables;
%let vars =;
%do j=0 %to 80;
	%let vars = &vars RAKEDW&j;
%end;

%do k=1 %to %sysfunc(countw(&vars));
%let var = %scan(&vars, &k);

proc print data=g.datadictionary noobs;
	var variable label values;
	where variable="&var";
run;

proc sgplot data=g.chis2020clean;
	histogram &var;
	title "&var";
run;

%end;

%mend;

%codebook;

ods excel close;



/********************************************************
**************** Weighted codebook ******************
*******************************************************/

ods excel file="/home/u63767022/EPI 207/EPI207 Assignment 2 Codebook Weighted.xlsx" options (sheet_interval="none" sheet_name="Variables of Interest");
ods noptitle;

*macro for weighted frequencies codebook;
%macro codebookweighted;
%let varlist = AJ31 AJ31_bin AJ31_level AC115 AC116_P1 AC116_bin SRAGE_P1 SRSEX OMBSRR_P1 SREDUC AK22_P1 WRKST_P1 MARIT UR_CLRT2 SMOKING ILLIDRUG AC117V2;

*For the categorical variables;
%do i=1 %to %sysfunc(countw(&varlist));
%let var = %scan(&varlist, &i);

proc print data=g.datadictionary noobs;
	var variable label values;
	where variable="&var";
run;

proc surveyfreq data=g.chis2020clean varmethod=jackknife;
	weight rakedw0;
	repweight rakedw1-rakedw80/jkcoefs=1;
	tables &var;
run;

%end;

*For the weighting variables;
%let vars =;
%do j=0 %to 80;
	%let vars = &vars RAKEDW&j;
%end;

%do k=1 %to %sysfunc(countw(&vars));
%let var = %scan(&vars, &k);

proc print data=g.datadictionary noobs;
	var variable label values;
	where variable="&var";
run;

proc sgplot data=g.chis2020clean;
	histogram &var;
	title "&var";
run;

%end;

%mend;

%codebookweighted;

ods excel close;





/********************************************************
******************** Table 1 Macro ********************
*******************************************************/

/***Table 1 Unweighted Descriptive Statistics***/

*macro code for table 1;
%Table1(DSName=g.chis2020clean,
		GroupVar=AJ31_bin,
		NumVars=,
        FreqVars= AJ31_level AC115 AC116_P1 AC116_bin SRAGE_P1 SRSEX OMBSRR_P1 SREDUC AK22_P1 WRKST_P1 MARIT UR_CLRT2 SMOKING ILLIDRUG AC117V2,
        Mean=N,
        Median=N,
        Total=RC,
        P=N, 
        Fisher=, 
        KW=, 
        FreqCell=N(RP),
        Missing=N, 
        Print=Y,
        Dec=A,
        Sig=2,
        Label=L, 
        Out=g.table1, 
        Out1way=b);


ods excel file = "/home/u63767022/EPI 207/table1macro.xlsx";

title 'Table 1. Characteristics of the Sample Population in CHIS 2020, Unweighted (N = 12,098)';
%Table1Print(DSname=g.table1,Space=N);


ods excel close;




/***Table 1 Weighted Descriptive Statistics (alternative, not used) - Not able to use Macro***/

proc surveyfreq data=g.chis2020clean varmethod=jackknife;
	weight rakedw0;
	repweight rakedw1-rakedw80/jkcoefs=1;
	tables AJ31_bin*(AC115 AC116_P1 SRAGE_P1 SRSEX OMBSRR_P1 SREDUC AK22_P1 WRKST_P1 MARIT UR_CLRT2 SMOKING ILLIDRUG AC117V2)/row;
run;



/********************************************************
********* Figure 1: Frequency of Restlessness **********
*******************************************************/

proc freq DATA=g.chis2020clean;
  tables AJ31_bin*AC116_bin;
  title 'Frequency Distribution of Restlessness (N=12,098)';
  format AJ31_bin AJ31_binft. AC116_bin AC116_binft.;
run;

proc sgplot data=g.chis2020clean;
   vbar AJ31_bin / stat=pct datalabel group=AC116_bin groupdisplay=cluster;
   title 'Frequency Distribution of Restlessness, stratified by Marijuana use in the past month';
   format AJ31_bin AJ31_binft. AC116_bin AC116_binft.;
run;


/********************************************************
******** Figure 1: Frequency of Marijuana Usage **********
***************** In the past 30 days ******************
*******************************************************/

proc freq DATA=g.chis2020clean;
  tables AC117V2*AC116_bin ;
  title 'Frequency Distribution of Marijuana Usage in the past 30 days (N=12,098)';
  format AC117V2 AC117V2ft. AC116_bin AC116_binft.;
run;

proc sgplot data=g.chis2020clean;
   vbar AC117V2 / stat=pct datalabel group=AC116_bin groupdisplay=cluster;
   title 'Frequency Distribution of Marijuana Usage in the past 30 days, stratified by Marijuana use in the past month';
   format AC117V2 AC117V2ft. AC116_bin AC116_binft.;
run;



/********************************************************
************** Table 2 Model Analysis *****************
*******************************************************/


/*Look at frequency distribution of our exposure and outcome variables**/
proc freq data=g.chis2020clean;
	table AJ31_bin AC116_P1 AC116_bin;
	format AJ31_bin AJ31_binft. AC116_bin AC116_binft.;
run;


*Table 2 Model 1: Crude Model;
proc surveylogistic data=g.chis2020clean varmethod=jackknife;
	weight rakedw0;
	repweight rakedw1-rakedw80/JKCOEFS=1;  
	class AJ31_bin(ref="No restlessness") / param=ref;
	model AC116_bin(ref="Marijuana use ever") = AJ31_bin /clparm;
	format AC116_bin AC116_binft. AJ31_bin AJ31_binft.;
run;


*Table 2 Model 2: Only adjusting for Age and Sex;
proc surveylogistic data=g.chis2020clean varmethod=jackknife;
	weight rakedw0;
	repweight rakedw1-rakedw80/JKCOEFS=1;  
	class AJ31_bin(ref="No restlessness") SRAGE_P1 SRSEX/ param=ref;
	model AC116_bin (ref = "Marijuana use ever") = AJ31_bin SRAGE_P1 SRSEX / clparm;
	format AC116_bin AC116_binft. AJ31_bin AJ31_binft. SRAGE_P1 SRAGE_P1ft. SRSEX SRSEXft.;
run;


*Table 2 Model 3: Adjusting for all sociodemographic covariates;
proc surveylogistic data=g.chis2020clean varmethod=jackknife;
	weight rakedw0;
	repweight rakedw1-rakedw80/JKCOEFS=1;  
	class AJ31_bin(ref="No restlessness") SRAGE_P1 SRSEX OMBSRR_P1 SREDUC AK22_P1 WRKST_P1 MARIT UR_CLRT2/ param=ref;
	model AC116_bin (ref="Marijuana use ever")= AJ31_bin SRAGE_P1 SRSEX OMBSRR_P1 SREDUC AK22_P1 WRKST_P1 MARIT UR_CLRT2 / clparm;
	format AC116_bin AC116_binft. AJ31_bin AJ31_binft. SRAGE_P1 SRAGE_P1ft. SRSEX SRSEXft. OMBSRR_P1 OMBSRR_P1ft. SREDUC SREDUCft. AK22_P1 AK22_P1ft. 
		WRKST_P1 WRKST_P1ft. MARIT MARITft. UR_CLRT2 UR_CLRT2ft. ;
run;

*Table 2 Model 4: Adjusting for all sociodemographic and Behavioral covariates;
proc surveylogistic data=g.chis2020clean varmethod=jackknife;
	weight rakedw0;
	repweight rakedw1-rakedw80/JKCOEFS=1;  
	class AJ31_bin(ref="No restlessness") SRAGE_P1 SRSEX OMBSRR_P1 SREDUC AK22_P1 WRKST_P1 MARIT UR_CLRT2 AC116_bin SMOKING ILLIDRUG/ param=ref;
	model AC116_bin (ref="Marijuana use ever")= AJ31_bin SRAGE_P1 SRSEX OMBSRR_P1 SREDUC AK22_P1 WRKST_P1 MARIT UR_CLRT2 SMOKING ILLIDRUG / clparm;
format AC116_bin AC116_binft. AJ31_bin AJ31_binft. SRAGE_P1 SRAGE_P1ft. SRSEX SRSEXft. OMBSRR_P1 OMBSRR_P1ft. SREDUC SREDUCft. AK22_P1 AK22_P1ft. 
	WRKST_P1 WRKST_P1ft. MARIT MARITft. UR_CLRT2 UR_CLRT2ft. SMOKING SMOKINGft. ILLIDRUG ILLIDRUGft.;
run;






/********************************************************
************** Table 3 Model Analysis *****************
***************** Straifying by Age ********************
*******************************************************/


/*Look at frequency distribution of our exposure and outcome variables**/
proc freq data=g.chis2020clean;
	table SRAGE_P1*AJ31_bin SRAGE_P1*AC116_P1 SRAGE_P1*AC116_bin;
	format AJ31_bin AJ31_binft. AC116_bin AC116_binft. SRAGE_P1 SRAGE_P1ft.;
run;

/**Soring my dataset by age before stratifying**/
proc sort data=g.chis2020clean;
   by SRAGE_P1;
run;


*Table 3 Model 1: Crude Model;
proc surveylogistic data=g.chis2020clean varmethod=jackknife;
	by SRAGE_P1;
	weight rakedw0;
	repweight rakedw1-rakedw80/JKCOEFS=1;  
	class AJ31_bin(ref="No restlessness")/ param=ref;
	model AC116_bin(ref="Marijuana use ever") = AJ31_bin / clparm;
	format AC116_bin AC116_binft. AJ31_bin AJ31_binft. SRAGE_P1 SRAGE_P1ft.;
run;


*Table 3 Model 2: Only adjusting for Age and Sex;
proc surveylogistic data=g.chis2020clean varmethod=jackknife;
	by SRAGE_P1;
	weight rakedw0;
	repweight rakedw1-rakedw80/JKCOEFS=1;  
	class AJ31_bin(ref="No restlessness") SRSEX/ param=ref;
	model AC116_bin(ref="Marijuana use ever") = AJ31_bin SRSEX / clparm;
	format AC116_bin AC116_binft. AJ31_bin AJ31_binft. SRSEX SRSEXft. SRAGE_P1 SRAGE_P1ft.;
run;


*Table 3 Model 3: Adjusting for all sociodemographic covariates;
proc surveylogistic data=g.chis2020clean varmethod=jackknife;
	by SRAGE_P1;
	weight rakedw0;
	repweight rakedw1-rakedw80/JKCOEFS=1;  
	class AJ31_bin(ref="No restlessness") SRSEX OMBSRR_P1 SREDUC AK22_P1 WRKST_P1 MARIT UR_CLRT2/ param=ref;
	model AC116_bin(ref="Marijuana use ever") = AJ31_bin  SRSEX OMBSRR_P1 SREDUC AK22_P1 WRKST_P1 MARIT UR_CLRT2 / clparm;
	format AC116_bin AC116_binft. AJ31_bin AJ31_binft. SRAGE_P1 SRAGE_P1ft. SRSEX SRSEXft. OMBSRR_P1 OMBSRR_P1ft. SREDUC SREDUCft. AK22_P1 AK22_P1ft. 
		WRKST_P1 WRKST_P1ft. MARIT MARITft. UR_CLRT2 UR_CLRT2ft. ;
run;

*Table 3 Model 4: Adjusting for all sociodemographic and Behavioral covariates;
proc surveylogistic data=g.chis2020clean varmethod=jackknife;
	by SRAGE_P1;
	weight rakedw0;
	repweight rakedw1-rakedw80/JKCOEFS=1;  
	class AJ31_bin(ref="No restlessness") SRSEX OMBSRR_P1 SREDUC AK22_P1 WRKST_P1 MARIT UR_CLRT2 AC116_bin SMOKING ILLIDRUG/ param=ref;
	model AC116_bin (ref="Marijuana use ever")= AJ31_bin SRSEX OMBSRR_P1 SREDUC AK22_P1 WRKST_P1 MARIT UR_CLRT2 SMOKING ILLIDRUG / clparm;
format AC116_bin AC116_binft. AJ31_bin AJ31_binft. SRAGE_P1 SRAGE_P1ft. SRSEX SRSEXft. OMBSRR_P1 OMBSRR_P1ft. SREDUC SREDUCft. AK22_P1 AK22_P1ft. 
	WRKST_P1 WRKST_P1ft. MARIT MARITft. UR_CLRT2 UR_CLRT2ft. SMOKING SMOKINGft. ILLIDRUG ILLIDRUGft.;
run;





/********************************************************
************** Table 4 Model Analysis *****************
*************** Sensitivity Analysis *******************
*******************************************************/


/*Look at frequency distribution of our exposure and outcome variables**/
proc freq data=g.chis2020clean;
	table AJ31_bin AC116_P1 AC116_bin AJ31_level;
	format AJ31_bin AJ31_binft. AC116_bin AC116_binft. AJ31_level AJ31_levelft.;
run;


*Table 4 Model 1: Crude Model;
proc surveylogistic data=g.chis2020clean varmethod=jackknife;
	weight rakedw0;
	repweight rakedw1-rakedw80/JKCOEFS=1;  
	class AJ31_level(ref="No levels of restlessness") / param=ref;
	model AC116_bin(ref="Marijuana use ever") = AJ31_level /clparm;
	format AC116_bin AC116_binft. AJ31_level AJ31_levelft.;
run;


*Table 4 Model 2: Only adjusting for Age and Sex;
proc surveylogistic data=g.chis2020clean varmethod=jackknife;
	weight rakedw0;
	repweight rakedw1-rakedw80/JKCOEFS=1;  
	class AJ31_level(ref="No levels of restlessness") SRAGE_P1 SRSEX/ param=ref;
	model AC116_bin (ref = "Marijuana use ever") = AJ31_level SRAGE_P1 SRSEX / clparm;
	format AC116_bin AC116_binft. AJ31_level AJ31_levelft. SRAGE_P1 SRAGE_P1ft. SRSEX SRSEXft.;
run;


*Table 4 Model 3: Adjusting for all sociodemographic covariates;
proc surveylogistic data=g.chis2020clean varmethod=jackknife;
	weight rakedw0;
	repweight rakedw1-rakedw80/JKCOEFS=1;  
	class AJ31_level(ref="No levels of restlessness") SRAGE_P1 SRSEX OMBSRR_P1 SREDUC AK22_P1 WRKST_P1 MARIT UR_CLRT2/ param=ref;
	model AC116_bin (ref="Marijuana use ever")= AJ31_level SRAGE_P1 SRSEX OMBSRR_P1 SREDUC AK22_P1 WRKST_P1 MARIT UR_CLRT2 / clparm;
	format AC116_bin AC116_binft. AJ31_level AJ31_levelft. SRAGE_P1 SRAGE_P1ft. SRSEX SRSEXft. OMBSRR_P1 OMBSRR_P1ft. SREDUC SREDUCft. AK22_P1 AK22_P1ft. 
		WRKST_P1 WRKST_P1ft. MARIT MARITft. UR_CLRT2 UR_CLRT2ft. ;
run;

*Table 4 Model 4: Adjusting for all sociodemographic and Behavioral covariates;
proc surveylogistic data=g.chis2020clean varmethod=jackknife;
	weight rakedw0;
	repweight rakedw1-rakedw80/JKCOEFS=1;  
	class AJ31_level(ref="No levels of restlessness") SRAGE_P1 SRSEX OMBSRR_P1 SREDUC AK22_P1 WRKST_P1 MARIT UR_CLRT2 AC116_bin SMOKING ILLIDRUG/ param=ref;
	model AC116_bin (ref="Marijuana use ever")= AJ31_level SRAGE_P1 SRSEX OMBSRR_P1 SREDUC AK22_P1 WRKST_P1 MARIT UR_CLRT2 SMOKING ILLIDRUG / clparm;
format AC116_bin AC116_binft. AJ31_level AJ31_levelft. SRAGE_P1 SRAGE_P1ft. SRSEX SRSEXft. OMBSRR_P1 OMBSRR_P1ft. SREDUC SREDUCft. AK22_P1 AK22_P1ft. 
	WRKST_P1 WRKST_P1ft. MARIT MARITft. UR_CLRT2 UR_CLRT2ft. SMOKING SMOKINGft. ILLIDRUG ILLIDRUGft.;
run;

