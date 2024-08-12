import '../childpage/child/main_child_page.dart';
import '/pay/device_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unicode_moyasar/unicode_moyasar.dart';
import '../controller/check_internet.dart';

class PaymentViewScreen extends StatefulWidget {
  final double amount;
  const PaymentViewScreen({Key? key, required this.amount}) : super(key: key);

  @override
  State<PaymentViewScreen> createState() => _PaymentViewScreenState();
}

class _PaymentViewScreenState extends State<PaymentViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: const Text(
            "الدفع",
            style: TextStyle(
                color: Colors.white, fontSize: 23, fontWeight: FontWeight.w500),
          ),
          backgroundColor: const Color.fromARGB(255, 20, 20, 20),
          shape: const Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          )),
      body: MoyasarPayment(
        moyasarPaymentData: MoyasarPaymentData(
          appName: "تطبيق تحدث",
          secretKey: //  "sk_test_rb9t7aUSFB9qLWsKoGRgm48mavCthrqa1A11jeVN",
              "sk_live_t25FRpFc8VJge19EXuxyaPFPMrHSQhfNLEPD6Gyx",
          publishableSecretKey:
              //     "pk_test_o2hGGCfRdscvmesVgcuRpgGUUwUA2c1A7f5TuPSB",
              "pk_live_5HcCv9pGLqGGttnHj95LrTntgqphFMmn2Fop35dk",
          purchaseAmount: widget.amount,
          locale: PaymentLocale.ar,
          paymentEnvironment: PaymentEnvironment.live,
          paymentOptions: [PaymentOption.card, PaymentOption.applepay],
        ),
        onPaymentSucess: (response) async {
          internetConnection().then((value) {
            if (value) {
              initPlatformState().then((value) {
                try {
                  FirebaseFirestore.instance
                      .collection("payChildApp")
                      .doc("mi63rhuIAw1hKJDnLNwx")
                      .set({
                    "${value[0]}${value[1]}":
                        DateTime.now().add(const Duration(days: 365))
                  }, SetOptions(merge: true));
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const MainChildPage(
                        index: 0,
                      ),
                    ),
                  );
                } catch (_) {}
              });
            }
          });
        },
        onPaymentFailed: (response) {
          debugPrint("Failed ------> ${response.toMap()}");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const FailPage(),
            ),
          );
        },
      ),
    );
  }
}

class FailPage extends StatelessWidget {
  const FailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fail"),
      ),
      body: const Center(
        child: Text("Payment fail"),
      ),
    );
  }
}
