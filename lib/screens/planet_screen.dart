import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:some_game/models/planet_model.dart';
import 'package:some_game/utility/constants.dart';
import 'package:some_game/widgets/planet_screen/defence.dart';
import 'package:some_game/widgets/planet_screen/stats.dart';
import 'package:some_game/widgets/planet_screen/upgrades.dart';
import 'package:some_game/widgets/static_stars_bg.dart';

class PlanetScreen extends StatefulWidget {
  static const route = '/planet-screen';

  PlanetScreen();

  @override
  _PlanetScreenState createState() => _PlanetScreenState();
}

class _PlanetScreenState extends State<PlanetScreen> {
  bool _loadedInitData = false;
  Planet _planet;

  Map<String, Widget> _displayMode;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs = ModalRoute.of(context).settings.arguments as Planet;
      _planet = routeArgs;
      _loadedInitData = true;
      _displayMode = {
        'Stats': PlanetStats(
          planet: _planet,
        ),
        'Upgrades': PlanetUpgrades(),
        'Defence': PlanetDefence(),
      };
    }
    super.didChangeDependencies();
  }

  Widget _planetImage() {
    return Expanded(
      child: Hero(
          tag: _planet.name,
          child: Image.asset(
              'assets/img/planets/${describeEnum(_planet.name).toLowerCase()}.png')),
    );
  }

  Widget _tabBar() {
    return TabBar(
        unselectedLabelColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.pink[700],
            opacityPrimaryColor(0.5)
          ]),
          borderRadius: BorderRadius.circular(50),
        ),
        tabs: List.generate(
            _displayMode.keys.length,
            (index) => Tab(
                  text: List.from(_displayMode.keys)[index],
                )));
  }

  Widget _tabView() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: TabBarView(
          children: List.generate(_displayMode.values.length,
              (index) => List.from(_displayMode.values)[index]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(describeEnum(_planet.name)),
        ),
        body: Stack(
          children: [
            StaticStarsBackGround(),
            orientation == Orientation.landscape
                ? Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            _planetImage(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: _tabBar(),
                            ),
                          ],
                        ),
                      ),
                      _tabView(),
                    ],
                  )
                : Column(
                    children: [
                      _planetImage(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: _tabBar(),
                      ),
                      _tabView(),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
