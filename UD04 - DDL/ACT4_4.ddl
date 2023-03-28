-- Generado por Oracle SQL Developer Data Modeler 21.2.0.183.1957
--   en:        2023-01-09 08:28:41 CET
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE acomunities (
    aco_id   VARCHAR2(5) NOT NULL,
    aco_name VARCHAR2(100) NOT NULL
);

ALTER TABLE acomunities ADD CONSTRAINT aco_pk PRIMARY KEY ( aco_id );

CREATE TABLE locations (
    loc_id     VARCHAR2(5) NOT NULL,
    loc_name   VARCHAR2(100) NOT NULL,
    loc_pro_id VARCHAR2(5) NOT NULL,
    loc_tlo_id VARCHAR2(2) NOT NULL
);

ALTER TABLE locations ADD CONSTRAINT locations_pk PRIMARY KEY ( loc_id );

CREATE TABLE provinces (
    pro_id     VARCHAR2(5) NOT NULL,
    pro_name   VARCHAR2(100) NOT NULL,
    pro_aco_id VARCHAR2(5) NOT NULL,
    pro_loc_id VARCHAR2(5) NOT NULL
);

ALTER TABLE provinces ADD CONSTRAINT pro_pk PRIMARY KEY ( pro_id );

CREATE TABLE tlocations (
    tlo_id   VARCHAR2(2) NOT NULL,
    tlo_name VARCHAR2(100) NOT NULL
);

ALTER TABLE tlocations ADD CONSTRAINT tlo_pk PRIMARY KEY ( tlo_id );

ALTER TABLE locations
    ADD CONSTRAINT loc_pro_fk FOREIGN KEY ( loc_pro_id )
        REFERENCES provinces ( pro_id );

ALTER TABLE locations
    ADD CONSTRAINT loc_tlo_fk FOREIGN KEY ( loc_tlo_id )
        REFERENCES tlocations ( tlo_id );

ALTER TABLE provinces
    ADD CONSTRAINT pro_aco_fk FOREIGN KEY ( pro_aco_id )
        REFERENCES acomunities ( aco_id );

ALTER TABLE provinces
    ADD CONSTRAINT pro_loc_fk FOREIGN KEY ( pro_loc_id )
        REFERENCES locations ( loc_id );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             4
-- CREATE INDEX                             0
-- ALTER TABLE                              8
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
