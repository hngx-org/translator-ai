import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator_ai/ui/screens/auth/login.dart';
import 'package:translator_ai/ui/screens/auth/signUp.dart';
import 'package:translator_ai/ui/screens/auth/spalshPage.dart';
import 'package:translator_ai/ui/screens/onBoarding.dart';
import 'helpers/locator.dart';
import 'helpers/router.dart';
import 'providers/auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
        onGenerateRoute: RouteHelper().generateRoute,
      ),
    );
  }
}
