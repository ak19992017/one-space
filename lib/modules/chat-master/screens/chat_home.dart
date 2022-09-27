// ignore_for_file: unused_local_variable

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:one_space/modules/chat-master/screens/chat_details.dart';
import 'package:provider/provider.dart';
import '../../../constants/chat_users_model.dart';
import '../../../constants/friend_provider.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({Key? key}) : super(key: key);

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var friendProvider = context.watch<FriendProvider>();
    int selectedIndex = friendProvider.friendSelectedToChat;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat master'),
        centerTitle: true,
        actions: const [
          Icon(EvaIcons.search),
          SizedBox(width: 15),
          Icon(EvaIcons.personAddOutline),
          SizedBox(width: 25),
        ],
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: chatUsers.length,
        padding: const EdgeInsets.only(top: 20, bottom: 80),
        itemBuilder: (context, index) {
          return ListTile(
            onTap: (() {
              setState(() => selectedIndex = index);
              friendProvider.setFriendSelectedToChat(index);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((_) => ChatDetails(user: chatUsers[5]))));
            }),
            tileColor: Colors.transparent,
            leading: Stack(
              children: [
                CircleAvatar(
                    backgroundImage: AssetImage(chatUsers[index].imageURL)),
                if ((index % 3 == 0) == false)
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green,
                      ),
                    ),
                  ),
              ],
            ),
            title: Text(chatUsers[index].name),
            subtitle: Text(chatUsers[index].messageText),
            trailing: Text(chatUsers[index].time),
          );
        },
      ),
    );
  }
}
