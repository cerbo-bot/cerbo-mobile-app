import 'package:flutter_chat_types/src/room.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:my_bot/app/app.locator.dart';
import 'package:my_bot/app/app.logger.dart';
import 'package:my_bot/app/app.router.dart';
import 'package:my_bot/services/common.dart';
import 'package:stacked/stacked.dart';
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
}
