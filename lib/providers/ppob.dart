// import 'dart:convert';

// import 'package:customer/models/PpobModel.dart';
// import 'package:customer/models/TrxModel.dart';
// import 'package:customer/models/TrxModelintId.dart';
// import 'package:customer/utils/api_client.dart';

// class PpobService {
//   Future<List<PulsaModel>> getPulsaData() async {
//     String endPoint = "pricelist/pulsa";
//     var response = await client.getData(endPoint: endPoint);
//     var res = jsonDecode(response.body);
//     return pulsaModelFromMap(jsonEncode(res['data']));
//   }

//   Future<List<PulsaModel>> getPaketData() async {
//     String endPoint = "pricelist/data";
//     var response = await client.getData(endPoint: endPoint);
//     var res = jsonDecode(response.body);
//     return pulsaModelFromMap(jsonEncode(res['data']));
//   }

//   Future<List<PulsaModel>> getPlnData() async {
//     String endPoint = "pricelist/pln";
//     var response = await client.getData(endPoint: endPoint);
//     var res = jsonDecode(response.body);
//     return pulsaModelFromMap(jsonEncode(res['data']));
//   }

//   Future<List> getPdamSector() async {
//     String endPoint = "kota/pdam";
//     var response = await client.getData(endPoint: endPoint);
//     List res = jsonDecode(response.body);
//     return res;
//   }

//   Future checkPdamBilling(Object data) async {
//     String endPoint = "checkbill/pdam";
//     var response = await client.postData(endPoint: endPoint, body: data);
//     var res = jsonDecode(response.body);
//     return {
//       "response_code": res['data']["response_code"],
//       "message": res['data']["message"],
//       "data": res['data']
//     };
//   }

//   Future<TrxModelintId> paymentMidtrans(Object data, String endPoint) async {
//     var response = await client.postData(endPoint: endPoint, body: data);

//     var res = jsonDecode(response.body);
//     try {
//       // print(jsonEncode(res));
//       // print(res);
//       var x = trxModelintIdFromMap(jsonEncode(res));
//       // print("kesini");
//     } catch (e) {
//       print(e);
//     }
//     return trxModelintIdFromMap(jsonEncode(res));
//   }

//   Future payment(Object data, String endPoint) async {
//     var response = await client.postData(endPoint: endPoint, body: data);
//     var res = jsonDecode(response.body);
//     // print(res);
//     return {
//       "statusCode": response.statusCode,
//       "message": res["message"],
//       "data": res
//     };
//   }
// }
