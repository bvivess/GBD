-- Generado por Oracle SQL Developer Data Modeler 21.2.0.183.1957
--   en:        2023-01-09 08:32:33 CET
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE brands (
    bra_id          VARCHAR2(5) NOT NULL,
    bra_description VARCHAR2(100) NOT NULL
);

ALTER TABLE brands ADD CONSTRAINT bra_pk PRIMARY KEY ( bra_id );

CREATE TABLE cars (
    car_pnumber VARCHAR2(10) NOT NULL,
    car_regdate DATE NOT NULL,
    car_cus_id  VARCHAR2(5) NOT NULL,
    car_mod_id  VARCHAR2(5) NOT NULL
);

ALTER TABLE cars ADD CONSTRAINT car_pk PRIMARY KEY ( car_pnumber );

CREATE TABLE customers (
    cus_id       VARCHAR2(5) NOT NULL,
    cus_name     VARCHAR2(100) NOT NULL,
    cus_surname1 VARCHAR2(100) NOT NULL,
    cus_surname2 VARCHAR2(100)
);

ALTER TABLE customers ADD CONSTRAINT cus_pk PRIMARY KEY ( cus_id );

CREATE TABLE models (
    mod_id          VARCHAR2(5) NOT NULL,
    mod_description VARCHAR2(10) NOT NULL,
    mod_bra_id      VARCHAR2(5) NOT NULL
);

ALTER TABLE models ADD CONSTRAINT mod_pk PRIMARY KEY ( mod_id );

CREATE TABLE repairheaders (
    rhe_id          VARCHAR2(10) NOT NULL,
    rhe_deldate     DATE NOT NULL,
    rhe_estdate     DATE,
    rhe_regkm       NUMBER(5) NOT NULL,
    rhe_car_pnumber VARCHAR2(10) NOT NULL
);

ALTER TABLE repairheaders ADD CONSTRAINT rhe_pk PRIMARY KEY ( rhe_id );

CREATE TABLE repairlog (
    rlg_number      VARCHAR2(5) NOT NULL,
    rlg_description VARCHAR2(100) NOT NULL,
    rlg_rhe_id      VARCHAR2(10) NOT NULL
);

ALTER TABLE repairlog ADD CONSTRAINT rlg_pk PRIMARY KEY ( rlg_number,
                                                          rlg_rhe_id );

CREATE TABLE spareparts (
    spa_id          VARCHAR2(5) NOT NULL,
    spa_description VARCHAR2(100) NOT NULL,
    spa_tsp_id      VARCHAR2(5) NOT NULL
);

ALTER TABLE spareparts ADD CONSTRAINT spa_pk PRIMARY KEY ( spa_id );

CREATE TABLE spartsxrheaders (
    sxh_rhe_id VARCHAR2(10) NOT NULL,
    sxh_spa_id VARCHAR2(5) NOT NULL
);

ALTER TABLE spartsxrheaders ADD CONSTRAINT sxh_pk PRIMARY KEY ( sxh_rhe_id,
                                                                sxh_spa_id );

CREATE TABLE tspareparts (
    tsp_id          VARCHAR2(5) NOT NULL,
    tsp_description VARCHAR2(100) NOT NULL
);

ALTER TABLE tspareparts ADD CONSTRAINT tsp_pk PRIMARY KEY ( tsp_id );

ALTER TABLE cars
    ADD CONSTRAINT car_cus_fk FOREIGN KEY ( car_cus_id )
        REFERENCES customers ( cus_id );

ALTER TABLE cars
    ADD CONSTRAINT car_mod_fk FOREIGN KEY ( car_mod_id )
        REFERENCES models ( mod_id );

ALTER TABLE models
    ADD CONSTRAINT mod_bra_fk FOREIGN KEY ( mod_bra_id )
        REFERENCES brands ( bra_id );

ALTER TABLE repairheaders
    ADD CONSTRAINT rhe_car_fk FOREIGN KEY ( rhe_car_pnumber )
        REFERENCES cars ( car_pnumber );

ALTER TABLE repairlog
    ADD CONSTRAINT rlg_rhe_fk FOREIGN KEY ( rlg_rhe_id )
        REFERENCES repairheaders ( rhe_id );

ALTER TABLE spareparts
    ADD CONSTRAINT spa_tsp_fk FOREIGN KEY ( spa_tsp_id )
        REFERENCES tspareparts ( tsp_id );

ALTER TABLE spartsxrheaders
    ADD CONSTRAINT sxh_rhe_fk FOREIGN KEY ( sxh_rhe_id )
        REFERENCES repairheaders ( rhe_id );

ALTER TABLE spartsxrheaders
    ADD CONSTRAINT sxh_spa_fk FOREIGN KEY ( sxh_spa_id )
        REFERENCES spareparts ( spa_id );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             9
-- CREATE INDEX                             0
-- ALTER TABLE                             17
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
