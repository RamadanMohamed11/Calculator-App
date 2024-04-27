import 'dart:math';

import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:math_expressions/math_expressions.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  double iconPadding = 23.h;
  double fontSize = 25.sp;
  double textPadding = 20.h;
  bool isEqualPressed = false;
  double height = 190.h;
  double width = 65.w;
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
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      result,
                      style: TextStyle(
                          color: isEqualPressed ? Colors.white : Colors.white60,
                          fontSize: isEqualPressed == true ? 40.sp : 30.sp),
                    ),
                    Text(
                      current,
                      style: TextStyle(
                          color: isEqualPressed ? Colors.white60 : Colors.white,
                          fontSize: isEqualPressed ? 30.sp : 40.sp),
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(19.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.sp),
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      current = "";
                                      result = "";
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: firstRow,
                                      maximumSize: Size(width, height),
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
                                          fontSize: fontSize),
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
                                      height = 95.h;
                                      textPadding = 11.sp;
                                      iconPadding = 14.h;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              duration: 2000.ms,
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 25, 25, 50),
                                              content: Text(
                                                  "Long press on '(' to write ')' ",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: fontSize))));
                                    } else {
                                      iconPadding = 23.h;
                                      height = 190.h;
                                      fontSize = 25.sp;
                                      textPadding = 20.sp;
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: firstRow,
                                    maximumSize: Size(width, height),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: iconPadding),
                                  child: Container(
                                    child: isPressed
                                        ? Icon(
                                            Icons.move_down_rounded,
                                            color: Colors.white,
                                            size: fontSize,
                                          )
                                        : Icon(
                                            Icons.move_up_rounded,
                                            color: Colors.white,
                                            size: fontSize,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.sp),
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (isEqualPressed == false) {
                                        isEqualPressed = true;
                                        current += '%';
                                        Expression exp = p.parse(
                                            "${current.substring(0, current.length - 1)}/100");
                                        ContextModel cm = ContextModel();
                                        double eval = exp.evaluate(
                                            EvaluationType.REAL, cm);
                                        result = eval.toString();
                                        print(eval);
                                      }
                                    });
                                    current = result;
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: firstRow,
                                      maximumSize: Size(width, height),
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
                                          fontSize: fontSize),
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.sp),
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
                                      maximumSize: Size(width, height),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)))),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: iconPadding),
                                    child: Icon(
                                      Icons.backspace_outlined,
                                      color: Colors.white,
                                      size: fontSize,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: isPressed,
                        child: Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MaterialButton(
                                  padding: EdgeInsets.symmetric(
                                      vertical: textPadding),
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
                                  child: Padding(
                                    padding: EdgeInsets.all(textPadding),
                                    child: Text(
                                      "sin",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: fontSize),
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.sp),
                                child: MaterialButton(
                                    padding: EdgeInsets.symmetric(
                                        vertical: textPadding),
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
                                    child: Text(
                                      "cos",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: fontSize),
                                    )),
                              ),
                              MaterialButton(
                                  padding: EdgeInsets.symmetric(
                                      vertical: textPadding),
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
                                  child: Padding(
                                    padding: EdgeInsets.all(textPadding),
                                    child: Text(
                                      "tan",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: fontSize),
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.sp),
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
                                        maximumSize: Size(width, height),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)))),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: textPadding),
                                      child: Text(
                                        "(",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: fontSize),
                                      ),
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
                        padding: EdgeInsets.all(8.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
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
                                child: Padding(
                                  padding: EdgeInsets.all(textPadding),
                                  child: Text(
                                    "7",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontSize),
                                  ),
                                )),
                            MaterialButton(
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
                                child: Padding(
                                  padding: EdgeInsets.all(textPadding),
                                  child: Text(
                                    "8",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontSize),
                                  ),
                                )),
                            MaterialButton(
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
                                child: Padding(
                                  padding: EdgeInsets.all(textPadding),
                                  child: Text(
                                    "9",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontSize),
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.sp),
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
                                      maximumSize: Size(width, height),
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
                                          fontSize: fontSize),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
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
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: textPadding),
                                  child: Text(
                                    "4",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontSize),
                                  ),
                                )),
                            MaterialButton(
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
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: textPadding),
                                  child: Text(
                                    "5",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: fontSize),
                                  ),
                                )),
                            MaterialButton(
                                padding:
                                    EdgeInsets.symmetric(vertical: textPadding),
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
                                child: Text(
                                  "6",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: fontSize),
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.sp),
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
                                      maximumSize: Size(width, height),
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
                                          fontSize: fontSize),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                                padding:
                                    EdgeInsets.symmetric(vertical: textPadding),
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
                                child: Text(
                                  "1",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: fontSize),
                                )),
                            MaterialButton(
                                padding:
                                    EdgeInsets.symmetric(vertical: textPadding),
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
                                child: Text(
                                  "2",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: fontSize),
                                )),
                            MaterialButton(
                                padding:
                                    EdgeInsets.symmetric(vertical: textPadding),
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
                                child: Text(
                                  "3",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: fontSize),
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.sp),
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
                                      maximumSize: Size(width, height),
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
                                          fontSize: fontSize),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                                padding:
                                    EdgeInsets.symmetric(vertical: textPadding),
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
                                child: Text(
                                  "0",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: fontSize),
                                )),
                            MaterialButton(
                                padding:
                                    EdgeInsets.symmetric(vertical: textPadding),
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
                                child: Text(
                                  ".",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: fontSize),
                                )),
                            MaterialButton(
                                padding:
                                    EdgeInsets.symmetric(vertical: textPadding),
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
                                                        fontSize: fontSize))));
                                      }
                                    }
                                  });
                                },
                                child: Text(
                                  "=",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: fontSize),
                                )),
                            ElevatedButton(
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
                                    maximumSize: Size(width, height),
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
                                        fontSize: fontSize),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ).animate().scaleX(duration: 750.ms),
                ),
              ))
        ],
      ),
    );
  }
}
