USE department_staff;

-- 1 --
DROP TRIGGER IF EXISTS subject_delete_structural_integrity;
Delimiter //
CREATE TRIGGER
subject_delete_structural_integrity
BEFORE DELETE 
ON subjects FOR EACH ROW
BEGIN 
	UPDATE employee SET employee.subject_id = null WHERE employee.subject_id=old.id;
END//
Delimiter ;

DROP TRIGGER IF EXISTS academic_rank_delete_structural_integrity;
Delimiter //
CREATE TRIGGER
academic_rank_delete_structural_integrity
BEFORE DELETE 
ON academic_rank FOR EACH ROW
BEGIN 
	UPDATE employee SET employee.academic_rank_id = null WHERE employee.academic_rank_id=old.id;
END//
Delimiter ;

DROP TRIGGER IF EXISTS subject_update_structural_integrity;
Delimiter //
CREATE TRIGGER
subject_update_structural_integrity
BEFORE UPDATE 
ON subjects FOR EACH ROW
BEGIN 
	IF OLD.id IN (SELECT subject_id FROM employee) THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Oops, foreign key reference to subject primary key';
    END IF;
END//
Delimiter ;

DROP TRIGGER IF EXISTS academic_rank_update_structural_integrity;
Delimiter //
CREATE TRIGGER
academic_rank_update_structural_integrity
BEFORE UPDATE 
ON academic_rank FOR EACH ROW
BEGIN 
	IF OLD.id IN (SELECT academic_rank_id FROM employee) THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Oops, foreign key reference to academic rank primary key';
    END IF;
END//
Delimiter ;

DROP TRIGGER IF EXISTS employee_insert_foreign_keys_structural_integrity;
Delimiter //
CREATE TRIGGER
employee_insert_foreign_keys_structural_integrity
BEFORE INSERT 
ON employee FOR EACH ROW
BEGIN 
	IF NEW.academic_rank_id NOT IN (SELECT id FROM academic_rank) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Oops, no one academic rank with this id';
    ELSEIF NEW.subject_id NOT IN (SELECT id FROM subjects) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Oops, no one subject with this id';    
    END IF;
END//
Delimiter ;

-- 2 --
DROP TRIGGER IF EXISTS passport_code_validation;
Delimiter //
CREATE TRIGGER
passport_code_validation
BEFORE INSERT 
ON employee FOR EACH ROW
BEGIN 
	IF NOT (SELECT NEW.passport_code REGEXP '^[A-Za-z]{2} [0-9]{6}') THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Wrong passport_code';
	END IF;
END//
Delimiter ;

-- 3 --
DROP TRIGGER IF EXISTS employee_name_validation;
Delimiter //
CREATE TRIGGER
employee_name_validation
BEFORE INSERT
ON employee FOR EACH ROW
BEGIN
	IF NEW.name NOT IN ('Андрій', 'Оля', 'Володимир', 'Оксана') THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Wrong name';
	END IF;
END//
Delimiter ;

-- 4 -- 
DROP TRIGGER IF EXISTS academic_rank_update_forbidden;
Delimiter //
CREATE TRIGGER
academic_rank_update_forbidden
BEFORE UPDATE
ON academic_rank FOR EACH ROW
BEGIN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'you cannot update this table';
END//
Delimiter ;