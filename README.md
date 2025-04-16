# Brasil Cripto

Este projeto foi desenvolvido como parte do processo seletivo para a vaga de Flutter Pleno na BrasilCard (Grupo Adriano Cobuccio).

O objetivo é criar um aplicativo de monitoramento de criptomoedas com funcionalidades como busca por moedas, visualização de detalhes, adição e remoção de favoritas, utilizando dados em tempo real da API pública da CoinGecko.

Utilizei o Flutter Modular pela facilidade de gerenciar rotas e injeção de dependência com baixo acoplamento entre módulos. Mesmo sendo um app pequeno, modularizei as features para manter o código limpo e preparado para escala, facilitando também a testabilidade e leitura. também adotei o offline First, priorizando a leitura local antes de recorrer à API. Isso garante estabilidade, reduz uso de rede e melhora a UX em ambientes instáveis. Quando a conexão retorna, os dados passam a ser atualizados em tempo real, mantendo a interface fluida sem bloqueios.

### Stream e atualização dos detalhes
A quantidade de dados que vinha do endpoint dos detalhes me trouxe muitas perguntas, o que deveria ser feito, usar um isolate, ou um stream?

Diante disso, optei por utilizar um Stream.periodic no repositório, em vez de um Isolate, pelos seguintes motivos:
 - Stream é mais simples e adequado quando o objetivo é apenas refazer uma chamada HTTP periodicamente.
 - Isolate seria desnecessário, pois não há processamento pesado local que justifique a criação de uma nova thread Dart.
 - Stream permite desacoplar o fluxo de dados da UI, facilitando a integração com StreamBuilder ou escuta manual no ViewModel.