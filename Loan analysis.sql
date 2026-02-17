create database bank_analysis;

use bank_analysis;

show tables;

select * from loan;

desc loan;

select count(LoanId) from loan;
# Total Loan applicxations-29679

select avg(age) from loan;
# avg age for Customer-43 years

select avg(income) from loan;
# avg income for Customer-82460

select avg(creditScore) from loan;
# avg creditscore for customers-575

select avg(LoanAmount) from loan;
# avg loan amount for customers-127605

SELECT MAX(LoanAmount) AS highest_loan_amount FROM loan;
# highest loan amount -249999

SELECT min(LoanAmount) AS lowest_loan_amount FROM loan;
# lowest loan amount-5005

select avg(MonthsEmployed) from loan;
# avg MonthsEmployed for customers -59M

SELECT MAX(MonthsEmployed) AS highest_MonthsEmployed FROM loan;
# highest Months_Employed -119M

SELECT Min(MonthsEmployed) AS lowset_MonthsEmployed FROM loan;
# lowest Months_Employed -0M

select avg(NumCreditLines) from loan;
# avg NumCreditLines for customers-2.5

select avg(InterestRate) from loan;
# avg InterestRate for customers-13.49

SELECT MAX(InterestRate) AS highest_InterestRate FROM loan;
# highest InterestRate -25%

SELECT Min(InterestRate) AS lowest_InterestRate FROM loan;
# lowest InterestRate -2%

select avg(LoanTerm) from loan;
# avg LoanTerm for customers-36M(3Y)

SELECT MAX(LoanTerm) AS Loan_Term FROM loan;
# highest Loan_Term -60M(5Y)

SELECT Min(LoanTerm) AS Loan_Term FROM loan;
# lowest Loan_Term -12M(1Y)

select avg(DTIRatio) from loan;
# avg DTIRatio for customers-50% (High risk)

SELECT MAX(DTIRatio) AS DTI_Ratio FROM loan;
# highest DTI_Ratio- 90% (very risk)

SELECT Min(DTIRatio) AS DTI_Ratio FROM loan;
# lowest DTI_Ratio - 10% (Safe customer)

SELECT education,
CASE
    WHEN education = 'Highschool' THEN 'School'
    WHEN education = 'Bachelor''s' THEN 'Undergraduate'
    WHEN education = 'Master''s' THEN 'Postgraduate'
    WHEN education = 'PhD' THEN 'Doctorate'
END AS education_group
FROM loan;

SELECT education, COUNT(*) AS total_members
FROM loan
GROUP BY education;
# bachelor's-44956 (25.17%)
# Master's-44433   (24.87%)
# Highschool-44700 (25.01%)
# phd -44570       (24.94%)

select EmploymentType,count(*) as Total_members from loan
Group by EmploymentType;
# full time -49776 
# un employed-49902
# self-employed-50068
# part-time-50215

select MaritalStatus,count(*) as Total_members from loan
Group by MaritalStatus;
# Divorced-70314
# married-70232
# single-70254

SELECT 
    LoanPurpose, COUNT(*) AS Total_members
FROM
    loan
GROUP BY Loanpurpose;
# other-43289
# auto-43314
# business-43356
# Home-43476
# Education-43269

ALTER TABLE loan
ADD default_status VARCHAR(5);

UPDATE loan
set default_status =
CASE
    WHEN `Default` = 1 THEN 'Yes'
    WHEN `Default` = 0 THEN 'No'
END;


SELECT "Default", COUNT(*) AS total_members
FROM loan
GROUP BY "Default";

SELECT education,
       ROUND(AVG(income),2) AS avg_income
FROM loan
GROUP BY education
ORDER BY avg_income DESC;

SELECT creditscore,
CASE
    WHEN creditscore < 600 THEN 'Poor'
    WHEN creditscore <= 750 THEN 'Average'
    ELSE 'Good'
END AS credit_category
FROM loan;

SELECT 
CASE
    WHEN MonthsEmployed < 12 THEN '0-1 Year'
    WHEN MonthsEmployed < 36 THEN '1-3 Years'
    WHEN MonthsEmployed < 60 THEN '3-5 Years'
    ELSE '5+ Years'
END AS experience_group,
ROUND(AVG(LoanAmount),2) AS avg_loan
FROM loan
GROUP BY experience_group
ORDER BY avg_loan DESC;

SELECT *
FROM loan
WHERE DTIRatio> 50
AND creditscore < 600;

SELECT LoanID,
ROUND(LoanAmount / income,2) AS loan_income_ratio
FROM loan
ORDER BY loan_income_ratio DESC;

SELECT LoanID, LoanAmount
FROM loan
ORDER BY LoanAmount DESC
LIMIT 5;

SELECT LoanID,
CASE
    WHEN DTIRatio > 50 AND creditscore < 600 THEN 'High Risk'
    WHEN DTIRatio BETWEEN 30 AND 50 THEN 'Medium Risk'
    ELSE 'Low Risk'
END AS risk_category
FROM loan;

SELECT Education,
       `EmploymentType`,
       COUNT(*) AS defaulters
FROM loan
WHERE `Default` = 1
GROUP BY Education, `EmploymentType`
ORDER BY defaulters DESC;









