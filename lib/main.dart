import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fakeslink/app/model/entities/certificate.dart';
import 'package:fakeslink/app/model/entities/degree.dart';
import 'package:fakeslink/app/model/entities/experience.dart';
import 'package:fakeslink/app/model/entities/session.dart';
import 'package:fakeslink/app/model/entities/user.dart';
import 'package:fakeslink/app/view/authentication/login/login.dart';
import 'package:fakeslink/app/view/authentication/sign_up/sign_up.dart';
import 'package:fakeslink/app/view/home_page/home.dart';
import 'package:fakeslink/app/view/profile/profile.dart';
import 'package:fakeslink/app/view/transaction/transaction_detail.dart';
import 'package:fakeslink/core/utils/device_info.dart';
import 'package:fakeslink/core/utils/network_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/const/app_routes.dart';
import 'core/utils/interceptor.dart';
import 'core/utils/share_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FirebaseOptions? options;
  // if (Platform.isAndroid) {
  //   options = FirebaseOptions(
  //       apiKey: FirebaseConfig.ANDROID_API_KEY,
  //       appId: FirebaseConfig.ANDROID_APP_ID,
  //       messagingSenderId: FirebaseConfig.SENDER_ID,
  //       projectId: "fake-slink");
  // }
  // await Firebase.initializeApp(options: options);
  await Hive.initFlutter();
  Hive.registerAdapter(SessionAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(CertificateAdapter());
  Hive.registerAdapter(DegreeAdapter());
  Hive.registerAdapter(ExperienceAdapter());
  await init();
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

late Box configBox;

Future<void> init() async {
  GetIt getIt = GetIt.instance;
  getIt.registerLazySingleton(() => GlobalKey<NavigatorState>());

  configBox = await Hive.openBox("configuration");

  final deviceInfo = DeviceInfo();
  await deviceInfo.init();
  getIt.registerSingleton(deviceInfo);

  final networkInfo = NetworkInfo();
  await networkInfo.init();
  getIt.registerSingleton(networkInfo);

  final spUtils = SharePreferencesUtils();
  await spUtils.init();
  getIt.registerFactory(() => spUtils);
  // if (spUtils.getString("refresh") != null) {
  //   getIt.registerSingleton(Session(
  //       access: spUtils.getString("access")!,
  //       refresh: spUtils.getString("refresh")!));
  // }
  getIt.registerLazySingleton(() => Hive);

  var options = BaseOptions(
    baseUrl: 'http://192.168.0.102:8000',
    connectTimeout: 60000,
    receiveTimeout: 60000,
  );

  getIt.registerSingleton(Dio(options)
    ..interceptors.addAll([
      AuthenticationInterceptor(),
      LogInterceptor(
          requestBody: true,
          requestHeader: false,
          responseBody: true,
          request: false,
          responseHeader: false,
          error: true),
    ]));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const oneSignalAppId = "1537dc7c-b315-4c3a-a355-9ca677c33fef";
  @override
  void initState() {
    super.initState();
    initOneSignal();
  }

  Future<void> initOneSignal() async {
    // await OneSignal.shared.setAppId(oneSignalAppId);
    // OneSignal.shared.setNotificationOpenedHandler((openedResult) {
    //   var data = openedResult.notification.additionalData;
    //   GetIt.instance<GlobalKey<NavigatorState>>()
    //       .currentState
    //       ?.pushNamed(AppRoute.notificationDetails, arguments: data);
    // });
    // OneSignal.shared.setNotificationWillShowInForegroundHandler(
    //     (OSNotificationReceivedEvent event) {
    //   // Will be called whenever a notification is received in foreground
    //   // Display Notification, pass null param for not displaying the notification
    //   event.complete(event.notification);
    // });
    // OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
    //   // Will be called whenever the permission changes
    //   // (ie. user taps Allow on the permission prompt in iOS)
    //   print(
    //       "TanKiem: setPermissionObserver from ${changes.from.status} to ${changes.to.status}");
    // });
    // OneSignal.shared
    //     .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
    //   // Will be called whenever the subscription changes
    //   // (ie. user gets registered with OneSignal and gets a user ID)
    //   print(
    //       "TanKiem: setSubscriptionObserver from ${changes.from.pushToken} to ${changes.to.pushToken}");
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: MaterialApp(
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          textTheme: GoogleFonts.montserratTextTheme(),
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoute.login: (context) => LoginPage(),
          AppRoute.home: (context) => HomePage(),
          AppRoute.signUp: (context) => SignUpPage(),
        },
        onGenerateRoute: (settings) {
          final session = configBox.get("session");
          switch (settings.name) {
            case "/":
              if (session == null) {
                return MaterialPageRoute(
                  builder: (context) => LoginPage(),
                );
              } else {
                return MaterialPageRoute(
                  builder: (context) => HomePage(),
                );
              }
            case AppRoute.profile:
              return MaterialPageRoute(
                builder: (context) =>
                    UserProfilePage(userId: settings.arguments as int),
              );
            case AppRoute.transactionDetail:
              return MaterialPageRoute(
                  builder: (context) => TransactionDetail(
                        transactionId: settings.arguments as int,
                      ));
            default:
          }
          return null;
        },
      ),
    );
  }
}
