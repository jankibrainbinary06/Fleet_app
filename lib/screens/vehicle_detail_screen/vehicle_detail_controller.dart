import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_project/apis/get_all_transporters_api.dart';
import 'package:new_project/common/widgets/toasts.dart';
import 'package:new_project/screens/vehicle_detail_screen/api/vehical_api.dart';
import 'package:new_project/utils/color_res.dart';
import 'package:new_project/utils/string_res.dart';
import 'package:new_project/utils/text_styles.dart';

class VehicleDetailController extends GetxController {
  TextEditingController vehicalNumberController = TextEditingController();
  TextEditingController transporterNameController = TextEditingController();
  String profileImagePath = '';
  String licenceFrontPath = '';
  String licenceBackPath = '';
  String vehicleNumberPath = '';
  String orgId = '';
  RxBool loader = false.obs;
  List<String> extensionList = [];
  List<String> imagebase64List = [];
  bool isDrop = false ;
  String selectedName ='Select';

  bool validation() {
    if (vehicalNumberController.text.isEmpty) {
      errorToast("Please enter vehicle number");
      return false;
    }
else if(selectedName=="Select"){
      errorToast("Please select transporter name");
      return false;
    }

    else if (vehicleNumberPath.isEmpty) {
      errorToast("Please select vehicle number photo");
      return false;
    }

    else if (profileImagePath.isEmpty) {
      errorToast("Please select driver photo");
      return false;
    } else if (licenceFrontPath.isEmpty) {
      errorToast("Please select license front photo");
      return false;
    } else if (licenceBackPath.isEmpty) {
      errorToast("Please select license back photo");
      return false;
    } else {
      return true;
    }
  }



  Future<void> fileToBase64() async {
    extensionList.clear();
    imagebase64List.clear();

    extensionList.add(profileImagePath.split(".").last);
    extensionList.add(licenceFrontPath.split(".").last);
    extensionList.add(licenceBackPath.split(".").last);
    extensionList.add(vehicleNumberPath.split(".").last);

    File file1 = File(profileImagePath);
    File file2 = File(licenceFrontPath);
    File file3 = File(licenceBackPath);
    File file4 = File(vehicleNumberPath);
    List<int> image1Bytes = await file1.readAsBytes();
    List<int> image2Bytes = await file2.readAsBytes();
    List<int> image3Bytes = await file3.readAsBytes();
    List<int> image4Bytes = await file4.readAsBytes();
    debugPrint("==+++++++++++++: ${base64Encode(image1Bytes)}");
    imagebase64List.add(base64Encode(image1Bytes));
    imagebase64List.add(base64Encode(image2Bytes));
    imagebase64List.add(base64Encode(image3Bytes));
    imagebase64List.add(base64Encode(image4Bytes));
  }


  Future<void> saveVehical() async {
    try {
      loader.value = true;
      await fileToBase64();
      Map<String, String> body = {
        "vehicle_no": vehicalNumberController.text,
        "driver_photo": imagebase64List[0],
        "license_front": imagebase64List[1],
        "license_back": imagebase64List[2],
        'number_plate': imagebase64List[3],
        'transporter_name': selectedName,
      };
      await VehicalApi.saveVehicalApi(
        body: body,
        orgId:orgId
        // imagebase64: imagebase64List,
        // imageExtensionList: extensionList
      ).then((value) {
        if (value != null) {
          debugPrint("-------------:${value.message}");
          profileImagePath = "";
          licenceFrontPath = "";
          licenceBackPath = "";
          vehicalNumberController.clear();
          update(["vehicle"]);
        }
      });
      loader.value = false;
    } catch (e) {
      loader.value = false;
    }
  }

  imageDialog(context, int i) async {
    await showModalBottomSheet(
        elevation: 10,
        barrierColor: ColorRes.black.withOpacity(0.4),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        backgroundColor: ColorRes.white,
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  Get.back();
                  final ImagePicker picker = ImagePicker();
                  final image =
                      await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

                  if (image != null) {
                    if (i == 1) {
                      profileImagePath = image.path.toString();
                    } else if (i == 2) {
                      licenceFrontPath = image.path.toString();
                    } else if (i == 3) {
                      licenceBackPath = image.path.toString();
                    } else if (i == 4) {
                      vehicleNumberPath = image.path.toString();
                    } else {}
                    update(['vehicle']);
                  }
                },
                child: ListTile(
                  leading: Icon(
                    Icons.camera,
                    color: ColorRes.appPrimary,
                  ),
                  title: Text(Strings.camera, style: blackSubTitle),
                ),
              ),
              Container(
                height: 0.5,
                width: Get.width,
                color: ColorRes.white,
              ),
              GestureDetector(
                onTap: () async {
                  Get.back();
                  final ImagePicker picker = ImagePicker();
                  final image =
                      await picker.pickImage(source: ImageSource.gallery,imageQuality: 50);

                  if (image != null) {
                    if (i == 1) {
                      profileImagePath = image.path.toString();
                    } else if (i == 2) {
                      licenceFrontPath = image.path.toString();
                    } else if (i == 3) {
                      licenceBackPath = image.path.toString();
                    } else if (i == 4) {
                      vehicleNumberPath = image.path.toString();
                    } else {}
                    update(['vehicle']);
                  }
                },
                child: ListTile(
                  leading: Icon(
                    Icons.photo_size_select_actual_outlined,
                    color: ColorRes.appPrimary,
                  ),
                  title: Text(Strings.gallery, style: blackSubTitle),
                ),
              ),
            ],
          );
        });
  }


  @override
  void onInit() {
    getTransportersApi();
    super.onInit();
  }
  List getTransporters = [];
  getTransportersApi() async {
    try {
      loader.value = true;
      getTransporters = await GetAllTraApi.getAllTragApi();
      print(getTransporters);
      getTransporters.add('+ Add New');

      loader.value = false;
    } catch (e) {
      print(e.toString());
      loader.value = false;
    }
  }
}
