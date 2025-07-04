-- =============================================== --
-- SQL Query Set for Skill Connect Platform        --       
-- =============================================== --

-- 1. List companies in a specific state with contracts shorter than X months
SELECT DISTINCT  
    c.company_name,
    con.contract_start_date,
    con.contract_end_date
FROM company c  
JOIN offers o ON c.cid = o.cid  
JOIN contract con ON o.offer_id = con.offer_id  
JOIN offices off ON c.cid = off.cid  
WHERE off.state = 'Karnataka'  
AND (con.contract_end_date - con.contract_start_date) < (5 * 30); -- Adjust "5" as needed

-- 2. Find users who have both job and internship experiences
SELECT DISTINCT u.user_id, u.user_name  
FROM user_t u  
WHERE u.user_id IN (SELECT e.user_id FROM experience e)  
  AND u.user_id IN (SELECT ie.eid FROM internship_experience ie); 

-- 3. List skills by descending frequency based on job market demand
SELECT skill_name, COUNT(*) AS frequency  
FROM (  
    SELECT skill_name  
    FROM offers  
    JOIN skills ON offers.skill_required = skills.skill_name  
) AS subquery  
GROUP BY skill_name  
ORDER BY frequency DESC;

-- 4. Application status for a specific user and company
SELECT u.user_name, c.company_name, a.status  
FROM user_t u  
JOIN apply a ON u.user_id = a.user_id  
JOIN offers o ON a.offer_id = o.offer_id  
JOIN company c ON o.cid = c.cid  
WHERE a.user_id = 8  
  AND c.company_name = 'Wipro Limited';

-- 5. Offers requiring skills possessed by users who applied but weren’t accepted
SELECT DISTINCT o.offer_id, o.role, o.skill_required  
FROM offers o  
JOIN apply a ON o.offer_id = a.offer_id  
JOIN possess p ON a.user_id = p.user_id AND o.skill_required = p.skill_name 
WHERE a.status <> 'Accepted';

-- 6. State-wise count of all users
SELECT state, COUNT(user_id) AS user_count  
FROM user_t  
GROUP BY state;

-- 7. State-wise list of all companies and their office locations
SELECT c.cid, c.company_name, c.website_link, o.city, o.state  
FROM company c  
NATURAL JOIN offices o;

-- 8. Average salary offered for roles with at least one vacancy
SELECT o.role, AVG(o.salary) AS average_salary  
FROM offers o  
GROUP BY o.role  
HAVING COUNT(o.offer_id) >= 1;

-- 9. Top 7 offers with highest vacancies and respective companies
SELECT o.offer_id, o.role, c.company_name, o.number_of_vacancies  
FROM offers o  
JOIN company c ON o.cid = c.cid  
ORDER BY o.number_of_vacancies DESC  
LIMIT 7;

-- 10. List all registered users with their details
SELECT user_id, user_name, github_handle, codeforces_handle, leetcode_handle, dob, city, state  
FROM user_t;

-- 11. Users with JEE percentile > 90 and CGPA > 8
SELECT u.user_id, u.user_name, s.JEE_percentile, c.CGPA  
FROM user_t u  
JOIN schooling s ON u.user_id = s.user_id  
JOIN completed c ON u.user_id = c.user_id  
WHERE s.JEE_percentile > 90 AND c.CGPA > 8;

-- 12. Top 5 companies with most applied offers
SELECT c.company_name, COUNT(DISTINCT a.offer_id) AS total_applied_offers  
FROM company c  
JOIN offers o ON c.cid = o.cid  
JOIN apply a ON o.offer_id = a.offer_id  
GROUP BY c.company_name  
ORDER BY total_applied_offers DESC  
LIMIT 5;

-- 13. Companies that currently have no job offers
SELECT c.company_name  
FROM company c  
LEFT JOIN offers o ON c.cid = o.cid  
WHERE o.offer_id IS NULL;

-- 14. Highest salary offered for each role
SELECT role, MAX(salary) AS highest_salary  
FROM offers  
GROUP BY role;

-- 15. Companies that offer roles requiring skills no user possesses
SELECT DISTINCT c.company_name, o.skill_required  
FROM company c  
JOIN offers o ON c.cid = o.cid  
WHERE NOT EXISTS (
    SELECT 1  
    FROM possess p  
    WHERE p.skill_name = o.skill_required
);

-- 16. List all registered companies with their office details
SELECT c.cid, c.company_name, c.website_link, o.city, o.state  
FROM company c  
NATURAL JOIN offices o;

-- 17. List all active job openings (future end date)
SELECT *  
FROM offers  
WHERE end_date > CURRENT_DATE;

-- 18. Average salary of offers per state for a specific skill
SELECT o.state, AVG(off.salary) AS avg_salary  
FROM offices o  
JOIN company c ON o.cid = c.cid  
JOIN offers off ON c.cid = off.cid  
WHERE off.skill_required = 'Android Development'  
GROUP BY o.state;
