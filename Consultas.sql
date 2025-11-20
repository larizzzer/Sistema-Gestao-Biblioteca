-- Perguntas de Negócio, onde algumas dúvidas que o sistema anterior não conseguia responder

-- Quantos estudantes tem empréstimos em atraso?
SELECT es.Nome AS 'Nome', 
       em.RaEstudante AS 'RA', 
       em.Status AS 'Status'
FROM Estudantes es INNER JOIN Emprestimos em ON em.RaEstudante = es.RA
WHERE em.Status = 'Atrasado' ORDER BY es.Nome;

-- Quais os livros que são mais emprestados?
SELECT l.Titulo AS 'Título', 
       l.Categoria AS 'Categoria', 
       COUNT(*) AS 'Total de Empréstimos'
FROM Livros l INNER JOIN Exemplares ex ON l.Id = ex.IdLivro 
INNER JOIN Emprestimos em ON ex.Id = em.IdExemplar 
GROUP BY l.Titulo, l.Categoria ORDER BY COUNT(*) DESC;

-- Quantos exemplares de cada livro estão disponíveis no momento?
SELECT l.Titulo AS 'Título', 
       ex.Status AS 'Status', 
       COUNT(*) AS 'Quantidade'
FROM Livros l INNER JOIN Exemplares ex ON l.Id = ex.IdLivro
WHERE ex.Status = 'disponível'
GROUP BY l.Titulo, ex.Status ORDER BY COUNT(*) ASC;

-- Qual é a taxa de uso dos livros de tecnologia nos últimos 6 meses?
SELECT l.Titulo AS 'Título', 
       l.Categoria AS 'Categoria', 
       COUNT(*) AS 'Quantidade'
FROM Livros l INNER JOIN Exemplares ex ON l.Id = ex.IdLivro
INNER JOIN Emprestimos em ON ex.Id = em.IdExemplar
WHERE em.DataEmprestimo >= DATEADD(MONTH, -6, GETDATE()) AND l.Categoria = 'Tecnologia' -- Aqui pega a data de 6 meses atrás até hoje
GROUP BY l.Titulo, l.Categoria ORDER BY COUNT(*) DESC;

-- Quais estudantes nunca fizeram um empréstimo?
SELECT es.Nome AS 'Nome'
FROM Estudantes es LEFT JOIN Emprestimos em ON es.RA = em.RaEstudante
WHERE em.RaEstudante IS NULL 
ORDER BY es.Nome ASC;

-- Quais exemplares estão em manutenção ou perdidos?
SELECT l.Titulo AS 'Livro',
       ex.CodigoPatrimonio AS 'Código',
       ex.Localizacao AS 'Localização'
FROM Livros l INNER JOIN Exemplares ex ON l.Id = ex.IdLivro
WHERE ex.Status = 'em manutenção';


-- Qual a média de dias que os estudantes levam para devolver os livros?
SELECT es.Nome AS 'Nome',
       AVG(DATEDIFF(DAY, em.DataEmprestimo, em.DataDevolucaoReal)) AS 'Média de dia das devoluções'
FROM Estudantes es INNER JOIN Emprestimos em ON es.RA = em.RaEstudante
WHERE em.DataDevolucaoReal IS NOT NULL
GROUP BY es.Nome;

-- Liste todos os empréstimos ativos com detalhes completos. 
SELECT es.Nome AS 'Estudante',
       l.Titulo AS 'Livro',
       em.DataEmprestimo AS 'Data do Empréstimo',
       em.DataDevolucaoPrevista AS 'Data Prevista de Devolução'
FROM Livros l INNER JOIN Exemplares ex ON l.Id = ex.IdLivro
INNER JOIN Emprestimos em ON ex.Id = em.IdExemplar
INNER JOIN Estudantes es ON es.RA = em.RaEstudante
WHERE em.DataDevolucaoReal IS NULL -- Aqui indica que o empréstimo está ativo
ORDER BY em.DataEmprestimo DESC;

-- Quantos livros no acervo são de autores brasileiros?
SELECT COUNT(*) AS 'Quantidade de livros de autores brasileiros'
FROM Autores a INNER JOIN Livros l ON a.Id = l.IdAutor
WHERE a.Nacionalidade = 'Brasileiro';

-- Lista detalhada dos livros que são de autores brasileiros
SELECT a.Nome AS 'Autor',
       a.Nacionalidade AS 'Nacionalidade',
       l.Titulo AS 'Livro'
FROM Autores a INNER JOIN Livros l ON a.Id = l.IdAutor
WHERE a.Nacionalidade = 'Brasileiro'
ORDER BY a.Nome, l.Titulo;

-- Quais cursos têm mais estudantes ativos na biblioteca (ou seja, que já fizeram pelo menos um empréstimo)?
SELECT es.Curso AS 'Curso',
       COUNT(DISTINCT es.RA) AS 'Quantidade de Estudantes'
FROM Emprestimos em INNER JOIN Estudantes es ON es.RA = em.RaEstudante
GROUP BY es.Curso
ORDER BY COUNT(DISTINCT es.RA) DESC;

-- Consulta que mostra a situação de todos os empréstimos de livros
SELECT 
       em.RaEstudante AS 'RA',
       es.Nome AS 'Estudante',
       em.DataEmprestimo AS 'Data do Empréstimo',
       em.DataDevolucaoPrevista AS 'Data Prevista de Devolução',
       em.DataDevolucaoReal AS 'Data Real de Devolução',
       CASE
        WHEN DataDevolucaoReal IS NULL THEN
            CASE -- Empréstimos abertos
                WHEN GETDATE() > DataDevolucaoPrevista THEN 'Em atraso - Procure a Secretaria para regularizar a sua situação'
                ELSE 'Em dia (não devolvido)'
            END
        WHEN DataDevolucaoReal <= DataDevolucaoPrevista THEN
            CASE -- Empréstimos devolvidos
                WHEN DataDevolucaoReal < DataDevolucaoPrevista THEN 'Devolvido antes do prazo'
                ELSE 'Devolvido no prazo'
            END
        WHEN DataDevolucaoReal > DataDevolucaoPrevista THEN 'Devolvido com atraso - Procure a Secretaria para regularizar a sua situação'
        ELSE 'Situação não identificada'
       END AS 'Status do Empréstimo'
FROM Emprestimos em INNER JOIN Estudantes es ON em.RaEstudante = es.RA;


SELECT * FROM Estudantes; SELECT * FROM Autores;
SELECT * FROM Livros; SELECT * FROM Exemplares;
SELECT * FROM Emprestimos;