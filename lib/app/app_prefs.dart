import 'package:movieapp/data/mapper/mapper.dart';
import 'package:movieapp/presentation/favorites/favorites_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";
const String PREFS_KEY_TOKEN = "PREFS_KEY_TOKEN";
const String PREFS_KEY_NOTIFICATION = "PREFS_KEY_NOTIFICATION";

class AppPreferences {
   SharedPreferences _sharedPreferences;

   AppPreferences(this._sharedPreferences);

   Future<void> setToken(String token)async{
     _sharedPreferences.setString(PREFS_KEY_TOKEN, token);
   }

   Future<String> getToken()async{
     return _sharedPreferences.getString(PREFS_KEY_TOKEN)??EMPTY;
   }

   Future<void> setIsUserLoggedIn()async{
     _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
   }

   Future<bool> isUserLoggedIn()async{
     return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN)??false;
   }

   Future<void> logout()async{
     _sharedPreferences.remove(PREFS_KEY_IS_USER_LOGGED_IN);
     _sharedPreferences.remove(PREFS_KEY_TOKEN);
   }
   
   Future<void> allowNotification()async{
    _sharedPreferences.setBool(PREFS_KEY_NOTIFICATION, true);
   }

   Future<void> disAllowNotification()async{
    _sharedPreferences.setBool(PREFS_KEY_NOTIFICATION, false);
   }
   
   Future<bool> isNotificationAllowed()async{
    return _sharedPreferences.getBool(PREFS_KEY_NOTIFICATION)??true;
   }

}


