import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_challenges/boats/models/BoatModel.dart';
import 'package:flutter_challenges/boats/widgets/by_text.dart';

class DetailPage extends StatefulWidget {
  final Boat boat;
  final Duration durationHero;

  const DetailPage({Key key, this.boat, this.durationHero}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  ValueNotifier<bool> disableBackButton = ValueNotifier(true);

  @override
  void initState() {
    updateDisabled();
    super.initState();
  }

  void updateDisabled() {
    Future.delayed(widget.durationHero, () => disableBackButton.value = false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (disableBackButton.value) {
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder(
                  builder: (BuildContext context, value, Widget child) {
                    return HeaderDetail(
                      boat: widget.boat,
                      disableBackButton: value,
                    );
                  },
                  valueListenable: disableBackButton,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTitle(widget.boat.name, widget.boat.by),
                      SizedBox(
                        height: 20.0,
                      ),
                      buildDescription(widget.boat.description),
                      SizedBox(
                        height: 25.0,
                      ),
                      buildSpec(),
                    ],
                  ),
                ),
                buildGallery(),
                SizedBox(
                  height: 30.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  FadeInLeft buildTitle(name, by) {
    return FadeInLeft(
      duration: Duration(milliseconds: 350),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          ByText(by),
        ],
      ),
    );
  }

  FadeInLeft buildDescription(description) {
    return FadeInLeft(
      duration: Duration(milliseconds: 350),
      delay: Duration(milliseconds: 100),
      child: Text(
        description,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black.withOpacity(0.6),
        ),
        overflow: TextOverflow.clip,
      ),
    );
  }

  FadeInLeft buildGallery() {
    return FadeInLeft(
      duration: Duration(milliseconds: 350),
      delay: Duration(milliseconds: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "GALLERY",
              style: TextStyle(
                  fontSize: 20.0, color: Colors.black.withOpacity(0.6)),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ImageGallery("assets/boats/img/carrousel/c1.jpg"),
                  ImageGallery("assets/boats/img/carrousel/c2.jpg"),
                  ImageGallery("assets/boats/img/carrousel/c3.jpg"),
                  ImageGallery("assets/boats/img/carrousel/c4.jpg"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  FadeInLeft buildSpec() {
    return FadeInLeft(
      duration: Duration(milliseconds: 350),
      delay: Duration(milliseconds: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "SPEC",
            style:
                TextStyle(fontSize: 20.0, color: Colors.black.withOpacity(0.6)),
          ),
          SizedBox(
            height: 20.0,
          ),
          DescriptionItem("Boat Length", widget.boat.specs.length),
          DescriptionItem("Beam", widget.boat.specs.beam),
          DescriptionItem("Weigth", "${widget.boat.specs.weigth} KG"),
          DescriptionItem(
              "Fuel capacity", "${widget.boat.specs.fuelCapacity} L"),
          SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }
}

class HeaderDetail extends StatelessWidget {
  final Boat boat;
  final bool disableBackButton;

  const HeaderDetail({
    Key key,
    @required this.boat,
    this.disableBackButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 240.0,
          width: double.infinity,
          child: Transform.translate(
            offset: Offset(-120.0, 230.0),
            child: Transform.scale(
              scale: 1.9,
              child: Hero(
                tag: boat.image,
                child: Transform.rotate(
                  alignment: Alignment.topCenter,
                  angle: -math.pi / 2,
                  child: Image.asset('assets/boats/img/boats/${boat.image}'),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 15.0,
          left: 15.0,
          child: GestureDetector(
            onTap: () {
              if (!disableBackButton) {
                Navigator.pop(context);
              }
            },
            child: Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey.withOpacity(0.25)),
              child: Icon(
                Icons.close,
                color: Colors.black45,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ImageGallery extends StatelessWidget {
  final String path;
  const ImageGallery(
    this.path, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(left: 15.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: AspectRatio(
        aspectRatio: 16 / 10,
        child: Image.asset(
          path,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class DescriptionItem extends StatelessWidget {
  final String text;
  final String value;
  const DescriptionItem(
    this.text,
    this.value, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
              child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )),
          Expanded(
              child: Text(
            value,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black45,
                fontSize: 16),
          )),
        ],
      ),
    );
  }
}
