CREATE TABLE telephone_types(
  tty_id        	VARCHAR2(5) NOT NULL,
  tty_description	VARCHAR2(30)
);

ALTER TABLE telephone_types ADD CONSTRAINT PRIMARY ...

CREATE TABLE customer_telephones(
  tel_customer_id	DECIMAL(6) NOT NULL,
  tel_tty_id        VARCHAR2(5) NOT NULL,
  tel_number		VARCHAR(30) NOT NULL
);

--
INSERT INTO telephone_types( tty_id, tty_description )
VALUES( '1', 'Home');
INSERT INTO telephone_types( tty_id, tty_description )
VALUES( '2', 'Mobile');
INSERT INTO telephone_types( tty_id, tty_description )
VALUES('3', 'Work');
INSERT INTO telephone_types( tty_id, tty_description )
VALUES('4', 'Fax');
--
INSERT INTO customer_telephones( tel_customer_id, tel_tty_id, tel_number )
		-- First phone
		SELECT customer_id, '1' tty_id, LTRIM(RTRIM(SUBSTR(phone_numbers, 1, 15 ))) 
		FROM customers
		WHERE phone_numbers IS NOT NULL
	UNION
		-- Second phone
		SELECT customer_id, '2' tty_id, LTRIM(RTRIM(SUBSTR(phone_numbers, 17, 15 ))) 
		FROM customers
		WHERE LTRIM(RTRIM(SUBSTR(phone_numbers, 17, 15 ))) != '';

--
ALTER TABLE customer_telephones DROP CONSTRAINT PRIMARY ...

ALTER TABLE customer_telephones ADD CONSTRAINT PRIMARY ...

ALTER TABLE customer_telephones ADD CONSTRAINT FOREIGN ...