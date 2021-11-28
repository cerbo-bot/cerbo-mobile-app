import 'package:cerbo/app/app.locator.dart';
import 'package:cerbo/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class StartUpViewModel extends BaseViewModel {
  final _nagivationService = locator<NavigationService>();
  final _firebaseAuthService = locator<FirebaseAuthenticationService>();

  String title = 'Startup';

  void doSomething() async {
    _firebaseAuthService.hasUser
        ? _nagivationService.clearStackAndShow(Routes.homeView)
        : _nagivationService.clearStackAndShow(Routes.loginView);
  }
}
