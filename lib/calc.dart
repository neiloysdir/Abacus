import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Calc extends StatefulWidget {
  const Calc({Key? key}) : super(key: key);

  @override
  _CalcState createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  String lbl = "0";
  bool toClear = false;
  bool isAC = true;
  bool canPoint = true;
  String? operation;
  double? num1;
  double? num2;
  double? result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: FittedBox(
                      child: Text(
                        lbl,
                        style: const TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 96,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: GridView.count(
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    crossAxisCount: 4,
                    padding: const EdgeInsets.only(top: 20),
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // First Row Of Calculator
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: MaterialButton(
                          color: Colors.grey.shade400,
                          highlightColor: Colors.grey.shade200,
                          onPressed: () {
                            setState(() {
                              if (!isAC) {
                                lbl = "0";
                                canPoint = true;
                                isAC = true;
                              } else {
                                lbl = "0";
                                canPoint = true;
                                operation = null;
                                num1 = null;
                                num2 = null;
                                toClear = false;
                              }
                            });
                          },
                          child: Center(
                            child: Text(
                              isAC ? "AC" : "C",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: isAC ? 30 : 36,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: MaterialButton(
                          color: Colors.grey.shade400,
                          highlightColor: Colors.grey.shade200,
                          onPressed: () {
                            double? temp = double.tryParse(lbl);
                            if (temp != null) {
                              temp = temp * -1;
                              setState(() {
                                lbl = temp.toString();
                                isAC = false;
                              });
                            }
                          },
                          child: const Center(
                            child: Text(
                              "±",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 36,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: MaterialButton(
                          color: Colors.grey.shade400,
                          highlightColor: Colors.grey.shade200,
                          onPressed: () {
                            double? temp = double.tryParse(lbl);
                            if (temp != null) {
                              temp = temp / 100;
                              setState(() {
                                lbl = temp.toString();
                                isAC = false;
                              });
                            }
                          },
                          child: const Center(
                            child: Text(
                              "%",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 36,
                              ),
                            ),
                          ),
                        ),
                      ),
                      operatorButton(operator: "div", icon: "÷"),

                      // Second Row of Calculator
                      numberButton(number: "7"),
                      numberButton(number: "8"),
                      numberButton(number: "9"),
                      operatorButton(operator: "mul", icon: "×"),

                      // Third Row of Calculator
                      numberButton(number: "4"),
                      numberButton(number: "5"),
                      numberButton(number: "6"),
                      operatorButton(operator: "sub", icon: "-"),

                      // Forth Row of Calculator
                      numberButton(number: "1"),
                      numberButton(number: "2"),
                      numberButton(number: "3"),
                      operatorButton(operator: "add", icon: "+"),
                      // Fifth Row of Calculator
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: MaterialButton(
                          color: Colors.pink.shade200,
                          highlightColor: Colors.pink,
                          onPressed: () {
                            print("Heart");
                          },
                          child: const Center(
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 36.0,
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: MaterialButton(
                          color: Colors.grey.shade800,
                          onPressed: () {
                            List<String> temp = lbl.split("");
                            temp.add("0");
                            double newTemp = double.parse(temp.join());
                            setState(() {
                              if (canPoint) {
                                lbl = format(newTemp);
                              } else {
                                lbl = temp.join();
                              }
                            });
                          },
                          child: const Center(
                            child: Text(
                              "0",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: MaterialButton(
                          color: Colors.grey.shade800,
                          onPressed: () {
                            if (toClear) {
                              setState(() {
                                lbl = "0";
                                toClear = false;
                                canPoint = true;
                              });
                            }
                            if (canPoint) {
                              List<String> temp = lbl.split("");
                              temp.add(".");
                              String newTemp = temp.join();
                              setState(() {
                                canPoint = false;
                                lbl = newTemp;
                              });
                            }
                          },
                          child: const Center(
                            child: Text(
                              ".",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: MaterialButton(
                          color:
                              operation == null ? Colors.white : Colors.orange,
                          highlightColor: Colors.orange.shade200,
                          onPressed: () {
                            setState(() {
                              if (operation != null && num1 != null) {
                                switch (operation!) {
                                  case "add":
                                    lbl = format(num1! + double.tryParse(lbl)!);
                                    break;
                                  case "sub":
                                    lbl = format(num1! + double.tryParse(lbl)!);
                                    break;
                                  case "mul":
                                    lbl = format(num1! * double.tryParse(lbl)!);
                                    break;
                                  case "div":
                                    lbl = format(num1! / double.tryParse(lbl)!);
                                    break;
                                }
                                operation = null;
                                toClear = true;
                              }
                            });
                          },
                          child: const Center(
                            child: Text(
                              "=",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String format(double n) {
    return n.truncateToDouble() == n ? n.toStringAsFixed(0) : n.toString();
  }

  Widget numberButton({required String number}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: MaterialButton(
        color: Colors.grey.shade800,
        onPressed: () {
          if (toClear) {
            setState(() {
              lbl = "0";
              toClear = false;
              canPoint = true;
            });
          }
          List<String> temp = lbl.split("");
          temp.add(number);
          double newTemp = double.parse(temp.join());
          setState(() {
            lbl = format(newTemp);
            isAC = false;
          });
        },
        child: Center(
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
            ),
          ),
        ),
      ),
    );
  }

  Widget operatorButton({required String operator, required String icon}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: MaterialButton(
        color: operation != null && operation == operator
            ? Colors.orange.shade200
            : Colors.orange,
        highlightColor: Colors.orange.shade200,
        onPressed: () {
          setState(() {
            if (operation != null) {
              switch (operation!) {
                case "add":
                  lbl = format(num1! + double.tryParse(lbl)!);
                  break;
                case "sub":
                  lbl = format(num1! + double.tryParse(lbl)!);
                  break;
                case "mul":
                  lbl = format(num1! * double.tryParse(lbl)!);
                  break;
                case "div":
                  lbl = format(num1! / double.tryParse(lbl)!);
                  break;
              }
              operation = null;
            }
            num1 = double.tryParse(lbl);
            operation = operator;
            toClear = true;
            isAC = false;
          });
        },
        child: Center(
          child: Text(
            icon,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
            ),
          ),
        ),
      ),
    );
  }
}
