import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_client.dart';

import 'mqtt_client_stub.dart'
    if (dart.library.html) 'mqtt_client_web.dart'
    if (dart.library.io) 'mqtt_client_native.dart';

class MqttService extends ChangeNotifier {
  static final MqttService instance = MqttService._();
  MqttService._();

  static const _host = 'cd9967d5ecd74b5096d5f0950ecd4270.s1.eu.hivemq.cloud';
  static const _username = 'ltimbola';
  static const _password = 'Leo5Guto8';
  static const topic = 'piano/nota';

  MqttClient? _client;
  bool isConnected = false;
  bool isConnecting = false;
  String? errorMessage;

  Future<void> connect() async {
    if (isConnected || isConnecting) return;

    isConnecting = true;
    errorMessage = null;
    notifyListeners();

    final clientId = 'flutter_piano_${DateTime.now().millisecondsSinceEpoch}';
    debugPrint('[MQTT] Iniciando conexão...');
    debugPrint('[MQTT] Host: $_host');
    debugPrint('[MQTT] ClientId: $clientId');
    debugPrint('[MQTT] Plataforma web: $kIsWeb');

    _client = createMqttClient(_host, clientId);
    _client!.keepAlivePeriod = 60;
    _client!.connectTimeoutPeriod = 10000;
    _client!.logging(on: true);
    _client!.onConnected = _onConnected;
    _client!.onDisconnected = _onDisconnected;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .authenticateAs(_username, _password)
        .startClean();
    _client!.connectionMessage = connMessage;

    try {
      debugPrint('[MQTT] Enviando CONNECT ao broker...');
      final status = await _client!.connect();
      debugPrint('[MQTT] Status retornado: ${status?.state} | Código: ${status?.returnCode}');

      if (status == null || status.state != MqttConnectionState.connected) {
        final reason = status?.returnCode ?? 'sem resposta';
        debugPrint('[MQTT] ERRO — broker recusou: $reason');
        errorMessage = 'Broker recusou a conexão ($reason)';
        _client?.disconnect();
        isConnected = false;
        isConnecting = false;
        notifyListeners();
      }
    } catch (e, stack) {
      debugPrint('[MQTT] EXCEÇÃO ao conectar: $e');
      debugPrint('[MQTT] Stack: $stack');
      errorMessage = 'Erro: ${e.toString()}';
      _client?.disconnect();
      isConnected = false;
      isConnecting = false;
      notifyListeners();
    }
  }

  void _onConnected() {
    debugPrint('[MQTT] ✓ Conectado com sucesso ao broker!');
    isConnected = true;
    isConnecting = false;
    notifyListeners();

    // Nota dó (C4) de teste logo após conectar
    debugPrint('[MQTT] Enviando nota de teste: C4 (Dó)');
    publish('C4');
  }

  void _onDisconnected() {
    debugPrint('[MQTT] Desconectado do broker.');
    isConnected = false;
    isConnecting = false;
    notifyListeners();
  }

  void publish(String note) {
    if (!isConnected || note.isEmpty) {
      debugPrint('[MQTT] publish ignorado — conectado: $isConnected | nota: "$note"');
      return;
    }
    debugPrint('[MQTT] Publicando "$note" no tópico $topic');
    final builder = MqttClientPayloadBuilder();
    builder.addString(note);
    _client?.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
  }

  void publicarNota(String nota) => publish(nota);

  Future<void> disconnect() async {
    debugPrint('[MQTT] Desconectando...');
    _client?.disconnect();
  }

  @override
  void dispose() {
    _client?.disconnect();
    super.dispose();
  }
}
