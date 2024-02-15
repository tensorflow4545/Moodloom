import 'package:HappyLink/controller/FireBase_controller/CurrentUserController.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCall extends StatelessWidget {
  MyCall({super.key, required this.callID});
  final String callID;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CurrentUserController>();
    return ZegoUIKitPrebuiltCall(
      appID:
          1152945642, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign:
          , // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: "${controller.userModel.value.userDetails!.userId}",
      userName: "${controller.userModel.value.userDetails!.name}",
      callID: callID,
      config: ZegoUIKitPrebuiltCallConfig.groupVideoCall()
        ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );
  }
}
