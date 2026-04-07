import '../../models/device_model.dart';

abstract class DeviceRepository {
  List<DeviceModel> getInitialDevices();
  Future<List<DeviceModel>> scanDevices();
  Future<DeviceModel> connectToDevice(DeviceModel device);
}
