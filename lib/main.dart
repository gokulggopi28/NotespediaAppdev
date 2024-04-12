import 'dart:convert';
import 'dart:io';

import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:notespedia/repositories/user_preferences.dart';
import 'package:notespedia/src/features/cart/controller/promo_code_controller.dart';
import 'package:notespedia/src/features/detailed/controller/transaction_controller.dart';
import 'package:notespedia/src/widgets/profile/user_profile_controller.dart';
import 'package:notespedia/utils/constants/app_export.dart';
import 'package:path_provider/path_provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'src/features/navigation/navigationController.dart';

final _configuration =
    PurchasesConfiguration('appl_FppiqsuDRaxKQTrMIYglabZvKwR');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    if (Platform.isAndroid) {
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    }
  });
  await configureSDKForInApp();
  final documentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(documentDir.path);
  await UserPreferences.init();
  //
  await GetStorage.init();
  setPathUrlStrategy();

  final packageInfo = await PackageInfo.fromPlatform();
  DebugLogger.info(
    "App Name: ${packageInfo.appName}\n"
    "Package Name: ${packageInfo.packageName}\n"
    "Version: ${packageInfo.version}\n"
    "Build Number: ${packageInfo.buildNumber}\n"
    "Build Signature: ${packageInfo.buildSignature}\n"
    "Installer Store: ${packageInfo.installerStore}",
  );

  Get.put(NavigationController());
  //Get.put(UserProfileController());
  Get.put(PromoCodeController());
  // Get.put(CourseSelectionController());
  Get.put(NetworkStateController(), permanent: true);
  //Get.put(NetworkStateController());
  //Stripe.merchantIdentifier = 'NotesPedia';

  runApp(
    const MyApp(),
  );
}

Future<void> configureSDKForInApp() async {
  await Purchases.setLogLevel(LogLevel.debug);

  PurchasesConfiguration? configuration;

  if (Platform.isAndroid) {
    configuration = PurchasesConfiguration('goog_BFjswSEpzmfWeHJeOirhhhmOEiw');
    Purchases.configure(configuration);
  } else {
    configuration = PurchasesConfiguration('appl_FppiqsuDRaxKQTrMIYglabZvKwR');
    Purchases.configure(_configuration);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with RestorationMixin {
  @override
  String get restorationId => 'my_app';

  final RestorableBool _isDataLoaded = RestorableBool(false);

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_isDataLoaded, 'is_data_loaded');
  }

  @override
  void dispose() {
    _isDataLoaded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool darkMode =
        MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // DebugLogger.info(
    //   "Status Bar Height: ${DeviceHelper.getStatusBarHeight(context)}\n"
    //   "AppBar Height: ${DeviceHelper.getAppBarHeight()}\n"
    //   "Bottom NavBar Height: ${DeviceHelper.getBottomNavigationBarHeight()}\n"
    //   "Keyboard Height: ${DeviceHelper.getKeyboardHeight(context)}\n"
    //   "Pixel Ratio: ${DeviceHelper.getPixelRatio(context)}\n"
    //   "Screen Height: ${DeviceHelper.getScreenHeight(context)}\n"
    //   "Screen Width: ${DeviceHelper.getScreenWidth(context)}",
    // );

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              darkMode ? Brightness.light : Brightness.dark,
          systemNavigationBarColor: Colors.black.withOpacity(.3),
          systemNavigationBarIconBrightness:
              darkMode ? Brightness.light : Brightness.dark,
        ),
        child: DynamicColorBuilder(
          builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              debugShowMaterialGrid: false,
              showSemanticsDebugger: false,
              showPerformanceOverlay: false,
              title: AppTexts.appName,
              themeMode: ThemeMode.light,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              defaultTransition: Transition.cupertino,
              // navigatorKey: Get.key,
              // navigatorObservers: [GetObserver()],
              onGenerateRoute: AppRoutes.generateRoute,
              initialBinding: InitialBindings(),
              enableLog: true,
              // opaqueRoute: Get.isOpaqueRouteDefault,
              // popGesture: Get.isPopGestureEnable,
            );
          },
        ),
      ),
    );
  }
}
