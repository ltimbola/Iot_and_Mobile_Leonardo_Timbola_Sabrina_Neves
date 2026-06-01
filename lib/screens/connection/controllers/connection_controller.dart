import 'package:flutter/foundation.dart';
import '../../../services/mqtt_service.dart';

class ConnectionController extends ChangeNotifier {
  ConnectionController() {
    _mqtt.addListener(_onMqttChanged);
  }

  final MqttService _mqtt = MqttService.instance;

  bool get isConnected => _mqtt.isConnected;
  bool get isConnecting => _mqtt.isConnecting;
  String? get errorMessage => _mqtt.errorMessage;

  String get buttonLabel {
    if (isConnected) return 'Desconectar';
    if (isConnecting) return 'Conectando...';
    return 'Conectar';
  }

  Future<void> connect() {
    debugPrint('[UI] Botão "Conectar" pressionado — iniciando conexão MQTT');
    return _mqtt.connect();
  }

  Future<void> disconnect() {
    debugPrint('[UI] Botão "Desconectar" pressionado');
    return _mqtt.disconnect();
  }

  void _onMqttChanged() => notifyListeners();

  @override
  void dispose() {
    _mqtt.removeListener(_onMqttChanged);
    super.dispose();
  }
}
