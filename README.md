# Payfy

Projeto prático de API Rest para cadastro de sorteios e usuários. O projeto utiliza uma arquitetura simples MVC, com testes unitários e separação de responsabilidade por camada.

Para o requisito de acessos simultâneos e alta carga, foi utilizada uma solucão de Pool de processos e operacões assíncronas, aliviando o processo atual de executar todas as funcões.

Todas as operações de mutabilidade são transacionadas pelo banco de dados.

# Executando

Utilizando o docker-compose/docker, rode o seguinte comando para subir os containers

```bash
docker-compose up --build
```

O servidor estará sendo executado em modo DEV - Acesse localhost:4000/api para utilizar a API.

Utilize a coleção do postman que está na raiz do projeto para interagir com a API:

1 - Utilize as rotas de criar usuários e sorteios para iniciar o processo.
2 - Utilize a rota "Join" para inserir seu usuário no sorteio.
3- A rota "Close" foi adicionada para encerrar manualmente o sorteio. Utilize-a com o ID do sorteio criado anteriormente
4 - Para saber o resultado do sorteio, utilize a rota "Result" com o ID do sorteio escolhido.

# Melhorias

Para agilizar a entrega do desafio técnico, algumas coisas foram feitas de forma imparcial e não otimizadas.

O que falta/poderia ser melhorado:

- Adicionar o restante das funcionalidades CRUD para cada recurso, como deletar e editar sorteios/usuários.

- Validação de payload das requests através de embbed schemas
- Melhorar error handling no fallback controller
- Utilizar um cache para guardar as requisições que não mudam com frequência.
- Adicionar testes de edge case
- Utilizar GenStage para backpressure de requests durante horário de pico.
- Configurar retries em caso de falhas.
- Adicionar Swagger para ter uma documentação de API
- Adicionar documentacão inline/typespecs

# Testes unitários

Para executar todos os testes unitários, execute o seguinte comando:

```bash
  mix test
```

Os testes rodam na CI do Github, quando a branch **main** é atualizada.

# Coleção Postman

Caso queira usar o Postman para executar suas requests, existe uma coleção na raiz do projeto que poderá ser importada.

Também existe um Environment para carregar as configurações de variáveis de ambiente.
