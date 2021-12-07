import 'package:cook_app/providers/auth.dart';
import 'package:cook_app/providers/recipe.dart';
import 'package:cook_app/screens/home.dart';
import 'package:cook_app/screens/recepies/ingredients/ingredient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cook_app/screens/login/login.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: Recipe()),
        // ChangeNotifierProxyProvider<Auth, Products(to co Ty provajdujesz)>(
        // update: (ctx, auth, previousProducts) => Products(auth.token))
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, child) => MaterialApp(
          title: 'CookApp',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.teal,
            accentColor: Colors.limeAccent,
            textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
            iconTheme: const IconThemeData(color: Colors.white),
            colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.teal),
            // change the focus border color when the errorText is set
            errorColor: Colors.purple,
          ),
          // home: authData.isAuth ? HomeScreen() : LoginScreen(),
          home: HomeScreen(),
          routes: {
            LoginScreen.routeName: (ctx) => LoginScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            IngredientScreen.routeName: (ctx) => IngredientScreen(),
          },
        ),
      ),
    );
  }
}
