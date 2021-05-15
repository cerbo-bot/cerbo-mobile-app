import 'dart:convert';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_bot/app/app.locator.dart';
import 'package:my_bot/app/app.logger.dart';
import 'package:my_bot/constants/model_helper.dart';
import 'package:my_bot/constants/styles.dart';
import 'package:my_bot/models/story.dart';
import 'package:my_bot/services/api.dart';
import 'package:my_bot/services/common.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  List<Story> _stories_cache = [];
  List<Story> _stories = [];
  List<Story> get stories => _stories;
  var log = getLogger('HomeView', printCallstack: true);

  late SpinKitDoubleBounce loader;

  void showLoading() {
    loader = SpinKitDoubleBounce(
      color: TextColorDark,
      size: 50.0,
    );
    // this will call the builder defined in the view file and rebuild the ui using
    // the update version of the model.
    // notifyListeners();
  }

  // void populateTopStories() async {
  //   if (_stories_cache.length == _stories.length) {
  //     getStoriesAndCache();
  //   } else {
  //     populateSomeStories();
  //   }
  // }

  void getStoriesAndCache() async {
    log.d("getting stories");
    showLoading();
    try {
      final responses = await locator<APIService>().getTopStories();
      log.d(responses.length);
      final stories = responses.map((response) {
        log.i(response.body.toString());
        final json = jsonDecode(response.body);
        return Story.fromJSON(json);
      }).toList();
      _stories_cache.insertAll(0, stories);
      _stories.clear();
      populateSomeStories();
    } catch (e, s) {
      log.e("Error in fetching stories", e, s);
    }
  }

  void populateSomeStories() {
    log.d("populating stories");
    int currentStoriesCount = _stories.length;
    if (currentStoriesCount + noOfStoriesToPopulate != _stories_cache.length) {
      _stories.addAll(_stories_cache.sublist(
          currentStoriesCount, currentStoriesCount + noOfStoriesToPopulate));
      log.i(_stories.length);
      log.i(_stories[0].title);
      notifyListeners();
    }
  }

  openStory(String url) async {
    try {
      await locator<CommonServices>().launchUrl(url);
    } catch (e) {}
  }
}
