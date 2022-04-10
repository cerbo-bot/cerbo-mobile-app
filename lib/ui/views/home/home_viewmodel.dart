import 'package:cerbo/app/app.locator.dart';
import 'package:cerbo/app/app.logger.dart';
import 'package:cerbo/app/app.router.dart';
import 'package:cerbo/models/categories.dart';
import 'package:cerbo/models/category.dart';
import 'package:cerbo/models/news.dart';
import 'package:cerbo/services/api.dart';
import 'package:cerbo/services/dummyData.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../re_usable_functions.dart';

class HomeViewModel extends BaseViewModel {
  final _nagivationService = locator<NavigationService>();
  final _firebaseAuthService = locator<FirebaseAuthenticationService>();
  final _apiService = locator<APIService>();

  List<Category>? categoriesCache;

  String selectedCategoryTab = "";
  String selectedRegionalTab = "";
  String selectedRecentTab = "Read Later";
  List<News> recentlyVisitedHistory = [];
  List<News> readLaterHistory = [];
  final mainCategories = [
    Category(name: "Popular"),
    Category(name: "Trending"),
    Category(name: "Recent")
  ];

  final List<Category> categories = [];
  final List<News> news = [];

  final log = getLogger('HomeView');
  Room room = new Room(id: "", type: RoomType.group, users: []);

  String userName = '';

  void doSomething() {
    _nagivationService.navigateTo(Routes.newsView);
  }

  void openCerboWebsite() {
    launchUrl('https://github.com/cerbo-bot');
  }

  initHome() async {
    userName = _firebaseAuthService.currentUser!.displayName!;
    categoriesCache = await getIntialCategories();
    getCategories();
    getNews();
  }

  void logout() async {
    await locator<FirebaseAuthenticationService>().logout();
    _nagivationService.clearStackAndShow(Routes.loginView);
  }

  void search() {}

  Future<List<Category>> getIntialCategories() async {
    return _apiService.getCategories();
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

  Future getCategories() async {
    var categories = await _apiService.getCategories();
    categories.forEach((element) {
      log.e(element.toJson());
    });
    this.categories.addAll(categories);
    notifyListeners();
  }

  Future getNews() async {
    var token = await _firebaseAuthService.userToken;
    log.e("Token $token");
    var news = await _apiService.getNews(token);
    categories.forEach((element) {
      log.e(element.toJson());
    });
    this.news.addAll(news);
    notifyListeners();
  }
}
