import 'dart:math';

import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_expressions/math_expressions.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isPage2 = false;
  double textPadding = 12.h;
  double textFontSize = 25.sp;
  bool isEqualPressed = false;
  double height = 60.h;
  double width = 70.w;
  bool isPressed = false;
  Parser p = Parser();
  String current = "";
  String result = "";
  bool isExpressionValid(String expressionString) {
    try {
      Parser().parse(expressionString);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 25, 25, 50)),
              child: Padding(
                padding: EdgeInsets.all(5.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 30.0.h),
                      child: Center(
                        child: Switch(
                            activeColor: Colors.blueAccent,
                            inactiveTrackColor: allButtons,
                            value: isPage2,
                            onChanged: (val) {
                              setState(() {
                                isPage2 = val;
                              });
                            }),
                      ),
                    ),
                    Text(
                      result,
                      style: TextStyle(
                          color: isEqualPressed ? Colors.white : Colors.white60,
                          fontSize: isEqualPressed == true ? 40 : 30),
                    ),
                    Text(
                      current,
                      style: TextStyle(
                          color: isEqualPressed ? Colors.white60 : Colors.white,
                          fontSize: isEqualPressed ? 30 : 40),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                    color: background2,
                    border: Border(top: BorderSide(color: mauve, width: 8.sp)),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: textPadding),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    current = "";
                                    result = "";
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: firstRow,
                                    minimumSize: Size(width, height),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: textPadding),
                                  child: Text(
                                    "C",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textFontSize),
                                  ),
                                )),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: textPadding),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isPressed = !isPressed;
                                  if (isPressed) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            duration: 2000.ms,
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 25, 25, 50),
                                            content: Text(
                                                "Long press on '(' to write ')' ",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: textFontSize))));
                                    height = 45.h;
                                    textFontSize = 20.sp;
                                  } else {
                                    height = 60.h;
                                    textFontSize = 25.sp;
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: firstRow,
                                  minimumSize: Size(width, height),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                child: isPressed
                                    ? const Icon(
                                        Icons.move_down_rounded,
                                        color: Colors.white,
                                        size: 25,
                                      )
                                    : const Icon(
                                        Icons.move_up_rounded,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: textPadding),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (isEqualPressed == false) {
                                      isEqualPressed = true;
                                      current += '%';
                                      Expression exp = p.parse(
                                          "${current.substring(0, current.length - 1)}/100");
                                      ContextModel cm = ContextModel();
                                      double eval =
                                          exp.evaluate(EvaluationType.REAL, cm);
                                      result = eval.toString();
                                      print(eval);
                                    }
                                  });
                                  current = result;
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: firstRow,
                                    minimumSize: Size(width, height),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: textPadding),
                                  child: Text(
                                    "%",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textFontSize),
                                  ),
                                )),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: textPadding),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (current.isNotEmpty) {
                                      current = current.substring(
                                          0, current.length - 1);
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: firstRow,
                                    minimumSize: Size(width, height),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  child: const Icon(
                                    Icons.backspace_outlined,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isPressed,
                      child: Padding(
                        padding: EdgeInsets.all(5.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: textPadding),
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (isEqualPressed) {
                                        isEqualPressed = false;
                                        current = "";
                                        result = "";
                                      }
                                      current += "sin(";
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          isPage2 ? background2 : allButtons,
                                      elevation: isPage2 ? 0 : 1,
                                      minimumSize: Size(width, height),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)))),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: textPadding),
                                    child: Text(
                                      "sin",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: textFontSize - 5.sp),
                                    ),
                                  )),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: textPadding),
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (isEqualPressed) {
                                        isEqualPressed = false;
                                        current = "";
                                        result = "";
                                      }
                                      current += "cos(";
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          isPage2 ? background2 : allButtons,
                                      elevation: isPage2 ? 0 : 1,
                                      minimumSize: Size(width, height),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)))),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: textPadding),
                                    child: Text(
                                      "cos",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: textFontSize - 5.sp),
                                    ),
                                  )),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: textPadding),
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (isEqualPressed) {
                                        isEqualPressed = false;
                                        current = "";
                                        result = "";
                                      }
                                      current += 'tan(';
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          isPage2 ? background2 : allButtons,
                                      elevation: isPage2 ? 0 : 1,
                                      minimumSize: Size(width, height),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)))),
                                  child: Text(
                                    "tan",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textFontSize - 5.sp),
                                  )),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: textPadding),
                              child: ElevatedButton(
                                  onLongPress: () {
                                    setState(() {
                                      if (isEqualPressed) {
                                        current = "";
                                        result = "";
                                      }
                                      current += ')';
                                    });
                                  },
                                  onPressed: () {
                                    setState(() {
                                      if (isEqualPressed) {
                                        isEqualPressed = false;
                                        current = "";
                                        result = "";
                                      }
                                      current += '(';
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: mauve,
                                      minimumSize: Size(width, height),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)))),
                                  child: Text(
                                    "(",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textFontSize),
                                  )),
                            ),
                          ],
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 500.ms)
                          .scaleY(duration: 500.ms),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: textPadding),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (isEqualPressed) {
                                      isEqualPressed = false;
                                      current = "";
                                      result = "";
                                    }
                                    current += "7";
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        isPage2 ? background2 : allButtons,
                                    elevation: isPage2 ? 0 : 1,
                                    minimumSize: Size(width, height),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: textPadding),
                                  child: Text(
                                    "7",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textFontSize),
                                  ),
                                )),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: textPadding),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (isEqualPressed) {
                                      isEqualPressed = false;
                                      current = "";
                                      result = "";
                                    }
                                    current += '8';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        isPage2 ? background2 : allButtons,
                                    elevation: isPage2 ? 0 : 1,
                                    minimumSize: Size(width, height),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: textPadding),
                                  child: Text(
                                    "8",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textFontSize),
                                  ),
                                )),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: textPadding),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (isEqualPressed) {
                                      isEqualPressed = false;
                                      current = "";
                                      result = "";
                                    }
                                    current += '9';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        isPage2 ? background2 : allButtons,
                                    elevation: isPage2 ? 0 : 1,
                                    minimumSize: Size(width, height),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: textPadding),
                                  child: Text(
                                    "9",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textFontSize),
                                  ),
                                )),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: textPadding),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isEqualPressed = false;
                                    if (current != "") {
                                      current += '/';
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: mauve,
                                    minimumSize: Size(width, height),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: textPadding),
                                  child: Text(
                                    "/",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textFontSize),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: textPadding),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (isEqualPressed) {
                                      isEqualPressed = false;
                                      current = "";
                                      result = "";
                                    }
                                    current += "4";
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        isPage2 ? background2 : allButtons,
                                    elevation: isPage2 ? 0 : 1,
                                    minimumSize: Size(width, height),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: textPadding),
                                  child: Text(
                                    "4",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textFontSize),
                                  ),
                                )),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: textPadding),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (isEqualPressed) {
                                      isEqualPressed = false;
                                      current = "";
                                      result = "";
                                    }
                                    current += '5';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        isPage2 ? background2 : allButtons,
                                    elevation: isPage2 ? 0 : 1,
                                    minimumSize: Size(width, height),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: textPadding),
                                  child: Text(
                                    "5",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textFontSize),
                                  ),
                                )),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: textPadding),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (isEqualPressed) {
                                      isEqualPressed = false;
                                      current = "";
                                      result = "";
                                    }
                                    current += '6';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        isPage2 ? background2 : allButtons,
                                    elevation: isPage2 ? 0 : 1,
                                    minimumSize: Size(width, height),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: textPadding),
                                  child: Text(
                                    "6",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textFontSize),
                                  ),
                                )),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: textPadding),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (current != "") {
                                      isEqualPressed = false;

                                      current += '-';
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: mauve,
                                    minimumSize: Size(width, height),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: textPadding),
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textFontSize),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: textPadding),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (isEqualPressed) {
                                      isEqualPressed = false;
                                      current = "";
                                      result = "";
                                    }
                                    current += "1";
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        isPage2 ? background2 : allButtons,
                                    elevation: isPage2 ? 0 : 1,
                                    minimumSize: Size(width, height),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: textPadding),
                                  child: Text(
                                    "1",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textFontSize),
                                  ),
                                )),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: textPadding),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (isEqualPressed) {
                                      isEqualPressed = false;
                                      current = "";
                                      result = "";
                                    }
                                    current += '2';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        isPage2 ? background2 : allButtons,
                                    elevation: isPage2 ? 0 : 1,
                                    minimumSize: Size(width, height),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: textPadding),
                                  child: Text(
                                    "2",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textFontSize),
                                  ),
                                )),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: textPadding),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (isEqualPressed) {
                                      isEqualPressed = false;
                                      current = "";
                                      result = "";
                                    }
                                    current += '3';
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        isPage2 ? background2 : allButtons,
                                    elevation: isPage2 ? 0 : 1,
                                    minimumSize: Size(width, height),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: textPadding),
                                  child: Text(
                                    "3",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textFontSize),
                                  ),
                                )),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: textPadding),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (current != "") {
                                      current += '*';
                                      isEqualPressed = false;
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: mauve,
                                    minimumSize: Size(width, height),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: textPadding),
                                  child: Text(
                                    "*",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textFontSize),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: textPadding),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (isEqualPressed) {
                                      isEqualPressed = false;
                                      current = "";
                                      result = "";
                                    }
                                    if (current != "") current += "0";
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        isPage2 ? background2 : allButtons,
                                    elevation: isPage2 ? 0 : 1,
                                    minimumSize: Size(width, height),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: textPadding),
                                  child: Text(
                                    "0",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textFontSize),
                                  ),
                                )),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: textPadding),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (current !=
                                        "") if ((current[current.length - 1] !=
                                            '+') &&
                                        (current[current.length - 1] != '-') &&
                                        (current[current.length - 1] != '/') &&
                                        (current[current.length - 1] != '*')) {
                                      current += '.';
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        isPage2 ? background2 : allButtons,
                                    elevation: isPage2 ? 0 : 1,
                                    minimumSize: Size(width, height),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: textPadding),
                                  child: Text(
                                    ".",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textFontSize),
                                  ),
                                )),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: textPadding),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (current != "") {
                                      if (isExpressionValid(current)) {
                                        isEqualPressed = true;
                                        Expression exp = p.parse(current);
                                        ContextModel cm = ContextModel();
                                        double eval = exp.evaluate(
                                            EvaluationType.REAL, cm);
                                        result = eval.toString();
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                duration: 2000.ms,
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 25, 25, 50),
                                                content: Text(
                                                    "Expression is not valid",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize:
                                                            textFontSize))));
                                      }
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        isPage2 ? background2 : allButtons,
                                    elevation: isPage2 ? 0 : 1,
                                    minimumSize: Size(width, height),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: textPadding),
                                  child: Text(
                                    "=",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textFontSize),
                                  ),
                                )),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: textPadding),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (current != "") {
                                      current += '+';
                                      isEqualPressed = false;
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: mauve,
                                    minimumSize: Size(width, height),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: textPadding),
                                  child: Text(
                                    "+",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: textFontSize),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ).animate().scaleX(duration: 750.ms),
              ))
        ],
      ),
    );
  }
}
