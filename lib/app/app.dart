import 'package:cerbo/services/api.dart';
import 'package:cerbo/services/common.dart';
import 'package:cerbo/ui/views/home/home_view.dart';
import 'package:cerbo/ui/views/login/login_view.dart';
import 'package:cerbo/ui/views/news/news_view.dart';
import 'package:cerbo/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  MaterialRoute(page: StartUpView, initial: true),
  CupertinoRoute(page: HomeView),
  CupertinoRoute(page: LoginView),
  CupertinoRoute(page: NewsView),
], dependencies: [
  Singleton(classType: NavigationService),
  LazySingleton(classType: APIService),
  LazySingleton(classType: CommonServices),
  LazySingleton(classType: FirebaseAuthenticationService),
])
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
