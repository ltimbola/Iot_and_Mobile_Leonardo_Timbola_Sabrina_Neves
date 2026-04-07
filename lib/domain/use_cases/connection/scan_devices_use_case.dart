import '../../../data/repositories/device_repository.dart';
import '../../../models/device_model.dart';

class ScanDevicesUseCase {
  const ScanDevicesUseCase(this._repository);

  final DeviceRepository _repository;

  Future<List<DeviceModel>> call() => _repository.scanDevices();
}
