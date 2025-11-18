
# Sistema de Gestão de Biblioteca Universitária

Projeto em **T-SQL (SQL Server)** que modela uma biblioteca universitária com controle de acervo, empréstimos e membros **100% em código nativo**, sem Power BI ou ferramentas externas.


## ❌ Problema

A biblioteca da Universidade AAZZ enfrentava várias dificuldades de empréstimos de seus livros e de uma forma eficiente e acabava não gerenciando bem o seu acervo. O controle era feito a mão, onde uma única pessoa era a responsável e isso gerava:

- Perda de exemplares
- Exemplares não registrados
- Dificuldades em identificar os livros mais cobiçados
- Atrasos nas devoluções e sem cálculos automáticos para as multas
- Impossibilidade de consultar na hora se tinha o livro disponível ou não
- Estudantes cadastrados incorretamente e muitas duplicidades


## ✅ Melhorias

Com esse novo sistema, a biblioteca passa a contar com:

- Controle de status de cada empréstimo
- Controle de livros e exemplares disponíveis
- Gestão de estudantes inscritos para não se ter duplicidade
- Gestão de multas por atraso com base em regras claras
- Base sólida para futuras integrações (como um site)

Tudo isso com mais transparência e eficiência.
## 📁 Arquivos
- `Tabelas.sql` → Estrutura do banco  
- `InserindoDados.sql` → Inserção com dados consistentes (com IA)
- `Consultas.sql` → Consultas com `JOIN` e outras visualizações 
- `Projeto.pdf` → Explicação do projeto em arquivo PDF

## 👩‍💻 Autora

- [@larizzzer](https://www.github.com/larizzzer)

