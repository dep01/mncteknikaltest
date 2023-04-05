// import 'dart:convert';

// import 'package:customer/app/locator.dart';
// import 'package:customer/app/routes.gr.dart';
// import 'package:customer/components/alert_component.dart';
// import 'package:customer/components/loading_components.dart';
// import 'package:customer/models/PpobModel.dart';
// import 'package:customer/providers/ppob.dart';
// import 'package:customer/providers/profile.dart';
// import 'package:customer/utils/constant.dart';
// import 'package:customer/utils/indonesia.dart';
// import 'package:customer/utils/session.dart';
// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
// import 'package:stacked_services/stacked_services.dart';
// import 'package:toast/toast.dart';

// class SoPPOBViewModel extends BaseViewModel {
//   final ppobService = new PpobService();
//   NavigationService nav = locator<NavigationService>();
//   final cartGlobalKey = new GlobalKey<ScaffoldState>();
//   List<PulsaModel> pulsaData;
//   List<PulsaModel> pulsa = [];
//   bool allowPostpaid = false;
//   PulsaModel pulsaSelected;
//   PdamBilingModel pdamBilingModel;
//   List provider = [];
//   String paymentType = 'PREPAID';
//   final alerts = new AlertComponents();
//   String providerSelected;
//   final phoneController = new TextEditingController();
//   final pdamController = new TextEditingController();
//   String iconUrl;
//   final ppobmenu = [
//     {"name": "Pulsa", "icon": Resources.ic_pulsa},
//     {"name": "Paket Data", "icon": Resources.ic_paket},
//     {"name": "Air", "icon": Resources.ic_pam},
//     {"name": "Listrik", "icon": Resources.ic_pln},
//     // {"name": "BPJS", "icon": Resources.ic_bpjs},
//   ];
//   List pdamSector;
//   List pdamSectorFilter;
//   List filterPdamSector;
//   String activemenu = "Pulsa";
//   int plnProduct = 1;
//   int bpjsPayment = 1;
//   String pamSectorSelected;
//   final globalKey = new GlobalKey<ScaffoldState>();
//   bool init = true;
//   var userData = jsonDecode(sessions.load('user'));
//   final loadings = LoadingComponents();
//   Future getPdamSector() async {
//     init = true;
//     final result = await ppobService.getPdamSector();
//     pdamSector = result;
//     pdamSectorFilter = result;
//     pamSectorSelected = pdamSector[0];
//     init = false;
//     notifyListeners();
//   }

//   Future getPulsaData() async {
//     final result = await ppobService.getPulsaData();
//     pulsaData = result
//         .where((pulsa) =>
//             pulsa.pulsaOp != "ORANGE TV" &&
//             pulsa.pulsaOp != "Ceria" &&
//             pulsa.pulsaOp != "Xixi Games")
//         .toList();
//     // phoneController.text = formatPhoneNumber(userData['phone']);
//     phoneController.text = formatPhoneNumber(userData['phone']);
//     providerSelected = parseOperator(formatPhoneNumber(userData['phone']));
//     if (pulsaData.length > 0 && providerSelected != null) {
//       populatePulsa();
//     }
//   }

//   Future populatePulsa() async {
//     provider = [];
//     pulsa = [];
//     pulsaData.map((e) => provider.add(e.pulsaOp)).toList();
//     provider = provider.toSet().toList();
//     // providerSelected = provider[0];
//     pulsaData
//         .map((e) => {
//               if (e.pulsaOp.toLowerCase().contains(providerSelected))
//                 {
//                   pulsa.add(e),
//                   if (e.iconUrl != "-") {iconUrl = e.iconUrl}
//                 }
//             })
//         .toList();
//   }

//   Future getPaketData() async {
//     final result = await ppobService.getPaketData();
//     pulsaData = result;
//     // phoneController.text = formatPhoneNumber(userData['phone']);
//     providerSelected =
//         parseOperator(formatPhoneNumber(userData['phone']), "Paket Data");
//     phoneController.text = formatPhoneNumber(userData['phone']);
//     if (pulsaData.length > 0 && providerSelected != null) {
//       populatePaketData();
//     }
//   }

//   Future populatePaketData() async {
//     print(providerSelected);
//     provider = [];
//     pulsa = [];
//     pulsaData.map((e) => provider.add(e.pulsaOp)).toList();
//     provider = provider.toSet().toList();

//     pulsaData
//         .map((e) => {
//               if (e.pulsaOp.toLowerCase().contains(providerSelected))
//                 {
//                   pulsa.add(e),
//                   if (e.iconUrl != "-") {iconUrl = e.iconUrl}
//                 }
//             })
//         .toList();
//   }

//   Future getPlnData() async {
//     final result = await ppobService.getPlnData();
//     pulsaData = result;
//     if (pulsaData.length > 0) {
//       provider = [];
//       pulsa = [];
//       pulsaData.map((e) => provider.add(e.pulsaOp)).toList();
//       provider = provider.toSet().toList();
//       providerSelected = provider[0];
//       pulsaData
//           .map((e) => {
//                 if (e.pulsaOp == providerSelected)
//                   {
//                     pulsa.add(e),
//                     if (e.iconUrl != "-") {iconUrl = e.iconUrl}
//                   }
//               })
//           .toList();
//     }
//   }

//   Future initialize() async {
//     await getPulsaData();
//     init = false;
//     notifyListeners();
//   }

//   Future initializePayment() async {
//     bool isPostPaid = sessions.load('isPostPaid').toLowerCase() == 'true';
//     if (isPostPaid == true) {
//       allowPostpaid = true;
//       paymentType = 'POSTPAID';
//     }
//     init = false;
//     notifyListeners();
//   }

//   Future changeActivemenu(String name) async {
//     activemenu = name;
//     init = true;
//     phoneController.clear();
//     pdamController.clear();
//     pulsaSelected = null;
//     iconUrl = "";
//     notifyListeners();
//     switch (name) {
//       case 'Pulsa':
//         await getPulsaData();
//         break;
//       case 'Paket Data':
//         await getPaketData();
//         break;
//       case 'Air':
//         await getPdamSector();
//         break;
//       case 'Listrik':
//         await getPlnData();
//         break;
//       default:
//     }
//     init = false;
//     notifyListeners();
//   }

//   void changePlnProduct(int val) {
//     plnProduct = val;
//     notifyListeners();
//   }

//   void changePhone(String phone) {
//     if (activemenu != "Listrik") {
//       if (phone.length >= 4) {
//         providerSelected = parseOperator(formatPhoneNumber(phone), activemenu);
//         if (pulsaData.length > 0 && providerSelected != null) {
//           if (activemenu == "Pulsa") {
//             populatePulsa();
//           } else if (activemenu == "Paket Data") {
//             populatePaketData();
//           }
//         }
//       } else {
//         providerSelected = null;
//       }
//     }
//     phoneController.text = phone;
//     notifyListeners();
//   }

//   String parseOperator(String phone, [String type = "Pulsa"]) {
//     Map<String, dynamic> operatorPrefix = {
//       "telkomsel": [
//         "0812",
//         "0813",
//         "0821",
//         "0822",
//         "0852",
//         "0853",
//         "0823",
//         "0851"
//       ],
//       "indosat": ["0814", "0815", "0816", "0855", "0856", "0857", "0858"],
//       "smart": [
//         "0881",
//         "0882",
//         "0883",
//         "0884",
//         "0885",
//         "0886",
//         "0887",
//         "0888",
//         "0889"
//       ],
//       "xl": ["0817", "0818", "0819", "0859", "0877", "0878"],
//       "axis": ["0838", "0831", "0832", "0833"]
//     };

//     if (type == "Pulsa") {
//       operatorPrefix["three"] = ["0895", "0896", "0897", "0898", "0899"];
//     } else if (type == "Paket Data") {
//       operatorPrefix["tri"] = ["0895", "0896", "0897", "0898", "0899"];
//     }

//     print(operatorPrefix);

//     // Map<String, dynamic> res = {"operator": null};
//     String res;

//     operatorPrefix.forEach((k, v) {
//       List<String> _operator = operatorPrefix[k];
//       String prefix = _operator.firstWhere((val) => phone.startsWith(val),
//           orElse: () => "");

//       if (prefix.isNotEmpty) {
//         // res = {"operator": k, "prefix": prefix, "phone": phone};
//         res = k;
//       }
//     });

//     return res;
//   }

//   void changePamSector(context, String val) {
//     pamSectorSelected = val;
//     if (pdamController.text != '') {
//       checkPdamBilling(context);
//     }
//     print(pamSectorSelected);
//     notifyListeners();
//   }

//   void changeBpjsPayment(int val) {
//     bpjsPayment = val;
//     notifyListeners();
//   }

//   filterData([String filter = ""]) {
//     pdamSectorFilter = pdamSector;
//     if (filter.isNotEmpty) {
//       pdamSectorFilter = pdamSectorFilter
//           .where((z) => z.toString().toLowerCase().contains(filter))
//           .toList();
//     }
//     notifyListeners();
//   }

//   Future refreshListItem() async {
//     pulsa = [];
//     pulsaData
//         .map((e) => {
//               if (e.pulsaOp == providerSelected)
//                 {
//                   pulsa.add(e),
//                   if (e.iconUrl != "-") {iconUrl = e.iconUrl}
//                 }
//             })
//         .toList();
//   }

//   Future changeProvider(String val) async {
//     init = true;
//     providerSelected = val;
//     await refreshListItem();
//     pulsaSelected = null;
//     init = false;
//     notifyListeners();
//   }

//   void changePulsaSelected(PulsaModel item) {
//     pulsaSelected = item;
//     notifyListeners();
//   }

//   Future checkPdamBilling(context) async {
//     init = true;
//     notifyListeners();
//     Object data = {"hp": pdamController.text, "kota": "PDAMKOTA.SURABAYA"};
//     final result = await ppobService.checkPdamBilling(data);
//     if (result['response_code'] != "00") {
//       alerts.alertIcon(context, result["message"], Icons.cancel_outlined);
//       pdamBilingModel = null;
//     } else {
//       pdamBilingModel = pdamBilingModelFromMap(jsonEncode(result['data']));
//     }
//     init = false;
//     notifyListeners();
//   }

//   void payment(context) async {
//     if (activemenu == "Pulsa" ||
//         activemenu == "Paket Data" ||
//         activemenu == "Listrik") {
//       if (pulsaSelected == null) {
//         alerts.alertIcon(
//             context, "Tidak ada item yang dipilih", Icons.cancel_outlined);
//       } else if (phoneController.text == null || phoneController.text == '') {
//         alerts.alertIcon(
//             context, "Nomor tidak boleh kosong", Icons.cancel_outlined);
//       } else {
//         var a = await nav.navigateTo(Routes.ppobPayment,
//             arguments: PpobPaymentArguments(
//                 type: activemenu,
//                 phone: phoneController.text,
//                 item: pulsaSelected));
//         print(a);
//         if (a != null) {
//           activemenu = "Pulsa";
//           initialize();
//           notifyListeners();
//         }
//       }
//     } else {
//       if (pdamBilingModel == null) {
//         alerts.alertIcon(
//             context, "Tidak ada yang dibayar", Icons.cancel_outlined);
//       } else {
//         var a = await nav.navigateTo(Routes.ppobPayment,
//             arguments: PpobPaymentArguments(
//                 type: activemenu,
//                 phone: pdamController.text,
//                 pdamBilingModel: pdamBilingModel));
//         print(a);

//         if (a != null) {
//           activemenu = "Pulsa";

//           initialize();
//           notifyListeners();
//         }
//       }
//     }
//   }

//   void changePaymentType(String code) {
//     paymentType = code;
//     notifyListeners();
//   }

//   void submit(context, [String paymentTypes = "NONPREPAID"]) async {
//     init = true;
//     notifyListeners();
//     Object data;
//     String endPoint;
//     final ppobService = new PpobService();
//     try {
//       var session = sessions.load('user');
//       if (session != null) {
//         if (paymentTypes == "PREPAID") {
//           if (activemenu == "Air") {
//             endPoint = "payment/pdam";
//             data = {
//               "tr_id": pdamBilingModel.trId.toString(),
//               "price": pdamBilingModel.price,
//               "payment_type": "Prepaid"
//             };
//           } else {
//             endPoint = "topup";
//             data = {
//               "hp": phoneController.text,
//               "pulsa_code": pulsaSelected.pulsaCode,
//               "type": pulsaSelected.pulsaType,
//               "payment_type": "Prepaid"
//             };
//           }
//           final result = await ppobService.paymentMidtrans(data, endPoint);
//           if (result != null) {
//             final res = await nav.navigateTo(Routes.midtrans,
//                 arguments: MidtransArguments(orderWithintId: result));
//             if (res == true) {
//               nav.popRepeated(1);
//             }
//           } else {
//             Toast.show("Terjadi kesalahan koneksi", context,
//                 duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//           }
//         } else {
//           if (activemenu == "Air") {
//             endPoint = "payment/pdam";
//             data = {
//               "tr_id": pdamBilingModel.trId.toString(),
//               "price": pdamBilingModel.price,
//               "payment_type": "Postpaid"
//             };
//           } else {
//             endPoint = "topup";
//             data = {
//               "hp": phoneController.text,
//               "pulsa_code": pulsaSelected.pulsaCode,
//               "type": pulsaSelected.pulsaType,
//               "payment_type": "Postpaid"
//             };
//           }
//           final res = await ppobService.payment(data, endPoint);
//           if (res['statusCode'] == 200) {
//             nav.back(result: true);

//             alerts.alertColumnAction(context,
//                 title: "Terima Kasih",
//                 alert: "Mohon ditunggu pesanannya",
//                 image: Resources.ic_checked,
//                 iconColor: Colors.orange,
//                 action: [
//                   SizedBox(
//                     width: double.infinity,
//                     child: RaisedButton(
//                       onPressed: () async {
//                         nav.popUntil((route) => route.isFirst);
//                         nav.navigateTo(Routes.orderDetail,
//                             arguments: OrderDetailArguments(
//                                 defaultTypeOrder: "booking",
//                                 transId: int.tryParse(res['data']['id'])));
//                       },
//                       disabledTextColor: Colors.black45,
//                       color: Colors.greenAccent[400],
//                       child: Text(
//                         'Cek Order',
//                         style: TextStyle(fontSize: 16, color: Colors.white),
//                         textAlign: TextAlign.center,
//                       ),
//                       elevation: 0,
//                       highlightElevation: 0,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 12.0,
//                   ),
//                   SizedBox(
//                     width: double.infinity,
//                     child: RaisedButton(
//                       onPressed: () {
//                         nav.back(result: true);
//                       },
//                       disabledTextColor: Colors.black45,
//                       color: Color.fromARGB(255, 0, 117, 207),
//                       child: Text(
//                         'Order lagi',
//                         style: TextStyle(fontSize: 16, color: Colors.white),
//                         textAlign: TextAlign.center,
//                       ),
//                       elevation: 0,
//                       highlightElevation: 0,
//                     ),
//                   )
//                 ]);
//           } else {
//             alerts.alertIcon(context, res["message"], Icons.cancel_outlined);
//           }
//         }
//         notifyListeners();
//       }
//       init = false;
//     } catch (e) {
//       final message = e.toString().split(': ');
//       Toast.show(message.last, context,
//           duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//       init = false;
//     }
//     notifyListeners();
//   }

//   void checkPaymentMethode(context) async {
//     init = true;
//     notifyListeners();
//     final _profileProvider = new ProfileProvider();
//     try {
//       final result = await _profileProvider.getProfile();
//       if (result == null) nav.replaceWith(Routes.login);
//       if (result.name == null ||
//           result.email == null ||
//           result.customer.name == null ||
//           result.customer.phone == null ||
//           result.customer.address == null) {
//         nav.popUntil((route) => route.isFirst);
//         nav.navigateTo(Routes.home, arguments: HomeArguments(indexPage: 3));
//         // initializeData();
//       } else {
//         switch (paymentType) {
//           case "CASH":
//             alerts.alertAction(context,
//                 title: "Konfirmasi",
//                 alert: "Ingin coba bayar dengan LinkAja yang lebih instan?",
//                 onCancelText: "tidak",
//                 onCancel: () async {
//                   nav.back();
//                   submit(context);
//                 },
//                 onOk: () => nav.back(),
//                 onOkText: "ya");
//             break;
//           case "POSTPAID":
//             alerts.alertAction(context,
//                 title: "Konfirmasi",
//                 alert: "Anda yakin jadikan tagihan?",
//                 onCancelText: "tidak", onOk: () async {
//               nav.back();
//               submit(context);
//             }, onCancel: () {
//               init = false;
//               notifyListeners();

//               nav.back();
//             }, onOkText: "Masuk\nTagihan");
//             break;
//           case "PREPAID":
//             submit(context, "PREPAID");
//             // alerts.alertAction(context,
//             //     title: "Konfirmasi",
//             //     alert: "Pembayaran gagal",
//             //     onCancelText: "tidak", onCancel: () async {
//             //   nav.back();
//             // }, onOk: () {
//             //   nav.back();
//             //   alerts.alertColumnAction(context,
//             //     title: "Mohon Maaf",
//             //     alert: "Pembayaran dibatalkan",
//             //     image: Resources.ic_smile,
//             //     iconColor: Colors.orange,
//             //     action: [
//             //       SizedBox(
//             //         width: double.infinity,
//             //         child: RaisedButton(
//             //           onPressed: () async {
//             //             nav.popUntil((route) => route.isFirst);
//             //           },
//             //           disabledTextColor: Colors.black45,
//             //           color: Colors.greenAccent[400],
//             //           child: Text(
//             //             'Kembali ke Menu',
//             //             style: TextStyle(fontSize: 16, color: Colors.white),
//             //             textAlign: TextAlign.center,
//             //           ),
//             //           elevation: 0,
//             //           highlightElevation: 0,
//             //         ),
//             //       ),
//             //     ]);
//             // }, onOkText: "Ya");
//             break;
//           default:
//             alerts.alertIcon(context, "Pilih metode pembayaran terlebih dahulu",
//                 Icons.cancel);
//         }
//       }
//     } catch (e) {
//       // JUST LEAVE IT EMPTY
//     }
//   }
// }
