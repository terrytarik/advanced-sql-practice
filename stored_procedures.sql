USE department_staff;

-- 1 --
DROP PROCEDURE IF EXISTS subjects_insert;
Delimiter //
CREATE PROCEDURE subjects_insert(
    name VARCHAR(40),
    course INT
)
BEGIN
	INSERT INTO subjects(name, course)
    VALUES (name, course);
END//
Delimiter ;
-- CALL subjects_insert('alghorithms and data structures', 2);

-- 2 --
DROP PROCEDURE IF EXISTS academic_rank_insert_10_strings;
Delimiter //
CREATE PROCEDURE academic_rank_insert_10_strings()
BEGIN
	DECLARE count INT;
    SET count = 1;
    WHILE count <= 10 
		DO
			SET @temp = Concat('Noname', count );
			INSERT INTO academic_rank(name) VALUES(@temp);
			SET count = count + 1;
		END WHILE;
END//
Delimiter ;
-- CALL academic_rank_insert_10_strings();

-- 3 --
DROP PROCEDURE IF EXISTS create_db_of_subject_tables;
Delimiter //
CREATE PROCEDURE create_db_of_subject_tables()
BEGIN
	DECLARE done INT DEFAULT 0;
	DECLARE subjectName VARCHAR(30);
	DECLARE count INT;

	DECLARE subjects_cursor CURSOR
	FOR SELECT name FROM subjects;

	DECLARE CONTINUE handler 
	FOR NOT FOUND SET done=1;

	OPEN subjects_cursor;
    
	create_db_loop: LOOP
		FETCH subjects_cursor INTO subjectName;
		
		IF done=1 THEN LEAVE create_db_loop;
		END IF;
	
		SET @delete_db_query = CONCAT('DROP DATABASE IF EXISTS ', subjectName);
		PREPARE delete_db_query FROM @delete_db_query;
		EXECUTE delete_db_query;
		DEALLOCATE PREPARE delete_db_query;
			
		SET @create_db_query = CONCAT('CREATE DATABASE ', subjectName);
		PREPARE create_db_query FROM @create_db_query;
		EXECUTE create_db_query;
		DEALLOCATE PREPARE create_db_query;
    
		SET @rand = FLOOR(RAND()*(9-1+1))+1;
       
		SET count = 1;
		create_tables_loop: LOOP
			IF count > @rand THEN LEAVE create_tables_loop;
            END IF;
            
			SET @delete_table_query = CONCAT('DROP TABLE IF EXISTS ', subjectName, ".", subjectName, "_", count);
			PREPARE delete_table_query FROM @delete_table_query;
			EXECUTE delete_table_query;
			DEALLOCATE PREPARE delete_table_query;
					
			SET @create_table_query = CONCAT('CREATE TABLE ', subjectName, ".", subjectName, "_", count, "(
				id INT PRIMARY KEY AUTO_INCREMENT,
				col1 VARCHAR(20), 
				col2 VARCHAR(20) 
			)");
			PREPARE create_table_query FROM @create_table_query;
			EXECUTE create_table_query;
			DEALLOCATE PREPARE create_table_query;
            SET count = count + 1;
		END LOOP;
	END LOOP;
	CLOSE subjects_cursor;
END//
Delimiter ;
-- CALL create_db_of_subject_tables();