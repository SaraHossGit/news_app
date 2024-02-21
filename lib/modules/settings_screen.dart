import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  String userName = "Sara Hossam";
  String userImg = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              backgroundImage: userImg.isEmpty
                  ? const AssetImage("assets/images/profile.jpg")
                  : AssetImage(userImg),
              radius: 90,
            ),
          ),
          SizedBox(height: 10),
          userName.isEmpty
              ? SizedBox()
              : Center(
                child: Text(userName,
                    style: Theme.of(context).textTheme.headlineLarge),
              ),
          SizedBox(height: 50),
          Text("Account Settings",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _settingsTile(
            context: context,
            tileImg: "assets/images/profile.jpg",
            tileTitle: "Your Profile",
            tileDescription: "Edit and view profile info",
            onPressed: (){},
          ),
          SizedBox(height: 15),
          Text("App Settings",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _settingsTile(
            context: context,
            tileImg: "assets/images/profile.jpg",
            tileTitle: "Language",
            tileDescription: "Choose your preferred app language",
            onPressed: (){},
          ),
          SizedBox(height: 15),
          _settingsTile(
            context: context,
            tileImg: "assets/images/profile.jpg",
            tileTitle: "Country",
            tileDescription: "Choose the country you'd like to view its news",
            onPressed: (){},
          ),
        ],
      ),
    );
  }

  Widget _settingsTile({
    required String tileImg,
    required String tileTitle,
    required String tileDescription,
    required VoidCallback onPressed,
    required BuildContext context,
}) =>GestureDetector(
    onTap: (){},
    child: Row(
      children: [
        CircleAvatar(
            backgroundImage: AssetImage(tileImg)
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tileTitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
              Text(tileDescription, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        Icon(Icons.chevron_right),
      ],),
  );
}
