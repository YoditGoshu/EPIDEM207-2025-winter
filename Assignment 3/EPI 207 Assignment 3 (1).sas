/*************************************************************
Name: Anonymous
Date: February 28, 2025
Topic: EPI 207 Individual Project 3
Objective: To reproduce data
*****************************************************************/

libname g '/home/u63767022/EPI 207 PROJECT 3';


/********************************************************
******************** Cleaning Data ********************
*******************************************************/

Data g.project3;
	set g.adult (keep= SRAGE_P1 OMBSRR_P1 SRSEX MARIT SPK_ENG SREDUC POVLL UR_CLRT4 AF113 AM183 AM19 AM20 AM21 AK28 AM39 AF112 rakedw0 rakedw1-rakedw80);

	if 18<= SRAGE_P1 <= 29 then SRAGE_P1 = 1;
	if 30<= SRAGE_P1 <= 39 then SRAGE_P1 = 2;
	if 40<= SRAGE_P1 <= 49 then SRAGE_P1 = 3;
	if 50<= SRAGE_P1 <= 64 then SRAGE_P1 = 4;
	if SRAGE_P1 >= 65 then SRAGE_P1 = 5;
	
	where AF112 in (1, 2);
	
run;

proc contents data=g.project3;
run;


Proc format;
value SRAGE_P1ft
        1 					  = '18-29'
        2 					  = '30-39'
        3 					  = '40-49'
        4 					  = '50-64'
        5 					  = '65+';
        
VALUE  OMBSRR_P1ft
       -9                     = "NOT ASCERTAINED"
       -8                     = "DON'T KNOW"
       -7                     = "REFUSED"
       -5                     = "ADULT/HOUSEHOLD INFO NOT COLLECTED"
       -2                     = "PROXY SKIPPED"
       -1                     = "INAPPLICABLE"
       1                      = "HISPANIC"
       2                      = "WHITE, NON-HISPANIC (NH)"
       3                      = "AFRICAN AMERICAN ONLY, NOT HISPANIC"
       4                      = "AMERICAN INDIAN/ALASKAN NATIVE ONLY, NH"
       5                      = "ASIAN ONLY, NH"
       6                      = "OTHER/TWO OR MORE RACES";
       
value SRSEXft
        1 					  = 'Male'
        2 					  = 'Female';  
        
value MARITft
		1 					  = 'Married'
		2 					  = 'Widowed/Divorced/Living with partner'
		3 					  = 'Never Married';

VALUE  SPK_ENGft
       -9                     = "NOT ASCERTAINED"
       1                      = "SPEAK ONLY ENGLISH"
       2                      = "VERY WELL/WELL"
       3                      = "NOT WELL/NOT AT ALL";
       
VALUE  SREDUCft
       0                      = "< 18 YRS OLD"
       1                      = "< HIGH SCHOOL EDUCATION"
       2                      = "HIGH SCHOOL EDUCATION"
       3                      = "SOME COLLEGE"
       4                      = "COLLEGE DEGREE OR ABOVE";
       
VALUE  POVLLft
       1                      = "0-99% FPL"
       2                      = "100-199% FPL"
       3                      = "200-299% FPL"
       4                      = "300% FPL AND ABOVE";
       
       
VALUE  UR_CLRT4ft
       -9                     = "NOT ASCERTAINED"
       -8                     = "DON'T KNOW"
       -7                     = "REFUSED"
       -5                     = "ADULT/HOUSEHOLD INFO NOT COLLECTED"
       -2                     = "PROXY SKIPPED"
       -1                     = "INAPPLICABLE"
       1                      = "URBAN"
       2                      = "MIXED"
       3                      = "SUBURBAN"
       4                      = "RURAL";      
       
VALUE  YESNO
       -9                     = "NOT ASCERTAINED"
       -8                     = "DON'T KNOW"
       -7                     = "REFUSED"
       -5                     = "ADULT/HOUSEHOLD INFO NOT COLLECTED"
       -2                     = "PROXY SKIPPED"
       -1                     = "INAPPLICABLE"
       1                      = "YES"
       2                      = "NO";      
       
VALUE  AM183ft
       -9                     = "NOT ASCERTAINED"
       -8                     = "DON'T KNOW"
       -7                     = "REFUSED"
       -5                     = "ADULT/HOUSEHOLD INFO NOT COLLECTED"
       -2                     = "PROXY SKIPPED"
       -1                     = "INAPPLICABLE"
       1                      = "VERY STABLE"
       2                      = "FAIRLY STABLE"
       3                      = "SOMEWHAT STABLE"
       4                      = "FAIRLY UNSTABLE"
       5                      = "VERY UNSTABLE";
      
       
VALUE  AGREE
       -9                     = "NOT ASCERTAINED"
       -8                     = "DON'T KNOW"
       -7                     = "REFUSED"
       -2                     = "PROXY SKIPPED"
       -1                     = "INAPPLICABLE"
       1                      = "STRONGLY AGREE"
       2                      = "AGREE"
       3                      = "DISAGREE"
       4                      = "STRONGLY DISAGREE";
       
VALUE  AK28ft
       -9                     = "NOT ASCERTAINED"
       -8                     = "DON'T KNOW"
       -7                     = "REFUSED"
       -2                     = "PROXY SKIPPED"
       -1                     = "INAPPLICABLE"
       1                      = "ALL OF THE TIME"
       2                      = "MOST OF THE TIME"
       3                      = "SOME OF THE TIME"
       4                      = "NONE OF THE TIME";       
run;      
       

Data g.project3;
	set g.project3;
	
format SRAGE_P1 SRAGE_P1ft. OMBSRR_P1 OMBSRR_P1ft. SRSEX SRSEXft. MARIT MARITft. SPK_ENG SPK_ENGft. SREDUC SREDUCft. POVLL POVLLft.
		UR_CLRT4 UR_CLRT4ft. AF113 YESNO. AM183 AM183ft. AM19 AGREE. AM20 AGREE. AM21 AGREE. AK28 AK28ft. AM39 YESNO. AF112 YESNO.;
run;


proc freq data=g.project3;
tables
SRAGE_P1*AF112 
OMBSRR_P1*AF112 
SRSEX*AF112 
MARIT*AF112 
SPK_ENG*AF112 
SREDUC*AF112 
POVLL*AF112 
UR_CLRT4*AF112 
AF113*AF112 
AM183*AF112 
AM19*AF112 
AM20*AF112 
AM21*AF112 
AK28*AF112 
AM39*AF112;
format SRAGE_P1 SRAGE_P1ft. OMBSRR_P1 OMBSRR_P1ft. SRSEX SRSEXft. MARIT MARITft. SPK_ENG SPK_ENGft. SREDUC SREDUCft. POVLL POVLLft.
		UR_CLRT4 UR_CLRT4ft. AF113 YESNO. AM183 AM183ft. AM19 AGREE. AM20 AGREE. AM21 AGREE. AK28 AK28ft. AM39 YESNO. AF112 YESNO.;
run;


/********************************************************
******************** Table 1 Macro ********************
*******************************************************/

/***Table 1 Unweighted Descriptive Statistics***/

*macro code for table 1;
%Table1(DSName=g.project3,
		GroupVar=AF112,
		NumVars=,
        FreqVars= SRAGE_P1 OMBSRR_P1 SRSEX MARIT SPK_ENG SREDUC POVLL UR_CLRT4 AF113 AM183 AM19 AM20 AM21 AK28 AM39,
        Mean=N,
        Median=N,
        Total=N,
        P=N, 
        Fisher=, 
        KW=, 
        FreqCell=N(CP),
        Missing=N, 
        Print=Y,
        Dec=A,
        Sig=2,
        Label=L, 
        Out=g.table1, 
        Out1way=);


ods excel file = "/home/u63767022/EPI 207 PROJECT 3/table1macro.xlsx";

title 'Table 1. Characteristics of the Sample Population in CHIS 2021, Unweighted (N = 12,955)';
%Table1Print(DSname=g.table1,Space=N);


ods excel close;



/********************************************************
************** Table 2 Model Analysis *****************
************** Unadjusted OR models ******************
*******************************************************/

proc freq data=g.project3;
	table AF112 AM19 AM20 AM21 AK28 AM39 ;
	format AM19 AGREE. AM20 AGREE. AM21 AGREE. AK28 AK28ft. AM39 YESNO. AF112 YESNO.;
run;


*Table 2 Model 0: Unadjusted Model [#1.PEOPLE IN NEIGHBORHOOD WILLING TO HELP EACH OTHER] ;
proc surveylogistic data=g.project3 varmethod=jackknife;
	weight rakedw0;
	repweights rakedw1-rakedw80/JKCOEFS=1;  
	class AM19(ref="STRONGLY DISAGREE") / param=ref;
	model AF112(ref="NO") = AM19 /clparm;
	format AF112 YESNO. AM19 AGREE.;
run;

*Table 2 Model 0: Unadjusted Model [#2.PEOPLE IN NEIGHBORHOOD CAN BE TRUSTED] ;
proc surveylogistic data=g.project3 varmethod=jackknife;
	weight rakedw0;
	repweights rakedw1-rakedw80/JKCOEFS=1;  
	class AM21(ref="STRONGLY DISAGREE") / param=ref;
	model AF112(ref="NO") = AM21 /clparm;
	format AF112 YESNO. AM21 AGREE.;
run;


*Table 2 Model 0: Unadjusted Model [#3.HOW OFTEN FEEL SAFE IN NEIGHBORHOOD] ;
proc surveylogistic data=g.project3 varmethod=jackknife;
	weight rakedw0;
	repweights rakedw1-rakedw80/JKCOEFS=1;  
	class AK28(ref="NONE OF THE TIME") / param=ref;
	model AF112(ref="NO") = AK28 /clparm;
	format AF112 YESNO. AK28 AK28ft.;
run;

*Table 2 Model 0: Unadjusted Model [#4.VOLUNTEER IN ORG DEALING W/COMM PROB PAST YR] ;
proc surveylogistic data=g.project3 varmethod=jackknife;
	weight rakedw0;
	repweights rakedw1-rakedw80/JKCOEFS=1;  
	class AM39(ref="NO") / param=ref;
	model AF112(ref="NO") = AM39 /clparm;
	format AF112 YESNO. AM39 YESNO.;
run;


*Table 2 Model 0: Unadjusted Model [#5.PEOPLE IN NEIGHBORHOOD DO NOT GET ALONG] ;
proc surveylogistic data=g.project3 varmethod=jackknife;
	weight rakedw0;
	repweights rakedw1-rakedw80/JKCOEFS=1;  
	class AM20(ref="STRONGLY DISAGREE") / param=ref;
	model AF112(ref="NO") = AM20 /clparm;
	format AF112 YESNO. AM20 AGREE.;
run;





/********************************************************
************** Table 2 Model Analysis *****************
************** Adjusted OR model 1 ******************
*******************************************************/

*Table 2 Model 1: Unadjusted Model [#1.PEOPLE IN NEIGHBORHOOD WILLING TO HELP EACH OTHER] ;
proc surveylogistic data=g.project3 varmethod=jackknife;
	weight rakedw0;
	repweights rakedw1-rakedw80/JKCOEFS=1;  
	class AM19(ref="STRONGLY DISAGREE") 
		SRAGE_P1 (REF = "65+")
		OMBSRR_P1 (REF = "WHITE, NON-HISPANIC (NH)")
		SRSEX (REF = "Male")
		MARIT (REF = "Married")
		SPK_ENG (REF = "NOT WELL/NOT AT ALL")
		SREDUC (REF = "HIGH SCHOOL EDUCATION")
		POVLL (REF = "0-99% FPL")
		UR_CLRT4 (REF = "URBAN")
		AF113 (REF = "NO")
		AM183 (REF = "VERY STABLE")	/ param=ref;
	model AF112(ref="NO") = AM19 SRAGE_P1 OMBSRR_P1 SRSEX MARIT SPK_ENG SREDUC POVLL UR_CLRT4 AF113 AM183 /clparm;
	format AF112 YESNO. AM19 AGREE. SRAGE_P1 SRAGE_P1ft. OMBSRR_P1 OMBSRR_P1ft. SRSEX SRSEXft. MARIT MARITft. SPK_ENG SPK_ENGft. SREDUC SREDUCft. POVLL POVLLft.
		UR_CLRT4 UR_CLRT4ft. AF113 YESNO. AM183 AM183ft.;
run;

*Table 2 Model 1: Unadjusted Model [#2.PEOPLE IN NEIGHBORHOOD CAN BE TRUSTED] ;
proc surveylogistic data=g.project3 varmethod=jackknife;
	weight rakedw0;
	repweights rakedw1-rakedw80/JKCOEFS=1;  
	class AM21(ref="STRONGLY DISAGREE") 
		SRAGE_P1 (REF = "65+")
		OMBSRR_P1 (REF = "WHITE, NON-HISPANIC (NH)")
		SRSEX (REF = "Male")
		MARIT (REF = "Married")
		SPK_ENG (REF = "NOT WELL/NOT AT ALL")
		SREDUC (REF = "HIGH SCHOOL EDUCATION")
		POVLL (REF = "0-99% FPL")
		UR_CLRT4 (REF = "URBAN")
		AF113 (REF = "NO")
		AM183 (REF = "VERY STABLE")/ param=ref;
	model AF112(ref="NO") = AM21 SRAGE_P1 OMBSRR_P1 SRSEX MARIT SPK_ENG SREDUC POVLL UR_CLRT4 AF113 AM183 /clparm;
	format AF112 YESNO. AM21 AGREE. SRAGE_P1 SRAGE_P1ft. OMBSRR_P1 OMBSRR_P1ft. SRSEX SRSEXft. MARIT MARITft. SPK_ENG SPK_ENGft. SREDUC SREDUCft. POVLL POVLLft.
		UR_CLRT4 UR_CLRT4ft. AF113 YESNO. AM183 AM183ft.;
run;


*Table 2 Model 1: Unadjusted Model [#3.HOW OFTEN FEEL SAFE IN NEIGHBORHOOD] ;
proc surveylogistic data=g.project3 varmethod=jackknife;
	weight rakedw0;
	repweights rakedw1-rakedw80/JKCOEFS=1;  
	class AK28(ref="NONE OF THE TIME")
		SRAGE_P1 (REF = "65+")
		OMBSRR_P1 (REF = "WHITE, NON-HISPANIC (NH)")
		SRSEX (REF = "Male")
		MARIT (REF = "Married")
		SPK_ENG (REF = "NOT WELL/NOT AT ALL")
		SREDUC (REF = "HIGH SCHOOL EDUCATION")
		POVLL (REF = "0-99% FPL")
		UR_CLRT4 (REF = "URBAN")
		AF113 (REF = "NO")
		AM183 (REF = "VERY STABLE")/ param=ref;
	model AF112(ref="NO") = AK28 SRAGE_P1 OMBSRR_P1 SRSEX MARIT SPK_ENG SREDUC POVLL UR_CLRT4 AF113 AM183 /clparm;
	format AF112 YESNO. AK28 AK28ft. SRAGE_P1 SRAGE_P1ft. OMBSRR_P1 OMBSRR_P1ft. SRSEX SRSEXft. MARIT MARITft. SPK_ENG SPK_ENGft. SREDUC SREDUCft. POVLL POVLLft.
		UR_CLRT4 UR_CLRT4ft. AF113 YESNO. AM183 AM183ft.;
run;

*Table 2 Model 1: Unadjusted Model [#4.VOLUNTEER IN ORG DEALING W/COMM PROB PAST YR] ;
proc surveylogistic data=g.project3 varmethod=jackknife;
	weight rakedw0;
	repweights rakedw1-rakedw80/JKCOEFS=1;  
	class AM39(ref="NO") 
		SRAGE_P1 (REF = "65+")
		OMBSRR_P1 (REF = "WHITE, NON-HISPANIC (NH)")
		SRSEX (REF = "Male")
		MARIT (REF = "Married")
		SPK_ENG (REF = "NOT WELL/NOT AT ALL")
		SREDUC (REF = "HIGH SCHOOL EDUCATION")
		POVLL (REF = "0-99% FPL")
		UR_CLRT4 (REF = "URBAN")
		AF113 (REF = "NO")
		AM183 (REF = "VERY STABLE")/ param=ref;
	model AF112(ref="NO") = AM39 SRAGE_P1 OMBSRR_P1 SRSEX MARIT SPK_ENG SREDUC POVLL UR_CLRT4 AF113 AM183 /clparm;
	format AF112 YESNO. AM39 YESNO. SRAGE_P1 SRAGE_P1ft. OMBSRR_P1 OMBSRR_P1ft. SRSEX SRSEXft. MARIT MARITft. SPK_ENG SPK_ENGft. SREDUC SREDUCft. POVLL POVLLft.
		UR_CLRT4 UR_CLRT4ft. AF113 YESNO. AM183 AM183ft.;
run;


*Table 2 Model 1: Unadjusted Model [#5.PEOPLE IN NEIGHBORHOOD DO NOT GET ALONG] ;
proc surveylogistic data=g.project3 varmethod=jackknife;
	weight rakedw0;
	repweights rakedw1-rakedw80/JKCOEFS=1;  
	class AM20(ref="STRONGLY DISAGREE") 
		SRAGE_P1 (REF = "65+")
		OMBSRR_P1 (REF = "WHITE, NON-HISPANIC (NH)")
		SRSEX (REF = "Male")
		MARIT (REF = "Married")
		SPK_ENG (REF = "NOT WELL/NOT AT ALL")
		SREDUC (REF = "HIGH SCHOOL EDUCATION")
		POVLL (REF = "0-99% FPL")
		UR_CLRT4 (REF = "URBAN")
		AF113 (REF = "NO")
		AM183 (REF = "VERY STABLE")/ param=ref;
	model AF112(ref="NO") = AM20 SRAGE_P1 OMBSRR_P1 SRSEX MARIT SPK_ENG SREDUC POVLL UR_CLRT4 AF113 AM183 /clparm;
	format AF112 YESNO. AM20 AGREE. SRAGE_P1 SRAGE_P1ft. OMBSRR_P1 OMBSRR_P1ft. SRSEX SRSEXft. MARIT MARITft. SPK_ENG SPK_ENGft. SREDUC SREDUCft. POVLL POVLLft.
		UR_CLRT4 UR_CLRT4ft. AF113 YESNO. AM183 AM183ft.;
run;




/********************************************************
************** Table 2 Model Analysis *****************
************** Adjusted OR model 2 ******************
*******************************************************/

*Table 2 Model 2: Unadjusted Model [#1.PEOPLE IN NEIGHBORHOOD WILLING TO HELP EACH OTHER] ;
proc surveylogistic data=g.project3 varmethod=jackknife;
	weight rakedw0;
	repweights rakedw1-rakedw80/JKCOEFS=1;  
	class AM19(ref="STRONGLY DISAGREE") 
		SRAGE_P1 (REF = "65+")
		OMBSRR_P1 (REF = "WHITE, NON-HISPANIC (NH)")
		SRSEX (REF = "Male")
		MARIT (REF = "Married")
		SPK_ENG (REF = "NOT WELL/NOT AT ALL")
		SREDUC (REF = "HIGH SCHOOL EDUCATION")
		POVLL (REF = "0-99% FPL")
		UR_CLRT4 (REF = "URBAN")
		AF113 (REF = "NO")
		AM183 (REF = "VERY STABLE")	
		AM20 (REF = "STRONGLY DISAGREE")
		AM21 (REF = "STRONGLY DISAGREE")
		AK28 (REF = "NONE OF THE TIME")
		AM39 (REF = "NO")/ param=ref;
	model AF112(ref="NO") = AM19 SRAGE_P1 OMBSRR_P1 SRSEX MARIT SPK_ENG SREDUC POVLL UR_CLRT4 AF113 AM183 AM20 AM21 AK28 AM39/clparm;
	format SRAGE_P1 SRAGE_P1ft. OMBSRR_P1 OMBSRR_P1ft. SRSEX SRSEXft. MARIT MARITft. SPK_ENG SPK_ENGft. SREDUC SREDUCft. POVLL POVLLft.
		UR_CLRT4 UR_CLRT4ft. AF113 YESNO. AM183 AM183ft. AM19 AGREE. AM20 AGREE. AM21 AGREE. AK28 AK28ft. AM39 YESNO. AF112 YESNO.;
run;

*Table 2 Model 2: Unadjusted Model [#2.PEOPLE IN NEIGHBORHOOD CAN BE TRUSTED] ;
proc surveylogistic data=g.project3 varmethod=jackknife;
	weight rakedw0;
	repweights rakedw1-rakedw80/JKCOEFS=1;  
	class AM21(ref="STRONGLY DISAGREE") 
		SRAGE_P1 (REF = "65+")
		OMBSRR_P1 (REF = "WHITE, NON-HISPANIC (NH)")
		SRSEX (REF = "Male")
		MARIT (REF = "Married")
		SPK_ENG (REF = "NOT WELL/NOT AT ALL")
		SREDUC (REF = "HIGH SCHOOL EDUCATION")
		POVLL (REF = "0-99% FPL")
		UR_CLRT4 (REF = "URBAN")
		AF113 (REF = "NO")
		AM183 (REF = "VERY STABLE")
		AM19 (REF = "STRONGLY DISAGREE")
		AM20 (REF = "STRONGLY DISAGREE")
		AK28 (REF = "NONE OF THE TIME")
		AM39 (REF = "NO")/ param=ref;
	model AF112(ref="NO") = AM21 SRAGE_P1 OMBSRR_P1 SRSEX MARIT SPK_ENG SREDUC POVLL UR_CLRT4 AF113 AM183 AM19 AM20 AK28 AM39/clparm;
	format SRAGE_P1 SRAGE_P1ft. OMBSRR_P1 OMBSRR_P1ft. SRSEX SRSEXft. MARIT MARITft. SPK_ENG SPK_ENGft. SREDUC SREDUCft. POVLL POVLLft.
		UR_CLRT4 UR_CLRT4ft. AF113 YESNO. AM183 AM183ft. AM19 AGREE. AM20 AGREE. AM21 AGREE. AK28 AK28ft. AM39 YESNO. AF112 YESNO.;
run;


*Table 2 Model 2: Unadjusted Model [#3.HOW OFTEN FEEL SAFE IN NEIGHBORHOOD] ;
proc surveylogistic data=g.project3 varmethod=jackknife;
	weight rakedw0;
	repweights rakedw1-rakedw80/JKCOEFS=1;  
	class AK28(ref="NONE OF THE TIME")
		SRAGE_P1 (REF = "65+")
		OMBSRR_P1 (REF = "WHITE, NON-HISPANIC (NH)")
		SRSEX (REF = "Male")
		MARIT (REF = "Married")
		SPK_ENG (REF = "NOT WELL/NOT AT ALL")
		SREDUC (REF = "HIGH SCHOOL EDUCATION")
		POVLL (REF = "0-99% FPL")
		UR_CLRT4 (REF = "URBAN")
		AF113 (REF = "NO")
		AM183 (REF = "VERY STABLE")
		AM19 (REF = "STRONGLY DISAGREE")
		AM20 (REF = "STRONGLY DISAGREE")
		AM21 (REF = "STRONGLY DISAGREE")
		AM39 (REF = "NO")/ param=ref;
	model AF112(ref="NO") = AK28 SRAGE_P1 OMBSRR_P1 SRSEX MARIT SPK_ENG SREDUC POVLL UR_CLRT4 AF113 AM183 AM19 AM20 AM21 AM39/clparm;
	format SRAGE_P1 SRAGE_P1ft. OMBSRR_P1 OMBSRR_P1ft. SRSEX SRSEXft. MARIT MARITft. SPK_ENG SPK_ENGft. SREDUC SREDUCft. POVLL POVLLft.
		UR_CLRT4 UR_CLRT4ft. AF113 YESNO. AM183 AM183ft. AM19 AGREE. AM20 AGREE. AM21 AGREE. AK28 AK28ft. AM39 YESNO. AF112 YESNO.;
run;

*Table 2 Model 2: Unadjusted Model [#4.VOLUNTEER IN ORG DEALING W/COMM PROB PAST YR] ;
proc surveylogistic data=g.project3 varmethod=jackknife;
	weight rakedw0;
	repweights rakedw1-rakedw80/JKCOEFS=1;  
	class AM39(ref="NO") 
		SRAGE_P1 (REF = "65+")
		OMBSRR_P1 (REF = "WHITE, NON-HISPANIC (NH)")
		SRSEX (REF = "Male")
		MARIT (REF = "Married")
		SPK_ENG (REF = "NOT WELL/NOT AT ALL")
		SREDUC (REF = "HIGH SCHOOL EDUCATION")
		POVLL (REF = "0-99% FPL")
		UR_CLRT4 (REF = "URBAN")
		AF113 (REF = "NO")
		AM183 (REF = "VERY STABLE")
		AM19 (REF = "STRONGLY DISAGREE")
		AM20 (REF = "STRONGLY DISAGREE")
		AM21 (REF = "STRONGLY DISAGREE")
		AK28 (REF = "NONE OF THE TIME")/ param=ref;
	model AF112(ref="NO") = AM39 SRAGE_P1 OMBSRR_P1 SRSEX MARIT SPK_ENG SREDUC POVLL UR_CLRT4 AF113 AM183 AM19 AM20 AM21 AK28/clparm;
	format SRAGE_P1 SRAGE_P1ft. OMBSRR_P1 OMBSRR_P1ft. SRSEX SRSEXft. MARIT MARITft. SPK_ENG SPK_ENGft. SREDUC SREDUCft. POVLL POVLLft.
		UR_CLRT4 UR_CLRT4ft. AF113 YESNO. AM183 AM183ft. AM19 AGREE. AM20 AGREE. AM21 AGREE. AK28 AK28ft. AM39 YESNO. AF112 YESNO.;
run;


*Table 2 Model 2: Unadjusted Model [#5.PEOPLE IN NEIGHBORHOOD DO NOT GET ALONG] ;
proc surveylogistic data=g.project3 varmethod=jackknife;
	weight rakedw0;
	repweights rakedw1-rakedw80/JKCOEFS=1;  
	class AM20(ref="STRONGLY DISAGREE") 
		SRAGE_P1 (REF = "65+")
		OMBSRR_P1 (REF = "WHITE, NON-HISPANIC (NH)")
		SRSEX (REF = "Male")
		MARIT (REF = "Married")
		SPK_ENG (REF = "NOT WELL/NOT AT ALL")
		SREDUC (REF = "HIGH SCHOOL EDUCATION")
		POVLL (REF = "0-99% FPL")
		UR_CLRT4 (REF = "URBAN")
		AF113 (REF = "NO")
		AM183 (REF = "VERY STABLE")
		AM19 (REF = "STRONGLY DISAGREE")
		AM21 (REF = "STRONGLY DISAGREE")
		AK28 (REF = "NONE OF THE TIME")
		AM39 (REF = "NO")/ param=ref;
	model AF112(ref="NO") = AM20 SRAGE_P1 OMBSRR_P1 SRSEX MARIT SPK_ENG SREDUC POVLL UR_CLRT4 AF113 AM183 AM19 AM21 AK28 AM39 /clparm;
	format SRAGE_P1 SRAGE_P1ft. OMBSRR_P1 OMBSRR_P1ft. SRSEX SRSEXft. MARIT MARITft. SPK_ENG SPK_ENGft. SREDUC SREDUCft. POVLL POVLLft.
		UR_CLRT4 UR_CLRT4ft. AF113 YESNO. AM183 AM183ft. AM19 AGREE. AM20 AGREE. AM21 AGREE. AK28 AK28ft. AM39 YESNO. AF112 YESNO.;
run;




/********************************************************
************** Table 2 Model Analysis *****************
****** Assigning the reference as Strongly agree *******
*******************************************************/

*Table 2 Model 0: Unadjusted Model [#5.PEOPLE IN NEIGHBORHOOD DO NOT GET ALONG] ;
proc surveylogistic data=g.project3 varmethod=jackknife;
	weight rakedw0;
	repweights rakedw1-rakedw80/JKCOEFS=1;  
	class AM20(ref="STRONGLY AGREE") / param=ref;
	model AF112(ref="NO") = AM20 /clparm;
	format AF112 YESNO. AM20 AGREE.;
run;


*Table 2 Model 1: Unadjusted Model [#5.PEOPLE IN NEIGHBORHOOD DO NOT GET ALONG] ;
proc surveylogistic data=g.project3 varmethod=jackknife;
	weight rakedw0;
	repweights rakedw1-rakedw80/JKCOEFS=1;  
	class AM20(ref="STRONGLY AGREE") 
		SRAGE_P1 (REF = "65+")
		OMBSRR_P1 (REF = "WHITE, NON-HISPANIC (NH)")
		SRSEX (REF = "Male")
		MARIT (REF = "Married")
		SPK_ENG (REF = "NOT WELL/NOT AT ALL")
		SREDUC (REF = "HIGH SCHOOL EDUCATION")
		POVLL (REF = "0-99% FPL")
		UR_CLRT4 (REF = "URBAN")
		AF113 (REF = "NO")
		AM183 (REF = "VERY STABLE")/ param=ref;
	model AF112(ref="NO") = AM20 SRAGE_P1 OMBSRR_P1 SRSEX MARIT SPK_ENG SREDUC POVLL UR_CLRT4 AF113 AM183 /clparm;
	format AF112 YESNO. AM20 AGREE. SRAGE_P1 SRAGE_P1ft. OMBSRR_P1 OMBSRR_P1ft. SRSEX SRSEXft. MARIT MARITft. SPK_ENG SPK_ENGft. SREDUC SREDUCft. POVLL POVLLft.
		UR_CLRT4 UR_CLRT4ft. AF113 YESNO. AM183 AM183ft.;
run;


*Table 2 Model 2: Unadjusted Model [#5.PEOPLE IN NEIGHBORHOOD DO NOT GET ALONG] ;
proc surveylogistic data=g.project3 varmethod=jackknife;
	weight rakedw0;
	repweights rakedw1-rakedw80/JKCOEFS=1;  
	class AM20(ref="STRONGLY AGREE") 
		SRAGE_P1 (REF = "65+")
		OMBSRR_P1 (REF = "WHITE, NON-HISPANIC (NH)")
		SRSEX (REF = "Male")
		MARIT (REF = "Married")
		SPK_ENG (REF = "NOT WELL/NOT AT ALL")
		SREDUC (REF = "HIGH SCHOOL EDUCATION")
		POVLL (REF = "0-99% FPL")
		UR_CLRT4 (REF = "URBAN")
		AF113 (REF = "NO")
		AM183 (REF = "VERY STABLE")
		AM19 (REF = "STRONGLY DISAGREE")
		AM21 (REF = "STRONGLY DISAGREE")
		AK28 (REF = "NONE OF THE TIME")
		AM39 (REF = "NO")/ param=ref;
	model AF112(ref="NO") = AM20 SRAGE_P1 OMBSRR_P1 SRSEX MARIT SPK_ENG SREDUC POVLL UR_CLRT4 AF113 AM183 AM19 AM21 AK28 AM39 /clparm;
	format SRAGE_P1 SRAGE_P1ft. OMBSRR_P1 OMBSRR_P1ft. SRSEX SRSEXft. MARIT MARITft. SPK_ENG SPK_ENGft. SREDUC SREDUCft. POVLL POVLLft.
		UR_CLRT4 UR_CLRT4ft. AF113 YESNO. AM183 AM183ft. AM19 AGREE. AM20 AGREE. AM21 AGREE. AK28 AK28ft. AM39 YESNO. AF112 YESNO.;
run;




















