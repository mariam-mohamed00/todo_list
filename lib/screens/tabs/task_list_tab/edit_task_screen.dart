import 'package:app_todo_list/model/task.dart';
import 'package:app_todo_list/my_theme.dart';
import 'package:app_todo_list/providers/app_config_provider.dart';
import 'package:app_todo_list/providers/auth_provider.dart';
import 'package:app_todo_list/providers/list_provider.dart';
import 'package:app_todo_list/utils/dialog_utils.dart';
import 'package:app_todo_list/utils/firebase_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  DateTime selectedDateTime = DateTime.now();

  var formKey = GlobalKey<FormState>();

  late ListProvider listProvider;

  late AppConfigProvider provider;

  Task? task;

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (task == null) {
      task = ModalRoute.of(context)!.settings.arguments as Task;
      selectedDateTime = task!.dateTime!;
      titleController.text = task!.title ?? '';
      descriptionController.text = task!.description ?? '';
    }

    provider = Provider.of<AppConfigProvider>(context);
    listProvider = Provider.of<ListProvider>(context);

    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 56,
        title: Text(
          'Edit Task',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        iconTheme: IconThemeData(color: MyTheme.whiteColor),
      ),
      body: Column(children: [
        Stack(children: [
          Container(
            height: 44,
            color: MyTheme.primaryLight,
          ),
          Center(
            child: Container(
              height: screenSize.height * 0.7,
              width: screenSize.width * 0.85,
              padding: const EdgeInsets.all(12),
              margin: EdgeInsets.only(top: screenSize.height * 0.02),
              decoration: BoxDecoration(
                  color: MyTheme.whiteColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  SizedBox(height: screenSize.height * 0.05),
                  Text(
                    'Edit Task',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenSize.height * 0.05),
                  Form(
                      key: formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: titleController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .title_error;
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: titleController.text,
                                    hintStyle:
                                        TextStyle(color: MyTheme.blackColor)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: descriptionController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .desc_error;
                                  }
                                  return null;
                                },
                                maxLines: 4,
                                decoration: InputDecoration(
                                    hintText: descriptionController.text,
                                    hintStyle:
                                        TextStyle(color: MyTheme.blackColor)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  AppLocalizations.of(context)!.select_time,
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                            ),
                            GestureDetector(
                              onTap: () async {
                                var chosenDate = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 365)));
                                if (chosenDate != null) {
                                  selectedDateTime = chosenDate;
                                }
                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(
                                    '${selectedDateTime.day}/${selectedDateTime.month}/${selectedDateTime.year}',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {});

                                editTask();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: MyTheme.primaryLight,
                                  shape: const RoundedRectangleBorder()),
                              child: Text(
                                'Edit',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            )
                          ]))
                ],
              ),
            ),
          ),
        ])
      ]),
    );
  }

  void editTask() {
    if (formKey.currentState!.validate() == true) {
      task!.title = titleController.text;
      task!.description = descriptionController.text;
      task!.dateTime = selectedDateTime;

      var authProvider = Provider.of<UserAuthProvider>(context, listen: false);
      DialogUtils.showLoading(
          context,
          'Waiting...',
          provider.appTheme == ThemeMode.light
              ? MyTheme.whiteColor
              : MyTheme.backgroundDark);
      FirebaseUtils.editTask(task!, authProvider.currentuser?.id ?? '')
          .then((value) {
        DialogUtils.hideLoading(context);

        DialogUtils.showMessage(context, 'Task edit succeessfully',
            textColor: provider.appTheme == ThemeMode.light
                ? MyTheme.blackColor
                : MyTheme.whiteColor,
            actionColor: MyTheme.primaryLight,
            backgroundColor: provider.appTheme == ThemeMode.light
                ? MyTheme.whiteColor
                : MyTheme.backgroundDark,
            titleMessage: 'Success',
            posActionName: 'ok', posAction: () {
          Navigator.of(context).pop();
        });
        // listProvider
        //     .getAllTasksFromFireStore(authProvider.currentuser?.id ?? '');
      }).timeout(
        const Duration(microseconds: 100),
        onTimeout: () {
          listProvider
              .getAllTasksFromFireStore(authProvider.currentuser?.id ?? '');
        },
      );
    }
  }
}
