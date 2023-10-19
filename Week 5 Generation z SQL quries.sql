-- Q1 What percentage of male and female genz want to go to their office every day --
SELECT
    Gender,
    COUNT(*) AS TotalRespondents,
    SUM(CASE WHEN PreferredWorkingEnvironment = 'Every Day Office Environment' THEN 1 ELSE 0 END) AS OfficeEveryDayCount,
    (SUM(CASE WHEN PreferredWorkingEnvironment = 'Every Day Office Environment' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS Percentage
FROM learning_aspirations
JOIN personalized_info
ON learning_aspirations.ResponseID = personalized_info.ResponseID
WHERE PreferredWorkingEnvironment = 'Every Day Office Environment' AND Gender IN ('Male', 'Female')
GROUP BY Gender;

-- Q2 What percentage of genz who has chosen their career in business operations are most likely to influence by their parents --
SELECT
    COUNT(*) AS TotalRespondents,
    ClosestAspirationalCareer,
    SUM(CASE WHEN CareerInfluenceFactor = 'My Parents' THEN 1 ELSE 0 END) AS ParentsAsCareerInfluencerCount,
    (SUM(CASE WHEN CareerInfluenceFactor = 'My Parents' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS Percentage
FROM learning_aspirations
WHERE CareerInfluenceFactor = 'My Parents' AND ClosestAspirationalCareer LIKE '%Business Operations%'
GROUP BY ClosestAspirationalCareer;


-- Q3 What percentage of genz prefer optio for higher studies, give  a gender wise approach --
SELECT
    Gender,
    COUNT(*) AS TotalRespondents,
    SUM(CASE WHEN HigherEducationAbroad = 'Yes, I wil' THEN 1 ELSE 0 END) AS HigherEducationCount,
    (SUM(CASE WHEN HigherEducationAbroad = 'Yes, I wil' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS Percentage
FROM learning_aspirations
JOIN personalized_info
ON learning_aspirations.ResponseID = personalized_info.ResponseID
WHERE HigherEducationAbroad = 'Yes, I wil' AND Gender IN ('Male', 'Female')
GROUP BY Gender;

-- Q4 What percentage of genz is willing & not willing to work for a company whose mission is miss allignied with their public actions are even their product give gender base split --
SELECT
    Gender,
    COUNT(*) AS TotalRespondents,
    SUM(MisalignedMissionLikelihood) AS MisalignedMissioCount,
    (SUM(MisalignedMissionLikelihood) / COUNT(*)) * 100 AS Percentage
FROM mission_aspirations
JOIN personalized_info
ON mission_aspirations.ResponseID = personalized_info.ResponseID
WHERE MisalignedMissionLikelihood IN ('Will NOT work for them','Will work for them') AND Gender IN ('Male', 'Female')
GROUP BY Gender;

-- Q5 What is most sutiable working environment according to female genz --
SELECT
Gender,
MAX(PreferredWorkingEnvironment)
FROM personalized_info
JOIN learning_aspirations
ON personalized_info.ResponseID = learning_aspirations.ResponseID
WHERE Gender = 'Female';

-- Q6 Find out the correlation between gender prefer work setup --
SELECT
  (
    SUM((Gender - mean_Gender) * (PreferredWorkingEnvironment- mean_PreferredWorkingEnvironment))
    / (SQRT(SUM(POWER(Gender - mean_Gender, 2)) * SUM(POWER(Gender - mean_PreferredWorkingEnvironment, 2))))
  ) AS correlation_coefficient
FROM personalized_info
JOIN learning_aspirations
ON personalized_info.ResponseID = learning_aspirations.ResponseID
CROSS JOIN
  (
    SELECT
      AVG(Gender) AS mean_Gender,
      AVG(PreferredWorkingEnvironment) AS mean_PreferredWorkingEnvironment
    FROM personalized_info
JOIN learning_aspirations
ON personalized_info.ResponseID = learning_aspirations.ResponseID
  ) AS subquery;
  
  -- Q7 Calculate the total number of female who aspira to work in their cloesest aspirational career and have no social impact lifehood '1-5' --
SELECT 
COUNT(Gender) AS tatalNoOfFemale,
ClosestAspirationalCareer,
NoSocialImpactLikelihood
FROM learning_aspirations
JOIN mission_aspirations
ON learning_aspirations.ResponseID = mission_aspirations.ResponseID
JOIN personalized_info
ON learning_aspirations.ResponseID = personalized_info.ResponseID
WHERE Gender = 'Female' AND  NoSocialImpactLikelihood IN (1,2,3,4,5)
GROUP BY ClosestAspirationalCareer, NoSocialImpactLikelihood;

-- Q8 Retrive the male who intrested in higher education abroad and career influnced by their parents --
SELECT
Gender,
HigherEducationAbroad,
CareerInfluenceFactor
FROM learning_aspirations
JOIN personalized_info
ON learning_aspirations.ResponseID = personalized_info.ResponseID
WHERE Gender = 'Male' AND HigherEducationAbroad = 'Yes, I will' AND CareerInfluenceFactor = 'My Parents';

-- Q9 Determine the percentage of gender who has no social impact likelihood 8-10 among those who are intersseed in higher educatio abroad --
 SELECT
    COUNT(*) AS TotalRespondents,
     Gender,
    SUM(CASE WHEN NoSocialImpactLikelihood BETWEEN 8 AND 10 THEN 1 ELSE 0 END) AS HighSocialImpactCount,
    (SUM(CASE WHEN NoSocialImpactLikelihood BETWEEN 8 AND 10 THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS PercentageHighSocialImpact
FROM learning_aspirations
JOIN mission_aspirations
ON learning_aspirations.ResponseID = mission_aspirations.ResponseID
JOIN personalized_info
ON learning_aspirations.ResponseID = personalized_info.ResponseID
WHERE HigherEducationAbroad = 'Yes'
GROUP BY Gender;

-- Q10 Give a detail split of genz preference to work with team, data should include male female and overall and overall percentage --
SELECT 
Gender,
COUNT(PreferredWorkSetup) AS CountOfPreferredWorkSetup,
(SUM(PreferredWorkSetup) / COUNT(*)) * 100 AS Percentage
FROM manager_aspirations
JOIN personalized_info
ON manager_aspirations.ResponseID = personalized_info.ResponseID
WHERE Gender IN ('Male','Female')
GROUP BY Gender;



-- Q11 Give a detaile breakdown of worklikelihood 3 year for each gender --
SELECT 
Gender, 
WorkLikelihood3Years
FROM manager_aspirations
JOIN personalized_info
ON manager_aspirations.ResponseID = personalized_info.ResponseID
WHERE Gender IN ('Male','Female');

-- Q12 Give a detaile breakdown of worklikelihood 3 year for each State --
SELECT 
CurrentCountry, 
WorkLikelihood3Years
FROM manager_aspirations
JOIN personalized_info
ON manager_aspirations.ResponseID = personalized_info.ResponseID;

-- Q13 What is average starting salary expactation at 3 year mark for each gender -- 
SELECT 
Gender,
AVG(ExpectedSalary3Years) AS average_salary_expacation_at_3_year
FROM mission_aspirations
JOIN personalized_info
ON mission_aspirations.ResponseID = personalized_info.ResponseID
WHERE Gender IN ('Male','Female')
GROUP BY Gender;

-- Q14 What is average starting salary expactation at 5 year mark for each gender -- 
SELECT 
Gender,
AVG(ExpectedSalary5Years) AS average_salary_expacation_at_5_year
FROM mission_aspirations
JOIN personalized_info
ON mission_aspirations.ResponseID = personalized_info.ResponseID
WHERE Gender IN ('Male','Female')
GROUP BY Gender;

-- Q15 What is average higher bar starting salary expactation at 3 year mark for each gender--
SELECT 
Gender, 
AVG(MaxStartingSalary) AS AvgHigherBarSalaryAt3
FROM (
SELECT 
Gender,
  MAX(ExpectedSalary3Years) AS MaxStartingSalary
FROM mission_aspirations
JOIN personalized_info
ON mission_aspirations.ResponseID = personalized_info.ResponseID
WHERE Gender IN ('female','Male')
GROUP BY Gender
) AS Subquery
GROUP BY Gender;

-- Q16 What is average higher bar starting salary expactation at 5 year mark for each gender --
SELECT 
    Gender,
    AVG(MaxExpectedSalary) AS AverageHighestSalary
FROM (
    SELECT 
        Gender,
        MAX(ExpectedSalary5Years) AS MaxExpectedSalary
    FROM mission_aspirations
    JOIN personalized_info
    ON mission_aspirations.ResponseID = personalized_info.ResponseID
    WHERE Gender IN ('Male', 'Female')
    GROUP BY Gender
) AS Subquery
GROUP BY Gender;

-- Q17 What is average starting salary expactation at 3 year mark for each gender and each state in india -- 
SELECT 
Gender,
CurrentCountry,
AVG(ExpectedSalary3Years) AS average_salary_expacation_at_3_year
FROM mission_aspirations
JOIN personalized_info
ON mission_aspirations.ResponseID = personalized_info.ResponseID
WHERE Gender IN ('Male','Female') AND CurrentCountry= 'India'
GROUP BY Gender;

-- Q18 What is average starting salary expactation at 5 year mark for each gender and each state in india -- 
SELECT 
Gender,
CurrentCountry,
AVG(ExpectedSalary5Years) AS average_salary_expacation_at_5_year
FROM mission_aspirations
JOIN personalized_info
ON mission_aspirations.ResponseID = personalized_info.ResponseID
WHERE Gender IN ('Male','Female') AND CurrentCountry= 'India'
GROUP BY Gender;

-- Q19 What is average higher bar starting salary expactation at 3 year mark for each gender and each state in india --
SELECT 
Gender,
CurrentCountry, 
AVG(MaxStartingSalary) AS AvgHigherBarSalaryAt3
FROM (
SELECT 
Gender,
CurrentCountry,
  MAX(ExpectedSalary3Years) AS MaxStartingSalary
FROM mission_aspirations
JOIN personalized_info
ON mission_aspirations.ResponseID = personalized_info.ResponseID
WHERE Gender IN ('female','Male') AND CurrentCountry = 'India'
GROUP BY Gender
) AS Subquery
GROUP BY Gender;

-- Q20 What is average higher bar starting salary expactation at 5 year mark for each gender and each state in india --
SELECT 
Gender,
CurrentCountry, 
AVG(MaxStartingSalary) AS AvgHigherBarSalaryAt3
FROM (
SELECT 
Gender,
CurrentCountry,
  MAX(ExpectedSalary5Years) AS MaxStartingSalary
FROM mission_aspirations
JOIN personalized_info
ON mission_aspirations.ResponseID = personalized_info.ResponseID
WHERE Gender IN ('female','Male') AND CurrentCountry = 'India'
GROUP BY Gender
) AS Subquery
GROUP BY Gender;

-- Q21 Give a detail breakdown of the possibility of genz working for an org if the mission is misaligned for each state of india --
SELECT
    CurrentCountry,
    MisalignedMissionLikelihood,
    COUNT(MisalignedMissionLikelihood) BreakDownMisaligniedMission
FROM mission_aspirations
JOIN personalized_info
ON mission_aspirations.ResponseID = personalized_info.ResponseID
WHERE CurrentCountry = 'India'
GROUP BY MisalignedMissionLikelihood;