/*

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpressfly/presentation/kyc_one_screen/controller/kyc_one_controller.dart';



class CameraScreen extends StatefulWidget {

  CameraScreen({ Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  KycOneController kycOneController = Get.put(KycOneController());
  @override
  void initState() {
    super.initState();
    controller = CameraController(
        CameraDescription(
            sensorOrientation: 1,
            lensDirection: CameraLensDirection.back,
            name: "0"),
        ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
        print('Camera Initialization Error:------------------------------ $e');
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
              height: Get.height -100,
              width: Get.width,
              alignment: Alignment.center,
              child: CameraPreview(controller)),
          Column(
            children: [
              InkWell(
                onTap: () async {
                  final XFile file = await controller.takePicture();
                   Get.back(result: file);
                },
                child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blueAccent,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.camera,
                      size: 30,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }


}
*/



import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project/global.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> initializeCamera() async {
    try {
      controller = CameraController(
          CameraDescription(
              sensorOrientation: 1, lensDirection: CameraLensDirection.back, name: "0"),
          ResolutionPreset.medium);
      await controller.initialize();
      if(Global.isEnable ?? false)
        {
          controller.setFlashMode(FlashMode.torch);
        }
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      handleCameraInitializationError(e);
    }
  }

  void handleCameraInitializationError(Object e) {
    if (e is CameraException) {
      switch (e.code) {
        case 'CameraAccessDenied':
        // Handle access errors here.
          break;
        default:
        // Handle other errors here.
          break;
      }
      print('Camera Initialization Error: $e');
    }
  }

  Future<void> takePictureAndNavigateBack() async {
    final XFile file = await controller.takePicture();
    Get.back(result: file);
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return WillPopScope(
      onWillPop: ()async{
        Global().toggle();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              height: Get.height - 100,
              width: Get.width,
              alignment: Alignment.center,
              child: CameraPreview(controller),
            ),
            Column(
              children: [
                InkWell(
                  onTap: takePictureAndNavigateBack,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blueAccent,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.camera,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
