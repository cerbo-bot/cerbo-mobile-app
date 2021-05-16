import 'package:my_bot/app/app.locator.dart';
import 'package:my_bot/app/app.router.dart';
import 'package:my_bot/services/common.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartUpViewModel extends BaseViewModel {
  final _nagivationService = locator<NavigationService>();

  String title = 'Startup';

  void doSomething() {
    _nagivationService.navigateTo(Routes.homeView);
  }

  openChatPage() {
    _nagivationService.navigateTo(Routes.chatView);
  }

  void openCerboWebsite() {
    locator<CommonServices>().launchUrl('https://github.com/cerbo-bot');
  }
}
