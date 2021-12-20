-- При внесенні нових даних про ім'я пілота перша літера буде великою, а ішні - малі.

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