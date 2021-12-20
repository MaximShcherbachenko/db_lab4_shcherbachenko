--Виводить Ім'я та прізвище пілота та його очки 

CREATE OR REPLACE PROCEDURE get_points(driver_arg varchar(50))
LANGUAGE 'plpgsql'
AS $$
DECLARE record_forename drivername.driver_forename%TYPE;
DECLARE record_surname drivername.driver_surname%TYPE;
DECLARE record_points results.points%TYPE;


BEGIN
    SELECT driver_forename, driver_surname, points into record_forename, record_surname, record_points FROM drivername join results using(driver_id) WHERE driver_id = driver_arg;
    RAISE INFO 'Driver_name: % %, Driver_points: %', TRIM(record_forename), TRIM(record_surname), record_points;
END;
$$;

CALL get_points('3');