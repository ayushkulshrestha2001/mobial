import 'package:mobial/model/user.dart';
import 'package:localstorage/localstorage.dart';

final LocalStorage storage = new LocalStorage('mobial');

class UserPreferences {
  static User myUser = User(
    imagePath: "${storage.getItem('user')["picture"]}",
    name: "${storage.getItem('user')["name"]}",
    email: "${storage.getItem('user')["email"]}",
    phone: "${storage.getItem('user')["phone"]}",
    username: "${storage.getItem('user')["username"]}",
    isDarkMode: false,
    dob: "${storage.getItem('user')["dob"]}",
  );
}
