USE genzdataset;

SELECT *
FROM learning_aspirations
INNER Join manager_aspirations
ON learning_aspirations.ResponseID = manager_aspirations.ResponseID
INNER JOIN  mission_aspirations
ON learning_aspirations.ResponseID = mission_aspirations.ResponseID
INNER JOIN personalized_info
ON learning_aspirations.ResponseID = personalized_info.ResponseID;

-- Q1 How many Male have responded to survey from India --
SELECT 
COUNT(Gender),
CurrentCountry
FROM personalized_info
WHERE CurrentCountry = 'India' AND Gender ='Male';

-- Q2 How many Female have responded to survey from India --
SELECT 
COUNT(Gender),
CurrentCountry
FROM personalized_info
WHERE CurrentCountry = 'India' AND Gender ='Female';

-- Q3 How many generaion z are influnced by their parents in regard to their career choices from India --
SELECT COUNT(CareerInfluenceFactor) AS 'how_many_people_influence_by_their_parents',
CurrentCountry
FROM learning_aspirations
JOIN personalized_info
ON learning_aspirations.ResponseID = personalized_info.ResponseID
WHERE CareerInfluenceFactor = 'My Parents' AND CurrentCountry = 'India';

-- Q4 How many Females of generaion z are influnced by their parents in regard to their career choices from India --
SELECT COUNT(CareerInfluenceFactor) AS 'how_many_people_influence_by_their_parents',
CurrentCountry,
Gender
FROM learning_aspirations
JOIN personalized_info
ON learning_aspirations.ResponseID = personalized_info.ResponseID
WHERE CareerInfluenceFactor = 'My Parents' AND CurrentCountry = 'India' AND Gender = 'Female';

-- Q5 How many Males of generaion z are influnced by their parents in regard to their career choices from India --
SELECT COUNT(CareerInfluenceFactor) AS 'how_many_people_influence_by_their_parents',
CurrentCountry,
Gender
FROM learning_aspirations
JOIN personalized_info
ON learning_aspirations.ResponseID = personalized_info.ResponseID
WHERE CareerInfluenceFactor = 'My Parents' AND CurrentCountry = 'India' AND Gender = 'Male';

-- Q6 How many Females and Males of generaion z are influnced by their parents in regard to their career choices from India --
SELECT COUNT(CareerInfluenceFactor) AS 'how_many_people_influence_by_their_parents',
CurrentCountry,
Gender
FROM learning_aspirations
JOIN personalized_info
ON learning_aspirations.ResponseID = personalized_info.ResponseID
WHERE CareerInfluenceFactor = 'My Parents' AND CurrentCountry = 'India' AND Gender IN ('Female', 'Male')
GROUP BY Gender;

-- Q7 How many generaion z are influnced by Media and Influncers from India --
SELECT COUNT(CareerInfluenceFactor) AS 'how_many_people_influence_by_media_and_influencers',
CurrentCountry
FROM learning_aspirations
JOIN personalized_info
ON learning_aspirations.ResponseID = personalized_info.ResponseID
WHERE CareerInfluenceFactor IN ('Influencers who had successful careers','Social Media like LinkedIn') AND CurrentCountry = 'India';

-- Q8 How many Males and Females of generaion z are influnced by Media and Influncers from India --
SELECT COUNT(CareerInfluenceFactor) AS 'how_many_people_influence_by_media_and_influencers',
CurrentCountry,
Gender
FROM learning_aspirations
JOIN personalized_info
ON learning_aspirations.ResponseID = personalized_info.ResponseID
WHERE CareerInfluenceFactor IN ('Influencers who had successful careers','Social Media like LinkedIn') AND CurrentCountry = 'India' AND Gender IN('Male','Female')
GROUP BY
Gender;

-- Q9 How many generaion z who are influnced by Social Media for their career aspiration are going to abroad --
SELECT COUNT(CareerInfluenceFactor) AS 'how_many_people_influence_by_media',
HigherEducationAbroad AS 'going to abroad'
FROM learning_aspirations
WHERE CareerInfluenceFactor = 'Social Media like LinkedIn'AND HigherEducationAbroad = 'Yes, I wil';

-- Q10 How many generaion z who are influnced by Peopleof their circle for their career aspiration are going to abroad --
SELECT COUNT(CareerInfluenceFactor) AS 'how_many_people_influence_by_People_from_my_circle',
HigherEducationAbroad AS 'going to abroad'
FROM learning_aspirations
WHERE CareerInfluenceFactor = 'People from my circle, but not family members'AND HigherEducationAbroad = 'Yes, I wil';