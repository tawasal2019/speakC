import '/StartPage.dart';
import '/controller/istablet.dart';
import 'package:flutter/services.dart';
import '/controller/my_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Services/PushNotificationService.dart';

//crossAxisAlignment: CrossAxisAlignment.stretch,
//mainAxisSize: MainAxisSize.min,

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    PushNotificationsManager().init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (!DeviceUtil.isTablet) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }

    return ChangeNotifierProvider(
        create: (context) => MyProvider(),
        child: MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'المتحدث العربي',
            theme: ThemeData(
              primarySwatch: Colors.grey,
              fontFamily: "Almarai",
              dialogTheme: DialogTheme(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              )),
            ),
            home: const Start()));
  }
}
