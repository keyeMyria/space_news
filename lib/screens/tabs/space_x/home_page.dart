import 'package:flutter/material.dart';

import '../../../util/url.dart';
import 'about_page.dart';
import 'launch_list.dart';
import 'vehicle_list.dart';

/// HOME PAGE CLASS
/// Home page of the app.
class SpaceXHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SpaceXHomePageState();
}

class _SpaceXHomePageState extends State<SpaceXHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<StatelessWidget> _homeLists = List(_tabs.length);

  /// List of the TabBar's tabs
  static const List<Tab> _tabs = const <Tab>[
    const Tab(text: 'VEHICLES'),
    const Tab(text: 'UPCOMING'),
    const Tab(text: 'LATEST'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
      initialIndex: 1,
    );
    updateLists();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void updateLists() {
    _homeLists = [
      VehicleList(),
      LaunchList(Url.upcomingList),
      LaunchList(Url.launchesList),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SpaceX GO!',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder<Null>(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: const Interval(
                            0.0,
                            0.75,
                            curve: Curves.fastOutSlowIn,
                          ).transform(animation.value),
                          child: AboutPage(),
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          labelStyle: TextStyle(
            fontFamily: 'ProductSans',
            fontWeight: FontWeight.bold,
          ),
          isScrollable: true,
          controller: _tabController,
          tabs: _tabs,
        ),
      ),
      body: TabBarView(controller: _tabController, children: _homeLists),
    );
  }
}
