import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_bot/app/app.locator.dart';
import 'package:my_bot/app/app.logger.dart';
import 'package:my_bot/constants/styles.dart';
import 'package:my_bot/services/common.dart';
import 'package:stacked/stacked.dart';

class ChatViewModel extends BaseViewModel {
  final log = getLogger('ChatView');

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

  void _populateTopStories() async {}

  openResult(String url) async {
    try {
      await locator<CommonServices>().launchUrl(url);
    } catch (e) {}
  }
}
