import 'package:my_bot/services/api.dart';
import 'package:my_bot/services/common.dart';
import 'package:my_bot/ui/views/chat/chat_view.dart';
import 'package:my_bot/ui/views/home/home_view.dart';
import 'package:my_bot/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  MaterialRoute(page: StartUpView, initial: true),
  CupertinoRoute(page: HomeView),
  CupertinoRoute(page: ChatView),
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: APIService),
  LazySingleton(classType: CommonServices)
])
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
