import 'package:app_maps_2/config/firebase/firebase_services.dart';
import 'package:app_maps_2/ui/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'config/router/app_router.dart';
import 'config/theme/app_theme.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await setup();
  await dotenv.load();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MapProvider()),
        ChangeNotifierProvider(create: (_) => SingInProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> setup() async {
  await Future.delayed(const Duration(milliseconds: 800), () async {
    await FirebaseServices.init();
  });
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      title: 'Maps',
      theme: AppTheme().getTheme(),
    );
  }
}
