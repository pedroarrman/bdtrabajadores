/**
 *bdtrabajadoresInternos.sql
 *Script de creacción de la base de datos
 */

/** borra la base de datos si existe. */
drop database if exists BDProcesosSeleccion;

/** Crea la base de datos. */
create database BDProcesosSeleccion;

/** Crea el usuario para acceder a la base de datos. */
create or replace user 'UBDProcesosSeleccion'@'localhost'
        identified by 'Lo-1234-lo';

/** concede privilegios al usuario para acceder a la base de datos. */
grant select, insert, update, delete on UBDProcesosSeleccion.*
    to 'UBDProcesosSeleccion'@'localhost';

/** Selecciona la base de datos. */
use BDProcesosSeleccion;

/** Crea las tablas. */
CREATE TABLE Candidaturas (
    ID_Candidatura INTEGER,
    ID_Proceso INTEGER,
    Sexo TEXT(255),
    Estado TEXT(255),
    CONSTRAINT PK_Candidaturas PRIMARY KEY (ID_Candidatura)
);


CREATE TABLE Contratos (
    ID_Contrato INTEGER,
    ID_Candidatura INTEGER,
    Fecha_Contrato DATETIME,
    CONSTRAINT PK_Contratos PRIMARY KEY (ID_Contrato)
);


CREATE TABLE FasesDeLosProcesos (
    ID_Fase INTEGER,
    ID_Proceso INTEGER,
    Estado TEXT(255),
    Fecha DATETIME,
    CONSTRAINT PK_FasesDeLosProcesos PRIMARY KEY (ID_Fase)
);


CREATE TABLE PreSelecciones (
    ID_PreSeleccion INTEGER,
    ID_Fase INTEGER,
    ID_Candidatura INTEGER,
    Estado TEXT(255),
    CONSTRAINT PK_PreSelecciones PRIMARY KEY (ID_PreSeleccion)
);


CREATE TABLE ProcesosDeSeleccion (
    ID_Proceso INTEGER,
    Nombre_Proceso TEXT(255),
    Fecha_Inicio DATETIME,
    Fecha_Fin DATETIME,
    Descripcion TEXT(255),
    CONSTRAINT PK_ProcesosDeSeleccion PRIMARY KEY (ID_Proceso)
);
