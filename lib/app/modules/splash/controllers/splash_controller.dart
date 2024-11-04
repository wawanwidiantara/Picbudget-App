import 'package:get/get.dart';
import 'package:picbudget_app/app/constans/url.dart';
import 'package:http/http.dart' as http;
import 'package:picbudget_app/app/modules/login/controllers/login_controller.dart';
import 'package:picbudget_app/app/modules/splash/views/on_boarding_view.dart';
import 'package:picbudget_app/app/routes/app_pages.dart';

class SplashController extends GetxController {
  final loginController = Get.put(LoginController());

  @override
  void onReady() {
    super.onReady();
    var loginStatus = checkLogin();
    loginStatus.then((value) {
      if (value) {
        Future.delayed(const Duration(seconds: 3), () {
          Get.offAllNamed(Routes.NAVBAR);
        });
      } else {
        Future.delayed(const Duration(seconds: 3), () {
          Get.offAll(() => const OnBoardingView());
        });
      }
    });
  }

  checkLogin() async {
    try {
      var url = Uri.parse("${UrlApi.baseAPI}/user/");
      var token = 'Bearer ${loginController.getStorage.read("access_token")}';

      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token,
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        print(response.body);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
