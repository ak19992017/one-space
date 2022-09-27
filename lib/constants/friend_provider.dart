import 'package:flutter/material.dart';

class FriendProvider extends ChangeNotifier {
  int friendSelectedToChat = 0;

  setFriendSelectedToChat(int f) {
    friendSelectedToChat = f;
    notifyListeners();
  }
}
