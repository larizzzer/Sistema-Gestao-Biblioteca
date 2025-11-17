CREATE DATABASE Biblioteca;

CREATE TABLE Estudantes(
    RA INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    EmailInstitucional VARCHAR(200) NOT NULL UNIQUE,
    Curso VARCHAR(60) NOT NULL,
    DataCadastro DATE
);

CREATE TABLE Autores(
    Id INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(100) NOT NULL,
    Nacionalidade VARCHAR (50) NOT NULL,
    Biografia NVARCHAR(MAX) NOT NULL
);

CREATE TABLE Livros(
    Id INT PRIMARY KEY IDENTITY(1,1),
    IdAutor INT NOT NULL,
    Titulo VARCHAR(70) NOT NULL,
    Descricao NVARCHAR(MAX) NOT NULL,
    Categoria VARCHAR(40) NOT NULL,
    DataLancamento DATE,
    ISBN VARCHAR(17) NULL,
    Editora VARCHAR (50) NOT NULL,
    FOREIGN KEY (IdAutor) REFERENCES Autores(Id)
);

CREATE TABLE Exemplares(
    Id INT PRIMARY KEY IDENTITY(1,1),
    IdLivro INT NOT NULL,
    Status VARCHAR(20) NOT NULL,
    CodigoPatrimonio VARCHAR(20) NOT NULL,
    DataAquisicao DATE,
    Localizacao VARCHAR(20) NOT NULL,
    FOREIGN KEY (IdLivro) REFERENCES Livros(Id)
);

CREATE TABLE Emprestimos(
    Id INT PRIMARY KEY IDENTITY(1,1),
    RaEstudante INT NOT NULL,
    IdExemplar INT NOT NULL,
    DataEmprestimo DATE,
    DataDevolucaoPrevista DATE,
    DataDevolucaoReal DATE,
    Status VARCHAR(20) NOT NULL,
    FOREIGN KEY (RaEstudante) REFERENCES Estudantes(RA),
    FOREIGN KEY (IdExemplar) REFERENCES Exemplares(Id)
);

CREATE TABLE LivrosAutores(
    IdLivro INT NOT NULL,
    IdAutor INT NOT NULL,
    FOREIGN KEY (IdLivro) REFERENCES Livros(Id),
    FOREIGN KEY (IdAutor) REFERENCES Autores(Id)
);

-- Alterações nas tabelas
ALTER TABLE Exemplares ADD UNIQUE (CodigoPatrimonio);

-- Visualização das tabelas inteiras
SELECT * FROM Estudantes;
SELECT * FROM Autores;
SELECT * FROM Livros;
SELECT * FROM Exemplares;
SELECT * FROM Emprestimos;
SELECT * FROM LivrosAutores;







