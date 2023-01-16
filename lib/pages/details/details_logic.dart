import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:one/models/poster_model.dart';

import 'details_state.dart';

class DetailsLogic extends GetxController {
  final DetailsState state = DetailsState();

  Future<void> getPosterDetailsById(int id) async {
    String url = 'http://192.168.69.179:3000/poster/details?id=$id';

    try {
      var response = await Dio().get(url);
      var result = response.data;
      var data = result['data'];
      state.posterDetails = PosterModel(
        data['posterUrl'],
        data['content'],
        data['author'],
        data['id'],
      );
      update();
    } finally {}
  }

  @override
  void onInit() async {
    String? id = Get.parameters['id'];
    if (id != null) {
      await getPosterDetailsById(int.parse(id));
    }
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
