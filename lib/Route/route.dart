// NOTE: https://juejin.cn/post/7020598013986865182#heading-12
import 'package:get/get.dart';
import 'package:one/pages/details/details_binding.dart';
import 'package:one/pages/details/details_view.dart';
import 'package:one/pages/home/home_binding.dart';

import '../pages/home/home_view.dart';

class RouteConfig {
  static const String home = '/';
  static const String details = '/details/:id';

  static final List<GetPage> getPages = [
    GetPage(
      name: home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: details,
      page: () => DetailsPage(),
      binding: DetailsBinding(),
    )
  ];
}
