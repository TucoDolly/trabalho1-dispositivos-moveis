# App de Gestão de Tarefas - Projeto Flutter 📝

Aplicativo de controle de tarefas desenvolvido em Flutter para a disciplina de Desenvolvimento para Dispositivos Móveis, implementando um CRUD completo com persistência local e gestão de estado.

## 📋 Requisitos Implementados

- **CRUD Completo**: Criação, leitura, atualização e exclusão de tarefas.
- **Modelo de Dados**: Gerenciamento de `id`, `titulo`, `descricao`, `dataPrevista`, `importante`, `realizada` e o atributo extra **`categoria`**.
- **Persistência (SQLite)**: Integração com `sqflite`, ID autogerado e conversão de datas para `TEXT`.
- **Gestão de Estado**: Utilização do padrão **Provider** para sincronização reativa entre a lista global e o banco de dados.
- **Navegação**: Transições de tela estruturadas através de **rotas nomeadas**.
- **Filtros (TabBar)**: Filtragem reativa em 7 abas: Todas, Feitas, Fazer, Em dia, Importante, Comuns e Atrasos.
- **Componentização**: Criação do widget customizado `CardTarefa` para isolamento de interface e reuso de código.

## 🚀 Funcionalidades Extras Implementadas

- **Boas-Vindas Dinâmica**: Cálculo em tempo real da tarefa mais urgente e contagem de pendências da mesma data.
- **Ordenação Automática**: Lista duplamente ordenada por proximidade de data e ordem alfabética.
- **Sinalização de Atraso**: Alertas visuais e formatação condicional em vermelho para prazos vencidos.
- **Interatividade**: Navegação direta para os detalhes ao clicar no card da tarefa.

## ⚠️ Teste de Tarefas Atrasadas

Por padrão, o `showDatePicker` bloqueia a seleção de datas passadas. Para testar o comportamento dos filtros de atraso:
1. Acesse o arquivo `lib/telas/tela_cadastro.dart`.
2. No método `_selecionarData`, altere ou comente a linha `firstDate: DateTime.now()` para permitir a seleção de dias anteriores.

## 📁 Estrutura do Projeto

```text
lib/
├── componentes/   # Widgets customizados de UI (ex: CardTarefa)
├── models/        # Classes de dados e mapeamento (toMap/fromMap)
├── providers/     # Lógica de negócio e gestão de estado
├── telas/         # Interfaces do usuário (Rotas)
├── util/          # Infraestrutura e configuração do SQLite
└── main.dart      # Entry point e injeção de dependências
```

## 🛠️ Tecnologias

- **Flutter & Dart**
- **sqflite**: Persistência de dados local.
- **provider**: Gerenciamento de estado global.