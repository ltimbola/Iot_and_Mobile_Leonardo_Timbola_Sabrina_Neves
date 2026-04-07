import 'package:flutter/foundation.dart';
import '../../../data/repositories/device_repository.dart';
import '../../../data/repositories/mock_device_repository.dart';
import '../../../domain/use_cases/connection/connect_to_device_use_case.dart';
import '../../../domain/use_cases/connection/get_initial_devices_use_case.dart';
import '../../../domain/use_cases/connection/scan_devices_use_case.dart';
import '../../../models/device_model.dart';

class ConnectionController extends ChangeNotifier {
  ConnectionController({DeviceRepository? repository})
      : _repository = repository ?? MockDeviceRepository() {
    devices = _getInitialDevices();
  }

  final DeviceRepository _repository;
  late final GetInitialDevicesUseCase _getInitialDevices =
      GetInitialDevicesUseCase(_repository);
  late final ScanDevicesUseCase _scanDevices = ScanDevicesUseCase(_repository);
  late final ConnectToDeviceUseCase _connectToDevice =
      ConnectToDeviceUseCase(_repository);
  bool isConnected = false;
  bool isLoading = false;
  DeviceModel? selectedDevice;
  List<DeviceModel> devices = [];

  String get scanButtonLabel {
    if (isConnected) return 'Reconectar';
    if (devices.isNotEmpty) return 'Atualizar lista';
    return 'Buscar dispositivos';
  }

  String get selectedOrFallbackName {
    if (selectedDevice != null) return selectedDevice!.name;
    if (devices.isNotEmpty) return devices.first.name;
    return 'Modo demonstração';
  }

  Future<void> scanDevices() async {
    isLoading = true;
    notifyListeners();

    devices = await _scanDevices();
    isLoading = false;
    notifyListeners();
  }

  Future<DeviceModel> connectToDevice(DeviceModel device) async {
    isLoading = true;
    notifyListeners();

    final connectedDevice = await _connectToDevice(device);

    isConnected = true;
    selectedDevice = connectedDevice;
    isLoading = false;
    notifyListeners();
    return connectedDevice;
  }
}
