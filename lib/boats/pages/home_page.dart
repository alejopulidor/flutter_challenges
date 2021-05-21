import 'package:flutter/material.dart';

import 'package:flutter_challenges/boats/api/boats_api.dart';
import 'package:flutter_challenges/boats/models/BoatModel.dart';

import 'package:flutter_challenges/boats/widgets/header.dart';
import 'package:flutter_challenges/boats/widgets/boat_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController();
  ValueNotifier<double> _currentPage = ValueNotifier(0.0);

  void _listener() {
    _currentPage.value = _pageController.page;
  }

  @override
  void initState() {
    _pageController.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_listener);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeaderApp(),
            FutureBuilder<List<Boat>>(
              future: BoastApi.getBoats(context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final boats = snapshot.data;
                  return Flexible(
                    flex: 1,
                    child: ValueListenableBuilder(
                      valueListenable: _currentPage,
                      builder: (_, double value, Widget child) {
                        return PageView.builder(
                          physics: BouncingScrollPhysics(),
                          controller: _pageController,
                          itemBuilder: (BuildContext context, int index) {
                            final percent = 1.0 - (value - index).abs();
                            return Opacity(
                              opacity: percent.clamp(0.0, 1.0),
                              child: Transform.scale(
                                scale: percent.clamp(0.8, 1.0),
                                child: BoatItem(
                                  boat: boats[index],
                                ),
                              ),
                            );
                          },
                          itemCount: boats.length,
                        );
                      },
                    ),
                  );
                } else {
                  return Flexible(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
