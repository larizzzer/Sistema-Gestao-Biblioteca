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
SELECT em.RaEstudante AS 'RA',
       es.Nome AS 'Nome'
FROM Estudantes es LEFT JOIN Emprestimos em ON es.RA = em.RaEstudante
WHERE em.RaEstudante IS NULL 
ORDER BY es.Nome ASC;

-- Qual a média de dias que os estudantes levam para devolver os livros?
SELECT es.Nome AS 'Nome',
       AVG(DATEDIFF(DAY, em.DataEmprestimo, em.DataDevolucaoReal)) AS 'Média de dia das devoluções'
FROM Estudantes es INNER JOIN Emprestimos em ON es.RA = em.RaEstudante
WHERE em.DataDevolucaoReal IS NOT NULL
GROUP BY es.Nome;






SELECT * FROM Estudantes; SELECT * FROM Autores;
SELECT * FROM Livros; SELECT * FROM Exemplares;
SELECT * FROM Emprestimos;