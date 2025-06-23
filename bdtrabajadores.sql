/**
 *bdtrabajadores.sql
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
CREATE TABLE TipoSexo (
    codigoSexo int primary key,
    descripcion varchar(255),  
);

CREATE TABLE TipoNacionalidad (
    codigoNacionalidad int primary key,
    descripcion varchar(255),
);

CREATE TABLE Empresa (
    codigoEmpresa int primary key,
    nombreEmpresa varchar(100)
);

CREATE TABLE Ett (
    codigoEtt int primary key,
    nombreEtt varchar(100)
);

CREATE TABLE Trabajador (
    codigoTrabajador int primary key,
    nombreCompleto varchar(100),
    dni varchar(15),
    fechaNacimiento date,
    codigoSexo int,
    codigoNacionalidad int(255),
    numAfiliacionSS varchar(255),
    foreign key (codigoSexo) references TipoSexo(codigoSexo),
    foreign key (codigoNacionalidad) references TipoNacionalidad(codigoNacionalidad)
);

CREATE TABLE Cpd (
    codCpd int primary key,
    codigoTrabajador int,
    codigoEmpresa int,
    codigoEtt int,
    fechaCpd date,
    fechaAltaTrabajador date,
    foreign key (codigoTrabajador) references Trabajador(codigoTrabajador),
    foreign key (codigoEmpresa) references Empresa(codigoEmpresa),
    foreign key (codigoEtt) references Ett(codigoEtt),
        on update cascade
        on delete no action
);

CREATE TABLE PartesAsistencia (
    fechaParte date not null,
    codigoTrabajador int not null,
    codigoEmpresa int not null,
    primary key (fechaParte, codigoTrabajador, codigoEmpresa),
    foreign key (codigoTrabajador) references Trabajador(codigoTrabajador),
    foreign key (codigoEmpresa) references Empresa(codigoEmpresa),
        on update cascade
        on delete no action
);


CREATE TABLE PartesTrabajo (
    fechaParte date not null,
    codigoTrabajador int not null,
    codigoEmpresa int not null,
    primary key (fechaParte, codigoTrabajador, codigoEmpresa),
    foreign key (codigoTrabajador) references Trabajador(codigoTrabajador),
    foreign key (codigoEmpresa) references Empresa(codigoEmpresa),
        on update cascade
        on delete no action
);
