import 'package:app_todo_list/my_theme.dart';
import 'package:app_todo_list/providers/app_config_provider.dart';
import 'package:app_todo_list/providers/auth_provider.dart';
import 'package:app_todo_list/providers/list_provider.dart';
import 'package:app_todo_list/routing/app_router.dart';
import 'package:app_todo_list/routing/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  // await FirebaseFirestore.instance.disableNetwork();
  // FirebaseFirestore.instance.settings =
  //     const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AppConfigProvider()),
        ChangeNotifierProvider(create: (_) => ListProvider()),
        ChangeNotifierProvider(create: (_) => UserAuthProvider()),
  ],
  child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  late AppConfigProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    initSharedPref();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.loginScreen,
      onGenerateRoute: AppRouter.generateRoute,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),
      theme: MyTheme.lightMode,
      darkTheme: MyTheme.darkMode,
      themeMode: provider.appTheme,
    );
  }

  Future<void> initSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    var language = prefs.getString('language');
    var isDark = prefs.getBool('isDark');
    if (language != null) {
      provider.changeLanguage(language);
    }
    if (isDark == true) {
      provider.changeTheme(ThemeMode.dark);
    } else {
      provider.changeTheme(ThemeMode.light);
    }
  }
}
