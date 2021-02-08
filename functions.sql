USE department_staff;

-- 1 --
DROP FUNCTION IF EXISTS get_average_work_experiance;
Delimiter //
CREATE FUNCTION get_average_work_experiance()
RETURNS DOUBLE
DETERMINISTIC
BEGIN
	DECLARE avg_exp DOUBLE DEFAULT 0;
    SELECT ROUND(AVG(work_experience), 2) INTO avg_exp
    FROM employee;
	RETURN avg_exp;
END//
Delimiter ;
-- SELECT * FROM employee WHERE work_experience > get_average_work_experiance();

-- 2 --
DROP FUNCTION IF EXISTS get_rank_employee_by_id;
Delimiter //
CREATE FUNCTION get_rank_employee_by_id(id INT)
RETURNS VARCHAR(40) 
DETERMINISTIC
BEGIN
	RETURN (SELECT academic_rank.name
    FROM academic_rank
    JOIN employee ON academic_rank.id=employee.id
    WHERE academic_rank.id=id);
END//
Delimiter ;
-- SELECT *, get_rank_employee_by_id(id)
-- FROM employee;





