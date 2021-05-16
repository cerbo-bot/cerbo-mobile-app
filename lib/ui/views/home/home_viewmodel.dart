import 'dart:convert';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_bot/app/app.locator.dart';
import 'package:my_bot/app/app.logger.dart';
import 'package:my_bot/constants/styles.dart';
import 'package:my_bot/models/story.dart';
import 'package:my_bot/services/api.dart';
import 'package:my_bot/services/common.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  List<Story> _stories_cache = [];
  List<Story> _stories = [];
  List<dynamic> _storyUrls = [];
  List<Story> get stories => _stories;
  int delayTimeToFetchNewStories = 900;
  int pageSize = 10;
  int pageNo = 1;
  var log = getLogger('HomeView', printCallstack: true);
  DateTime? fetchTime;

  late SpinKitDoubleBounce loader;

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
      _storyUrls = await locator<APIService>().getTopStories();
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
        final storyResponse = await locator<APIService>().getStory(element);
        final storyJson = jsonDecode(storyResponse.body);
        final story = Story.fromJSON(storyJson);
        _stories_cache.add(story);
        populateSomeStories();
      } catch (e, s) {
        log.e("Error in fetching story: $element : $e", e, s);
      }
    });
  }

  void populateSomeStories() {
    _stories = List.from(_stories_cache);
    notifyListeners();
  }

  getNext() {
    if ((pageSize * (pageNo + 1)) <= _storyUrls.length) {
      pageNo++;
      fetchAndUpdateStories();
    }
  }

  openStory(String url) async {
    try {
      await locator<CommonServices>().launchUrl(url);
    } catch (e) {}
  }
}
