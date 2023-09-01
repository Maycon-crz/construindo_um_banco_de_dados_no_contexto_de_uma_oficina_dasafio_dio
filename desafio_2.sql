-- Esquema lógico para o contexto de uma oficina
-- create database oficina;
use oficina;
CREATE TABLE Clientes(
  ClienteID INT PRIMARY KEY,
  Nome VARCHAR(45),
  Endereço VARCHAR(255),
  Telefone VARCHAR(45),
  Email VARCHAR(255),
  Data_de_cadastro DATETIME
);

CREATE TABLE Veiculos (
  VeiculoID INT PRIMARY KEY,
  Marca VARCHAR(45),
  Modelo VARCHAR(45),
  Ano INT,
  Placa VARCHAR(45),
  ClienteID INT,
  FOREIGN KEY (ClienteID) REFERENCES Clientes (ClienteID)
);

CREATE TABLE Ordens_de_servico (
  OrdemID INT PRIMARY KEY,
  ClienteID INT,
  VeiculoID INT,
  Data_de_abertura DATETIME,
  Data_de_conclusao DATETIME,
  Status VARCHAR(45),
  Valor_total DECIMAL(10,2),
  FOREIGN KEY (ClienteID) REFERENCES Clientes (ClienteID),
  FOREIGN KEY (VeiculoID) REFERENCES Veiculos (VeiculoID)
);
/*
Essa constraint é para garantir que o valor do atributo ClienteID na tabela Ordens_de_servico exista na tabela Clientes. 
Cada ordem de serviço deve estar associada a um cliente.
Garante que o valor do atributo ClienteID seja único na tabela Ordens_de_servico, não podendo haver duas ordens de serviço com o mesmo cliente.
*/
ALTER TABLE Ordens_de_servico ADD CONSTRAINT FK_Ordens_de_servico_ClienteID FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID);
/*
Essa constraint está sendo usada para garantir que o valor do atributo VeiculoID na tabela Ordens_de_servico exista na tabela Veiculos.
Cada ordem de serviço deve estar associada a um veículo existente. 
Garante também que o valor do atributo VeiculoID seja único na tabela Ordens_de_servico, não podendo haver duas ordens de serviço com o mesmo veículo.
*/
ALTER TABLE Ordens_de_servico ADD CONSTRAINT FK_Ordens_de_servico_VeiculoID FOREIGN KEY (VeiculoID) REFERENCES Veiculos(VeiculoID);
/* -- */

CREATE TABLE Itens_de_servico (
  ItemID INT PRIMARY KEY,
  OrdemID INT,
  Descricao_do_servico VARCHAR(45),
  Preco DECIMAL(10,2),
  FOREIGN KEY (OrdemID) REFERENCES Ordens_de_servico(OrdemID)
);
/*
Aqui a constraint é usada para garantir que o valor do atributo OrdemID na tabela Itens_de_servico exista na tabela Ordens_de_servico. 
Então cada item de serviço deve estar associado a uma ordem de serviço existente. 
Essa constraint também garante que o valor do atributo OrdemID seja único na tabela Itens_de_servico, não pode haver dois itens de serviço com a mesma ordem de serviço.
*/
ALTER TABLE Itens_de_servico ADD CONSTRAINT FK_Itens_de_servico_OrdemID FOREIGN KEY (OrdemID) REFERENCES Ordens_de_servico(OrdemID);

CREATE TABLE Funcionarios (
  FuncionarioID INT PRIMARY KEY,
  Nome VARCHAR(45),
  Cargo VARCHAR(45),
  DataDeContratacao DATETIME,
  Salario DECIMAL(10,2)
);


INSERT INTO Clientes (ClienteID, Nome, Endereço, Telefone, Email, Data_de_cadastro) VALUES
(1, 'João da Silva', 'Rua da Paz, 123', '(11) 9999-9999', 'joao@dasilva.com', '2023-03-08'),
(2, 'Maria Oliveira', 'Rua das Flores, 456', '(11) 8888-8888', 'maria@oliveira.com', '2023-03-09'),
(3, 'Pedro Santos', 'Rua do Sol, 789', '(11) 7777-7777', 'pedro@santos.com', '2023-03-10');

INSERT INTO Veiculos (VeiculoID, Marca, Modelo, Ano, Placa, ClienteID) VALUES
(1, 'Fiat', 'Uno', 2010, 'ABC-1234', 1),
(2, 'Volkswagen', 'Gol', 2011, 'DEF-5678', 2),
(3, 'Chevrolet', 'Onix', 2012, 'GHI-9012', 3);

INSERT INTO Ordens_de_servico (OrdemID, ClienteID, VeiculoID, Data_de_abertura, Data_de_conclusao, Status, Valor_total) VALUES
(1, 1, 1, '2023-03-08', '2023-03-10', 'Concluída', 100.00),
(2, 2, 2, '2023-03-09', '2023-03-11', 'Em andamento', 200.00),
(3, 3, 3, '2023-03-10', '2023-03-12', 'Aberta', 300.00);

INSERT INTO Itens_de_servico (ItemID, OrdemID, Descricao_do_servico, Preco) VALUES
(1, 1, 'Troca de óleo', 50.00),
(2, 1, 'Alinhamento de direção', 50.00),
(3, 2, 'Revisão geral', 100.00),
(4, 3, 'Conserto de freio', 150.00);

INSERT INTO Funcionarios (FuncionarioID, Nome, Cargo, DataDeContratacao, Salario) VALUES
(1, 'João da Silva', 'Gerente', '2023-03-08', 5000.00),
(2, 'Maria Oliveira', 'Mecânica', '2023-03-09', 3000.00),
(3, 'Pedro Santos', 'Vendedor', '2023-03-10', 2000.00);

select * from Clientes;
select * from Veiculos;
select * from Ordens_de_servico;
select * from Itens_de_servico;
select * from Funcionarios;
--
--
-- Filtros com WHERE Statement
SELECT * FROM Clientes WHERE Nome LIKE 'João%';
SELECT * FROM Veiculos WHERE Placa = 'ABC-1234';
SELECT * FROM Ordens_de_servico WHERE Status = 'Concluída';
SELECT * FROM Itens_de_servico WHERE Nome = 'Troca de óleo';
SELECT * FROM Funcionarios WHERE Cargo = 'Gerente';
--
--
-- Crie expressões para gerar atributos derivados
-- Adiciona uma coluna à tabela Veiculos com o nome "Modelo" e concatena a marca e o modelo do veículo
SELECT Marca, Modelo, CONCAT(Marca, ' ', Modelo) AS ModeloCompleto FROM Veiculos;
--
--
-- Defina ordenações dos dados com ORDER BY
-- Ordena os clientes por nome
SELECT * FROM Clientes ORDER BY Nome;
-- Ordena os veículos por placa
SELECT * FROM Veiculos ORDER BY Placa;
-- Ordena os funcionários por cargo
SELECT * FROM Funcionarios ORDER BY Cargo;
--
--
-- Condição de filtros aos grupos – HAVING Statement
-- Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados;
SELECT Nome, Salario
FROM Funcionarios
HAVING Salario > 3000.00;

SELECT v.Marca, v.Modelo, COUNT(os.OrdemID) AS TotalOrdens
FROM Veiculos v
JOIN Ordens_de_servico os ON v.VeiculoID = os.VeiculoID
WHERE os.Status = 'Aberta'
GROUP BY v.Marca, v.Modelo
HAVING COUNT(os.OrdemID) > 0;