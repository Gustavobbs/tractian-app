## Vídeo de funcionamento: (O vídeo possui narração 😊)

[Tractian - Flutter App](https://youtu.be/Vc8upcwvzqc)

## Melhorias que estão faltando:

- Construção do filtra por Localidade/Asset/Component, do jeito que está filtra apenas Assets/Components.

- Para que o item anterior fique com uma implementação mais performática, seria interessante estudar implementações de árvore que seja ótima para os casos de uso.
Foi usado uma estrutura genéria de árvore que se encaixa bem com o escopo; tanto em sua montagem como renderização e busca possuem complexidade linear na ordem de O(N),
más talvez dê para melhorar, dado que na massa de dados mais pesada há um pequeno gargalo na renderização.

- Componentização de widgets, principalmente para deixar a tela de busca e exibição de assets mais leve e fácil de compreender, além de tornar os widgets re-utilizáveis.

- Separação das regras de negócio das telas, movendo-as para controllers.

- Otimizações de carregamento para bases de dados maiores, estudando e realizando mudanças em parceria com Backend. Para conseguirmos chegar a um faseamento no carregamento dos dados,
tornando assim a aplicação mais leve em seu start.