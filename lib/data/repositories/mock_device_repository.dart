import '../../models/device_model.dart';
import '../mock_devices.dart';
import 'device_repository.dart';

class MockDeviceRepository implements DeviceRepository {
  @override
  List<DeviceModel> getInitialDevices() => List<DeviceModel>.from(mockDevices);

  @override
  Future<List<DeviceModel>> scanDevices() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return List<DeviceModel>.from(mockDevices);
  }

  @override
  Future<DeviceModel> connectToDevice(DeviceModel device) async {
    await Future.delayed(const Duration(seconds: 2));
    return device;
  }
}
