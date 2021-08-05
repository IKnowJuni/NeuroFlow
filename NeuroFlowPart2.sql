/* Question#1:
    How many users completed an exercise in their first month per monthly cohort?
    Assume you have two tables in our company’s database:
    'users' table, with columns 'user_id', 'created_at'
    ‘exercises’ table, with columns 'exercise_id', 'user_id', 'exercise_completion_date'
    
    Write a single SQL query that breaks up the users based on the month that they signed
    up (their cohort month), and determines the percentage of users that have a completed
    exercise in their first month for each monthly cohort (e.g., the 2018 January cohort
    has x% of users completingan exercise in their first month, 2018 February cohort has
    x% of users completing an exercise in their first month, etc.).
*/

SELECT user_id, YEAR(exercise_completion_date) AS compYear,
    month(exercise_completion_date) AS compMonth,
        (SELECT user_id, created_at, COUNT(*) * 100 / SUM(COUNT(*) AS userPercent
        FROM users GROUP BY user_id)
    FROM exercises
LEFT JOIN users ON users.user_id = exercises.user_id
AND exercises.exercise_completion_date = users.created_at
GROUP BY compYear, compMonth;


/* Question#2:
    How many users completed a given amount of exercises?
    Assume you have two tables in our company’s database:
    'users' table, with columns 'user_id', 'created_at'
    ‘exercises’ table, with columns 'exercise_id', 'user_id', 'exercise_completion_date'
    
    Write a single SQL query that returns a frequency distribution of the number of
    activities each user completed. (Ex: 1000 users completed 1 activity, 500 completed
    10 activities, 100 completed 100 activities, etc…)
*/

SELECT COUNT(user_id) as numOfAct, exercise_completion_date FROM exercise
LEFT JOIN users ON users.user_id = exercises.user_id
WHERE exercise_completion_date != null

/* Question#3:
    Which organizations have the most severe patient population?
    Assume you have two tables in our company’s database:
    ‘Providers’ table that contains ‘provider_id’, ‘organization_id’, and ‘organization_name’
    ‘Phq9’ table that contains ‘patient_id’,’provider_id’, ‘score’,’datetime_created’
    
    For context, A phq9 score ranges from 0-27 and anything 20 or above is considered severe.
    Write a single query that finds the top five organizations that have the highest average
    phq9 score per patient.
*/

SELECT provider_id, organization_name FROM providers
LEFT JOIN phq9 ON Providers.provider_id = Phq9.provider_id
WHERE Phq9.score >= 20
ORDER BY score;
