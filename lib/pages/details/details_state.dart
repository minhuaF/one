import '../../models/poster_model.dart';

class DetailsState {
  late PosterModel posterDetails;

  DetailsState() {
    // TODO: 对象的情况怎么处理？
    posterDetails = PosterModel('', '', '', 0);
  }
}
