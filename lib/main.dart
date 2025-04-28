import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tazkira/logic/note/note_cubit.dart';
import 'package:tazkira/routing/app_router.dart';
import 'package:tazkira/routing/routes.dart';
import 'logic/theme_cubit.dart';
import 'models/note.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>('notesBox');

  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create:(context) => ThemeCubit(sharedPreferences: sharedPreferences),),
      BlocProvider(create:(context) => NoteCubit(),),
    ],
    //create: (context) => ThemeCubit(sharedPreferences: sharedPreferences,),
    child: const MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeStates>(
      builder: (context, themeState) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: getThemeMode(themeState, ),
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: Routes.signUpScreen,
        );
      },
    );
  }
}

ThemeMode getThemeMode(ThemeStates themeState){
  switch (themeState){
    case ThemeLightState():
      return ThemeMode.light;
    case ThemeDarkState():
      return ThemeMode.dark;
    case ThemeSystemState():
      return ThemeMode.system;
    default:
      return ThemeMode.system;
  }
}