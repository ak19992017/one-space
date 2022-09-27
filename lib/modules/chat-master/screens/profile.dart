import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:one_space/constants/chat_users_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    chatUsers[0].imageURL,
                    width: 200,
                    height: 200,
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                ),
                accountEmail: const Text('ak19992017@gmail.com'),
                accountName: Text(chatUsers[0].name),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(EvaIcons.attach2),
                  title: const Text('Media, links and docs'),
                  onTap: () {},
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.block),
                  title: const Text('Block '),
                  onTap: () {},
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.thumb_down),
                  title: const Text('Report'),
                  onTap: () {},
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(EvaIcons.trash2),
                  title: const Text('Delete chat'),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
