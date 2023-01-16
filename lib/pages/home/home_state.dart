import '../../models/poster_model.dart';

class HomeState {
  late bool hasMore;
  late List<PosterModel> posterList;
  late int count;
  late int pageNum;
  late bool isLoading;

  HomeState() {
    hasMore = true;
    isLoading = false;
    posterList = [];
    count = 0;
    pageNum = 1;
  }
}
