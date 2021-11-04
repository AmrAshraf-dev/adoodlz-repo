import 'package:adoodlz/feature/tasks/ui/widgets/submitted_tasks_list.dart';
import 'package:adoodlz/feature/tasks/ui/widgets/tasks_list_widget.dart';
import 'package:adoodlz/ui/widgets/floating_support_button.dart';
import 'package:flutter/material.dart';

class TasksWidget extends StatefulWidget {
  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> tasksBar = ['Tasks', 'Submitted Task'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tasksBar.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tasksBar.length,
      child: Scaffold(
        floatingActionButton: SupportButton(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniStartFloat,
        // appBar: PreferredSize(
        //   preferredSize: const Size.fromHeight(50.0),
        //   child: AppBar(
        //     elevation: 0.0,
        //     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        //     bottom: TabBar(
        //       controller: _tabController,
        //        indicator: BoxDecoration(color:Theme.of(context).scaffoldBackgroundColor ),
        //        indicatorColor: Colors.black,
        //        indicatorSize: TabBarIndicatorSize.tab,
        //        indicatorWeight: 1.0,
        //        unselectedLabelColor: Colors.grey,
        //       labelColor: const Color(0xFFDE608F),
        //       tabs: tasksBar.map((e) {
        //         return Container(
        //           alignment: Alignment.center,
        //           width: MediaQuery.of(context).size.width,
        //             padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
        //             child: Text(e.toUpperCase(),
        //                 style: const TextStyle(
        //                   fontSize: 16.0,
        //                   fontWeight: FontWeight.bold,
        //                 )));
        //       }).toList(),
        //     ),
        //   ),
        //  ),
        body: Column(
          children: [
            // Container(
            //   height: 50.0,
            //   child: TabBar(
            //      controller: _tabController,
            //      indicator: BoxDecoration(color:Theme.of(context).scaffoldBackgroundColor ),
            //      indicatorColor: Colors.black,
            //      indicatorSize: TabBarIndicatorSize.tab,
            //      indicatorWeight: 1.0,
            //      unselectedLabelColor: Colors.grey,
            //      labelColor: Colors.red,
            //      tabs: tasksBar.map((e) {
            //        return Container(
            //            alignment: Alignment.center,
            //            width: MediaQuery.of(context).size.width,
            //            padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
            //            child: Text(e.toUpperCase(),
            //                style: const TextStyle(
            //                  fontSize: 16.0,
            //                  fontWeight: FontWeight.bold,
            //                )));
            //      }).toList(),
            //    ),
            // ),

            Expanded(
              // child: TabBarView(
              // controller: _tabController,
              //physics: NeverScrollableScrollPhysics(),
              // children: [
              child: TasksListWidget(),
              // SubmittedTasksList(),
              // ],
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
