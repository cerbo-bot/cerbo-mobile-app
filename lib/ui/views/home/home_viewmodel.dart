import 'package:cerbo/app/app.locator.dart';
import 'package:cerbo/app/app.logger.dart';
import 'package:cerbo/app/app.router.dart';
import 'package:cerbo/models/categories.dart';
import 'package:cerbo/models/news.dart';
import 'package:cerbo/services/api.dart';
import 'package:cerbo/services/dummyData.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../re_usable_functions.dart';

class HomeViewModel extends BaseViewModel {
  final _nagivationService = locator<NavigationService>();
  final _firebaseAuthService = locator<FirebaseAuthenticationService>();
  final _apiService = locator<APIService>();

  Categories? categoriesCache;

  String selectedCategoryTab = "";
  String selectedRegionalTab = "";
  String selectedRecentTab = "Read Later";
  List<News> recentlyVisitedHistory = [];
  List<News> readLaterHistory = [];

  final log = getLogger('HomeView');
  Room room = new Room(id: "", type: RoomType.group, users: []);

  String userName = '';

  void doSomething() {
    _nagivationService.navigateTo(Routes.newsView);
  }

  openChatPage() {
    _nagivationService.navigateTo(Routes.chatView,
        arguments: ChatViewArguments(room: room));
  }

  void openCerboWebsite() {
    launchUrl('https://github.com/cerbo-bot');
  }

  initHome() async {
    FirebaseChatCore.instance.rooms().listen(_setRoomId);
    userName = _firebaseAuthService.currentUser!.displayName!;
    categoriesCache = await getIntialCategories();
    changeSelectedCategoryTab("popular");
  }

  void _setRoomId(List<Room> rooms) {
    rooms.forEach((room) {
      for (var item in room.users) {
        if (item.id == 'ZkuedrNkNbtVbAE87sNC') {
          this.room = room;
        }
      }
    });
  }

  void logout() async {
    await locator<FirebaseAuthenticationService>().logout();
    _nagivationService.clearStackAndShow(Routes.loginView);
  }

  void search() {}

  Future<Categories> getIntialCategories() async {
    DummyData dummyData = new DummyData();
    var json = await dummyData.getNewsByCategory();
    return new Categories.fromJson(json);
  }

  void changeSelectedCategoryTab(String category) {
    selectedCategoryTab = category;
    selectedRegionalTab = (this.selectedCategoryTab.toLowerCase() == "popular"
            ? this.categoriesCache?.popular?.regionalNews?.keys.first
            : this.selectedCategoryTab.toLowerCase() == "recent"
                ? this.categoriesCache?.recent?.regionalNews?.keys.first
                : this.categoriesCache?.trending?.regionalNews?.keys.first) ??
        "";
    notifyListeners();
  }

  void changeSelectedRegionalNewsTab(String category) {
    selectedRegionalTab = category;
    notifyListeners();
  }

  void changeSelectedRecentTab(String category) {
    selectedRecentTab = category;
    log.d(recentlyVisitedHistory.length);
    notifyListeners();
  }

  void addNewsToHistory(News news) {
    recentlyVisitedHistory.add(news);
  }

  void removeNewsToHistory(News news) {
    recentlyVisitedHistory.removeWhere((tempNews) {
      return news.title == tempNews.title;
    });
    notifyListeners();
  }

  void addNewsToReadLater(News news) {
    readLaterHistory.add(news);
  }

  void removeNewsToReadLater(News news) {
    readLaterHistory.removeWhere((tempNews) {
      return news.title == tempNews.title;
    });
    notifyListeners();
  }
}
