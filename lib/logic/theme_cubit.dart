import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeStates> {
  final SharedPreferences sharedPreferences;
  ThemeCubit({required this.sharedPreferences}) : super(ThemeSystemState(),);

  void setThemeMode(ThemeStates themeState){
    emit(themeState);
    saveThemePreference(themeState);
  }

  void saveThemePreference(ThemeStates themeState){
    sharedPreferences.setString('themeMode', themeState.toString(),);
  }

  void loadThemePreference(){
    String? storedTheme = sharedPreferences.getString('themeMode');

    if(storedTheme != null){
      if(storedTheme == 'ThemeState.dark'){
        emit(ThemeDarkState(),);
      } else if (storedTheme == 'ThemeState.light'){
        emit(ThemeLightState(),);
      } else{
        emit(ThemeSystemState(),);
      }
    }
  }
}