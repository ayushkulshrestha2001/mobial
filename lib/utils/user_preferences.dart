import 'package:mobial/model/user.dart';
import 'package:localstorage/localstorage.dart';

final LocalStorage storage = new LocalStorage('mobial');

class UserPreferences {
  static User myUser = User(
    imagePath: "${storage.getItem('user')["picture"]}" ??
        'https://firebasestorage.googleapis.com/v0/b/shrink4shrink.appspot.com/o/663328.png?alt=media&token=2bcd32f3-9872-40f3-b59d-eee666ff2b79',
    name: "${storage.getItem('user')["name"]}",
    email: "${storage.getItem('user')["email"]}",
    phone: "${storage.getItem('user')["phone"]}",
    username: "${storage.getItem('user')["username"]}",
    isDarkMode: false,
  );
}
