import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:roller_list/roller_list.dart';

class SlotMachineViewModel extends ChangeNotifier {
  static const _ROTATION_DURATION = Duration(milliseconds: 300);
  final List<Widget> slots = getSlots();
  final List<String> slotNames = [
    "grape",
    "apple",
    "banana",
    "tree",
    "carrot",
    "lemon",
    "pineapple",
    "seven",
    "orange",
    "watermelon",
  ];
  int first = 0, second = 0, third = 0;

  final leftRoller = GlobalKey<RollerListState>();
  final rightRoller = GlobalKey<RollerListState>();
  final centerRoller = GlobalKey<RollerListState>();

  late Timer rotator;
  final Random _random = Random();

  void startRotating() {
    rotator = Timer.periodic(_ROTATION_DURATION,
        rotateRoller); //let's use timer to do rotations periodically
    notifyListeners();
  }

  void rotateRoller(_) {
    final leftRotationTarget = _random.nextInt(3 * slots.length);
    final rightRotationTarget = _random.nextInt(3 * slots.length);
    final centerRotationTarget = _random.nextInt(3 * slots.length);
    leftRoller.currentState!.smoothScrollToIndex(leftRotationTarget,
        duration: _ROTATION_DURATION,
        curve: Curves
            .linear); //it is possible to select custom duration and curve for this animation
    rightRoller.currentState!.smoothScrollToIndex(rightRotationTarget,
        duration: _ROTATION_DURATION, curve: Curves.linear);
    centerRoller.currentState!.smoothScrollToIndex(centerRotationTarget,
        duration: _ROTATION_DURATION, curve: Curves.linear);
    notifyListeners();
  }

  void finishRotating() {
    rotator.cancel();
  }

  static List<Widget> getSlots() {
    List<Widget> result = [];
    for (int i = 0; i <= 9; i++) {
      result.add(Container(
        // margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.all(4.0),
        // decoration: BoxDecoration(
        //     color: Colors.grey[300], borderRadius: BorderRadius.circular(10.0)),
        child: Image.asset(
          "assets/images/$i.png",
          width: double.infinity,
          height: double.infinity,
        ),
      ));
    }
    return result;
  }
}
