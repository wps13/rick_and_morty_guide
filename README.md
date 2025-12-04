# Rick and Morty - Guia do multiverso

## Arquitetura

O projeto foi feito usando a arquitetura `MVVM` e `ChangeNotifier` para gerenciar estado, visando simplicidade e separação por camadas, facilitando criação de novas funcionalidades e manutenções futuras. Para esse projeto foi considerado cada tela como uma parte, de forma a dividir o contexto e evitar muitas responsabilidades.

### Funcionalidades
- Listagem de personagens com filtros para nome (via campo de busca) e status (por meio de chips)
- Visualização de detalhes de um personagem
- Paginação
- Integração com API

### Pacotes usados
- Pacotes nativos do flutter
- `cached_network_image` para exibição de images com cache
- `equatable` para criação dos modelos

### Referências

[Documentação oficial Flutter - Recomendações de arquitetura](https://docs.flutter.dev/app-architecture/recommendations)

[Documentação oficial Flutter - Guia para arquitetura](https://docs.flutter.dev/app-architecture/guide)

## Setup

### Executar projeto

```flutter run```


## Screenshots

| Tela inicial | Tela com filtros | Tela de detalhe |
| ------ | ------ | ----- |
| <img width="1179" height="2556" alt="Simulator Screenshot - iPhone 16 - 2025-12-03 at 18 21 38" src="https://github.com/user-attachments/assets/22cb8212-dc57-42a6-ad0d-a8064f407007" /> | <img width="1179" height="2556" alt="Simulator Screenshot - iPhone 16 - 2025-12-03 at 18 21 50" src="https://github.com/user-attachments/assets/1c4fd222-a36a-4049-bc0c-b1af18ad6b0e" /> | <img width="1179" height="2556" alt="Simulator Screenshot - iPhone 16 - 2025-12-03 at 18 22 01" src="https://github.com/user-attachments/assets/eb77bd5c-042e-4aab-ae6a-eb724fa048fc" />| 



