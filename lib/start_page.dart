// ignore_for_file: prefer_const_constructors, file_names, use_build_context_synchronously

import 'dart:async';

import '/controller/get_all_data_pediction.dart';
import '/pay/need_pay.dart';
import 'childpage/child/main_child_page.dart';
import '/controller/shared_pref.dart';
import '/firstTimeOpenTheApp/page1.dart';
import '/view/Auth/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/check_internet.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  bool signOrLogIn = false;
  bool isverifyEmail = true;
  bool firstTimeOpenTheApp = true;
  bool needPay = false;
  @override
  void initState() {
    //  canGetData();
    getSetPayData().then((v) {
      if (!v) setPayData();
      else setPayData();
    });

    getFirstTimeOpenApp().then((v) {
      firstTimeOpenTheApp = v;
      getIsSignUpOrLogin().then((sign) {
        signOrLogIn = sign;

        /* if (isverifyEmail == false && signOrLogIn) {
          notverifyEmailYet();
        }*/
      });
    });
    Timer(
        Duration(seconds: 4),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => firstTimeOpenTheApp == true
                    ? Page1()
                    : signOrLogIn == false
                        ? const Login()
                        : MainChildPage(
                            index: 0,
                          ))));
    super.initState();
  }


  canGetData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int numb = pref.getInt("numb") ?? -1;
    internetConnection().then((value) async {
      if (value == true) {
        if (numb == -1 || numb == 1) {
          setDataPredictionWordsAndImage();
          setDataHarakatWords();
          setModonaSentence();
          pref.setInt("numb", 0);
        } else {
          pref.setInt("numb", numb + 1);
        }
      }
    });
  }

  getFirstTimeOpenApp() async {
    SharedPreferences firstTimeOpenApp = await SharedPreferences.getInstance();
    return firstTimeOpenApp.getBool("firstTimeOpenApp") ?? true;
  }

  getSetPayData() async {
    SharedPreferences setPayData = await SharedPreferences.getInstance();
    return setPayData.getBool("isSetPayData") ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Image.asset("assets/uiImages/first.gif")));
  }
}
