import 'package:notespedia/utils/bindings/home_bindings.dart';
import 'package:notespedia/utils/constants/app_export.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(NetworkStateController(), permanent: true);
    Get.put(AuthenticationController(), permanent: true);
  }
}
