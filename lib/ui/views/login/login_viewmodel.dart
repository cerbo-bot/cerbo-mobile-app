import 'package:cerbo/app/app.locator.dart';
import 'package:cerbo/app/app.logger.dart';
import 'package:cerbo/app/app.router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class LoginViewModel extends BaseViewModel {
  var log = getLogger('LoginView', printCallstack: true);
  final _nagivationService = locator<NavigationService>();
  final _firebaseAuthService = locator<FirebaseAuthenticationService>();
  bool _hideAuthUI = true;
  get hideUI => _hideAuthUI;
  FirebaseAuth? _auth;

  void navigateToHome() {
    _nagivationService.navigateTo(Routes.homeView);
  }

  Future<void> login() async {
    _showLoadingAuthUI();
    try {
      await _firebaseAuthService.signInWithGoogle();
      _auth = FirebaseAuth.instance;
      _handleSuccessfulLogin();
    } catch (err, stackTrace) {
      log.e("An error occured", err, stackTrace);
      _showAuthUI();
    }
  }

  void _handleSuccessfulLogin() async {
    if (_auth?.currentUser?.uid != null && _auth?.currentUser?.email != null) {
      types.User cerboUser = types.User(
          avatarUrl:
              'https://cdn.dribbble.com/users/690291/screenshots/3507754/untitled-1.gif',
          firstName: "Cerbo",
          id: "ZkuedrNkNbtVbAE87sNC");

      types.User user = types.User(
          avatarUrl: 'https://i.pravatar.cc/300?u=${_auth!.currentUser!.email}',
          firstName: _auth!.currentUser?.displayName ?? "",
          id: _auth!.currentUser!.uid,
          lastName: "");

      await FirebaseChatCore.instance.createUserInFirestore(
        user,
      );

      await FirebaseChatCore.instance.createRoom(cerboUser);

      navigateToHome();
    }
  }

  void _showAuthUI() {
    _hideAuthUI = false;
    notifyListeners();
  }

  void _showLoadingAuthUI() {
    _hideAuthUI = true;
    notifyListeners();
  }
}
