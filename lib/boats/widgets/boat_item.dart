import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_challenges/boats/models/BoatModel.dart';

import 'package:flutter_challenges/boats/pages/detail_page.dart';
import 'by_text.dart';

const Duration durationHero = Duration(milliseconds: 800);

class BoatItem extends StatefulWidget {
  final Boat boat;
  final Function onTap;

  const BoatItem({Key key, this.boat, this.onTap}) : super(key: key);

  @override
  _BoatItemState createState() => _BoatItemState();
}

class _BoatItemState extends State<BoatItem> {
  ValueNotifier<bool> disableBackButton = ValueNotifier(false);

  void updateDisabled() {
    disableBackButton.value = true;
    Future.delayed(durationHero, () => disableBackButton.value = false);
  }

  void pushPage(context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => DetailPage(
          boat: widget.boat,
          durationHero: durationHero,
        ),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            child: child,
            opacity: Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
                reverseCurve: Curves.easeInExpo,
              ),
            ),
          );
        },
        transitionDuration: durationHero,
        reverseTransitionDuration: durationHero,
      ),
    ).then((_) => updateDisabled());
  }

  Widget heroTransition(
      BuildContext flightContext,
      Animation<double> animation,
      HeroFlightDirection flightDirection,
      BuildContext fromHeroContext,
      BuildContext toHeroContext) {
    final _curve = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutBack,
      reverseCurve: Curves.easeInBack,
    );
    return ValueListenableBuilder(
      valueListenable: _curve,
      builder: (BuildContext context, double value, Widget child) {
        return Transform.rotate(
          alignment: Alignment.topCenter,
          angle: (-math.pi / 2) * value,
          child: flightDirection == HeroFlightDirection.push
              ? fromHeroContext.widget
              : toHeroContext.widget,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: disableBackButton,
      builder: (BuildContext context, bool value, Widget child) {
        return AbsorbPointer(
          absorbing: value,
          child: child,
        );
      },
      child: Column(
        children: [
          Flexible(
            flex: 8,
            child: Hero(
              flightShuttleBuilder: heroTransition,
              tag: widget.boat.image,
              child: Image.asset('assets/boats/img/boats/${widget.boat.image}'),
            ),
          ),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.boat.name,
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ByText(widget.boat.by),
                SpecButton(
                  onTap: () => pushPage(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SpecButton extends StatelessWidget {
  final Function onTap;

  const SpecButton({
    Key key,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        width: 100,
        height: 50,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                "SPEC",
                style: TextStyle(
                    color: Colors.deepPurple, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.deepPurple,
              )
            ],
          ),
        ),
      ),
    );
  }
}
