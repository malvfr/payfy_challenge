# Desafio Técnico Payfy

Nesse desafio, você vai ter que criar uma API REST para um sistema de sorteios

### Descrição da Aplicação

Nesse app você vai criar uma RESTful API, aonde os usuarios podem se registrar com um nome e email e participar de sorteios.

### Regras de negócio a serem implementadas

- deve ser implementado em elixir
- usuários não devem poder entrar em sorteios após a data do sorteio
- cada usuário só pode participar uma unica vez do sorteio
- deve-se considerar que devido a api ser publica, pode ser que tenhamos muitos sorteios sendo criados concorrentementes
- deve-se considerar que pessoas famosas porem criar sorteios muito populares aonde teriam muitos usuários se cadastrando ao mesmo tempo e participando do sistema. O sistema não pode cair nesses casos, ou falhar em respeitar as regras acima.

### Funcionalidades obrigatórias

- rota registrar usuário, recebe um nome e email e retorna um id
- rota criar um sorteio, recebe o nome do sorteio e data do sorteio e retorna um id
- rota para participar de um sorteio, recebe um id de usuário e um id de sorteio e retorna ok
- rota para consultar o resultado de um sorteio, recebe um id de sorteio e retorna o id, nome e email do usuário que ganhou, ou o erro apropriado caso o sorteio não tenha sido encerrado

### Observações

- Será questionado que problemas você considerou na implementação e como resolveu solucionar/evitar esses problemas.
- Qualquer duvida você pode ou perguntar para quem lhe passou o desafio, ou assumir a resposta e documentar todas suas assunções no read-me do seu projeto

### Critérios de avaliação

- código está bem estruturado
- código faz o uso correto de Design Patterns
- sabe explicar o motivo das decisões de implementações
- o projeto realiza todas as funcionalidades básicas requeridas
- o README do projeto tem todos os detalhes que precisam para rodar o projeto em outro computador

### Sugestão de Estudo

- [Clean Code - Guia e Exemplos](https://balta.io/artigos/clean-code)
- [Elixir School - Lições sobre a linguagem de programação Elixir](https://elixirschool.com/pt/)
