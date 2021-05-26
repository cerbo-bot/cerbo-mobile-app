import 'package:cerbo/app/app.locator.dart';
import 'package:cerbo/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _nagivationService = locator<NavigationService>();
  final _firebaseAuthService = locator<FirebaseAuthenticationService>();

  void navigateToHome() {
    _nagivationService.navigateTo(Routes.homeView);
  }

  Future<void> login() async {
    await _firebaseAuthService.loginWithEmail(
        email: "lilla.stark@crist.us", password: 'Qawsed1-');
    navigateToHome();
  }
}
