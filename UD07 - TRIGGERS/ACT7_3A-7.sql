-- Triggers
CREATE OR REPLACE TRIGGER trg_order
	BEFORE INSERT, DELETE, UPDATE
	ON orders
BEGIN
  IF (TO_CHAR (SYSDATE, 'HH24:MI') NOT BETWEEN '08:00' AND '18:00' ) OR 
     (TO_CHAR (SYSDATE, 'DY') IN ('SAT', 'SUN')) THEN
	RAISE_APPLICATION_ERROR (-20001,
		'You may only make changes during normal office hours');
  END IF;
END;
