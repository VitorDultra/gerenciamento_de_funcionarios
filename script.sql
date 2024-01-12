-- Criando o banco de dados 

CREATE DATABASE gerenciamento_de_funcionarios

-- Entrando no banco de dados

USE gerenciamento_de_funcionarios

-- Criando tabelas

CREATE TABLE funcionarios (
employee_id INT IDENTITY (1,1) NOT NULL
	CONSTRAINT pk__employee_id PRIMARY KEY,
firtsname varchar(100) NOT NULL,
lastname varchar(100) NOT NULL,
birthdate DATE NOT NULL,
hiredate DATE NOT NULL,
salary MONEY NOT NULL
);

CREATE TABLE departamentos (
department_id INT IDENTITY (1,1) NOT NULL
	CONSTRAINT pk__department_id PRIMARY KEY,
departmentname VARCHAR(200) NOT NULL
);

CREATE TABLE alocacoes (
allocation_id INT IDENTITY (1,1) NOT NULL
	CONSTRAINT pk__allocation_id PRIMARY KEY,
employee_id INT NOT NULL
	CONSTRAINT fk__eployeer_id__employee_id FOREIGN KEY REFERENCES [funcionarios](employee_id),
department_id INT NOT NULL
	CONSTRAINT fk__department_id__department_id FOREIGN KEY REFERENCES [departamentos](department_id),
startdate DATE NOT NULL, 
enddate DATE
);


-- Inserindo dados nas tabelas

INSERT INTO funcionarios VALUES 
('Maria','Silva', '1992-02-15', '2022-01-07', 3500),
('Pedro','Santos', '1988-04-23', '2015-04-10', 3800),
('Ana','Oliveira', '1995-08-07', '2017-09-22',  6200),
('João','Souza', '1990-01-12', '2013-12-05',  5000),
('Carolina','Pereira', '1998-09-05', '2019-07-18', 7500),
('Rafael','Costa', '1994-03-20', '2020-02-29', 4200),
('Beatriz','Lima', '1997-10-09', '2014-11-15',8000),
('Lucas','Pereira', '1991-06-18', '2018-06-30', 5800),
('Isabella','Martins', '1996-12-03', '2021-08-12', 9500),
('Thiago','Oliveira', '1993-07-28', '2016-03-25', 6700)

INSERT INTO funcionarios VALUES 
('Guilherme','Silva','1985-03-15','2017-05-12',3500),
('Renata','Oliveira','1982-09-28','2019-09-28',3800),
('Marcos','Santos','1990-12-05','2022-01-05',6200),
('Camila','Pereira','1988-06-20','2014-11-20',5000),
('Ricardo','Costa','1983-11-10','2018-03-10',7500),
('Juliana','Almeida','1995-04-02','2020-06-02',4200),
('Anderson','Lima','1981-07-14','2016-07-14',8000),
('Isabela','Rocha','1998-08-25','2023-08-25',5800),
('Felipe','Mendes','1987-01-18','2015-02-18',9500),
('Luana','Barbosa','1992-10-30','2021-10-30',6700)

INSERT INTO departamentos VALUES 
('Recursos Humanos'),
('Financeiro'),
('Desenvolvimento de Produtos'),
('Vendas'),
('Tecnologia da Informação'),
('Marketing'),
('Logística'),
('Qualidade'),
('Atendimento ao Cliente'),
('Jurídico')

INSERT INTO alocacoes VALUES 
(1, 1, '2022-01-07',NULL),
(3, 5, '2017-09-22',NULL),
(2, 4, '2015-04-10',NULL),
(4, 6, '2013-12-05',NULL),
(5, 2, '2019-07-18',NULL),
(10, 3, '2016-03-25',NULL),
(9, 10, '2021-08-12',NULL),
(6, 8, '2020-02-29',NULL),
(7, 7, '2014-11-15',NULL),
(8, 9, '2018-06-30',NULL)

INSERT INTO alocacoes VALUES
(11, 1, '2017-05-12',NULL),
(13, 5, '2022-01-05',NULL),
(12, 4, '2019-09-28',NULL),
(14, 6, '2014-11-20',NULL),
(15, 2, '2018-03-10',NULL),
(20, 3, '2021-10-30',NULL),
(19, 10, '2015-02-18',NULL),
(16, 8, '2020-06-02',NULL),
(17, 7, '2016-07-14',NULL),
(18, 9, '2023-08-25',NULL)


--Desafios

Escreva uma consulta que liste todos os funcionários (nome completo) que estão atualmente alocados em um departamento, mostrando também o nome do departamento. 

SELECT f.firtsname, f.lastname, d.departmentname
FROM funcionarios f
INNER JOIN alocacoes a
ON f.employee_id = a.employee_id
INNER JOIN departamentos d
ON d.department_id = a.department_id


Ordene a lista pelo nome do departamento e, dentro do mesmo departamento, pelo sobrenome do funcionário.

SELECT f.lastname, d.departmentname
FROM funcionarios f
inner join alocacoes a
on f.employee_id = a.employee_id
inner join departamentos d
on d.department_id = a.department_id
ORDER BY d.departmentname desc


Crie uma consulta que retorne o salário médio dos funcionários por departamento. 

SELECT  AVG(f.salary) AS 'Salário Médio', d.departmentname
FROM funcionarios f
INNER JOIN alocacoes a
ON f.employee_id = a.employee_id
INNER JOIN departamentos d
ON a.department_id = d.department_id
GROUP BY d.departmentname


Inclua o nome do departamento e o salário médio, ordenando de forma decrescente pelo salário médio.

SELECT  AVG(f.salary) AS 'SalarioMedio', d.departmentname
FROM funcionarios f
INNER JOIN alocacoes a
ON f.employee_id = a.employee_id
INNER JOIN departamentos d
ON a.department_id = d.department_id
GROUP BY d.departmentname 
ORDER BY 'SalarioMedio' desc


Inclua o nome do departamento e o salário máximo, ordenando de forma decrescente pelo salário máximo.

SELECT  MAX(f.salary) AS 'SalarioMaximo', d.departmentname
FROM funcionarios f
INNER JOIN alocacoes a
ON f.employee_id = a.employee_id
INNER JOIN departamentos d
ON a.department_id = d.department_id
GROUP BY d.departmentname 
ORDER BY 'SalarioMaximo' desc

Inclua o nome do departamento e o salário minimo, ordenando de forma decrescente pelo salário minimo.

SELECT  MIN(f.salary) AS 'SalarioMinimo', d.departmentname
FROM funcionarios f
INNER JOIN alocacoes a
ON f.employee_id = a.employee_id
INNER JOIN departamentos d
ON a.department_id = d.department_id
GROUP BY d.departmentname 
ORDER BY 'SalarioMinimo' asc

-- Criação de procedures

CREATE PROCEDURE [dbo].[proc_nomedofuncpordepart]
AS
BEGIN 
SELECT f.firtsname, f.lastname, d.departmentname
FROM funcionarios f
INNER JOIN alocacoes a
ON f.employee_id = a.employee_id
INNER JOIN departamentos d
ON d.department_id = a.department_id

END 
GO
	
CREATE PROCEDURE [dbo].[proc_sobrenomedofuncpordepart]
AS
BEGIN  
SELECT f.lastname, d.departmentname
FROM funcionarios f
inner join alocacoes a
on f.employee_id = a.employee_id
inner join departamentos d
on d.department_id = a.department_id

END 
GO

CREATE PROCEDURE [dbo].[proc_salariomaximopordepart]
AS
BEGIN 
SELECT  MAX(f.salary) AS 'SalarioMaximo', d.departmentname
FROM funcionarios f
INNER JOIN alocacoes a
ON f.employee_id = a.employee_id
INNER JOIN departamentos d
ON a.department_id = d.department_id
GROUP BY d.departmentname 
ORDER BY 'SalarioMaximo' desc

END
GO


CREATE PROCEDURE [dbo].[proc_salariominimopordepart]
AS
BEGIN 
SELECT  MIN(f.salary) AS 'SalarioMinimo', d.departmentname
FROM funcionarios f
INNER JOIN alocacoes a
ON f.employee_id = a.employee_id
INNER JOIN departamentos d
ON a.department_id = d.department_id
GROUP BY d.departmentname 
ORDER BY 'SalarioMinimo' asc

END 
GO
