import 'package:app_todo_list/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../providers/app_config_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDateTime = DateTime.now();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.add_new_task,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.title_error;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.enter_task_title,
                            hintStyle: TextStyle(
                                color: provider.appTheme == ThemeMode.light
                                    ? MyTheme.greyColor
                                    : MyTheme.whiteColor)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.desc_error;
                          }
                          return null;
                        },
                        maxLines: 4,
                        decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.enter_task_desc,
                            hintStyle: TextStyle(
                                color: provider.appTheme == ThemeMode.light
                                    ? MyTheme.greyColor
                                    : MyTheme.whiteColor)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppLocalizations.of(context)!.select_time,
                          style: Theme.of(context).textTheme.titleSmall),
                    ),
                    GestureDetector(
                      onTap: () async {
                        var chosenDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 365)));
                        if (chosenDate != null) {
                          selectedDateTime = chosenDate;
                        }
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            '${selectedDateTime.day}/${selectedDateTime.month}/${selectedDateTime.year}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleSmall),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate() == true) {
                          Navigator.of(context).pop();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyTheme.primaryLight,
                          shape: const RoundedRectangleBorder()),
                      child: Text(
                        AppLocalizations.of(context)!.add,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    )
                  ]))
        ],
      ),
    );
  }
}
