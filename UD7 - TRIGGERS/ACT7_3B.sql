CREATE TABLE cuentas_bancarias(
  cta_id  VARCHAR2(10) NOT NULL,
  cta_per_id  VARCHAR2(10),
  cta_emp_id  VARCHAR2(10)
);

CREATE TABLE personas(
  per_id  VARCHAR2(10) NOT NULL
);

CREATE TABLE empresas(
  emp_id  VARCHAR2(10) NOT NULL
);

CREATE TABLE empleados(
  emp_per_id  VARCHAR2(10) NOT NULL
);

CREATE TABLE clientes(
  cli_per_id  VARCHAR2(10) NOT NULL
);

CREATE TABLE subcontratados(
  sub_per_id  VARCHAR2(10) NOT NULL
);

ALTER TABLE cuentas_bancarias ADD CONSTRAINT cta_PK
  PRIMARY KEY (cta_id);
  
ALTER TABLE clientes ADD CONSTRAINT cli_PK
  PRIMARY KEY (cli_per_id);
  
ALTER TABLE personas ADD CONSTRAINT per_PK
  PRIMARY KEY (per_id);
  
ALTER TABLE empresas ADD CONSTRAINT emp_PK
  PRIMARY KEY (emp_id);

ALTER TABLE empleados ADD CONSTRAINT emp_per_PK
  PRIMARY KEY (emp_per_id);

ALTER TABLE cuentas_bancarias ADD CONSTRAINT cta_per_FK
  FOREIGN KEY (cta_per_id) REFERENCES personas(per_id);

ALTER TABLE cuentas_bancarias ADD CONSTRAINT cta_emp_FK
  FOREIGN KEY (cta_emp_id) REFERENCES empresas(emp_id);

ALTER TABLE empleados ADD CONSTRAINT emp_per_FK
  FOREIGN KEY (emp_per_id) REFERENCES personas(per_id);

ALTER TABLE subcontratados ADD CONSTRAINT sub_PK
  PRIMARY KEY (sub_per_id);

ALTER TABLE subcontratados ADD CONSTRAINT sub_per_FK
  FOREIGN KEY (sub_per_id) REFERENCES personas(per_id);

ALTER TABLE clientes ADD CONSTRAINT cli_per_FK
  FOREIGN KEY (cli_per_id) REFERENCES personas(per_id);