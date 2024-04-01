import 'package:camera/camera.dart';
import 'package:torch_light/torch_light.dart';

class Global{
  static bool? isEnable;

  init(){
    isEnable =false;
  }

  toggle() async {
    if (Global.isEnable == true) {
      if (await isCameraInUse()) {
        await Future.delayed(Duration(milliseconds: 400),(){});
        await TorchLight.enableTorch();
      }
    }
    else {
      if (await isCameraInUse()) {
        await TorchLight.disableTorch();
      }
    }
  }
    Future<bool> isCameraInUse() async {
      try {
        await availableCameras();
        return true; // Camera available, likely in use
      } on CameraException catch (e) {

        return false;
    }
  }
}