import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:new_project/apis/get_all_organisation_api.dart';
import 'package:new_project/apis/search_api.dart';
import 'package:new_project/models/get_all_org_model.dart';
import 'package:new_project/models/search_model.dart';

class SearchController1 extends GetxController {
  TextEditingController searchController = TextEditingController();
  RxList<SearchModel> vehicalSearchList = <SearchModel>[].obs;
  RxBool loader = false.obs;
  RxBool isSearching = false.obs;
  String selectedOrg = 'Select';
  String selectedOrgId = '';
  bool isDrop = false;
  List<GetAllOrgModel> getAllOrgModel = [];

  Future<void> searchAPi(value) async {
    try {
      loader.value = true;
      vehicalSearchList.value.clear();
      await SearchApi.searchApi(value).then((value) {
        if (value != null) {
          vehicalSearchList.value.addAll(value);
          vehicalSearchList.refresh();
          debugPrint("------------: ${vehicalSearchList.value.length}");
        }
      });
      loader.value = false;
    } catch (e) {
      debugPrint(e.toString());
      loader.value = false;
    }
  }

  @override
  void onInit() {
    getAllOrgApi();
    super.onInit();
  }

  getAllOrgApi() async {
    try {
      loader.value = true;
      getAllOrgModel = await GetAllOrgApi.getAllOrgApi();
      loader.value = false;
    } catch (e) {
      loader.value = false;
    }

    update(['search']);
  }
}
