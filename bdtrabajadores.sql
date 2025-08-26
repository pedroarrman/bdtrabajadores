/**
 *bdtrabajadoresInternos.sql
 *Script de creacción de la base de datos
 */

/** borra la base de datos si existe. */
drop database if exists BDTrabajadores;

/** Crea la base de datos. */
create database BDTrabajadores;

/** Crea el usuario para acceder a la base de datos. */
create or replace user 'UBDTrabajadores'@'localhost'
        identified by 'Lo-1234-lo';

/** concede privilegios al usuario para acceder a la base de datos. */
grant select, insert, update, delete on UBDTrabajadores.*
    to 'UBDTrabajadores'@'localhost';

/** Selecciona la base de datos. */
use BDTrabajadores;

/** Crea las tablas. */

/** Tablas maestras. */
CREATE TABLE departamento (
    codDepartamento INT PRIMARY KEY,
    descripcion VARCHAR(255)
);

CREATE TABLE empresa (
    codigoEmpresa INT PRIMARY KEY,
    nombreEmpresa VARCHAR(100)
);

CREATE TABLE nombrePuesto (
    codigoPuesto INT PRIMARY KEY,
    descripcion VARCHAR(255)
);

CREATE TABLE nombreCuadrilla (
    codigoCuadrilla INT PRIMARY KEY,
    descripcion VARCHAR(255)
);

CREATE TABLE zona (
    codigoZona INT PRIMARY KEY,
    descripcion VARCHAR(50)
);

CREATE TABLE tipoTrabajador (
    codigoTipo INT PRIMARY KEY,
    descripcion VARCHAR(50)
);

CREATE TABLE tipoFijo (
    tipoFijo INT PRIMARY KEY,
    descripcion VARCHAR(255)
);

CREATE TABLE tipoEstado (
    codigoEstado INT PRIMARY KEY,
    descripcion VARCHAR(255)
);

CREATE TABLE nacionalidadTrabajador (
    codigoNacionalidad INT PRIMARY KEY,
    descripcion VARCHAR(50)
);

CREATE TABLE ett (
    codigoEtt INT PRIMARY KEY,
    nombreEtt VARCHAR(100)
);

CREATE TABLE trabajador (
    codigoTrabajador INT PRIMARY KEY,
    nombreCompleto VARCHAR(100),
    dni VARCHAR(15) NOT NULL UNIQUE,
    fechaNacimiento DATETIME,
    codigoTipo INT,
    codigoNacionalidad INT,
    codigoEstado INT,
    FOREIGN KEY (codigoTipo) REFERENCES tipoTrabajador(codigoTipo),
    FOREIGN KEY (codigoNacionalidad) REFERENCES nacionalidadTrabajador(codigoNacionalidad),
    FOREIGN KEY (codigoEstado) REFERENCES tipoEstado(codigoEstado)
);

/** Tablas de procesos. */
CREATE TABLE externo (
    codigoExterno INT PRIMARY KEY,
    codigoTipo INT,
    codigoTrabajador INT,
    codigoEtt INT,
    codigoZona INT,
    FOREIGN KEY (codigoTrabajador) REFERENCES trabajador(codigoTrabajador),
    FOREIGN KEY (codigoTipo) REFERENCES tipoTrabajador(codigoTipo),
    FOREIGN KEY (codigoZona) REFERENCES zona(codigoZona),
    FOREIGN KEY (codigoEtt) REFERENCES ett(codigoEtt)
);

CREATE TABLE ita (
    codigoIta INT PRIMARY KEY,
    fechaIta DATETIME,
    codigoEtt INT,
    FOREIGN KEY (codigoEtt) REFERENCES ett(codigoEtt)
);

CREATE TABLE cpd (
    codCpd INT PRIMARY KEY,
    codigoExterno INT,
    codigoEmpresa INT,
    fechaCpd DATETIME,
    fechaFin DATETIME,
    numAfiliacionSS VARCHAR(13),
    codigoIta INT,
    FOREIGN KEY (codigoExterno) REFERENCES externo(codigoExterno),
    FOREIGN KEY (codigoEmpresa) REFERENCES empresa(codigoEmpresa),
    FOREIGN KEY (codigoIta) REFERENCES ita(codigoIta)
);

CREATE TABLE itaTrabajador (
    numAfiliacionSS VARCHAR(13) NOT NULL PRIMARY KEY,
    codigoIta INT,
    fechaAltaTrabajador DATETIME,
    codigoExterno INT,
    FOREIGN KEY (codigoIta) REFERENCES ita(codigoIta),
    FOREIGN KEY (codigoExterno) REFERENCES externo(codigoExterno)
);

CREATE TABLE eventual (
    codigoEventual INT,
    tipoFijo INT NOT NULL,
    codigoTrabajador INT NOT NULL,
    codigoCuadrilla INT,
    PRIMARY KEY (codigoEventual, codigoTrabajador, tipoFijo),
    FOREIGN KEY (codigoTrabajador) REFERENCES trabajador(codigoTrabajador),
    FOREIGN KEY (tipoFijo) REFERENCES tipoFijo(tipoFijo),
    FOREIGN KEY (codigoCuadrilla) REFERENCES nombreCuadrilla(codigoCuadrilla)
);

CREATE TABLE contrato (
    codContrato INT PRIMARY KEY,
    codTrabajador INT,
    codEmpresa INT,
    fechaContrato DATETIME,
    fechaFinContrato DATETIME,
    codDepartamento INT,
    codPuesto INT,
    FOREIGN KEY (codTrabajador) REFERENCES trabajador(codigoTrabajador),
    FOREIGN KEY (codEmpresa) REFERENCES empresa(codigoEmpresa),
    FOREIGN KEY (codDepartamento) REFERENCES departamento(codDepartamento),
    FOREIGN KEY (codPuesto) REFERENCES nombrePuesto(codigoPuesto)
);

CREATE TABLE bajaTrabajador (
    codigoBaja INT PRIMARY KEY,
    codigoTrabajador INT,
    fechaInicioBaja DATETIME,
    fechaFinEstimada DATETIME,
    motivo VARCHAR(255),
    observaciones VARCHAR(255),
    codigoEstado INT,
    FOREIGN KEY (codigoTrabajador) REFERENCES trabajador(codigoTrabajador),
    FOREIGN KEY (codigoEstado) REFERENCES tipoEstado(codigoEstado)
);

CREATE TABLE partesAsistencia (
    fechaParte DATETIME NOT NULL,
    codigoTrabajador INT NOT NULL,
    codigoEmpresa INT NOT NULL,
    PRIMARY KEY (fechaParte, codigoTrabajador, codigoEmpresa),
    FOREIGN KEY (codigoTrabajador) REFERENCES trabajador(codigoTrabajador),
    FOREIGN KEY (codigoEmpresa) REFERENCES empresa(codigoEmpresa)
);

CREATE TABLE partesTrabajo (
    fechaParte DATETIME NOT NULL,
    codigoTrabajador INT NOT NULL,
    codigoEmpresa INT NOT NULL,
    PRIMARY KEY (fechaParte, codigoTrabajador, codigoEmpresa),
    FOREIGN KEY (codigoTrabajador) REFERENCES trabajador(codigoTrabajador),
    FOREIGN KEY (codigoEmpresa) REFERENCES empresa(codigoEmpresa)
);
