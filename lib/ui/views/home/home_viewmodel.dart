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
  List<Story> _stories = [];
  List<Story> get stories => _stories;
  var log = getLogger('HomeView');

  late SpinKitDoubleBounce loader;

  void doSomething() {
    loader = SpinKitDoubleBounce(
      color: TextColorDark,
      size: 50.0,
    );
    _populateTopStories();
    // this will call the builder defined in the view file and rebuild the ui using
    // the update version of the model.
    // notifyListeners();
  }

  void _populateTopStories() async {
    log.d('fetching stories');
    final responses = await locator<APIService>().getTopStories();
    final stories = responses.map((response) {
      final json = jsonDecode(response.body);
      return Story.fromJSON(json);
    }).toList();
    _stories = stories;
    notifyListeners();
  }

  openStory(String url) async {
    try {
      await locator<CommonServices>().launchUrl(url);
    } catch (e) {}
  }
}
