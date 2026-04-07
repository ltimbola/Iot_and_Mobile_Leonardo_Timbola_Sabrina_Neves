import '../../../data/repositories/device_repository.dart';
import '../../../models/device_model.dart';

class ConnectToDeviceUseCase {
  const ConnectToDeviceUseCase(this._repository);

  final DeviceRepository _repository;

  Future<DeviceModel> call(DeviceModel device) =>
      _repository.connectToDevice(device);
}
