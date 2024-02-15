import 'package:get/get.dart';
import 'package:HappyLink/utils/themes.dart';

class ThemeService extends GetxService {
  late Rx<AppTheme> _currentTheme = AppTheme().obs;

  AppTheme get currentTheme => _currentTheme.value;
  // @override
  // void onInit() {
  //   super.onInit();
  //   _currentTheme = HappyTheme().obs;
  // }

  void changeTheme(AppTheme theme) {
    _currentTheme.value = theme;
    // You can save the selected theme to local storage here if needed
  }
}
