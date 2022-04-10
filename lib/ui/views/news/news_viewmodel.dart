import 'dart:convert';

import 'package:flutter_chat_types/src/preview_data.dart' show PreviewData;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cerbo/app/app.locator.dart';
import 'package:cerbo/app/app.logger.dart';
import 'package:cerbo/constants/styles.dart';
import 'package:cerbo/models/story.dart';
import 'package:cerbo/services/api.dart';
import 'package:cerbo/services/common.dart';
import 'package:cerbo/ui/widgets/rotated_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:cerbo/app/app.locator.dart';

import '../../re_usable_functions.dart';

class NewsViewModel extends BaseViewModel {
  List<Story> _stories_cache = [];
  List<Story> _stories = [];
  List<dynamic> _storyUrls = [];
  List<Story> get stories => _stories;
  int delayTimeToFetchNewStories = 900;
  int pageSize = 10;
  int pageNo = 1;
  var log = getLogger('HomeView', printCallstack: true);
  DateTime? fetchTime;
  bool showBottomBarText = false;
  String bottomBarText = "Loading more stories";

  late SpinKitDoubleBounce loader;
  Map<String, PreviewData> _previewData = {};
  get previewData => _previewData;
  AnimationSyncButtonController? animationSyncButtonController;
  final _firebaseAuthService = locator<FirebaseAuthenticationService>();

  void showLoading() {
    loader = SpinKitDoubleBounce(
      color: TextColorDark,
      size: 50.0,
    );
  }

  bool isFetchingNewStoriesNeeded() {
    DateTime currentTime = DateTime.now();
    if (fetchTime != null) {
      if (currentTime.difference(fetchTime!).inSeconds >
          delayTimeToFetchNewStories) {
        return true;
      }
    }
    return false;
  }

  void getInitalStories() {
    if (_stories.length == 0 || isFetchingNewStoriesNeeded()) {
      getStoriesAndCache();
    }
  }

  void getStoriesAndCache() async {
    fetchTime = DateTime.now();
    showLoading();
    try {
      var token = await _firebaseAuthService.userToken;
      _storyUrls = await locator<APIService>().getNews(token);
      fetchAndUpdateStories();
    } catch (e, s) {
      log.e("Error in fetching stories", e, s);
    }
  }

  void fetchAndUpdateStories() {
    _storyUrls
        .sublist(pageSize * (pageNo - 1), (pageSize * (pageNo)))
        .forEach((element) async {
      try {
        final story = Story.fromJSON(element);
        _stories_cache.add(story);
        populateSomeStories();
      } catch (e, s) {
        log.e("Error in fetching story: $element : $e", e, s);
      }
    });
  }

  void populateSomeStories() {
    _stories = List.from(_stories_cache);
    showBottomBarText = false;
    notifyListeners();
  }

  getNext() {
    if ((pageSize * (pageNo + 1)) <= _storyUrls.length) {
      bottomBarText = "Loading more stories ...";
      showBottomBarText = true;
      pageNo++;
      fetchAndUpdateStories();
    } else {
      bottomBarText = "No more stories";
      showBottomBarText = true;
    }
    notifyListeners();
  }

  openStory(String url) async {
    try {
      await launchUrl(url);
    } catch (e) {}
  }

  void savePreviewData(PreviewData data, index) {
    _previewData = {
      ..._previewData,
      _stories[index].url: data,
    };
    notifyListeners();
  }

  share(String message, {String subject = ""}) {
    share(message, subject: subject);
  }
}
