import '../../../data/repositories/device_repository.dart';
import '../../../models/device_model.dart';

class GetInitialDevicesUseCase {
  const GetInitialDevicesUseCase(this._repository);

  final DeviceRepository _repository;

  List<DeviceModel> call() => _repository.getInitialDevices();
}
