EMPLOYEES
Employee_id Name       Manager_id   Salary(NN)
-----------	---------- -----------  ------
100         KING       (null)         1000


CUSTOMERS
Customer_id Name                      Employee_id(NN)
----------- ------------------------- -----------
100         NAUTICA ALGAR             101
101         PANUNPACO SL              101
102         AGLOMSA                   102
103         HIERROS Y ACEROS          102
104         CARTONERA ELOY            102
105         TELSEC SA                 102
106         ZANZINI MUEBLES           201
107         ARTCRETE                  202
108         IMPROCER SA               202
109         MOLER SA                  202

CREATE TABLE EMPLOYEES(
	employee_id NUMBER(6) NOT NULL, 
	name        VARCHAR2(100) NOT NULL, 
	manager_id  NUMBER(6), 
	salary      NUMBER(8,2),
	CONSTRAINT emp_pk PRIMARY KEY (employee_id) USING INDEX
);

INSERT INTO EMPLOYEES( Employee_id, Name, Manager_id, Salary )
	VALUES( 100, 'KING', null, 1000 );
INSERT INTO EMPLOYEES( Employee_id, Name, Manager_id, Salary )
	VALUES( 101, 'ROSE', 100,  500 );
INSERT INTO EMPLOYEES( Employee_id, Name, Manager_id, Salary )
	VALUES( 102, 'BEDFORD', 100,  500 );
INSERT INTO EMPLOYEES( Employee_id, Name, Manager_id, Salary )
	VALUES( 103, 'MCILROY', 100,  500 );
INSERT INTO EMPLOYEES( Employee_id, Name, Manager_id, Salary )
	VALUES( 200, 'REDMON', null, 1000 );
INSERT INTO EMPLOYEES( Employee_id, Name, Manager_id, Salary )
	VALUES( 201, 'MOORE', 200,  200 );
INSERT INTO EMPLOYEES( Employee_id, Name, Manager_id, Salary )
	VALUES( 202, 'MEMPHIS', 200,  200 );
INSERT INTO EMPLOYEES( Employee_id, Name, Manager_id, Salary )
	VALUES( 300, 'BARRYMORE', null, 1000 );

CREATE TABLE CUSTOMERS(
	customer_id     NUMBER(6) NOT NULL,
	name            VARCHAR2(100) NOT NULL,
	employee_id     NUMBER(6),
	CONSTRAINT cus_pk PRIMARY KEY (customer_id) USING INDEX,
	CONSTRAINT cus_emp_fk FOREIGN KEY(employee_id) REFERENCES employees(employee_id)
);

INSERT INTO CUSTOMERS( Customer_id, Name, Employee_id )
	VALUES( 100,         'NAUTICA ALGAR',             101 );
INSERT INTO CUSTOMERS( Customer_id, Name, Employee_id )
	VALUES( 101,         'PANUNPACO SL',              101 );
INSERT INTO CUSTOMERS( Customer_id, Name, Employee_id )
	VALUES( 102,         'AGLOMSA',                   102 );
INSERT INTO CUSTOMERS( Customer_id, Name, Employee_id )
	VALUES( 103,         'HIERROS Y ACEROS',          102 );
INSERT INTO CUSTOMERS( Customer_id, Name, Employee_id )
	VALUES( 104,         'CARTONERA ELOY',            102 );
INSERT INTO CUSTOMERS( Customer_id, Name, Employee_id )
	VALUES( 105,         'TELSEC SA',                 102 );
INSERT INTO CUSTOMERS( Customer_id, Name, Employee_id )
	VALUES( 106,         'ZANZINI MUEBLES' ,          201 );
INSERT INTO CUSTOMERS( Customer_id, Name, Employee_id )
	VALUES( 107,         'ARTCRETE',                  202 );
INSERT INTO CUSTOMERS( Customer_id, Name, Employee_id )
	VALUES( 108,         'IMPROCER SA',               202 );
INSERT INTO CUSTOMERS( Customer_id, Name, Employee_id )
	VALUES( 109,         'MOLER SA',                  202 );

