--STEP 1: CREATE TABLES

CREATE TABLE  INSURANCE ( 
INSURANCE_ID INTEGER PRIMARY KEY,
INSURANCE_COMPANY VARCHAR2(50) NOT NULL,
INSURANCE_PLAN VARCHAR2(50) NOT NULL,
INSURANCE_COVERAGE NUMBER(9,2) DEFAULT 0.00 NOT NULL
);

CREATE TABLE PATIENT (
PAT_ID INTEGER PRIMARY KEY,
PAT_FNAME VARCHAR2(20) NOT NULL,
PAT_LNAME VARCHAR2(20) NOT NULL,
PAT_GENDER  VARCHAR2(20) NOT NULL,
PAT_ADDRESS VARCHAR2(20) NOT NULL,
PAT_DOB DATE NOT NULL,
PAT_BLOOD_TYPE VARCHAR2(20) NOT NULL,
PAT_PHONE INTEGER NOT NULL,
PAT_EMER_PHONE INTEGER,
REQUIRED_dOC_SPECIALITY VARCHAR2(20) NOT NULL,
INSURANCE_ID INTEGER,
FOREIGN KEY (INSURANCE_ID) REFERENCES INSURANCE (INSURANCE_ID)
);

CREATE TABLE DOCTOR(
DOC_ID INTEGER PRIMARY KEY,
DOC_FNAME VARCHAR2(20) NOT NULL,
DOC_LNAME VARCHAR2(20) NOT NULL,
DOC_GENDER  VARCHAR2(20) NOT NULL,
DOC_HIRE_DATE DATE NOT NULL,
DOC_SPECIALITY VARCHAR2(20) NOT NULL,
DOC_MEDICAL_FEE NUMBER(9,2) DEFAULT 0.00 NOT NULL,
DOC_ADDRESS VARCHAR2(20) NOT NULL,
DOC_DOB DATE NOT NULL,
DOC_PHONE INTEGER NOT NULL
);

CREATE TABLE APPOINTMENT (
APPT_ID INTEGER PRIMARY KEY,
APPT_YEAR INTEGER NOT NULL,
APPT_MON VARCHAR2(10) NOT NULL,
APPT_DATE INTEGER NOT NULL,
APPT_TIME INTEGER NOT NULL,
APPT_ROOM INTEGER  NOT NULL,
PAT_ID INTEGER,
DOC_ID INTEGER,
FOREIGN KEY (PAT_ID) REFERENCES PATIENT (PAT_ID),
FOREIGN KEY (DOC_ID) REFERENCES DOCTOR (DOC_ID)
);

CREATE TABLE PRESCRIPTION (
PRES_ID INTEGER PRIMARY KEY,
PRES_DESCRIPTION VARCHAR2(500) NOT NULL,
APPT_ID INTEGER,
FOREIGN KEY (APPT_ID) REFERENCES APPOINTMENT (APPT_ID)
);

CREATE TABLE MEDICAL_TEST(
TEST_ID INTEGER PRIMARY KEY,
TEST_NAME VARCHAR2(20) NOT NULL,
TEST_FEE NUMBER(9,2) DEFAULT 0.00 NOT NULL
);

CREATE TABLE DRUG(
DRUG_ID INTEGER PRIMARY KEY,
DRUG_NAME VARCHAR2(20) NOT NULL,
DRUG_DESCRIPTION VARCHAR2(500) NOT NULL
);

CREATE TABLE PRES_LINE_TEST (
PRES_ID INTEGER NOT NULL,
PRES_LINE_TEST_ID INTEGER NOT NULL,
TEST_ID INTEGER,
PRES_LINE_TEST_RESULT VARCHAR2(500) NOT NULL,
CONSTRAINT PRES_LINE_TEST_PK PRIMARY KEY (PRES_ID,PRES_LINE_TEST_ID),
FOREIGN KEY (PRES_ID) REFERENCES PRESCRIPTION (PRES_ID),
FOREIGN KEY (TEST_ID) REFERENCES MEDICAL_TEST (TEST_ID)
);

CREATE TABLE PRES_LINE_DRUG (
PRES_ID INTEGER NOT NULL,
PRES_LINE_DRUG_ID INTEGER NOT NULL,
DRUG_ID INTEGER,
PRES_LINE_DRUG_DOSAGE VARCHAR2(500) NOT NULL,
CONSTRAINT PRES_LINE_DRUG_PK PRIMARY KEY (PRES_ID,PRES_LINE_DRUG_ID),
FOREIGN KEY (PRES_ID) REFERENCES PRESCRIPTION (PRES_ID),
FOREIGN KEY (DRUG_ID) REFERENCES DRUG (DRUG_ID)
);

CREATE TABLE BILLING(
BILLING_ID INTEGER PRIMARY KEY,
APPT_ID INTEGER,
PRES_ID INTEGER,
INSURANCE_ID INTEGER,
FOREIGN KEY (INSURANCE_ID) REFERENCES INSURANCE (INSURANCE_ID),
FOREIGN KEY (APPT_ID) REFERENCES APPOINTMENT (APPT_ID),
FOREIGN KEY (PRES_ID) REFERENCES PRESCRIPTION (PRES_ID)
);

--STEP 2: INSERT DATA

INSERT INTO INSURANCE VALUES ('9001','HEALTHCARE','HAPPY PLAN','0.5');
INSERT INTO INSURANCE VALUES ('9002','HEALTHCARE','SATISFACTORY PLAN','0.75');
INSERT INTO INSURANCE VALUES ('9003','HEALTHCARE','SUPPORT PLAN','1');
INSERT INTO INSURANCE VALUES ('9004','Wellcare Group ','A - PLAN','0.4');
INSERT INTO INSURANCE VALUES ('9005','Wellcare Group ','B - PLAN','0.6');
INSERT INTO INSURANCE VALUES ('9006','Wellcare Group ','C - PLAN','0.9');
INSERT INTO INSURANCE VALUES ('9007','Metropolitan Group ','PARTIAL PLAN','0.5');
INSERT INTO INSURANCE VALUES ('9008','Metropolitan Group ','LIFETIME PLAN','1');

INSERT INTO PATIENT VALUES 
    ('10001','JOHN','TAGORE','MALE','789,HILLERY DR,CA',TO_DATE('03-NOV-1990','DD-MON-YYYY'),'A+','6789706776','7890678888','Allergy','9003'); 
INSERT INTO PATIENT VALUES 
    ('10002','MARY','SMITH','FEMALE','#32,GREENFORDDR,OHIO',TO_DATE('06-AUG-1970','DD-MON-YYYY'),'A+','9845367878','7896578585','Allergy','9005');
INSERT INTO PATIENT VALUES 
    ('10003','JAMES','SMITH','MALE','#90,BLACKMOUNTAIN,CA',TO_DATE('03-NOV-1980','DD-MON-YYYY'),'B+','6457389999','6345789123','CARDIOLOGY','9007'); 
INSERT INTO PATIENT VALUES
    ('10004','ELIZABETH','BROWN','FEMALE','#06,RUFFINROAD,OHIO',TO_DATE('16-MAR-1985','DD-MON-YYYY'),'B+','6578495656','4563458978','Allergy','9001');
INSERT INTO PATIENT VALUES
    ('10005','MARTHA','JOHNSON','FEMALE','#104,CAMINO RUIZ,CA',TO_DATE('12-FEB-2015','DD-MON-YYYY'),'B+','3456784545','6589456666','PEDIATRICS','9002');
INSERT INTO PATIENT VALUES 
    ('10006','MICHAEL','GARCIA','MALE','#10,CAMINORUIZ,CA',TO_DATE('11-JAN-1995','DD-MON-YYYY'),'B+','4568933834','9078456666','Allergy','9002'); 
INSERT INTO PATIENT VALUES
    ('10007','ELIZA','DAVIS','FEMALE','#605,POWAY,CA',TO_DATE('17-DEC-2016','DD-MON-YYYY'),'O+','3456785656','8976546666','PEDIATRICS','9008');
INSERT INTO PATIENT VALUES 
    ('10008','DAVID','MILLER','MALE','#2,SUMMERDALEROAD,CA',TO_DATE('20-JUNE-1980','DD-MON-YYYY'),'O+','6754389598','8765678989','Allergy','9006'); 
INSERT INTO PATIENT VALUES 
    ('10009','TAYLOR','MILLER','MALE','#504,LIGHT AVENUE,CA',TO_DATE('09-SEP-1965','DD-MON-YYYY'),'B+','4567834646','8706548999','PEDIATRICS','9004'); 
INSERT INTO PATIENT VALUES
    ('10010','CATHERINE','WILLIAMS','FEMALE','#506,TICKETSTREET,CA',TO_DATE('15-APR-1997','DD-MON-YYYY'),'O+','8967545667','7685676565','Allergy','9007');
INSERT INTO PATIENT VALUES 
    ('10011','JOHN','TAGORE','MALE','789,HILLERY DR,CA',TO_DATE('03-NOV-1990','DD-MON-YYYY'),'A+','6789706776','7890678888','Allergy','9003'); 
INSERT INTO PATIENT VALUES 
    ('10012','MARY','SMITH','FEMALE','#32,GREENFORDDR,OHIO',TO_DATE('06-AUG-1970','DD-MON-YYYY'),'A+','9845367878','7896578585','PEDIATRICS','9005');
INSERT INTO PATIENT VALUES 
    ('10013','JAMES','SMITH','MALE','#90,BLACKMOUNTAIN,CA',TO_DATE('03-NOV-1980','DD-MON-YYYY'),'B+','6457389999','6345789123','CARDIOLOGY','9007'); 
INSERT INTO PATIENT VALUES
    ('10014','ELIZABETH','BROWN','FEMALE','#06,RUFFINROAD,OHIO',TO_DATE('16-MAR-1985','DD-MON-YYYY'),'B+','6578495656','4563458978','PEDIATRICS','9001');
INSERT INTO PATIENT VALUES
    ('10015','MARTHA','JOHNSON','FEMALE','#104,CAMINO RUIZ,CA',TO_DATE('12-FEB-2015','DD-MON-YYYY'),'B+','3456784545','6589456666','PEDIATRICS','9002');
INSERT INTO PATIENT VALUES 
    ('10016','MICHAEL','GARCIA','MALE','#10,CAMINORUIZ,CA',TO_DATE('11-JAN-1995','DD-MON-YYYY'),'B+','4568933834','9078456666','Allergy','9002'); 
INSERT INTO PATIENT VALUES
    ('10017','ELIZA','DAVIS','FEMALE','#605,POWAY,CA',TO_DATE('17-DEC-2016','DD-MON-YYYY'),'O+','3456785656','8976546666','PEDIATRICS','9008');
INSERT INTO PATIENT VALUES 
    ('10018','DAVID','MILLER','MALE','#2,SUMMERDALEROAD,CA',TO_DATE('20-JUNE-1980','DD-MON-YYYY'),'O+','6754389598','8765678989','PEDIATRICS','9006'); 
INSERT INTO PATIENT VALUES 
    ('10019','TAYLOR','MILLER','MALE','#504,LIGHT AVENUE,CA',TO_DATE('09-SEP-1965','DD-MON-YYYY'),'B+','4567834646','8706548999','NEUROLOGY','9004'); 
INSERT INTO PATIENT VALUES
    ('10020','CATHERINE','WILLIAMS','FEMALE','#506,TICKETSTREET,CA',TO_DATE('15-APR-1997','DD-MON-YYYY'),'O+','8967545667','7685676565','Allergy','9007');

INSERT  INTO DOCTOR  VALUES
    ('20001','DR.MANJU','REDDY','FEMALE',TO_DATE('03-NOV-2000','DD-MON-YYYY'),'Allergy','50','#10,CAMINORUIZ,CA',TO_DATE('25-JAN 1965','DD-MON-YYYY'),'5678903999'); 
INSERT  INTO DOCTOR  VALUES
    ('20002','DR.MARIEL','ECCLESTON','FEMALE',TO_DATE('14-JUN-1985','DD-MON-YYYY'),'CARDIOLOGY ','150','#50SUMMERDALEROAD,CA',TO_DATE('07-SEP-1940','DD-MON-YYYY'),'5678902111'); 
INSERT  INTO DOCTOR  VALUES
    ('20003','DR.RICHARD','ROBINSON','MALE',TO_DATE('19-DEC-2000','DD-MON-YYYY'),'NEUROLOGY ','120','#56 THOMAS ROAD,CA',TO_DATE('07-JAN-1965','DD-MON-YYYY'),'6784567555'); 
INSERT  INTO DOCTOR  VALUES
    ('20004','DR.GEORGE','GARCIA','MALE',TO_DATE('25-AUG-2005','DD-MON-YYYY'),'PEDIATRICS ','100','#78SUDARSHANROAD,CA',TO_DATE('19-SEP-1985','DD-MON-YYYY'),'6458945675'); 

INSERT INTO APPOINTMENT VALUES ('1','2018','AUG','6','9','301','10001','20001' );
INSERT INTO APPOINTMENT VALUES ('2','2018','AUG','6','11','301','10002','20001' );
INSERT INTO APPOINTMENT VALUES ('3','2018','AUG','8','9','301','10003','20002' );
INSERT INTO APPOINTMENT VALUES ('4','2018','AUG','15','9','302','10004','20001' );
INSERT INTO APPOINTMENT VALUES ('5','2018','AUG','22','9','302','10005','20004' );
INSERT INTO APPOINTMENT VALUES ('6','2018','SEP','2','9','302','10006','20001' );
INSERT INTO APPOINTMENT VALUES ('7','2018','SEP','9','9','303','10007','20004' );
INSERT INTO APPOINTMENT VALUES ('8','2018','SEP','15','9','303','10008','20001' );
INSERT INTO APPOINTMENT VALUES ('9','2018','SEP','16','9','303','10009','20004' );
INSERT INTO APPOINTMENT VALUES ('10','2018','SEP','20','9','303','10010','20001' );
INSERT INTO APPOINTMENT VALUES ('11','2018','SEP','25','9','303','10011','20001' );
INSERT INTO APPOINTMENT VALUES ('12','2018','OCT','3','9','303','10012','20004' );
INSERT INTO APPOINTMENT VALUES ('13','2018','OCT','4','9','304','10013','20002' );
INSERT INTO APPOINTMENT VALUES ('14','2018','OCT','7','9','304','10014','20004' );
INSERT INTO APPOINTMENT VALUES ('15','2018','OCT','11','9','304','10015','20004' );
INSERT INTO APPOINTMENT VALUES ('16','2018','OCT','15','9','304','10016','20001' );
INSERT INTO APPOINTMENT VALUES ('17','2018','OCT','16','9','304','10017','20004' );
INSERT INTO APPOINTMENT VALUES ('18','2018','OCT','17','9','304','10018','20004' );
INSERT INTO APPOINTMENT VALUES ('19','2018','OCT','23','9','304','10019','20003' );
INSERT INTO APPOINTMENT VALUES ('20','2018','OCT','23','11','304','10020','20001' );

INSERT INTO PRESCRIPTION VALUES ('50001','FOOD ELLERGEY, AVOID CITRIC FOODS','1');
INSERT INTO PRESCRIPTION VALUES ('50002','FOOD ELLERGEY, AVOID CITRIC FOODS','2');
INSERT INTO PRESCRIPTION VALUES ('50003','FOOD ELLERGEY, AVOID CITRIC FOODS','3');
INSERT INTO PRESCRIPTION VALUES ('50004','FOOD ELLERGEY, AVOID CITRIC FOODS','4');
INSERT INTO PRESCRIPTION VALUES ('50005','FOOD ELLERGEY, AVOID CITRIC FOODS','5');
INSERT INTO PRESCRIPTION VALUES ('50006','FOOD ELLERGEY, AVOID CITRIC FOODS','6');
INSERT INTO PRESCRIPTION VALUES ('50007','FOOD ELLERGEY, AVOID CITRIC FOODS','7');
INSERT INTO PRESCRIPTION VALUES ('50008','FOOD ELLERGEY, AVOID CITRIC FOODS','8');
INSERT INTO PRESCRIPTION VALUES ('50009','FOOD ELLERGEY, AVOID CITRIC FOODS','9');
INSERT INTO PRESCRIPTION VALUES ('50010','FOOD ELLERGEY, AVOID CITRIC FOODS','10');
INSERT INTO PRESCRIPTION VALUES ('50011','FOOD ELLERGEY, AVOID CITRIC FOODS','11');
INSERT INTO PRESCRIPTION VALUES ('50012','FOOD ELLERGEY, AVOID CITRIC FOODS','12');
INSERT INTO PRESCRIPTION VALUES ('50013','FOOD ELLERGEY, AVOID CITRIC FOODS','13');
INSERT INTO PRESCRIPTION VALUES ('50014','FOOD ELLERGEY, AVOID CITRIC FOODS','14');
INSERT INTO PRESCRIPTION VALUES ('50015','FOOD ELLERGEY, AVOID CITRIC FOODS','15');
INSERT INTO PRESCRIPTION VALUES ('50016','FOOD ELLERGEY, AVOID CITRIC FOODS','16');
INSERT INTO PRESCRIPTION VALUES ('50017','FOOD ELLERGEY, AVOID CITRIC FOODS','17');
INSERT INTO PRESCRIPTION VALUES ('50018','FOOD ELLERGEY, AVOID CITRIC FOODS','18');
INSERT INTO PRESCRIPTION VALUES ('50019','FOOD ELLERGEY, AVOID CITRIC FOODS','19');
INSERT INTO PRESCRIPTION VALUES ('50020','FOOD ELLERGEY, AVOID CITRIC FOODS','20');

INSERT INTO MEDICAL_TEST VALUES ('601','CT','80');
INSERT INTO MEDICAL_TEST VALUES ('602','BLOOD TEST','40');
INSERT INTO MEDICAL_TEST VALUES ('603','X-RAY','100');
INSERT INTO MEDICAL_TEST VALUES ('604','FULL BODY TEST','200');

INSERT INTO DRUG VALUES ('701','BERNALD','TAKE AFTER DINNER');
INSERT INTO DRUG VALUES ('702','PARACETOL','TAKE AFTER DINNER');
INSERT INTO DRUG VALUES ('703','DOLO','TAKE AFTER DINNER');

INSERT INTO PRES_LINE_TEST VALUES ('50001','1','601','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50001','2','603','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50002','1','604','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50003','1','602','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50004','1','602','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50005','1','604','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50006','1','603','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50006','2','604','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50007','1','604','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50008','1','601','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50009','1','601','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50010','1','601','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50011','1','603','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50012','1','602','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50012','2','601','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50012','3','603','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50013','1','604','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50014','1','603','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50015','1','601','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50016','1','603','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50016','2','602','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50017','1','602','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50018','1','604','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50019','1','604','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50019','2','602','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50020','1','602','GOOD');
INSERT INTO PRES_LINE_TEST VALUES ('50020','2','603','GOOD');

INSERT INTO PRES_LINE_DRUG VALUES ('50001','1','703','250MG DAILY 2 TIMES');
INSERT INTO PRES_LINE_DRUG VALUES ('50002','1','701','250MG DAILY 2 TIMES');
INSERT INTO PRES_LINE_DRUG VALUES ('50004','1','702','250MG DAILY 2 TIMES');
INSERT INTO PRES_LINE_DRUG VALUES ('50004','2','701','250MG DAILY 2 TIMES');
INSERT INTO PRES_LINE_DRUG VALUES ('50005','1','703','250MG DAILY 2 TIMES');
INSERT INTO PRES_LINE_DRUG VALUES ('50006','1','703','250MG DAILY 2 TIMES');
INSERT INTO PRES_LINE_DRUG VALUES ('50007','1','701','250MG DAILY 2 TIMES');
INSERT INTO PRES_LINE_DRUG VALUES ('50009','1','702','250MG DAILY 2 TIMES');
INSERT INTO PRES_LINE_DRUG VALUES ('50010','1','703','250MG DAILY 2 TIMES');
INSERT INTO PRES_LINE_DRUG VALUES ('50012','1','701','250MG DAILY 2 TIMES');
INSERT INTO PRES_LINE_DRUG VALUES ('50015','1','703','250MG DAILY 2 TIMES');
INSERT INTO PRES_LINE_DRUG VALUES ('50015','2','702','250MG DAILY 2 TIMES');
INSERT INTO PRES_LINE_DRUG VALUES ('50016','1','703','250MG DAILY 2 TIMES');
INSERT INTO PRES_LINE_DRUG VALUES ('50017','1','701','250MG DAILY 2 TIMES');
INSERT INTO PRES_LINE_DRUG VALUES ('50019','1','702','250MG DAILY 2 TIMES');
INSERT INTO PRES_LINE_DRUG VALUES ('50019','2','701','250MG DAILY 2 TIMES');
INSERT INTO PRES_LINE_DRUG VALUES ('50020','1','703','250MG DAILY 2 TIMES');

INSERT INTO BILLING VALUES ('80001','1','50001','9003');
INSERT INTO BILLING VALUES ('80002','2','50002','9005');
INSERT INTO BILLING VALUES ('80003','3','50003','9007');
INSERT INTO BILLING VALUES ('80004','4','50004','9001');
INSERT INTO BILLING VALUES ('80005','5','50005','9002');
INSERT INTO BILLING VALUES ('80006','6','50006','9002');
INSERT INTO BILLING VALUES ('80007','7','50007','9008');
INSERT INTO BILLING VALUES ('80008','8','50008','9006');
INSERT INTO BILLING VALUES ('80009','9','50009','9004');
INSERT INTO BILLING VALUES ('80010','10','50010','9007');
INSERT INTO BILLING VALUES ('80011','11','50011','9003');
INSERT INTO BILLING VALUES ('80012','12','50012','9005');
INSERT INTO BILLING VALUES ('80013','13','50013','9007');
INSERT INTO BILLING VALUES ('80014','14','50014','9001');
INSERT INTO BILLING VALUES ('80015','15','50015','9002');
INSERT INTO BILLING VALUES ('80016','16','50016','9002');
INSERT INTO BILLING VALUES ('80017','17','50017','9008');
INSERT INTO BILLING VALUES ('80018','18','50018','9006');
INSERT INTO BILLING VALUES ('80019','19','50019','9004');
INSERT INTO BILLING VALUES ('80020','20','50020','9007');

COMMIT;

--STEP 3: QUERIES

--Business Question 1: Are all kinds of doctors enough for the hospital?
select count(p.pat_id), d.doc_id, d.doc_speciality
from patient p, appointment a, doctor d
where a.pat_id = p.pat_id
and a.doc_id = d.doc_id
group by (d.doc_id, d.doc_speciality)
order by count(p.pat_id);

--Business Question 2: Is the number of patients per month increasing or decreasing? What is the growth rate?
select appt_mon, count(pat_id)
from appointment
group by appt_mon
order by count(pat_id);

select appt_mon, count(pat_id),
    100 * (count(pat_id) - lag (count(pat_id),1) over (order by (count(pat_id)))) 
    / lag (count(pat_id),1) over (order by (count(pat_id))) || '%' as growth
from appointment
group by appt_mon
order by count(pat_id);

--Business Question 3: Is the total cost of all patients including doctor medical fee and test fee per month increasing or decreasing?
--What is the growth rate?
select a.appt_mon, sum(t.test_fee + d.doc_medical_fee) total_fee
from billing b, prescription p, pres_line_test pt, medical_test t, appointment a, doctor d
where b.pres_id = p.pres_id
and p.pres_id = pt.pres_id
and pt.test_id = t.test_id
and b.appt_id = a.appt_id
and a.doc_id = d.doc_id
group by a.appt_mon
order by total_fee;

select a.appt_mon, sum(t.test_fee + d.doc_medical_fee) total_fee, 
    100 * (sum(t.test_fee + d.doc_medical_fee) - lag (sum(t.test_fee + d.doc_medical_fee),1) over (order by sum(t.test_fee + d.doc_medical_fee)))
    / lag (sum(t.test_fee + d.doc_medical_fee),1) over (order by sum(t.test_fee + d.doc_medical_fee)) || '%' as growth 
from billing b, prescription p, pres_line_test pt, medical_test t, appointment a, doctor d
where b.pres_id = p.pres_id
and p.pres_id = pt.pres_id
and pt.test_id = t.test_id
and b.appt_id = a.appt_id
and a.doc_id = d.doc_id
group by a.appt_mon
order by total_fee;

--Business Question 4: What is the average cost including doctor medical fee and test fee for each patient in 2018?
--Which patient's cost is the highest one in 2018? Is it much higher than the average cost?
select avg(t.test_fee + d.doc_medical_fee) avg_fee, a.appt_year
from billing b, prescription p, pres_line_test pt, medical_test t, appointment a, doctor d
where b.pres_id = p.pres_id
and p.pres_id = pt.pres_id
and pt.test_id = t.test_id
and b.appt_id = a.appt_id
and a.doc_id = d.doc_id
group by a.appt_year
having a.appt_year = '2018';

select * from
(select sum(t.test_fee + d.doc_medical_fee) total_fee, a.pat_id
from billing b, prescription p, pres_line_test pt, medical_test t, appointment a, doctor d
where b.pres_id = p.pres_id
and p.pres_id = pt.pres_id
and pt.test_id = t.test_id
and b.appt_id = a.appt_id
and a.doc_id = d.doc_id
group by a.pat_id)
where total_fee = (select max (total_fee) 
from 
(select sum(t.test_fee + d.doc_medical_fee) total_fee, a.pat_id
from billing b, prescription p, pres_line_test pt, medical_test t, appointment a, doctor d
where b.pres_id = p.pres_id
and p.pres_id = pt.pres_id
and pt.test_id = t.test_id
and b.appt_id = a.appt_id
and a.doc_id = d.doc_id
group by a.pat_id));

--Business Question 5: For the patient who has the highest total fee including doctor medical fee and test fee, 
--how much of it has been covered by the insurance company? How much of it has been paid by the patient himself or herself?
select *
from
(select pa.pat_id, pa.pat_fname, pa.pat_lname, sum(t.test_fee + d.doc_medical_fee) total_fee, i.insurance_company, 
    i.insurance_coverage, (i.insurance_coverage*(sum(t.test_fee + d.doc_medical_fee))) insurance_payment, 
    ((1-i.insurance_coverage)*(sum(t.test_fee + d.doc_medical_fee))) patient_payment
from patient pa, insurance i, billing b, prescription p, pres_line_test pt, medical_test t, appointment a, doctor d
where b.pres_id = p.pres_id
and p.pres_id = pt.pres_id
and pt.test_id = t.test_id
and b.appt_id = a.appt_id
and a.doc_id = d.doc_id
and a.pat_id = pa.pat_id
and pa.insurance_id = i.insurance_id
group by (pa.pat_id,pa.pat_fname, pa.pat_lname, i.insurance_company, i.insurance_coverage))
where total_fee = (select max (total_fee) 
from 
(select sum(t.test_fee + d.doc_medical_fee) total_fee, pa.pat_id, pa.pat_fname, pa.pat_lname, i.insurance_company, 
    i.insurance_coverage
from patient pa, insurance i, billing b, prescription p, pres_line_test pt, medical_test t, appointment a, doctor d
where b.pres_id = p.pres_id
and p.pres_id = pt.pres_id
and pt.test_id = t.test_id
and b.appt_id = a.appt_id
and a.doc_id = d.doc_id
and a.pat_id = pa.pat_id
and pa.insurance_id = i.insurance_id
group by (pa.pat_id, pa.pat_fname, pa.pat_lname, i.insurance_company, i.insurance_coverage)));


