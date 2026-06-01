import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';

// WebSocket seguro — porta 8884 do HiveMQ Cloud
MqttClient createMqttClient(String host, String clientId) {
  final client = MqttBrowserClient('wss://$host/mqtt', clientId);
  client.port = 8884;
  return client;
}
