import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cerbo/constants/styles.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: SecondaryColor,
        body: Center(
          child: TextButton(
            onPressed: model.login,
            child: Text(
              "Login",
              style: h2.copyWith(color: TextColorDark),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
