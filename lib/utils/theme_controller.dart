import 'package:get/get.dart';
import 'package:HappyLink/utils/Theme_services.dart';
import 'package:HappyLink/utils/themes.dart';

class ThemeController extends GetxController {
  final ThemeService _themeService = Get.find();

  void changeTheme(AppTheme theme) {
    _themeService.changeTheme(theme);
  }
}
