create schema if not exists azure_company;
use azure_company;

-- Criação da tabela Funcionario
CREATE TABLE Funcionario(
    Fname varchar(15) not null,
    Minit char,
    Lname varchar(15) not null,
    Ssn char(9) not null, 
    Bdate date,
    Address varchar(30),
    Sex char,
    Salary decimal(10,2),
    Super_ssn char(9),
    Dno int not null,
    constraint chk_salary_employee check (Salary> 2000.0),
    constraint pk_employee primary key (Ssn)
);

alter table Funcionario 
	add constraint fk_employee 
	foreign key(Super_ssn) references employee(Ssn)
    on delete set null
    on update cascade;

alter table Funcionario modify Dno int not null default 1;

desc Funcionario;

-- Criação da tabela Departamento
create table Departamento(
	Dname varchar(15) not null,
    Dnumber int not null,
    Mgr_ssn char(9) not null,
    Mgr_start_date date, 
    Dept_create_date date,
    constraint chk_date_dept check (Dept_create_date < Mgr_start_date),
    constraint pk_dept primary key (Dnumber),
    constraint unique_name_dept unique(Dname),
    foreign key (Mgr_ssn) references employee(Ssn)
);

alter table Departamento 
		add constraint fk_dept foreign key(Mgr_ssn) references employee(Ssn)
        on update cascade;

desc Departamento;

-- Criação da tabela Depart_Local
create table Depart_Local(
	Dnumber int not null,
	Dlocation varchar(15) not null,
    constraint pk_dept_locations primary key (Dnumber, Dlocation),
    constraint fk_dept_locations foreign key (Dnumber) references departament (Dnumber)
);

alter table Depart_Local drop fk_dept_locations;

alter table Depart_Local 
	add constraint fk_dept_locations foreign key (Dnumber) references departament(Dnumber)
	on delete cascade
    on update cascade;

-- Criação da tabela Projeto
create table Projeto(
	Pname varchar(15) not null,
	Pnumber int not null,
    Plocation varchar(15),
    Dnum int not null,
    primary key (Pnumber),
    constraint unique_project unique (Pname),
    constraint fk_project foreign key (Dnum) references departament(Dnumber)
);

-- Criação da tabela Works_On
create table Works_On(
	Essn char(9) not null,
    Pno int not null,
    Hours decimal(3,1) not null,
    primary key (Essn, Pno),
    constraint fk_employee_works_on foreign key (Essn) references employee(Ssn),
    constraint fk_project_works_on foreign key (Pno) references project(Pnumber)
);

-- Criação da tabela Dependente
create table Dependente(
	Essn char(9) not null,
    Dependent_name varchar(15) not null,
    Sex char,
    Bdate date,
    Relationship varchar(8),
    primary key (Essn, Dependent_name),
    constraint fk_dependent foreign key (Essn) references employee(Ssn)
);

show tables;
