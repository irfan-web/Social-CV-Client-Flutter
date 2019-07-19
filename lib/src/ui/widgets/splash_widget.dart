import 'package:flutter/material.dart';
import 'package:social_cv_client_flutter/src/ui/commons/styles.dart';
import 'package:social_cv_client_flutter/src/utils/logger.dart';

class SplashPage extends StatelessWidget {
  final String _tag = '$SplashPage';

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:$build');

    return Scaffold(
      backgroundColor: AppStyles.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text('Social CV'),
          ],
        ),
      ),
    );
  }
}

class SplashApp extends StatelessWidget {
  SplashApp() : super();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage(),
      color: AppStyles.primaryColor,
    );
  }
}
