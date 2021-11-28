import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

import 'startup_viewmodel.dart';

class StartUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      onModelReady: (model) {
        SchedulerBinding.instance!
            .addPostFrameCallback((_) => model.doSomething());
      },
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text("Startup"),
        ),
      ),
      viewModelBuilder: () => StartUpViewModel(),
    );
  }
}
