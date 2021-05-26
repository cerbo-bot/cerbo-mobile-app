import 'package:flutter_chat_types/src/room.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:cerbo/app/app.locator.dart';
import 'package:cerbo/app/app.logger.dart';
import 'package:cerbo/app/app.router.dart';
import 'package:cerbo/services/common.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _nagivationService = locator<NavigationService>();
  final log = getLogger('HomeView');

  String roomId = '';

  void doSomething() {
    _nagivationService.navigateTo(Routes.newsView);
  }

  openChatPage() {
    _nagivationService.navigateTo(Routes.chatView,
        arguments: ChatViewArguments(roomId: roomId));
  }

  void openCerboWebsite() {
    locator<CommonServices>().launchUrl('https://github.com/cerbo-bot');
  }

  initHome() async {
    FirebaseChatCore.instance.rooms().listen(_setRoomId);
  }

  void _setRoomId(List<Room> rooms) {
    rooms.forEach((room) {
      for (var item in room.users) {
        if (item.id == 'ZkuedrNkNbtVbAE87sNC') {
          roomId = room.id;
        }
      }
    });
  }

  void logout() async {
    await locator<FirebaseAuthenticationService>().logout();
    _nagivationService.clearStackAndShow(Routes.loginView);
  }
}
