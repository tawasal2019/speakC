/*import 'dart:async';
//import 'package:email_auth/utils/constants/firebase_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';*/
import 'dart:async';

import 'package:arabicchildandroid/view/Auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../childpage/child/main_child_page.dart';
import '../../controller/var.dart';


class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isEmailVerified = false;
  int _remainingSeconds = 0;
  Timer? _timer;
  bool reSead=false;
  bool _isButtonDisabled = true;
  bool  isSend = false;
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    _remainingSeconds = 59;
    _startTimer();
    super.initState();
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MainChildPage(
            index: 0,
          ),
        ),
      );

      /* ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Email Successfully Verified")));*/

      timer?.cancel();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          setState(() {
            // reSead=true;
            _isButtonDisabled = false;

          });
          _timer?.cancel();
        }
      });
    });
  }
  void _onButtonClick() {

    setState(() {
      _isButtonDisabled = true;
    });
    FirebaseAuth.instance.currentUser
        ?.sendEmailVerification();
    setState(() {
      isSend = true;
    });
    Future.delayed(const Duration(milliseconds: 3850))
        .then((value) {
      setState(() {
        isSend = false;
      });
    });

    Timer(const Duration(seconds: 10), () {
      setState(() {
        _isButtonDisabled = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: const Center(child: Text('التحقق من الايميل')),
      content: SizedBox(
        height: 110,
        child: Column(

          children: [
            const Text(
              'لقد قمنا بارسال رابط التفعيل على بريدك الالكتروني  ',
              textAlign: TextAlign.center,
            ),
            Text(
              ' ${FirebaseAuth.instance.currentUser!.email} ',
              textAlign: TextAlign.center,
            ),

            const Padding(
              padding:  EdgeInsets.only(top: 20.0),
              child:  Text(
                  'إذا لم يصلك رابط التفعيل خلال '
              ),
            ),
            Text(
              _remainingSeconds.toString(),
              style: const TextStyle(fontSize: 40),
            ),
          ],
        ),
      ),

      actions: <Widget>[
        Column(
          children: [
            GestureDetector(

              onTap: _isButtonDisabled ? null : _onButtonClick,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: _isButtonDisabled ? Colors.grey :  pinkColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child:
                // reSead==true?const
                Text(
                  'إعادة ارسال',
                  style: TextStyle(color:_isButtonDisabled ?  Colors.black:Colors.white),
                ),//:Container(),

              ),
            ),
            const SizedBox(height: 2,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:  pinkColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11)),
              ),
              onPressed: () async {
                Navigator.pop(context);

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                        (route) => false);

              },
              child: const Center(
                  child:  Text("موافق",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ))),
            ),

          ],
        )
      ],
    );


  }
}