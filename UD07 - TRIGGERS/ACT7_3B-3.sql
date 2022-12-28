INSERT INTO personas( per_id )
VALUES( '1' );

INSERT INTO personas( per_id )
VALUES( '2' );


INSERT INTO empleados( emp_per_id )
VALUES( '1' );

-- ERROR ?
INSERT INTO subcontratados ( sub_per_id )
VALUES('1');

-- ERROR ?
INSERT INTO clientes ( sub_per_id )
VALUES('1');

-- ERROR ?
DELETE FROM empleados WHERE sub_per_id = '1';
INSERT INTO subcontratados ( sub_per_id ) VALUES('1');


INSERT INTO subcontratados ( sub_per_id )
VALUES('2');

-- ERROR ?
INSERT INTO clientes ( cli_per_id )
VALUES('2');

-- ERROR ?
INSERT INTO empleados ( emp_per_id )
VALUES('2');