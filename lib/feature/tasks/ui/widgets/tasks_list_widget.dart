import 'package:adoodlz/feature/tasks/providers/task_provider.dart';
import 'package:adoodlz/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TasksListWidget extends StatefulWidget {
  @override
  _TasksListWidgetState createState() => _TasksListWidgetState();
}

class _TasksListWidgetState extends State<TasksListWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TaskProvider>(context, listen: false).getTasks();
    });
  }

  String _calculateTimeDifferenceBetween(
      {@required DateTime startDate, @required DateTime endDate}) {
    final int seconds = endDate.difference(startDate).inDays;
    if (seconds < 60) {
      return '$seconds ${AppLocalizations.of(context).day}';
    } else if (seconds >= 60 && seconds < 3600) {
      return '${startDate.difference(endDate).inMinutes.abs()} ${AppLocalizations.of(context).minute}';
    } else if (seconds >= 3600 && seconds < 86400) {
      return '${startDate.difference(endDate).inHours.abs()} ${AppLocalizations.of(context).hour}';
    } else {
      return '${startDate.difference(endDate).inDays.abs()} ${AppLocalizations.of(context).day}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (_, provider, __) => provider.loading2
          ? const Center(
              child: CircularProgressIndicator(
                //color: Color(0xFFDE608F),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFDE608F)),
              ),
            )
          : provider.tasks != null && provider.tasks.isNotEmpty
              ? RefreshIndicator(
                  onRefresh: () async {
                    Provider.of<TaskProvider>(context, listen: false)
                        .getTasks();
                  },
                  child: ListView.builder(
                    itemCount: provider.tasks.length,
                    itemBuilder: (context, index) {
                      //final endTaskDate = _calculateTimeDifferenceBetween(startDate: DateTime.now(), endDate: DateTime.parse('2021-05-25 00:31:10.035679'));

                      final endTaskDate = _calculateTimeDifferenceBetween(
                          startDate: DateTime.now(),
                          endDate:
                              provider.tasks[index].expireAt ?? DateTime.now());
                      int checkExpDate;

                      var convertToInt =
                          endTaskDate.substring(0, endTaskDate.length - 3);

                      checkExpDate = int.parse(convertToInt);

                      bool checkEndTaskNum(int x) {
                        if (x <= 0) {
                          return true;
                        }
                        return false;
                      }

                      //   check = int.parse(endTaskDate);

                      return provider.tasks[index].totalUserSubmit !=
                              provider.tasks[index].maxUserSubmit
                          ? GestureDetector(
                              onTap: () async {
                                Navigator.pushNamed(
                                    context, Routes.taskDetailScreen,
                                    arguments: provider.tasks[index]);
                              },
                              child:
                                  //  (checkEndTaskNum(
                                  //                         checkExpDate))?:

                                  checkEndTaskNum(checkExpDate) ||
                                          provider.tasks[index].submitCount > 0
                                      //=====================================================================================
                                      //disabled widget
                                      ? IgnorePointer(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 7.0),
                                            child: Card(
                                              elevation: 5.0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              child: Row(
                                                children: [
                                                  // ignore: sized_box_for_whitespace
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.29,
                                                    height: 150.0,
                                                    child: true
                                                        ? ClipRRect(
                                                            borderRadius: AppLocalizations.of(
                                                                            context)
                                                                        .localeName ==
                                                                    'ar'
                                                                ? const BorderRadius
                                                                    .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10.0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            10.0),
                                                                  )
                                                                : const BorderRadius
                                                                    .only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10.0),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10.0),
                                                                  ),
                                                            child: provider
                                                                        .tasks[
                                                                            index]
                                                                        .icon !=
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
                                                                : provider
                                                                            .tasks[
                                                                                index]
                                                                            .image !=
                                                                        null
                                                                    ? Image.network(
                                                                        provider
                                                                            .tasks[
                                                                                index]
                                                                            .image,
                                                                        fit: BoxFit
                                                                            .cover)
                                                                    : Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 10.0),
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images/logo.png',
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                      ),
                                                          )
                                                        : const Icon(
                                                            IconData(
                                                              0xf099,
                                                              fontFamily:
                                                                  'FontAwesomeBrands',
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
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10.0,
                                                        horizontal: 5.0),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.60,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          AppLocalizations.of(
                                                                          context)
                                                                      .localeName ==
                                                                  'ar'
                                                              ? provider
                                                                      .tasks[
                                                                          index]
                                                                      .content
                                                                      .ar
                                                                      .title ??
                                                                  ''
                                                              : provider
                                                                      .tasks[
                                                                          index]
                                                                      .content
                                                                      .en
                                                                      .title ??
                                                                  '',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headline5
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      16.0,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500),
                                                        ),
                                                        const SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        Text(
                                                          AppLocalizations.of(
                                                                          context)
                                                                      .localeName ==
                                                                  'ar'
                                                              ? provider
                                                                      .tasks[
                                                                          index]
                                                                      .content
                                                                      .ar
                                                                      .description ??
                                                                  ''
                                                              : provider
                                                                      .tasks[
                                                                          index]
                                                                      .content
                                                                      .en
                                                                      .description ??
                                                                  '',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .headline5
                                                              .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontSize: 13.0,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                          textAlign:
                                                              TextAlign.start,
                                                          softWrap: true,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        const SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5.0),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                '${AppLocalizations.of(context).pointsTask} ${provider.tasks[index].pointsIn ?? ''}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade500),
                                                              ),
                                                              const Spacer(),
                                                              Text(
                                                                '${AppLocalizations.of(context).taskEndTime ?? ''}',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 5),
                                                              // if (provider
                                                              //             .tasks[
                                                              //                 index]
                                                              //             .submitCount >
                                                              //         0 &&
                                                              //     checkEndTaskNum(
                                                              //         checkExpDate))
                                                              // Text('data'),
                                                              (provider.tasks[index].submitCount >
                                                                          0 &&
                                                                      checkEndTaskNum(
                                                                          checkExpDate))
                                                                  ? Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          .22,
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)
                                                                            .submitted,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color: Colors
                                                                              .grey
                                                                              .shade500,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : (provider.tasks[index]
                                                                              .submitCount >
                                                                          0)
                                                                      ? Container(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * .22,
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context).submitted,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.grey.shade500,
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : Container(
                                                                          width:
                                                                              MediaQuery.of(context).size.width * .22,
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context).expired,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.grey.shade500,
                                                                            ),
                                                                          ),
                                                                        ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      //====================================================================================================
                                      //the enabled task
                                      : Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 7.0),
                                          child: Card(
                                            elevation: 5.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: Row(
                                              children: [
                                                // ignore: sized_box_for_whitespace
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.29,
                                                  height: 150.0,
                                                  child: true
                                                      ? ClipRRect(
                                                          borderRadius: AppLocalizations.of(
                                                                          context)
                                                                      .localeName ==
                                                                  'ar'
                                                              ? const BorderRadius
                                                                  .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10.0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10.0),
                                                                )
                                                              : const BorderRadius
                                                                  .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10.0),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10.0),
                                                                ),
                                                          child: provider
                                                                      .tasks[
                                                                          index]
                                                                      .icon !=
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
                                                              : provider
                                                                          .tasks[
                                                                              index]
                                                                          .image !=
                                                                      null
                                                                  ? Image.network(
                                                                      provider
                                                                          .tasks[
                                                                              index]
                                                                          .image,
                                                                      fit: BoxFit
                                                                          .cover)
                                                                  : Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              10.0),
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/images/logo.png',
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                    ),
                                                        )
                                                      : const Icon(
                                                          IconData(
                                                            0xf099,
                                                            fontFamily:
                                                                'FontAwesomeBrands',
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
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 5.0),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.60,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        AppLocalizations.of(
                                                                        context)
                                                                    .localeName ==
                                                                'ar'
                                                            ? provider
                                                                .tasks[index]
                                                                .content
                                                                .ar
                                                                .title
                                                            : provider
                                                                .tasks[index]
                                                                .content
                                                                .en
                                                                .title,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 16.0,
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                      const SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Text(
                                                        AppLocalizations.of(
                                                                        context)
                                                                    .localeName ==
                                                                'ar'
                                                            ? provider
                                                                .tasks[index]
                                                                .content
                                                                .ar
                                                                .description
                                                            : provider
                                                                .tasks[index]
                                                                .content
                                                                .en
                                                                .description,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 13.0,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                        textAlign:
                                                            TextAlign.start,
                                                        softWrap: true,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    5.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              '${AppLocalizations.of(context).pointsTask} ${provider.tasks[index].pointsIn}',
                                                              style:
                                                                  const TextStyle(
                                                                color: Color(
                                                                    0xffE16E43),
                                                              ),
                                                            ),
                                                            const Spacer(),
                                                            Text(
                                                              '${AppLocalizations.of(context).taskEndTime}',
                                                              style:
                                                                  const TextStyle(
                                                                color: Color(
                                                                    0xffE16E43),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 5),
                                                            if (checkEndTaskNum(
                                                                checkExpDate))
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .22,
                                                                child:
                                                                    const Text(
                                                                  'Expired',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color(
                                                                        0xffE16E43),
                                                                  ),
                                                                ),
                                                              ),
                                                            if (!checkEndTaskNum(
                                                                checkExpDate))
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .25,
                                                                child: Text(
                                                                  '$endTaskDate',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color(
                                                                        0xffE16E43),
                                                                  ),
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ), // mylast is hereeeeeeeeeeeeee
                            )
                          : Container();
                    },
                  ),
                )
              : Center(
                  child: Text(AppLocalizations.of(context).noTasks),
                ),
    );
  }
}
