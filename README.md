# Brasil Cripto

Este projeto foi desenvolvido como parte do processo seletivo para a vaga de Flutter Pleno na BrasilCard (Grupo Adriano Cobuccio).

O objetivo é criar um aplicativo de monitoramento de criptomoedas com funcionalidades como busca por moedas, visualização de detalhes, adição e remoção de favoritas, utilizando dados em tempo real da API pública da CoinGecko.

Utilizei o Flutter Modular pela facilidade de gerenciar rotas e injeção de dependência com baixo acoplamento entre módulos. Mesmo sendo um app pequeno, modularizei as features para manter o código limpo e preparado para escala, facilitando também a testabilidade e leitura. também adotei o offline First, priorizando a leitura local antes de recorrer à API. Isso garante estabilidade, reduz uso de rede e melhora a UX em ambientes instáveis. Quando a conexão retorna, os dados passam a ser atualizados em tempo real, mantendo a interface fluida sem bloqueios.

## Stream e atualização dos detalhes
A quantidade de dados que vinha do endpoint dos detalhes me trouxe muitas perguntas, o que deveria ser feito, usar um isolate, ou um stream?

 - Stream é mais simples e adequado quando o objetivo é apenas refazer uma chamada HTTP periodicamente.
 - Isolate seria desnecessário, pois não há processamento pesado local que justifique a criação de uma nova thread Dart.
 - Stream permite desacoplar o fluxo de dados da UI, facilitando a integração com StreamBuilder ou escuta manual no ViewModel.

 ## Offline First com HIVE

O aplicativo foi desenvolvido com uma abordagem **offline-first real**, utilizando o Hive como banco de dados local. Isso permite:

- Persistir favoritos localmente de forma estruturada.
- Garantir acesso às criptomoedas favoritas mesmo sem internet.
- Futuramente, armazenar em cache os dados das pesquisas e detalhes para uso offline.

A separação entre `remote_datasource` e `local_datasource` permite alternar facilmente entre dados da API e dados locais conforme o estado da conexão.

## Debounce

Para evitar chamadas desnecessárias à API durante a digitação, implementei **debounce no campo de busca da tela inicial (Dashboard)**. Isso garante que os dados sejam buscados somente após uma pequena pausa na digitação, melhorando a performance e evitando sobrecarga na rede.

## 📦 Tecnologias Utilizadas

- **Flutter** (com Flutter Modular)
- **Dart**
- **Hive** (armazenamento local)
- **Dio** (requisições HTTP)
- **ValueNotifier + MVVM**
- **CoinGecko API**

## 🎥 Demonstração em Vídeo

Para facilitar a avaliação, gravei vídeos curtos demonstrando as principais funcionalidades do app:

- 🔍 **Busca e visualização de criptomoedas**  
  [Abrir vídeo](https://drive.google.com/file/d/1yKu8dDh3svEjuEwjmt3Nem-Br02BNJE6/view?usp=drive_link)

- ⭐ **Adicionar e remover favoritos**  
  [Abrir vídeo](https://drive.google.com/file/d/1bz-W6S4dWnfy_B4rIxcsLMv4ZOsF1Jfg/view?usp=drive_link)

- 📊 **Tela de detalhes com atualização em tempo real**  
  [Abrir vídeo](https://drive.google.com/file/d/18BOEQyz4PIHjPkBDKL0i72fsTZz1m8pS/view?usp=drive_link)

- 📴 **Funcionalidade Offline (Hive)**  
  [Abrir vídeo](https://drive.google.com/file/d/1jIReQ9dDxqMJaGWT69UXKhaJdqR75KTY/view?usp=drive_link)

> Caso o vídeo não abra diretamente, copie o link e cole no navegador.

## Algumas notas pessoais

Tive pouco tempo para todo o projeto, desde já agradeço ao avaliador, e a recrutadora Caroline que permitiu que eu fizesse esse teste, com certeza tinha muito mais para falar aqui e eu não consegui cobrir tudo que eu fiz, tudo que foi do projeto, diferencial e etc, também não tive tempo para colocar coisas como testes unitários que eu queria colocar, bom, espero que esse teste consiga provar as minhas capacidades e habilidades no desenvolvimento, novamente, muito obrigado.