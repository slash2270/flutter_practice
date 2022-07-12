// @dart=2.9

import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'dart:isolate';

import 'package:ble/ble.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_practice/animation/easyloadinganimationwidget.dart';
import 'package:flutter_practice/database/dbhelper.dart';
import 'package:flutter_practice/firebase/firebaseoptions.dart';
import 'package:flutter_practice/inappwebview/chromesafaribrowserexample.dart';
import 'package:flutter_practice/inappwebview/headlessinappwebviewexample.dart';
import 'package:flutter_practice/inappwebview/inappbrowserexample.dart';
import 'package:flutter_practice/inappwebview/inappwebviewexample.dart';
import 'package:flutter_practice/network/git.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/utils/constants.dart';
import 'package:flutter_practice/utils/datetimeutils.dart';
import 'package:flutter_practice/utils/global.dart';
//import 'package:flutter_practice/view/cropperview.dart';
import 'package:flutter_practice/view/eight.dart';
import 'package:flutter_practice/view/eighteen.dart';
import 'package:flutter_practice/view/eleven.dart';
import 'package:flutter_practice/view/fifteen.dart';
import 'package:flutter_practice/view/fifty.dart';
import 'package:flutter_practice/view/fiftyeight.dart';
import 'package:flutter_practice/view/fiftyfive.dart';
import 'package:flutter_practice/view/fiftyfour.dart';
import 'package:flutter_practice/view/fiftynine.dart';
import 'package:flutter_practice/view/fiftyone.dart';
import 'package:flutter_practice/view/fiftyseven.dart';
import 'package:flutter_practice/view/fiftythree.dart';
import 'package:flutter_practice/view/fiftytwo.dart';
import 'package:flutter_practice/view/first.dart';
import 'package:flutter_practice/view/five.dart';
import 'package:flutter_practice/view/fortyeight.dart';
import 'package:flutter_practice/view/fortyfive.dart';
import 'package:flutter_practice/view/fortyfour.dart';
import 'package:flutter_practice/view/fortynine.dart';
import 'package:flutter_practice/view/fortyone.dart';
import 'package:flutter_practice/view/fortyseven.dart';
import 'package:flutter_practice/view/fortysix.dart';
import 'package:flutter_practice/view/fortythree.dart';
import 'package:flutter_practice/view/fortytwo.dart';
import 'package:flutter_practice/view/four.dart';
import 'package:flutter_practice/view/fourteen.dart';
import 'package:flutter_practice/view/fourty.dart';
import 'package:flutter_practice/view/home.dart';
import 'package:flutter_practice/view/login.dart';
import 'package:flutter_practice/view/nine.dart';
import 'package:flutter_practice/view/nineteen.dart';
import 'package:flutter_practice/view/second.dart';
import 'package:flutter_practice/view/seven.dart';
import 'package:flutter_practice/view/seventeen.dart';
import 'package:flutter_practice/view/seventy.dart';
import 'package:flutter_practice/view/six.dart';
import 'package:flutter_practice/view/sixtyeight.dart';
import 'package:flutter_practice/view/sixtynine.dart';
import 'package:flutter_practice/view/sixteen.dart';
import 'package:flutter_practice/view/sixty.dart';
import 'package:flutter_practice/view/sixtyfive.dart';
import 'package:flutter_practice/view/sixtyfour.dart';
import 'package:flutter_practice/view/sixtyone.dart';
import 'package:flutter_practice/view/sixtyseven.dart';
import 'package:flutter_practice/view/sixtysix.dart';
import 'package:flutter_practice/view/sixtythree.dart';
import 'package:flutter_practice/view/sixtytwo.dart';
import 'package:flutter_practice/view/ten.dart';
import 'package:flutter_practice/view/third.dart';
import 'package:flutter_practice/view/thirteen.dart';
import 'package:flutter_practice/view/thirty.dart';
import 'package:flutter_practice/view/thirtyeight.dart';
import 'package:flutter_practice/view/thirtyfive.dart';
import 'package:flutter_practice/view/thirtyfour.dart';
import 'package:flutter_practice/view/thirtynine.dart';
import 'package:flutter_practice/view/thirtyone.dart';
import 'package:flutter_practice/view/thirtyseven.dart';
import 'package:flutter_practice/view/thirtysix.dart';
import 'package:flutter_practice/view/thirtythree.dart';
import 'package:flutter_practice/view/thirtytwo.dart';
import 'package:flutter_practice/view/twelve.dart';
import 'package:flutter_practice/view/twenty.dart';
import 'package:flutter_practice/view/twentynine.dart';
import 'package:flutter_practice/view/twentyfive.dart';
import 'package:flutter_practice/view/twentyfour.dart';
import 'package:flutter_practice/view/twentyeight.dart';
import 'package:flutter_practice/view/twentyone.dart';
import 'package:flutter_practice/view/twentyseven.dart';
import 'package:flutter_practice/view/twentysix.dart';
import 'package:flutter_practice/view/twentythree.dart';
import 'package:flutter_practice/view/twentytwo.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:statsfl/statsfl.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'backpress/willpopscope.dart';
import 'firebase/firebasecloudmessagedemo.dart';
import 'firebase/message.dart';
import 'generated/l10n.dart';

//var routePath = {secondTitle: (context) => second};

/// 定義一個頂級的命名處理程序，後台/終止消息將
/// 稱呼。
/// 要驗證一切是否正常，請查看本機平台日誌。
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // 如果您要在後台使用其他 Firebase 服務，例如 Firestore，
  // 確保在使用其他 Firebase 服務之前調用 `initializeApp`。
  await Firebase.initializeApp();
  print('Main Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

List<CameraDescription> _cameras;

Future<void> main() async {

  runZonedGuarded<Future<void>>(() async { // 處理未捕獲的錯誤+區域錯誤

    WidgetsFlutterBinding.ensureInitialized();

    await GetStorage.init(); // SharedPreferences

    //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    await Firebase.initializeApp();
    ///订阅主题
    await FirebaseMessaging.instance.subscribeToTopic('weather');

    // 將所有未捕獲的錯誤從框架傳遞給Crashlytics。
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    await FirebaseAppCheck.instance.activate( // 結合recaptcha
      webRecaptchaSiteKey: '6Lemcn0dAAAAABLkf6aiiHvpGD6x-zF3nOSDU2M8', // recaptcha-v3-site-key
    );

    // 儘早設置後台消息處理程序，作為命名的頂級函數
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description: 'This channel is used for important notifications.',
        importance: Importance.high,
      );
    }

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// 創建一個 Android 通知通道。
    /// 我們在 `AndroidManifest.xml` 文件中使用這個通道來覆蓋
    /// 啟用抬頭通知的默認 FCM 通道。
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    /// 更新 iOS 前台通知顯示選項以允許
    /// 抬頭通知。
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true,);

    try {
      _cameras = await availableCameras();
    } on CameraException catch (e) {
      print('Error in fetching the cameras: $e');
    }

    _setMain(); /// EasyLoading

    _setInAppWebView();

    //SpUtil.getInstance().then((value) => runApp(MyApp()));

    Global.init().then((e) => runApp(
        StatsFl(
            isEnabled: true, //Toggle on/off
            width: 600, //Set size
            height: 20, //
            maxFps: 144, // Support custom FPS target (default is 60)
            showText: true, // Hide text label
            sampleTime: .5, //Interval between fps calculations, in seconds.
            totalTime: 15, //Total length of timeline, in seconds.
            align: Alignment.topLeft, //Alignment of statsbox
            child: MyApp()
        ))
    ); /// GlobalKey
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

void _setMain(){
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
    //..customAnimation = EasyLoadingAnimationWidget();
}

_setInAppWebView() async{
  if (Platform.isAndroid) { /// inAppWebView
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
      AndroidServiceWorkerController.instance();

      await serviceWorkerController.setServiceWorkerClient(AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          print(request);
          return null;
        },
      ));
    }
  }
}

//统计
FirebaseAnalytics analytics = FirebaseAnalytics.instance;
FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
String _title = '';

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<FirebaseAnalytics>.value(value: analytics),
          Provider<FirebaseAnalyticsObserver>.value(value: observer),
        ],
        child: RefreshConfiguration(
          headerBuilder: () => WaterDropHeader(),        // Configure the default header indicator. If you have the same header indicator for each page, you need to set this
          footerBuilder: () => ClassicFooter(),        // Configure default bottom indicator
          headerTriggerDistance: 80.0,        // header trigger refresh trigger distance
          springDescription:SpringDescription(stiffness: 170, damping: 16, mass: 1.9),         // custom spring back animate,the props meaning see the flutter api
          maxOverScrollExtent :100, //The maximum dragging range of the head. Set this property if a rush out of the view area occurs
          maxUnderScrollExtent:0, // Maximum dragging range at the bottom
          enableScrollWhenRefreshCompleted: true, //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
          enableLoadingWhenFailed : true, //In the case of load failure, users can still trigger more loads by gesture pull-up.
          hideFooterWhenNotFull: false, // Disable pull-up to load more functionality when Viewport is less than one screen
          enableBallisticLoad: true, // trigger load more by BallisticScrollActivity
          child: ScreenUtilInit(
            builder: (_, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  // this line is important
                  RefreshLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                localeListResolutionCallback: (locales, supportedLocales) {
                  return;
                },
                localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
                  //print("change language");
                  return locale;
                },
                title: _title,
                theme: ThemeData(
                  // 這是您的應用程序的主題。
                  // 嘗試使用“flutter run”運行您的應用程序。 你會看到
                  // 應用程序有一個藍色工具欄。 然後，在不退出應用程序的情況下，嘗試
                  // 將下面的 primarySwatch 更改為 Colors.green 然後調用
                  // “熱重載”（在運行“flutter run”的控制台中按“r”，
                  // 或者只是將您的更改保存到 Flutter IDE 中的“熱重載”）。
                  // 注意計數器沒有重置為零； 應用程序
                  // 沒有重新啟動。
                  primarySwatch: Global.themes[3],
                  primaryColor: Colors.lightGreen.shade100,
                  primaryColorDark: Colors.lightGreen.shade100,
                  brightness: Brightness.light,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ).copyWith(
                  pageTransitionsTheme: const PageTransitionsTheme(
                    builders: <TargetPlatform, PageTransitionsBuilder>{
                      TargetPlatform.android: ZoomPageTransitionsBuilder(),
                      TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
                    },
                  ),
                ),
                home: const MyHomePage(),
                routes: {
                  //'/': (context) => Application(), 首頁
                  '/message': (context) => MessageView(),
                  '/InAppWebView': (context) => InAppWebViewExample(),
                  '/InAppBrowser': (context) => InAppBrowserExample(),
                  '/ChromeSafariBrowser': (context) => ChromeSafariBrowserExample(),
                  '/HeadlessInAppWebView': (context) => HeadlessInAppWebViewExample(),
                  '/FortyThree': (context) => FortyThree(),
                  Constants.HOME: (context) => HomeView(),
                  '/Six': (context) => Six(),
                  //'/Cropper': (context) => CropperView(),
                },
                navigatorObservers: <NavigatorObserver>[observer], //加入路由统计
                builder: EasyLoading.init(),
                showPerformanceOverlay: false,
                initialRoute: 'login', // 搶首頁
                onGenerateRoute: RoutePage.generateRoute,
                /*routes: routePath,
                  onGenerateRoute: (settings) {
                  /*如果路由名称相同则进行处理*/
                  if (settings.name == secondTitle) {
                  //Object? secondPage = settings.arguments;
                    return MaterialPageRoute(
                    builder: (context) => Second(
                    title: secondTitle,
                     ));
                    }
                  return null;
                },*/
               );
            },
            child: MyHomePage(),
          ),
      ),
   );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  // 這個小部件是您的應用程序的主頁。 它是有狀態的，意思是
  // 它有一個 State 對象（定義如下），其中包含影響的字段
  // 它看起來如何。

  // 這個類是狀態的配置。 它保存值（在這個
  // 由父級（在本例中為 App 小部件）提供的標題）和
  // 由 State 的 build 方法使用。 Widget 子類中的字段是
  // 始終標記為“最終”。

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{

  Set _set;
  DBHelper _dbHelper;
  List<Tab> _listTabs;
  List<StatelessWidget> _listBottom;
  TabController _tabController;
  int _bottomIndex = 0;
  int _drawerIndex = 0;
  int _selectedIndex = 0;
  int _leftDrawerIconClick = 0;
  int _rightDrawerIconClick = 0;

  @override
  void initState() {
    _set = Set();
    _dbHelper = DBHelper();
    _listTabs = <Tab>[const Tab(text: 'Six', height: 50,), const Tab(text: 'Seven', height: 50,), const Tab(text: 'Eight', height: 50,), const Tab(text: 'ThirtyFive', height: 50,), const Tab(text: 'ThirtySix', height: 50,)];
    _listBottom = [const First(), const Second(), const Third(), const Four()];
    _tabController = TabController(length: _listTabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() => _selectedIndex = _tabController.index);
    });
    _sendAnalyticsEvent();
    _setCrashlytics();
    _setInitState();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _dbHelper.initDb();
    super.didChangeDependencies();
  }


  @override
  void setState(VoidCallback fn) {
    _title = S.of(context).title;
    //_sendAnalyticsEvent();
    super.setState(fn);
  }

  // 動態
  // 這個對 setState 的調用告訴 Flutter 框架有東西
  // 在這個狀態下發生了變化，這導致它重新運行下面的構建方法
  // 以便顯示可以反映更新的值。 如果我們改變
  // _counter 不調用 setState()，則構建方法不會
  // 再次調用，因此似乎什麼也沒有發生。

  @override
  Widget build(BuildContext context) {
    // 每次調用 setState 時都會重新運行此方法，例如 done
    // 通過上面的 _incrementCounter 方法。
    //
    // Flutter 框架已經過優化，可以重新運行構建方法
    // 快，這樣你就可以重建任何需要更新的東西
    // 而不是必須單獨更改小部件的實例。

    return Scaffold(
      appBar: AppBar(
        // 這裡我們從創建的 MyHomePage 對像中獲取值
        // App.build 方法，並使用它來設置我們的 appbar 標題。
        leading: Builder(builder: (context){
          return IconButton(
            icon: const Icon(Icons.assistant),
            onPressed: (){
              setState(() {
                _leftDrawerIconClick++;
                debugPrint('Main leftDrawerIconClick = $_leftDrawerIconClick');
              });
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        actions: <Widget>[
          Builder(builder: (context){
            return IconButton(
              icon: const Icon(Icons.add),
              onPressed: (){
                setState(() {
                  _rightDrawerIconClick++;
                  debugPrint('Main rightDrawerIconClick = $_rightDrawerIconClick');
                });
                Scaffold.of(context).openEndDrawer();
              },
            );
          })
        ],
        bottom: TabBar(
          tabs: _listTabs.map((item)=>Tab(text: item.text)).toList(),
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.deepPurple,
          labelStyle: const TextStyle(fontSize: 20),
          unselectedLabelColor: Colors.purpleAccent,
          unselectedLabelStyle: const TextStyle(fontSize: 17),
          indicator: const UnderlineTabIndicator(
            //insets: EdgeInsetsGeometry.infinity,
            borderSide: BorderSide(width: 2.0, color: Colors.deepPurple),
          ),
          indicatorWeight: 5,
          indicatorColor: Colors.deepPurpleAccent,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 7.5),
          onTap: (int index) {
            tabClick(index);
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            //設定用户名稱
            const UserAccountsDrawerHeader(
              accountName: Text(
                "Ellen",
              ),
              //設定Email
              accountEmail: Text(
                "slash2270@gmail.com",
              ),
              //設定大頭照
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("images/ellen_cute2.jpeg"),
              ),
            ),
            //選單
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.chrome_reader_mode)),
              title: const Text('Nine Class'),
              onTap: () {
                drawerClick(0);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.code)),
              title: const Text('Ten Class'),
              onTap: () {
                drawerClick(1);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.computer)),
              title: const Text('Eleven Class'),
              onTap: () {
                drawerClick(2);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.wysiwyg)),
              title: const Text('Twelve Class'),
              onTap: () {
                drawerClick(3);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.work)),
              title: const Text('Thirteen Class'),
              onTap: () {
                drawerClick(4);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.account_balance)),
              title: const Text('Fourteen Class'),
              onTap: () {
                drawerClick(5);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.add_shopping_cart)),
              title: const Text('Fifteen Class'),
              onTap: () {
                drawerClick(6);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.stream)),
              title: const Text('Sixteen Class'),
              onTap: () {
                drawerClick(7);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.api)),
              title: const Text('Seventeen Class'),
              onTap: () {
                drawerClick(8);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.ac_unit)),
              title: const Text('Eighteen Class'),
              onTap: () {
                drawerClick(9);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.account_balance_wallet)),
              title: const Text('Nineteen Class'),
              onTap: () {
                drawerClick(10);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.baby_changing_station)),
              title: const Text('Twenty Class'),
              onTap: () {
                drawerClick(11);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.account_tree)),
              title: const Text('TwentyOne Class'),
              onTap: () {
                drawerClick(12);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.ad_units)),
              title: const Text('TwentyTwo Class'),
              onTap: () {
                drawerClick(13);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.add_a_photo)),
              title: const Text('TwentyThree Class'),
              onTap: () {
                drawerClick(14);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.add_alarm)),
              title: const Text('TwentyFour Class'),
              onTap: () {
                drawerClick(15);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.add_box)),
              title: const Text('TwentyFive Class'),
              onTap: () {
                drawerClick(16);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.vpn_lock)),
              title: const Text('TwentySix Class'),
              onTap: () {
                drawerClick(17);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.weekend)),
              title: const Text('TwentySeven Class'),
              onTap: () {
                drawerClick(18);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.wallet_giftcard)),
              title: const Text('TwentyEight Class'),
              onTap: () {
                drawerClick(19);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.deck)),
              title: const Text('TwentyNine Class'),
              onTap: () {
                drawerClick(20);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.eco)),
              title: const Text('Thirty Class'),
              onTap: () {
                drawerClick(21);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.festival)),
              title: const Text('ThirtyOne Class'),
              onTap: () {
                drawerClick(22);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.grain)),
              title: const Text('ThirtyTwo Class'),
              onTap: () {
                drawerClick(23);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.handyman)),
              title: const Text('ThirtyThree Class'),
              onTap: () {
                drawerClick(24);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.icecream)),
              title: const Text('ThirtyFour Class'),
              onTap: () {
                drawerClick(25);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.join_full)),
              title: const Text('ThirtySeven Class'),
              onTap: () {
                drawerClick(26);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.kebab_dining)),
              title: const Text('ThirtyEight Class'),
              onTap: () {
                drawerClick(27);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.label)),
              title: const Text('ThirtyNine Class'),
              onTap: () {
                drawerClick(28);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.mail)),
              title: const Text('Forty Class'),
              onTap: () {
                drawerClick(29);
              },
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          children: <Widget>[
            //設定用户名稱
            const UserAccountsDrawerHeader(
              accountName: Text(
                "Soldier",
              ),
              //設定Email
              accountEmail: Text(
                "slash2270@gmail.com",
              ),
              //設定大頭照
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("images/soldier_cute1.jpeg"),
              ),
            ),
            //選單
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.nat)),
              title: const Text('FortyOne Class'),
              onTap: () {
                drawerClick(30);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.outlet)),
              title: const Text('FortyTwo Class'),
              onTap: () {
                drawerClick(31);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.padding_rounded)),
              title: const Text('FortyThree Class'),
              onTap: () {
                drawerClick(32);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.quora)),
              title: const Text('FortyFour Class'),
              onTap: () {
                drawerClick(33);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.reddit)),
              title: const Text('FortyFive Class'),
              onTap: () {
                drawerClick(34);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.safety_divider)),
              title: const Text('FortySix Class'),
              onTap: () {
                drawerClick(35);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.tab_sharp)),
              title: const Text('FortySeven Class'),
              onTap: () {
                drawerClick(36);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.u_turn_left)),
              title: const Text('FortyEight Class'),
              onTap: () {
                drawerClick(37);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.vape_free)),
              title: const Text('FortyNine Class'),
              onTap: () {
                drawerClick(38);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.warehouse)),
              title: const Text('Fifty Class'),
              onTap: () {
                drawerClick(39);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.yard)),
              title: const Text('FiftyOne Class'),
              onTap: () {
                drawerClick(40);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.zoom_out_map_sharp)),
              title: const Text('FiftyTwo Class'),
              onTap: () {
                drawerClick(41);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.ad_units)),
              title: const Text('FiftyThree Class'),
              onTap: () {
                drawerClick(42);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.baby_changing_station)),
              title: const Text('FiftyFour Class'),
              onTap: () {
                drawerClick(43);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.calendar_view_week)),
              title: const Text('FiftyFive Class'),
              onTap: () {
                drawerClick(44);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.density_small_sharp)),
              title: const Text('FiftySix Class'),
              onTap: () {
                drawerClick(45);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.eight_k)),
              title: const Text('FiftySeven Class'),
              onTap: () {
                drawerClick(46);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.fact_check)),
              title: const Text('FiftyEight Class'),
              onTap: () {
                drawerClick(47);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.gradient_outlined)),
              title: const Text('FiftyNine Class'),
              onTap: () {
                drawerClick(48);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.hdr_weak)),
              title: const Text('Sixty Class'),
              onTap: () {
                drawerClick(49);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.image_not_supported)),
              title: const Text('SixtyOne Class'),
              onTap: () {
                drawerClick(50);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.join_inner)),
              title: const Text('SixtyTwo Class'),
              onTap: () {
                drawerClick(51);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.keyboard_rounded)),
              title: const Text('SixtyThree Class'),
              onTap: () {
                drawerClick(52);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.lens_sharp)),
              title: const Text('SixtyFour Class'),
              onTap: () {
                drawerClick(53);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.mediation)),
              title: const Text('SixtyFive Class'),
              onTap: () {
                drawerClick(54);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.nfc_sharp)),
              title: const Text('SixtySix Class'),
              onTap: () {
                drawerClick(55);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.outlined_flag)),
              title: const Text('SixtySeven Class'),
              onTap: () {
                drawerClick(56);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.pattern)),
              title: const Text('SixtyEight Class'),
              onTap: () {
                drawerClick(57);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.quiz)),
              title: const Text('SixtyNine Class'),
              onTap: () {
                drawerClick(58);
              },
            ),
            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.reddit_outlined)),
              title: const Text('Seventy Class'),
              onTap: () {
                drawerClick(59);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "First"),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Second"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Third"),
          BottomNavigationBarItem(
              icon: Icon(Icons.videocam_sharp), label: "Four")
        ],
        iconSize: 30.0,
        //图标大小
        currentIndex: _bottomIndex,
        fixedColor: Colors.green,
        //图标改变后的颜色
        type: BottomNavigationBarType.fixed,
        //Bar的樣式
        onTap: (int index) {
          bottomClick(index);
        },
      ),
      /*bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(icon: const Icon(Icons.home), onPressed: (){

            }),
            const SizedBox(),
            IconButton(icon: const Icon(Icons.business), onPressed: (){

            }),
            IconButton(icon: const Icon(Icons.business), onPressed: (){

            }),
          ],
        ),
      ),*/
      floatingActionButton: FloatingActionButton(
        heroTag: "fabJump",
        tooltip: 'jump page',
        child: _set.initText('Five'),
        onPressed: () {
          setFiveRoute();
        },
      ),
      // 這個尾隨逗號使構建方法的自動格式化更好。
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: TabBarView(
          controller: _tabController,
          children: const <Widget>[ Six(), Seven(), Eight() , ThirtyFive() , ThirtySix()]
      ),
      //pageList[bottomIndex],
      //调用函数
    );
  }

  void _setCrashlytics() async {
    //if (kDebugMode) { // 控制debug是否啟用
      // Force disable Crashlytics collection while doing every day development.
      // Temporarily toggle this to true if you want to test crash reporting in your app.
    //await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    //}
    // 自定義key value
    FirebaseCrashlytics.instance.setCustomKey("leftDrawerIconClick", _leftDrawerIconClick);
    FirebaseCrashlytics.instance.setCustomKey("rightDrawerIconClick", _rightDrawerIconClick);
    FirebaseCrashlytics.instance.setCustomKey("bottomIndex", _bottomIndex);
    FirebaseCrashlytics.instance.setCustomKey("drawerIndex", _drawerIndex);
    FirebaseCrashlytics.instance.setCustomKey("selectedIndex", _selectedIndex);
    // thread context 錯誤監聽
    Isolate.current.addErrorListener(RawReceivePort((pair) async {
      final List<dynamic> errorAndStacktrace = pair;
      await FirebaseCrashlytics.instance.recordError(
        errorAndStacktrace.first,
        errorAndStacktrace.last,
        fatal: true,
      );
    }).sendPort);
  }

  void _setInitState() {
    EasyLoading.addStatusCallback((status) {
      print('Main EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {

      }
    });
    EasyLoading.showSuccess('EasyLoading ShowSuccess');
    // EasyLoading.removeCallbacks();
  }

  void click(StatelessWidget statelessWidget) {
    Navigator.push(
      context, PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500), //动画时间为500毫秒
        pageBuilder: (BuildContext context, Animation<double> animation, Animation secondaryAnimation) {
          return FadeTransition(
            //使用渐隐渐入过渡,
            opacity: animation,
            child: statelessWidget,
          );
        },
      ),
    );
  }

  void tabClick(int index) {
    setState(() {
      _tabController.animateTo(index);
    });
  }

  void bottomClick(int index) {
    setState(() {
      _bottomIndex = index;
      click(_listBottom[index]);
    });
  }

  void drawerClick(int index) {
    setState(() {
      _drawerIndex = index;
      switch(index){
        case 0 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const Nine(),));
          break;
        case 1 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const Ten(),));
          break;
        case 2 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const Eleven(),));
          break;
        case 3 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const Twelve(),));
          break;
        case 4 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const Thirteen(),));
          break;
        case 5 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const Fourteen(),));
          break;
        case 6 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const Fifteen(),));
          break;
        case 7 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const Sixteen(),));
          break;
        case 8 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const Seventeen(),));
          break;
        case 9 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const Eighteen(),));
          break;
        case 10 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const Nineteen(),));
          break;
        case 11 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const Twenty(),));
          break;
        case 12 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const TwentyOne(),));
          break;
        case 13 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const TwentyTwo(),));
          break;
        case 14 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const TwentyThree(),));
          break;
        case 15 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const TwentyFour(),));
          break;
        case 16 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const TwentyFive(),));
          break;
        case 17 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const TwentySix(),));
          break;
        case 18 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const TwentySeven(),));
          break;
        case 19 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const TwentyEight(),));
          break;
        case 20 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const TwentyNine(),));
          break;
        case 21 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => Thirty(cameras: _cameras),));
          break;
        case 22 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const ThirtyOne(),));
          break;
        case 23 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const ThirtyTwo(),));
          break;
        case 24 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const ThirtyThree(),));
          break;
        case 25 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const ThirtyFour(),));
          break;
        case 26 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const ThirtySeven(),));
          break;
        case 27 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const ThirtyEight(),));
          break;
        case 28 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const ThirtyNine(),));
          break;
        case 29 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const Forty(),));
          break;
        case 30 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const FortyOne(),));
          break;
        case 31 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const FortyTwo(),));
          break;
        case 32 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const FortyThree(),));
          break;
        case 33 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const FortyFour(),));
          break;
        case 34 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const FortyFive(),));
          break;
        case 35 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const FortySix(),));
          break;
        case 36 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const FortySeven(),));
          break;
        case 37 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const FortyEight(),));
          break;
        case 38 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const FortyNine(),));
          break;
        case 39 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const Fifty(),));
          break;
        case 40 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const FiftyOne(),));
          break;
        case 41 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const FiftyTwo(),));
          break;
        case 42 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const FiftyThree(),));
          break;
        case 43 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const FiftyFour(),));
          break;
        case 44 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const FiftyFive(),));
          break;
        case 45 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const FiftyFive(),));
          break;
        case 46 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const FiftySeven(),));
          break;
        case 47 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const FiftyEight(),));
          break;
        case 48 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const FiftyNine(),));
          break;
        case 49 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const Sixty(),));
          break;
        case 50 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const SixtyOne(),));
          break;
        case 51 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const SixtyTwo(),));
          break;
        case 52 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const SixtyThree(),));
          break;
        case 53 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const SixtyFour(),));
          break;
        case 54 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const SixtyFive(),));
          break;
        case 55 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const SixtySix(),));
          break;
        case 56 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => SixtySeven(listCamera: _cameras,),));
          break;
        case 57 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const SixtyEight(),));
          break;
        case 58 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const SixtyNine(),));
          break;
        case 59 :
          Navigator.push(context, CupertinoPageRoute(builder: (context) => const Seventy(),));
          break;
      }
      //click(listDrawer[index]);
    });
  }

  Future<void> _sendAnalyticsEvent() async {
    analytics = Provider.of<FirebaseAnalytics>(context); // bug
    await analytics.logEvent(
      name: 'main_event',
      parameters: <String, dynamic>{
        'leftDrawerIconClick': _leftDrawerIconClick,
        'rightDrawerIconClick': _rightDrawerIconClick
      },
    );
    /*await analytics.logBeginCheckout( // example
        value: 10.0,
        currency: 'USD',
        items: [
          AnalyticsEventItem(
              itemName: 'Socks',
              itemId: 'xjw73ndnw',
              price: 10.0
          ),
        ],
        coupon: '10PERCENTOFF'
    );*/
  }

  void setFiveRoute() {
    Navigator.push(
        context, MaterialPageRoute(
        builder: (context) => const Five(),
        settings: const RouteSettings(
          arguments: 'Five Page',
        )
    ));
  }

}

class RoutePage {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Constants.LOGIN:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case Constants.HOME:
        return MaterialPageRoute(builder: (_) => HomeView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('沒有找到對應的頁面：${settings.name}'),
                  ),
                ));
    }
  }
}