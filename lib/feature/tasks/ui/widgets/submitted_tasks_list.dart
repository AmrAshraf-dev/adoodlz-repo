import 'package:adoodlz/feature/tasks/providers/task_provider.dart';
import 'package:adoodlz/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubmittedTasksList extends StatefulWidget {
  @override
  _SubmittedTasksListState createState() => _SubmittedTasksListState();
}

class _SubmittedTasksListState extends State<SubmittedTasksList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (_, provider, __) => provider.loading2
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : provider.submittedTasks != null &&
                  provider.submittedTasks.isNotEmpty
              ? ListView.builder(
                  itemCount: provider.submittedTasks.length,
                  itemBuilder: (context, index) {
                    //final endTaskDate = _calculateTimeDifferenceBetween(startDate: DateTime.now(), endDate: DateTime.parse('2021-05-25 00:31:10.035679'));
                    return provider.tasks[index].totalUserSubmit !=
                            provider.tasks[index].maxUserSubmit
                        ? GestureDetector(
                            onTap: () async {
                              Navigator.pushNamed(
                                  context, Routes.taskDetailScreen,
                                  arguments: provider.submittedTasks[index]);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 125.0,
                              margin: const EdgeInsets.symmetric(vertical: 7.0),
                              child: Card(
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Row(
                                  children: [
                                    // ignore: sized_box_for_whitespace
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.29,
                                      height: 150.0,
                                      child: true
                                          ? ClipRRect(
                                              borderRadius: AppLocalizations.of(
                                                              context)
                                                          .localeName ==
                                                      'ar'
                                                  ? const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(10.0),
                                                      bottomRight:
                                                          Radius.circular(10.0),
                                                    )
                                                  : const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(10.0),
                                                      topLeft:
                                                          Radius.circular(10.0),
                                                    ),
                                              child: provider
                                                          .tasks[index].icon !=
                                                      null
                                                  ? Icon(
                                                      IconData(
                                                        int.parse(
                                                            '0x${provider.tasks[index].icon.unicode}'),
                                                        fontFamily:
                                                            'FontAwesome${provider.tasks[index].icon.style}',
                                                        fontPackage:
                                                            'font_awesome_flutter',
                                                      ),
                                                      size: 70.0,
                                                    )
                                                  : provider.tasks[index]
                                                              .image !=
                                                          null
                                                      ? Image.network(
                                                          provider.tasks[index]
                                                              .image,
                                                          fit: BoxFit.cover)
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10.0),
                                                          child: Image.asset(
                                                            'assets/images/logo.png',
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                            )
                                          : const Icon(
                                              IconData(
                                                0xf099,
                                                fontFamily: 'FontAwesomeBrands',
                                                fontPackage:
                                                    'font_awesome_flutter',
                                              ),
                                              color: Colors.blue,
                                              size: 60.0,
                                            ),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 5.0),
                                      width: MediaQuery.of(context).size.width *
                                          0.55,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)
                                                        .localeName ==
                                                    'ar'
                                                ? provider.tasks[index].content
                                                    .ar.title
                                                : provider.tasks[index].content
                                                    .en.title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5
                                                .copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16.0,
                                                    color: Colors.black),
                                          ),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container();
                  },
                )
              : Center(
                  child: Text(AppLocalizations.of(context).noTasks),
                ),
    );
  }
}
