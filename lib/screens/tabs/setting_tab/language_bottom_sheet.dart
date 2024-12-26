import 'package:app_todo_list/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../providers/app_config_provider.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
            onTap: () {
              provider.changeLanguage('en');
            },
            child: provider.appLanguage == 'en'
                ? getSelectedItemWidget(
                    context, AppLocalizations.of(context)!.english)
                : getUnSelectedItemWidget(
                    context, AppLocalizations.of(context)!.english)),
        InkWell(
            onTap: () {
              provider.changeLanguage('ar');
            },
            child: provider.appLanguage == 'ar'
                ? getSelectedItemWidget(
                    context, AppLocalizations.of(context)!.arabic)
                : getUnSelectedItemWidget(
                    context, AppLocalizations.of(context)!.arabic)),
      ],
    );
  }

  Widget getSelectedItemWidget(BuildContext context, String text) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: provider.appTheme == ThemeMode.dark
                ? Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: MyTheme.primaryLight)
                : Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: MyTheme.primaryLight),
          ),
          Icon(
            Icons.check,
            color: MyTheme.primaryLight,
            size: 30,
          ),
        ],
      ),
    );
  }

  Widget getUnSelectedItemWidget(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
