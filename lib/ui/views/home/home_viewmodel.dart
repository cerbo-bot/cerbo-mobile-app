import 'package:cerbo/app/app.locator.dart';
import 'package:cerbo/app/app.logger.dart';
import 'package:cerbo/app/app.router.dart';
import 'package:cerbo/models/category.dart';
import 'package:cerbo/models/news.dart';
import 'package:cerbo/services/api.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../re_usable_functions.dart';

class HomeViewModel extends BaseViewModel {
  final _nagivationService = locator<NavigationService>();
  final _firebaseAuthService = locator<FirebaseAuthenticationService>();
  final _apiService = locator<APIService>();
  final mainCategories = [
    Category(name: "Popular"),
    Category(name: "Recent"),
  ];

  final recentCategories = [
    Category(name: "History"),
    Category(name: "Read Later"),
  ];

  List<Category>? categoriesCache;

  Category? selectedCategoryTab;
  Category? selectedRegionalTab;
  Category? selectedRecentTab;
  List<News> recentlyVisitedHistory = [];
  List<News> readLaterHistory = [];

  final List<Category> categories = [];
  final List<News> news = [];

  final log = getLogger('HomeView');
  // Room room = new Room(id: "", type: RoomType.group, users: []);

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
    await getCategories();
    await getNews();
    changeSelectedCategoryTab(mainCategories.first);
    changeSelectedRegionalNewsTab(categories.first);
    changeSelectedRecentTab(recentCategories.first);
  }

  void logout() async {
    await locator<FirebaseAuthenticationService>().logout();
    _nagivationService.clearStackAndShow(Routes.loginView);
  }

  void search() {}

  Future<List<Category>> getIntialCategories() async {
    return _apiService.getCategories();
  }

  void changeSelectedCategoryTab(Category category) {
    selectedCategoryTab = category;
    notifyListeners();
  }

  void changeSelectedRegionalNewsTab(Category category) {
    selectedRegionalTab = category;
    notifyListeners();
  }

  void changeSelectedRecentTab(Category category) {
    selectedRecentTab = category;
    notifyListeners();
  }

  void addNewsToHistory(News news) {
    recentlyVisitedHistory.addIf(
        !recentlyVisitedHistory.map((e) => e.id == news.id).contains(true),
        news);
  }

  void removeNewsToHistory(News news) {
    log.e(news.id);
    recentlyVisitedHistory.removeWhere((tempNews) {
      return news.id == tempNews.id;
    });
    notifyListeners();
  }

  void addNewsToReadLater(News news) {
    readLaterHistory.addIf(
        !readLaterHistory.map((e) => e.id == news.id).contains(true), news);
  }

  void removeNewsToReadLater(News news) {
    readLaterHistory.removeWhere((tempNews) {
      return news.id == tempNews.id;
    });
    notifyListeners();
  }

  Future getCategories() async {
    var categories = await _apiService.getCategories();
    this.categories.addAll(categories);

    notifyListeners();
  }

  Future getNews() async {
    var token = await _firebaseAuthService.userToken;
    var news = await _apiService.getNews(token);
    this.news.addAll(news);
    notifyListeners();
  }
}
