import 'package:flutter/material.dart';
import 'package:flutter_challenges/boats/models/BoatModel.dart';

class BoastApi {
  static Future<List<Boat>> getBoats(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final boats = await assetBundle.loadString("assets/boats/data/boats.json");
    return boatFromJson(boats);
  }
}
