import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/shared/components/components.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? userName;
  String? userImgPath;
  File? userImg;
  var usernameEditingController = TextEditingController();
  bool isArabic = false;
  bool isEgypt = false;

  @override
  void initState() {
    userName = CacheHelper.getData(key: "userName");
    userImgPath = CacheHelper.getData(key: "userImg");
    userImg = File(userImgPath!);
    isArabic = CacheHelper.getData(key: "isArabic") ?? false;
    isEgypt = CacheHelper.getData(key: "isEgypt") ?? false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          userImg != null
              ? Center(
                  child: CircleAvatar(
                  backgroundImage: FileImage(userImg!),
                  radius: 90,
                ))
              : const Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/profile.jpg"),
                    radius: 90,
                  ),
                ),
          const SizedBox(height: 10),
          userName == null
              ? const SizedBox()
              : Center(
                  child: Text(userName!,
                      style: Theme.of(context).textTheme.headlineLarge),
                ),
          const SizedBox(height: 50),
          Text("Account Settings",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _settingsTile(
            context: context,
            tileIcon: Icons.person,
            tileTitle: "Your Username",
            tileDescription: "Edit or view profile username",
            onPressed: () => showUsernameDialog(context: context),
          ),
          const SizedBox(height: 15),
          _settingsTile(
            context: context,
            tileIcon: Icons.camera_alt,
            tileTitle: "Your Profile Pic",
            tileDescription: "Edit or view profile picture",
            onPressed: () => showProfileImgDialog(context: context),
          ),
          const SizedBox(height: 15),
          Text("App Settings",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _settingsTile(
            context: context,
            tileIcon: Icons.language,
            tileTitle: "Language",
            tileDescription: "Choose your preferred app language",
            onPressed: () => showLangDialog(context: context),
          ),
          const SizedBox(height: 15),
          _settingsTile(
            context: context,
            tileIcon: Icons.place,
            tileTitle: "Country",
            tileDescription: "View news from different countries",
            onPressed: () => showCountryDialog(context: context),
          ),
        ],
      ),
    );
  }

  Widget _settingsTile({
    required IconData tileIcon,
    required String tileTitle,
    required String tileDescription,
    required VoidCallback onPressed,
    required BuildContext context,
  }) =>
      GestureDetector(
        onTap: onPressed,
        child: Row(
          children: [
            Icon(tileIcon),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(tileTitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  Text(tileDescription,
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      );

  void showUsernameDialog({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          "Change Username",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        contentPadding: const EdgeInsets.all(20),
        content: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TextField
              SizedBox(
                height: 45,
                child: TextFormField(
                  controller: usernameEditingController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              const SizedBox(height: 15),
              // Submit Button
              defaultButton(changeSettingsFunc: changeUserName),
            ],
          ),
        ),
      ),
    );
  }

  void changeUserName() => setState(() {
        userName = usernameEditingController.text;
        CacheHelper.saveData(key: "userName", value: userName);
        Navigator.pop(context);
      });

  void showProfileImgDialog({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          "Change Profile Pic",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        contentPadding: const EdgeInsets.all(20),
        content: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              defaultButton(
                buttonText: "Pick Image from Gallery",
                changeSettingsFunc: () =>
                    pickProfilePic(source: ImageSource.gallery),
              ),
              const SizedBox(height: 15),
              defaultButton(
                buttonText: "Pick Image from Camera",
                changeSettingsFunc: () =>
                    pickProfilePic(source: ImageSource.camera),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickProfilePic({required var source}) async {
    final returnedImage = await ImagePicker().pickImage(source: source);
    setState(() {
      userImg = File(returnedImage!.path);
      CacheHelper.saveData(key: "userImg", value: returnedImage.path);
      Navigator.pop(context);
    });
  }

  void showLangDialog({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (stfContext, stfSetState) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text(
              "Change Default App Language",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            contentPadding: const EdgeInsets.all(20),
            content: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // TextField
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => stfSetState(() =>changeLang(lang: "en")),
                          child: Container(
                            height: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color:
                                  !isArabic ? Colors.black : Colors.grey[200],
                            ),
                            child: Text(
                              "English",
                              style: TextStyle(
                                  color:
                                      !isArabic ? Colors.white : Colors.black),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => stfSetState(() =>changeLang(lang: "ar")),
                          child: Container(
                            height: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: isArabic ? Colors.black : Colors.grey[200],
                            ),
                            child: Text(
                              "Arabic",
                              style: TextStyle(
                                  color:
                                      isArabic ? Colors.white : Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  void changeLang({required String lang}) =>setState(() {
    isArabic = !isArabic;
    CacheHelper.saveData(
        key: "isArabic", value: isArabic);
    print(isArabic);
  });

  void showCountryDialog({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (stfContext, stfSetState) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Text(
              "View News From:",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            contentPadding: const EdgeInsets.all(20),
            content: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // TextField
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              stfSetState(() => changeCountry(country: "us")),
                          child: Container(
                            height: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: !isEgypt ? Colors.black : Colors.grey[200],
                            ),
                            child: Text(
                              "USA",
                              style: TextStyle(
                                  color:
                                      !isEgypt ? Colors.white : Colors.black),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              stfSetState(() => changeCountry(country: "eg")),
                          child: Container(
                            height: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: isEgypt ? Colors.black : Colors.grey[200],
                            ),
                            child: Text(
                              "Egypt",
                              style: TextStyle(
                                  color: isEgypt ? Colors.white : Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  void changeCountry({required String country}) => setState(() {
        isEgypt = !isEgypt;
        NewsCubit().get(context).country = country;
        NewsCubit().get(context).categorizedNewsList = [
          [],
          [],
          [],
          [],
          [],
          [],
          [],
        ];
        NewsCubit().get(context).getCategoriesNews(0);
        NewsCubit().get(context).getTrendingNews();
        CacheHelper.saveData(key: "isEgypt", value: isEgypt);
      });
}
