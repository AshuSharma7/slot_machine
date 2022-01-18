import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roller_list/roller_list.dart';
import 'package:slot_machine/slot_machine_view_model.dart';

class SlotMachine extends StatefulWidget {
  const SlotMachine({Key? key}) : super(key: key);

  @override
  _SlotMachineState createState() => _SlotMachineState();
}

class _SlotMachineState extends State<SlotMachine> {
  bool isFirst = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: ChangeNotifierProvider(
        create: (_) => SlotMachineViewModel(),
        child: Consumer<SlotMachineViewModel>(
          builder: (context, model, widget) {
            return Column(
              children: <Widget>[
                const Text(
                  'Slot Machine',
                  textScaleFactor: 1.5,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  child: Stack(
                    children: [
                      Container(
                        height: 500,
                        child: Image.asset('assets/images/slot-machine.jpg',
                            fit: BoxFit.cover),
                      ),
                      Positioned(
                        left: 94,
                        right: 94,
                        bottom: 160,
                        child: Container(
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                color: Colors.white,
                                width: 60,
                                child: RollerList(
                                  visibilityRadius: 0.0,
                                  height: 50.0,
                                  items: model.slots,
                                  enabled: false,
                                  key: model.leftRoller,
                                  onSelectedIndexChanged: (value) {
                                    setState(() {
                                      model.first = value;
                                    });
                                  },
                                ),
                              ),
                              VerticalDivider(
                                width: 2,
                                color: Colors.black,
                              ),
                              Container(
                                width: 60,
                                height: 50.0,
                                color: Colors.white,
                                child: RollerList(
                                  visibilityRadius: 0.0,
                                  items: model.slots,
                                  key: model.centerRoller,
                                  onSelectedIndexChanged: (value) {
                                    setState(() {
                                      model.second = value;
                                    });
                                  },
                                  // onScrollStarted: model.startRotating,
                                ),
                              ),
                              VerticalDivider(
                                width: 2,
                                color: Colors.black,
                              ),
                              Container(
                                width: 60,
                                height: 50.0,
                                color: Colors.white,
                                child: RollerList(
                                  visibilityRadius: 0,
                                  enabled: false,
                                  items: model.slots,
                                  key: model.rightRoller,
                                  onSelectedIndexChanged: (value) {
                                    setState(() {
                                      model.third = value;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                if (!model.first.isNegative && !isFirst)
                  const Text(
                    "Better Luck Next Time",
                    style: TextStyle(fontSize: 20.0),
                  ),
                (model.first == model.second &&
                        model.first == model.third &&
                        !isFirst)
                    ? const Text(
                        "WIN!!!",
                        style: TextStyle(fontSize: 20.0),
                      )
                    : Container(),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    model.startRotating();
                    Future.delayed(const Duration(milliseconds: 1500), () {
                      model.finishRotating();
                      isFirst = false;
                    });
                  },
                  child: Container(
                      margin: const EdgeInsets.all(10),
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color(0xFFFFCA19)),
                      child: const Center(
                          child: Text(
                        "Play",
                        style: TextStyle(fontSize: 25),
                      ))),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
