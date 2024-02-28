import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/cubit/news_cubit.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? userName;
  String? userImgPath;
  File? userImg;
  var usernameEditingController = TextEditingController();
  bool isArabic = false;
  String? country;
  int? selectedCountryIndex;

  @override
  void initState() {
    userName = CacheHelper.getData(key: "userName") ?? "";
    userImgPath = CacheHelper.getData(key: "userImg") ?? "";
    userImg = File(userImgPath!);
    isArabic = CacheHelper.getData(key: "isArabic") ?? false;
    selectedCountryIndex = CacheHelper.getData(key: "countryIdx") ?? 0;
    country = countries[selectedCountryIndex!];

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
          Text(AppLocalizations.of(context)!.accountSettings,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _settingsTile(
            context: context,
            tileIcon: Icons.person,
            tileTitle: AppLocalizations.of(context)!.username,
            tileDescription: AppLocalizations.of(context)!.usernameDesc,
            onPressed: () => showUsernameDialog(context: context),
          ),
          const SizedBox(height: 15),
          _settingsTile(
            context: context,
            tileIcon: Icons.camera_alt,
            tileTitle: AppLocalizations.of(context)!.profilePic,
            tileDescription: AppLocalizations.of(context)!.profilePicDesc,
            onPressed: () => showProfileImgDialog(context: context),
          ),
          const SizedBox(height: 15),
          Text(AppLocalizations.of(context)!.appSettings,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _settingsTile(
            context: context,
            tileIcon: Icons.language,
            tileTitle: AppLocalizations.of(context)!.lang,
            tileDescription: AppLocalizations.of(context)!.langDesc,
            onPressed: () => showLangDialog(context: context),
          ),
          const SizedBox(height: 15),
          _settingsTile(
            context: context,
            tileIcon: Icons.place,
            tileTitle: AppLocalizations.of(context)!.country,
            tileDescription: AppLocalizations.of(context)!.countryDesc,
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
        title: Text(
          AppLocalizations.of(context)!.showUsernameDialog,
          textAlign: TextAlign.center,
          style: const TextStyle(
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
              defaultButton(
                  buttonText: AppLocalizations.of(context)!.submit,
                  changeSettingsFunc: changeUserName),
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
        title: Text(
          AppLocalizations.of(context)!.showImgDialog1,
          textAlign: TextAlign.center,
          style: const TextStyle(
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
                buttonText: AppLocalizations.of(context)!.showImgDialog2,
                changeSettingsFunc: () =>
                    pickProfilePic(source: ImageSource.gallery),
              ),
              const SizedBox(height: 15),
              defaultButton(
                buttonText: AppLocalizations.of(context)!.showImgDialog3,
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
            title: Text(
              AppLocalizations.of(context)!.showLangDialog,
              textAlign: TextAlign.center,
              style: const TextStyle(
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
                              stfSetState(() => changeLang(lang: "en")),
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
                          onTap: () =>
                              stfSetState(() => changeLang(lang: "ar")),
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

  void changeLang({required String lang}) => setState(() {
        isArabic = !isArabic;
        CacheHelper.saveData(key: "isArabic", value: isArabic);
        print(isArabic);
        Phoenix.rebirth(context);
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
            title: Text(
              AppLocalizations.of(context)!.showCountryDialog,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            contentPadding: const EdgeInsets.all(20),
            content: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Countries
                  Container(
                    height: 50,
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () => stfSetState(
                                  () => changeCountry(countryIdx: index)),
                              child: Container(
                                height: 45,
                                width: 70,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: index == selectedCountryIndex
                                      ? Colors.black
                                      : Colors.grey[200],
                                ),
                                child: Text(
                                  countries[index],
                                  style: TextStyle(
                                      color: index == selectedCountryIndex
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                        itemCount: countries.length),
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }

  void changeCountry({required int countryIdx}) => setState(() {
        selectedCountryIndex = countryIdx;
        NewsCubit().get(context).country = countries[countryIdx];
        CacheHelper.saveData(key: "countryIdx", value: countryIdx);
        Phoenix.rebirth(context);
      });
}
