# SmartGuitar

Aplicativo Flutter para controle de notas e acordes em tempo real via protocolo MQTT, desenvolvido para integração com dispositivos ESP32.

## Descrição

O SmartGuitar permite tocar músicas pré-definidas e sincronizar cada nota ou acorde com um broker MQTT. O dispositivo físico conectado (ex: ESP32 com piano/guitarra) recebe as notas em tempo real conforme a música é reproduzida no app.

## Funcionalidades

- Conexão com broker MQTT via TCP/TLS (nativo) e WebSocket/TLS (web)
- Reprodução de músicas nota a nota com envio via MQTT
- Reprodução de músicas com acordes sincronizados
- Tela de player dedicada para cada música com:
  - Nota/acorde atual em destaque
  - Próxima nota/acorde
  - Barra de progresso com tempo
  - Controles de play, pause e reset
  - Status de sincronização MQTT
- Lista de músicas de exemplo (notas e acordes)
- Suporte a tema escuro

## Tecnologias

| Item | Detalhe |
|------|---------|
| Framework | Flutter 3.x (Dart ≥ 3.0) |
| MQTT | [mqtt_client](https://pub.dev/packages/mqtt_client) ^10.0.0 |
| Broker | HiveMQ Cloud (TLS) |
| Hardware alvo | ESP32 |
| Plataformas | Android, iOS, Web |

## Estrutura do Projeto

```
lib/
├── core/
│   ├── routes/          # Definição de rotas (AppRoutes)
│   └── theme/           # Tema do app (AppTheme)
├── models/
│   ├── musica.dart      # Modelo de música (notas) + músicas pré-definidas
│   ├── song_model.dart  # Modelo de música (acordes)
│   ├── chord_event.dart # Evento de troca de acorde
│   └── device_model.dart
├── data/
│   ├── repositories/    # Interfaces e implementações mock
│   └── mock_songs.dart  # Músicas de exemplo com acordes
├── domain/
│   └── use_cases/       # Casos de uso (player, songs, connection)
├── screens/
│   ├── connection/      # Tela de conexão MQTT
│   ├── songs/           # Lista de músicas com acordes
│   ├── player/          # Player de acordes (ESP32 guitarra)
│   ├── musicas/         # Lista de músicas com notas
│   └── musica_player/   # Player de notas (ESP32 piano)
└── services/
    └── mqtt_service.dart  # Serviço MQTT singleton (nativo + web)
```

## Músicas Disponíveis

### Notas (piano)
| Música | Notas |
|--------|-------|
| Ode to Joy | 30 |
| Happy Birthday | 25 |
| Mary Had a Little Lamb | 26 |
| C Major Scale | 15 |

### Acordes (guitarra)
| Música | Duração | Trocas de acorde |
|--------|---------|-----------------|
| Stand By Me | 3:45 | 9 |
| Wonderful Tonight | 4:12 | 8 |
| Knockin' on Heaven's Door | 2:58 | 7 |

## Como Executar

### Pré-requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) ≥ 3.0
- Dispositivo físico ou emulador Android/iOS, ou navegador para web

### Instalação

```bash
# Clone o repositório
git clone <url-do-repositorio>
cd Iot_and_Mobile_Leonardo_Timbola_Sabrina_Neves

# Instale as dependências
flutter pub get

# Execute o app
flutter run
```

### Web

```bash
flutter run -d chrome
```

## Configuração MQTT

As credenciais do broker estão em `lib/services/mqtt_service.dart`:

| Parâmetro | Valor |
|-----------|-------|
| Host | HiveMQ Cloud |
| Porta nativa | 8883 (TLS) |
| Porta web | 8884 (WebSocket TLS) |
| Tópico | `piano/nota` |

> Para usar seu próprio broker, altere as constantes de host e credenciais em `mqtt_service.dart`.

## Fluxo de Uso

```
Tela de Conexão
     │
     ▼  (conectar ao broker MQTT)
Lista de Músicas (notas ou acordes)
     │
     ▼  (selecionar uma música)
Tela de Player
     │
     ▼  (play)
Notas/Acordes enviados via MQTT → ESP32
```

## Autores

- Leonardo Timbola
- Sabrina Neves

**Instituto Presbiteriano Mackenzie — Disciplina: IoT e Mobile**
