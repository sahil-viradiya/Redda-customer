

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class WalletScreen extends StatefulWidget {
//   final String? status;
//   const WalletScreen({Key? key, this.status}) : super(key: key);

//   @override
//   State<WalletScreen> createState() => _WalletScreenState();
// }

// class _WalletScreenState extends State<WalletScreen> {
//   Rx<TextEditingController> amountController = new TextEditingController().obs;
//   RxString amount = "0".obs;
//   List<String> amountList = [
//     "1000.00",
//     "2000.00",
//     "3000.00",
//   ];
//   var firebaseDatabase = FirebaseDatabase.instance.ref();
//   RxBool hasData = false.obs;
//   late Razorpay _razorpay;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
//     getUserWallet();
//   }

//   void handlePaymentErrorResponse(PaymentFailureResponse response) {
//     /*
//     * PaymentFailureResponse contains three values:
//     * 1. Error Code
//     * 2. Error Description
//     * 3. Metadata
//     * */
//     print("Error");
//     print(response.code);
//     DioExceptions.showErrorMessage  (context,'Payment Failed - ${response.message}');

//     // showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
//   }

//   // void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
//   //   /*
//   //   * Payment Success Response contains three values:
//   //   * 1. Order ID
//   //   * 2. Payment ID
//   //   * 3. Signature
//   //   * */
//   //   print("Success");
//   //   print(response.orderId);
//   //   firebaseDatabase.child('Users').child(utils.getUserId()).update({
//   //     'userWallet': (double.parse(amountController.value.text.toString()) +
//   //             double.parse(Common.wallet.value))
//   //         .toString()
//   //   }).whenComplete(() {
//   //     Common.userModel.userWallet = amountController.value.text.toString();
//   //     Common.wallet.value =
//   //         (double.parse(amountController.value.text.toString()) +
//   //                 double.parse(Common.wallet.value))
//   //             .toString();

//   //     Map<String, dynamic> orderData = {
//   //       "paymentId": response.paymentId,
//   //       "orderId": response.orderId,
//   //       "signatureId": response.signature,
//   //       "amountAdded": amountController.value.text.toString(),
//   //       "uid": Common.userModel.uid,
//   //       "timeAdded": DateTime.now().millisecondsSinceEpoch.toString(),
//   //     };
//   //     firebaseDatabase
//   //         .child('WalletHistory')
//   //         .push()
//   //         .set(orderData)
//   //         .then((snapShot) {
//   //       utils.showToast('Your wallet has Updated');
//   //     });
//   //   });
//   //   // showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
//   // }

//   // void handleExternalWalletSelected(ExternalWalletResponse response) {
//   //   print("external value");
//   //   print(response.walletName);
//   //   // showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
//   // }

//   // Future getUserWallet() async {
//   //   amount.value = amountList[0];
//   //   amountController.value.text = amountList[0];
//   //   firebaseDatabase
//   //       .child("Users")
//   //       .child(utils.getUserId().toString())
//   //       .get()
//   //       .then((value) {
//   //     if (value.value != null) {
//   //       Map<dynamic, dynamic> mapDatavalue = Map.from(value.value as Map);
//   //       amount.value = amountController.value.text.isEmpty
//   //           ? "0"
//   //           : amountController.value.text;
//   //       Common.wallet.value = mapDatavalue['userWallet'];
//   //       print(mapDatavalue);
//   //     }
//   //   });
//   //   hasData.value = true;
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
     
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 15.0, vertical: 20.0),
//                 margin: const EdgeInsets.symmetric(horizontal: 15.0),
//                 decoration: utils.boxDecoration(
//                     Colors.white, Colors.transparent, 15.0, 0.0,
//                     isShadow: true, shadowColor: grey),
//                 child: Column(
//                   children: [
//                     hasData.value == true
//                         ? Obx(
//                             () => Row(
//                               children: [
//                                 Expanded(
//                                     child: utils.poppinsSemiBoldText(
//                                         "walletBalance".tr,
//                                         18.0,
//                                       black,
//                                         TextAlign.start)),
//                                 utils.poppinsSemiBoldText(
//                                     "${Common.currency} ${num.parse(Common.wallet.value).toStringAsFixed(2)}",
//                                     18.0,
//                                    black,
//                                     TextAlign.end)
//                               ],
//                             ),
//                           )
//                         : CupertinoActivityIndicator()
//                     // Row(
//                     //   children: [
//                     //     Expanded(child: utils.poppinsRegularText("tomorrowValue".tr, 14.0, AppColors.blackColor, TextAlign.start)),
//                     //     utils.poppinsRegularText("${Common.currency} 88.00", 14.0, AppColors.blackColor, TextAlign.end)
//                     //   ],
//                     // ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Container(
//                 width: Get.size.width,
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 15.0, vertical: 20.0),
//                 margin: const EdgeInsets.symmetric(horizontal: 15.0),
//                 decoration: utils.boxDecoration(
//                     Colors.white, Colors.transparent, 15.0, 0.0,
//                     isShadow: true, shadowColor: grey),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     utils.poppinsRegularText("enterAmount".tr, 14.0,
//                         black, TextAlign.start),
//                     Obx(
//                       () => TextFormField(
//                         controller: amountController.value,
//                         decoration: const InputDecoration(
//                             border: UnderlineInputBorder()),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "enterAmountToPay".tr;
//                           }
//                           return null;
//                         },
//                         onChanged: (value) {
//                           amount.value = value.isEmpty ? "0" : value;
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     chooseAmountWidget(),
//                     const SizedBox(height: 20),
//                     utils.poppinsRegularText("rechargeAmount".tr, 14.0,
//                         grey, TextAlign.start),
//                     Obx(
//                       () => InkWell(
//                         onTap: double.parse(amount.value) < 1
//                             ? null
//                             : () {
//                                 var options = {
//                                   'key': 'rzp_live_ILgsfZCZoFIKMb',
//                                   // 'key': 'rzp_test_PENDeiNbw1WXUl',
//                                   'amount': double.parse(amountController
//                                           .value.text
//                                           .toString()) *
//                                       100,
//                                   'name': 'Trupressed',
//                                   'description': 'Add to Wallet',
//                                   'retry': {'enabled': true, 'max_count': 1},
//                                   'send_sms_hash': true,
//                                   'prefill': {
//                                     'contact':
//                                         '9725558828' ?? "",
//                                     'email': 'sahil@gmail.com' "",
//                                   },
//                                   'external': {
//                                     'wallets': ['paytm']
//                                   }
//                                 };
//                                 _razorpay.open(options);
//                               },
//                         child: Container(
//                           height: 45,
//                           margin: const EdgeInsets.only(top: 20),
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           decoration: BoxDecoration(
//                             color: (double.parse(amount.value) < 1)
//                                 ? grey
//                                 : primary,
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(30.0)),
//                           ),
//                           child: Center(
//                               child: utils.poppinsMediumText('pay'.tr, 16.0,
//                                   white, TextAlign.center)),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               InkWell(
//                 onTap: () {
//                   // Get.to(() => const WalletTransactionHistory());
//                   //showLogoutDialog();
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 15.0, vertical: 20.0),
//                   margin: const EdgeInsets.symmetric(horizontal: 15.0),
//                   decoration: utils.boxDecoration(
//                       Colors.white, Colors.transparent, 15.0, 0.0,
//                       isShadow: true, shadowColor: grey),
//                   child: Column(
//                     children: [
//                       Center(
//                           child: utils.poppinsSemiBoldText(
//                               "walletTransactions".tr,
//                               18.0,
//                               black,
//                               TextAlign.start)),
//                       // Row(
//                       //   children: [
//                       //     Expanded(child: utils.poppinsRegularText("tomorrowValue".tr, 14.0, AppColors.blackColor, TextAlign.start)),
//                       //     utils.poppinsRegularText("${Common.currency} 88.00", 14.0, AppColors.blackColor, TextAlign.end)
//                       //   ],
//                       // ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget chooseAmountWidget() {
//     return Obx(() {
//       return Wrap(
//         spacing: 10.0,
//         runSpacing: 10.0,
//         alignment: WrapAlignment.start,
//         crossAxisAlignment: WrapCrossAlignment.start,
//         runAlignment: WrapAlignment.start,
//         children: [
//           for (int i = 0; i < amountList.length; i++)
//             InkWell(
//               onTap: () async {
//                 amount.value = amountList[i];
//                 amountController.value.text = amountList[i];
//               },
//               hoverColor: Colors.transparent,
//               child: IntrinsicWidth(
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
//                   decoration: utils.boxDecoration(
//                       white,
//                       amount.value == amountList[i]
//                           ? primary
//                           : grey,
//                       20.0,
//                       1.0),
//                   child: Center(
//                       child: utils.poppinsRegularText(
//                           "${Common.currency} ${amountList[i]}",
//                           16.0,
//                           amount.value == amountList[i]
//                               ? primary
//                               : black,
//                           TextAlign.center)),
//                 ),
//               ),
//             ),
//         ],
//       );
//     });
//   }
// }
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title="razor pay";

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the Wallet object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Pay with Razorpay',
            ),
            ElevatedButton(onPressed: (){
                  Razorpay razorpay = Razorpay();
                  var options = {
                    'key': 'rzp_test_GcZZFDPP0jHtC4',
                    'amount': 100,
                    'name': 'Acme Corp.',
                    'description': 'Fine T-Shirt',
                    'retry': {'enabled': true, 'max_count': 1},
                    'send_sms_hash': true,
                    'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
                    'external': {
                      'wallets': ['paytm']
                    }
                  };
                  razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                  razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
                  razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
                  razorpay.open(options);
                },
                child: const Text("Pay with Razorpay")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response){
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response){
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showAlertDialog(context, "Payment Successful", "Payment ID: ${response.data}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response){
    showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message){
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed:  () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}