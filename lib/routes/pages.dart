import 'package:shift_app/routes/routes.dart';
import 'package:shift_app/screens/base_page.dart';
import 'package:get/route_manager.dart';

import 'bindings/base_binding.dart';


class Pages {
  static List<GetPage> getPage = [
    GetPage(
      name: Routers.home,
      page: () => BasePage(),
      binding: BaseBinding(),
    ),
  ];
}
