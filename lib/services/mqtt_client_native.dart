import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

// TCP TLS — porta 8883 do HiveMQ Cloud
MqttClient createMqttClient(String host, String clientId) {
  final client = MqttServerClient.withPort(host, clientId, 8883);
  client.secure = true;
  client.onBadCertificate = (_) => true;
  return client;
}
