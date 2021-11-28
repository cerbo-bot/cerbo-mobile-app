import 'package:cerbo/app/app.logger.dart';
import 'package:stacked/stacked.dart';

class ChatViewModel extends BaseViewModel {
  final log = getLogger('ChatView');

  void doSomething() {
    // this will call the builder defined in the view file and rebuild the ui using
    // the update version of the model.
    // notifyListeners();
  }
}
