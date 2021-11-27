import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/src/room.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:cerbo/app/app.locator.dart';
import 'package:cerbo/app/app.logger.dart';
import 'package:cerbo/app/app.router.dart';
import 'package:cerbo/services/common.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class HomeViewModel extends BaseViewModel {
  final _nagivationService = locator<NavigationService>();
  final log = getLogger('HomeView');

  Room room = new Room(id: "", type: RoomType.group, users: []);

  void doSomething() {
    _nagivationService.navigateTo(Routes.newsView);
  }

  openChatPage() {
    _nagivationService.navigateTo(Routes.chatView,
        arguments: ChatViewArguments(room: room));
  }

  void openCerboWebsite() {
    locator<CommonServices>().launchUrl('https://github.com/cerbo-bot');
  }

  initHome() async {
    FirebaseChatCore.instance.rooms().listen(_setRoomId);
  }

  void _setRoomId(List<Room> rooms) {
    rooms.forEach((room) {
      log.d(room.toString());
      if (room.id == '8C7qKvx5VSTzta7oGm2W') {
        this.room = room;
      }
    });
  }

  void logout() async {
    await locator<FirebaseAuthenticationService>().logout();
    _nagivationService.clearStackAndShow(Routes.loginView);
  }
}
