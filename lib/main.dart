import 'package:cook_app/providers/auth.dart';
import 'package:cook_app/providers/recipe.dart';
import 'package:cook_app/providers/shopping_list.dart';
import 'package:cook_app/providers/user.dart';
import 'package:cook_app/screens/home.dart';
import 'package:cook_app/screens/login/splash_screen.dart';
import 'package:cook_app/screens/recepies/categories.dart';
import 'package:cook_app/screens/recepies/filters.dart';
import 'package:cook_app/screens/recepies/menu.dart';
import 'package:cook_app/screens/recepies/menu/shopping_list.dart';
import 'package:cook_app/screens/recepies/my_recipes.dart';
import 'package:cook_app/screens/recepies/new_recipe/ingredient.dart';
import 'package:cook_app/screens/recepies/new_recipe/step.dart';
import 'package:cook_app/screens/recepies/recipe.dart';
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
        ChangeNotifierProxyProvider<Auth, Recipe>(
            create: (ctx) => Recipe(null),
            update: (ctx, auth, previousRecipe) => Recipe(auth.token)),
        ChangeNotifierProxyProvider<Auth, User>(
            create: (ctx) => User(null),
            update: (ctx, auth, prevProvider) => User(auth.token)),
        ChangeNotifierProxyProvider<Auth, ShoppingListProvider>(
            create: (ctx) => ShoppingListProvider(null),
            update: (ctx, auth, prevProvider) =>
                ShoppingListProvider(auth.token))
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, child) => MaterialApp(
          title: 'CookApp',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            bottomSheetTheme:
                BottomSheetThemeData(backgroundColor: Colors.transparent),
            primaryColor: Colors.teal,
            primaryColorLight: const Color(0xff8CB7AE),
            accentColor: Colors.limeAccent,
            textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
            iconTheme: const IconThemeData(color: Colors.white),
            colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.teal),
            // change the focus border color when the errorText is set
            errorColor: Colors.teal,
          ),
          home: authData.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: authData.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? const SplashScreen()
                          : LoginScreen(),
                ),
          // home: HomeScreen(),
          routes: {
            LoginScreen.routeName: (ctx) => LoginScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            IngredientScreen.routeName: (ctx) => const IngredientScreen(),
            StepScreen.routeName: (ctx) => const StepScreen(),
            RecipeScreen.routeName: (ctx) => const RecipeScreen(),
            FiltersScreen.routeName: (ctx) => FiltersScreen(),
            CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
            MyRecipesScreen.routeName: (ctx) => MyRecipesScreen(),
            MenuScreen.routeName: (ctx) => MenuScreen(),
            ShoppingListScreen.routeName: (ctx) => ShoppingListScreen(),
          },
        ),
      ),
    );
  }
}
