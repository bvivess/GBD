-- Generado por Oracle SQL Developer Data Modeler 21.2.0.183.1957
--   en:        2023-01-09 08:36:33 CET
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE addresses (
    add_id     VARCHAR2(10) NOT NULL,
    add_name   VARCHAR2(100) NOT NULL,
    add_pdi_id VARCHAR2(5) NOT NULL,
    add_tad_id VARCHAR2(5) NOT NULL
);

ALTER TABLE addresses ADD CONSTRAINT add_pk PRIMARY KEY ( add_id );

CREATE TABLE authors (
    aut_id       VARCHAR2(5) NOT NULL,
    aut_name     VARCHAR2(100) NOT NULL,
    aut_surname1 VARCHAR2(100) NOT NULL,
    aut_surname2 VARCHAR2(100)
);

ALTER TABLE authors ADD CONSTRAINT aut_pk PRIMARY KEY ( aut_id );

CREATE TABLE autxtit (
    axt_tit_id VARCHAR2(5) NOT NULL,
    axt_aut_id VARCHAR2(5) NOT NULL
);

ALTER TABLE autxtit ADD CONSTRAINT axt_pk PRIMARY KEY ( axt_tit_id,
                                                        axt_aut_id );

CREATE TABLE buildings (
    bui_add_id VARCHAR2(10) NOT NULL,
    bui_code   VARCHAR2(5) NOT NULL,
    bui_name   VARCHAR2(100) NOT NULL
);

ALTER TABLE buildings ADD CONSTRAINT bui_pk PRIMARY KEY ( bui_code,
                                                          bui_add_id );

CREATE TABLE copies (
    cop_id       VARCHAR2(10) NOT NULL,
    cop_pti_isbn VARCHAR2(100) NOT NULL
);

ALTER TABLE copies ADD CONSTRAINT cop_pk PRIMARY KEY ( cop_id );

CREATE TABLE countries (
    cou_id   VARCHAR2(5) NOT NULL,
    cou_name VARCHAR2(100) NOT NULL
);

ALTER TABLE countries ADD CONSTRAINT cou_pk PRIMARY KEY ( cou_id );

CREATE TABLE locations (
    loc_id     VARCHAR2(5) NOT NULL,
    loc_name   VARCHAR2(100) NOT NULL,
    loc_pro_id VARCHAR2(5) NOT NULL
);

ALTER TABLE locations ADD CONSTRAINT loc_pk PRIMARY KEY ( loc_id );

CREATE TABLE members (
    mem_id       VARCHAR2(10) NOT NULL,
    mem_name     VARCHAR2(100) NOT NULL,
    mem_surname1 VARCHAR2(100) NOT NULL,
    mem_surname2 VARCHAR2(100),
    mem_dni      VARCHAR2(10) NOT NULL,
    mem_bui_code VARCHAR2(5) NOT NULL,
    mem_bui_id   VARCHAR2(10) NOT NULL
);

ALTER TABLE members ADD CONSTRAINT mem_pk PRIMARY KEY ( mem_id );

ALTER TABLE members ADD CONSTRAINT mem_dni_un UNIQUE ( mem_dni );

CREATE TABLE memxtty (
    mxt_mem_id  VARCHAR2(10) NOT NULL,
    mxt_tty_id  VARCHAR2(5) NOT NULL,
    mxt_tnumber VARCHAR2(10) NOT NULL
);

ALTER TABLE memxtty ADD CONSTRAINT mxt_pk PRIMARY KEY ( mxt_mem_id,
                                                        mxt_tty_id );

CREATE TABLE pdistricts (
    pdi_id     VARCHAR2(5) NOT NULL,
    pdi_name   VARCHAR2(100) NOT NULL,
    pdi_loc_id VARCHAR2(5) NOT NULL
);

ALTER TABLE pdistricts ADD CONSTRAINT pdi_pk PRIMARY KEY ( pdi_id );

CREATE TABLE provinces (
    pro_id     VARCHAR2(5) NOT NULL,
    pro_name   VARCHAR2(100) NOT NULL,
    pro_cou_id VARCHAR2(5) NOT NULL
);

ALTER TABLE provinces ADD CONSTRAINT pro_pk PRIMARY KEY ( pro_id );

CREATE TABLE ptitles (
    pti_isbn   VARCHAR2(100) NOT NULL,
    pti_tit_id VARCHAR2(5) NOT NULL,
    pti_pub_id VARCHAR2(5) NOT NULL
);

ALTER TABLE ptitles ADD CONSTRAINT pti_pk PRIMARY KEY ( pti_isbn );

ALTER TABLE ptitles ADD CONSTRAINT pti_un UNIQUE ( pti_tit_id,
                                                   pti_pub_id );

CREATE TABLE publishers (
    pub_id   VARCHAR2(5) NOT NULL,
    pub_name VARCHAR2(100) NOT NULL
);

ALTER TABLE publishers ADD CONSTRAINT publishers_pk PRIMARY KEY ( pub_id );

CREATE TABLE rhexcop (
    rxc_rse_id       VARCHAR2(10) NOT NULL,
    rxc_cop_id       VARCHAR2(10) NOT NULL,
    rxc_cop_pti_isbn VARCHAR2(100) NOT NULL
);

ALTER TABLE rhexcop ADD CONSTRAINT rxc_pk PRIMARY KEY ( rxc_rse_id,
                                                        rxc_cop_id );

CREATE TABLE rservices (
    rse_id        VARCHAR2(10) NOT NULL,
    rse_date      DATE NOT NULL,
    rse_hour      VARCHAR2(5) NOT NULL,
    rse_startdate DATE NOT NULL,
    rse_enddate   DATE NOT NULL,
    rse_mem_id    VARCHAR2(10) NOT NULL
);

ALTER TABLE rservices ADD CONSTRAINT rse_pk PRIMARY KEY ( rse_id );

CREATE TABLE taddress (
    tad_id          VARCHAR2(5) NOT NULL,
    tad_description VARCHAR2(100) NOT NULL
);

ALTER TABLE taddress ADD CONSTRAINT type_of_address_pk PRIMARY KEY ( tad_id );

CREATE TABLE titles (
    tit_id     VARCHAR2(5) NOT NULL,
    tit_title  VARCHAR2(100) NOT NULL,
    tit_tit_id VARCHAR2(5) NOT NULL
);

ALTER TABLE titles ADD CONSTRAINT tit_pk PRIMARY KEY ( tit_id );

CREATE TABLE ttypes (
    tty_id          VARCHAR2(5) NOT NULL,
    tty_description VARCHAR2(100) NOT NULL
);

ALTER TABLE ttypes ADD CONSTRAINT tty_pk PRIMARY KEY ( tty_id );

ALTER TABLE addresses
    ADD CONSTRAINT add_pdi_fk FOREIGN KEY ( add_pdi_id )
        REFERENCES pdistricts ( pdi_id );

ALTER TABLE addresses
    ADD CONSTRAINT add_tad_fk FOREIGN KEY ( add_tad_id )
        REFERENCES taddress ( tad_id );

ALTER TABLE autxtit
    ADD CONSTRAINT axt_aut_fk FOREIGN KEY ( axt_aut_id )
        REFERENCES authors ( aut_id );

ALTER TABLE autxtit
    ADD CONSTRAINT axt_tit_fk FOREIGN KEY ( axt_tit_id )
        REFERENCES titles ( tit_id );

ALTER TABLE buildings
    ADD CONSTRAINT bui_add_fk FOREIGN KEY ( bui_add_id )
        REFERENCES addresses ( add_id );

ALTER TABLE copies
    ADD CONSTRAINT cop_pti_fk FOREIGN KEY ( cop_pti_isbn )
        REFERENCES ptitles ( pti_isbn );

ALTER TABLE locations
    ADD CONSTRAINT loc_pro_fk FOREIGN KEY ( loc_pro_id )
        REFERENCES provinces ( pro_id );

ALTER TABLE members
    ADD CONSTRAINT mem_bui_fk FOREIGN KEY ( mem_bui_code,
                                            mem_bui_id )
        REFERENCES buildings ( bui_code,
                               bui_add_id );

ALTER TABLE memxtty
    ADD CONSTRAINT mxt_mem_fk FOREIGN KEY ( mxt_mem_id )
        REFERENCES members ( mem_id );

ALTER TABLE memxtty
    ADD CONSTRAINT mxt_tty_fk FOREIGN KEY ( mxt_tty_id )
        REFERENCES ttypes ( tty_id );

ALTER TABLE pdistricts
    ADD CONSTRAINT pdi_loc_fk FOREIGN KEY ( pdi_loc_id )
        REFERENCES locations ( loc_id );

ALTER TABLE provinces
    ADD CONSTRAINT pro_cou_fk FOREIGN KEY ( pro_cou_id )
        REFERENCES countries ( cou_id );

ALTER TABLE ptitles
    ADD CONSTRAINT pti_pub_fk FOREIGN KEY ( pti_pub_id )
        REFERENCES publishers ( pub_id );

ALTER TABLE ptitles
    ADD CONSTRAINT pti_tit_fk FOREIGN KEY ( pti_tit_id )
        REFERENCES titles ( tit_id );

ALTER TABLE rservices
    ADD CONSTRAINT rse_mem_fk FOREIGN KEY ( rse_mem_id )
        REFERENCES members ( mem_id );

ALTER TABLE rhexcop
    ADD CONSTRAINT rxc_cop_fk FOREIGN KEY ( rxc_cop_id )
        REFERENCES copies ( cop_id );

ALTER TABLE rhexcop
    ADD CONSTRAINT rxc_rse_fk FOREIGN KEY ( rxc_rse_id )
        REFERENCES rservices ( rse_id );

ALTER TABLE titles
    ADD CONSTRAINT tit_tit_fk FOREIGN KEY ( tit_tit_id )
        REFERENCES titles ( tit_id );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            18
-- CREATE INDEX                             0
-- ALTER TABLE                             38
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
