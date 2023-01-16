import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

import '../../models/poster_model.dart';
import 'home_state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  Future<void> getPosterList(int pageNum, String type) async {
    String url = 'http://192.168.69.179:3000/poster/list-mock?pageNum=$pageNum';
    // TODO 异常处理
    state.isLoading = true;
    update();

    if(state.hasMore == false) {
      return;
    }

    try {
      late List<PosterModel> list = [];
      var httpClient = HttpClient();
      var req = await httpClient.getUrl(Uri.parse(url));
      var rsp = await req.close();
      if (rsp.statusCode == HttpStatus.OK) {
        var jsonString = await rsp.transform(utf8.decoder).join();
        var result = jsonDecode(jsonString)['data'];
        for (var poster in result['list']) {
          list.add(  // NOTE: 遍历数组，创建对象实例
            PosterModel(
              poster['posterUrl'],
              poster['content'],
              poster['author'],
              poster['id']
            ),
          );
        }
        if(type == 'down') {
          state.posterList.insertAll(0, list);
        } else {
          state.posterList.addAll(list);
        }
        state.hasMore = result['hasMore'];
        state.isLoading = false;
        state.pageNum = pageNum;
        update();
      }
    } finally {
      state.isLoading = false;
      update();
    }
  }

  @override
  void onInit() async {
    await getPosterList(state.pageNum, 'down');
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
