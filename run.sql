--FUNCTION
CREATE OR REPLACE FUNCTION del_points(point_arg int) RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN 
   DELETE FROM results 
   WHERE results.res_id IN 
      (SELECT results.res_id from results where results.points = point_arg);
END;
$$; 

select * from results
select del_points(10)
select * from results


-- PROCEDURE
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


-- TRIGGER
CREATE TRIGGER driver_capital 
AFTER INSERT ON drivername
FOR EACH ROW EXECUTE FUNCTION upper_first_sym()



CREATE OR REPLACE FUNCTION upper_first_sym() RETURNS trigger AS
$$
     BEGIN
          UPDATE drivername
          SET driver_forename = UPPER(LEFT(driver_forename, 1)) || LOWER(SUBSTRING(driver_forename, 2, length(driver_forename))),
		      driver_surname = UPPER(LEFT(driver_surname, 1)) || LOWER(SUBSTRING(driver_surname, 2, length(driver_surname)))
			  WHERE drivername.driver_id = NEW.driver_id; 
		  RETURN NULL;
     END;
$$ LANGUAGE 'plpgsql';

select * from drivername
INSERT INTO Drivername(driver_id, driver_forename, driver_surname)
VALUES(7, 'valTTeri', 'boTTas');
select * from drivername