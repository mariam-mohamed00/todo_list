import 'package:app_todo_list/screens/tabs/setting_tab/theme_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../my_theme.dart';
import '../../../providers/app_config_provider.dart';
import 'language_bottom_sheet.dart';

class SettingTabScreen extends StatefulWidget {
  const SettingTabScreen({super.key});

  @override
  State<SettingTabScreen> createState() => _SettingTabScreenState();
}

class _SettingTabScreenState extends State<SettingTabScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: (provider.appTheme == ThemeMode.light)
                    ? MyTheme.whiteColor
                    : MyTheme.blackDark,
                context: context,
                builder: (context) => const LanguageBottomSheet(),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                  color: provider.appTheme == ThemeMode.light
                      ? MyTheme.whiteColor
                      : MyTheme.blackDark,
                  border: Border.all(color: MyTheme.primaryLight, width: 3)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.appLanguage == 'en'
                        ? AppLocalizations.of(context)!.english
                        : AppLocalizations.of(context)!.arabic,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: MyTheme.primaryLight,
                        fontWeight: FontWeight.w400),
                  ),
                  Icon(Icons.arrow_drop_down, color: MyTheme.primaryLight)
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            AppLocalizations.of(context)!.theme,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: (provider.appTheme == ThemeMode.light)
                    ? MyTheme.whiteColor
                    : MyTheme.blackDark,
                context: context,
                builder: (context) => const ThemeBottomSheet(),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                  color: provider.appTheme == ThemeMode.light
                      ? MyTheme.whiteColor
                      : MyTheme.blackDark,
                  border: Border.all(color: MyTheme.primaryLight, width: 3)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      provider.appTheme == ThemeMode.light
                          ? AppLocalizations.of(context)!.light
                          : AppLocalizations.of(context)!.dark,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: MyTheme.primaryLight,
                          fontWeight: FontWeight.w400)),
                  Icon(
                    Icons.arrow_drop_down,
                    color: MyTheme.primaryLight,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
