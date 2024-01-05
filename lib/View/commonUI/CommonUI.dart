import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nil/nil.dart';

Widget HeadlineWithBack(BuildContext context, String headlinestring, {isHideBackBtn = false}) {
  double icronWidth = 60;

  return SafeArea(
      bottom: false,
      child: Container(
        color: Color.fromRGBO(245, 245, 244, 1),
        alignment: Alignment.center,
        height: 65,
        padding: EdgeInsets.only(left: 0, top: 5, right: 0, bottom: 0),
        child: Container(
          color: Color.fromRGBO(245, 245, 244, 1),
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: icronWidth,
                height: icronWidth,
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(icronWidth),
                    onTap: () {
                      Navigator.of(context).maybePop();
                    },
                    child: SizedBox(
                      width: icronWidth,
                      height: icronWidth,
                      child: Center(
                        child: !isHideBackBtn ? nil : Image.asset(
                          "assets/blue arrow.png",
                          fit: BoxFit.contain,
                          width: 33,
                          height: 33,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width - icronWidth,
                padding: EdgeInsets.only(
                    left: 0, top: 0, right: icronWidth, bottom: 0),
                child: Text(headlinestring,
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        fontSize: 22,
                        color: Color.fromRGBO(34, 30, 31, 1)),
                    maxLines: 1,
                    textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ));
}

