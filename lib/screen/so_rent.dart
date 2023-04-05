// import 'package:badges/badges.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:customer/components/alert_component.dart';
// import 'package:customer/models/CartModel.dart';
// import 'package:customer/models/CategoryModel.dart';
// import 'package:customer/utils/constant.dart';
// import 'package:customer/utils/indonesia.dart';
// import 'package:customer/widgets/loading.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:stacked/stacked.dart';

// import 'model/so_snack_vm.dart';

// class SoRent extends ViewModelBuilderWidget<SoSnackViewModel> {
//   // RECEIVING PARAMETER CODE BELOW
//   final String defaultServiceName;
//   final int globalMerchantId;
//   final String globalMerchantName;
//   final CategoryModel categoryModel;
//   final String defaultSearchText;
//   SoRent(
//       {this.defaultServiceName,
//       this.globalMerchantId,
//       this.globalMerchantName,
//       this.categoryModel,
//       this.defaultSearchText});
//   Size size;
//   @override
//   viewModelBuilder(BuildContext context) => SoSnackViewModel();

//   @override
//   bool get reactive => true;

//   @override
//   bool get disposeViewModel => true;

//   @override
//   void onViewModelReady(SoSnackViewModel model) {
//     if (defaultSearchText != '') {
//       model.searchController.text = defaultSearchText;
//     }
//     model.defaultServiceName = defaultServiceName;
//     if (globalMerchantId != null) {
//       model.globalMerchantId = globalMerchantId;
//       model.globalMerchantName = globalMerchantName;
//     }
//     if (categoryModel != null) {
//       model.itemCategoryId = int.tryParse(categoryModel.id);
//     }
//     model.initializeData();
//     super.onViewModelReady(model);
//   }

//   @override
//   Widget builder(BuildContext context, model, Widget child) {
//     size = MediaQuery.of(context).size;

//     return Scaffold(
//       key: model.globalKey,
//       appBar: AppBar(
//         brightness: Brightness.light,
//         toolbarHeight: 64,
//         elevation: 0,
//         title: Padding(
//           padding: EdgeInsets.only(top: 8, bottom: 8),
//           child: TextFormField(
//             focusNode: model.searchFocus,
//             controller: model.searchController,
//             autocorrect: false,
//             enableSuggestions: false,
//             keyboardType: TextInputType.text,
//             decoration: InputDecoration(
//                 hintText:
//                     'What would be the best for ${model.serviceFormated}?'),
//             onFieldSubmitted: (value) {
//               model.init = true;
//               model.getItems();
//             },
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           if (defaultServiceName == 'SO_SNACK' ||
//               defaultServiceName == 'SO_ATK')
//             SizedBox(height: 20),
//           generateCategories(context, model),
//           Visibility(
//             visible: (model.globalMerchantId > 0 ? true : false),
//             child: Container(
//               padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//               height: 30,
//               width: MediaQuery.of(context).size.width,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Menampilkan merchant: ' + model.globalMerchantName,
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                   GestureDetector(
//                     onTap: () => model.removeSelectedMerchant(),
//                     child: Icon(Icons.close),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Flexible(
//             child: model.init
//                 ? initLoading
//                 : model.items.length > 0
//                     ? ListView.builder(
//                         padding: EdgeInsets.only(top: 24),
//                         controller: model.scrollController,
//                         itemCount: model.items.length,
//                         itemBuilder: (lContext, index) {
//                           return getItemTile(context, model, index);
//                         },
//                       )
//                     : Center(
//                         child: Image.asset(Resources.empty_data, scale: 2),
//                       ),
//           )
//         ],
//       ),
//       floatingActionButton: Builder(builder: (context) {
//         if (model.totalCart > 0) {
//           return FloatingActionButton(
//             backgroundColor: Colors.white,
//             focusColor: Colors.white,
//             foregroundColor: Colors.orange,
//             child: Badge(
//               badgeContent: Text(
//                 model.totalCart.toString(),
//                 style: Theme.of(context)
//                     .textTheme
//                     .caption
//                     .copyWith(color: Colors.white),
//               ),
//               badgeColor: Colors.red,
//               child: Icon(Icons.shopping_cart),
//             ),
//             onPressed: () {
//               model.goToCart();
//             },
//           );
//         } else {
//           return SizedBox(width: 0);
//         }
//       }),
//     );
//   }

//   void showAddToCartDialog(context, model, ProductModel item) {
//     showDialog(
//         context: context,
//         builder: (BuildContext dContext) {
//           return Builder(builder: (context) {
//             dynamic exists = model.find(defaultServiceName, item);
//             String title = 'Tambahkan Item';
//             model.notesController.text = '';
//             model.setQty(0);
//             if (exists != null) {
//               title = 'Ubah Item';
//               model.notesController.text = exists.note;
//               model.setQty(exists.qty);
//             }
//             var rentUnit = item.rentUnit;
//             var unitName = 'pcs';
//             if (rentUnit == 'Hourly') {
//               rentUnit = 'PER JAM';
//               unitName = 'jam';
//             } else if (rentUnit == 'Daily') {
//               rentUnit = 'PER HARI';
//               unitName = 'hari';
//             } else if (rentUnit == 'Monthly') {
//               rentUnit = 'PER BULAN';
//               unitName = 'bulan';
//             }
//             if (!item.isRent) {
//               unitName = 'pcs';
//             }
//             return AlertDialog(
//               title: Text(title, textAlign: TextAlign.center),
//               content: Container(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       children: [
//                         modifyQtyButton(model, type: 'minus'),
//                         SizedBox(width: 12),
//                         Expanded(
//                           child: TextFormField(
//                             textAlign: TextAlign.center,
//                             controller: model.qtyController,
//                             autocorrect: false,
//                             enableSuggestions: false,
//                             keyboardType: TextInputType.number,
//                             onFieldSubmitted: (value) {},
//                           ),
//                         ),
//                         SizedBox(width: 12),
//                         modifyQtyButton(model, type: 'add'),
//                       ],
//                     ),
//                     SizedBox(height: 16),
//                     Text(
//                       item.isRent == true &&
//                               (item.rentUnit != null || item.rentUnit != "")
//                           ? rentUnit
//                           : "PER PCS",
//                       style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.grey,
//                           fontWeight: FontWeight.bold),
//                       textAlign: TextAlign.center,
//                     ),
//                     // SizedBox(height: 16),
//                     // TextFormField(
//                     //   controller: model.notesController,
//                     //   autocorrect: false,
//                     //   enableSuggestions: false,
//                     //   keyboardType: TextInputType.text,
//                     //   maxLines: 3,
//                     //   decoration: InputDecoration(
//                     //     hintText: 'Add notes',
//                     //   ),
//                     //   onFieldSubmitted: (value) {},
//                     // ),
//                     SizedBox(height: 16),
//                     SizedBox(
//                       width: double.infinity,
//                       child: RaisedButton(
//                         onPressed: () {
//                           if (int.tryParse(model.qtyController.text) > 0) {
//                             Navigator.of(dContext).pop();
//                             if (exists == null) {
//                               model.add({
//                                 'service': defaultServiceName,
//                                 'merchantId': item.merchantId,
//                                 'merchantName': item.merchant.name,
//                                 'id': int.tryParse(item.id),
//                                 'name': item.name,
//                                 'description': item.description,
//                                 'qty': int.tryParse(model.qtyController.text),
//                                 'price': item.price,
//                                 'note': model.notesController.text,
//                                 'unit': unitName
//                               });
//                             } else {
//                               model.update({
//                                 'service': defaultServiceName,
//                                 'merchantId': item.merchantId,
//                                 'merchantName': item.merchant.name,
//                                 'id': int.tryParse(item.id),
//                                 'name': item.name,
//                                 'description': item.description,
//                                 'qty': int.tryParse(model.qtyController.text),
//                                 'price': item.price,
//                                 'note': model.notesController.text,
//                                 'unit': unitName
//                               });
//                             }
//                           }
//                         },
//                         child: Text(
//                           exists != null ? 'Perbarui Item' : 'Tambahkan',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.white,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         elevation: 0,
//                         highlightElevation: 0,
//                       ),
//                     ),
//                     if (exists != null)
//                       Padding(
//                         padding: EdgeInsets.only(top: 8),
//                         child: SizedBox(
//                           width: double.infinity,
//                           child: RaisedButton(
//                             color: Colors.red,
//                             highlightColor: Colors.red,
//                             focusColor: Colors.red,
//                             onPressed: () {
//                               Navigator.of(dContext).pop();
//                               model.remove(defaultServiceName,
//                                   int.tryParse(item.id), item.merchantId);
//                             },
//                             child: Text(
//                               'Hapus',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                             elevation: 0,
//                             highlightElevation: 0,
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             );
//           });
//         });
//   }

//   // LIBRARIES
//   Widget get initLoading {
//     return Center(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(
//             width: 15,
//             height: 15,
//             child: CircularProgressIndicator(
//               strokeWidth: 3,
//               valueColor: new AlwaysStoppedAnimation<Color>(AppColors.orange),
//             ),
//           ),
//           SizedBox(width: 8),
//           Text(
//             'Loading...',
//             style: TextStyle(color: Colors.black54),
//           )
//         ],
//       ),
//     );
//   }

//   Widget getItemTile(context, model, int i) {
//     ProductModel item = model.items[i];
//     print(item.toMap());
//     final alert = new AlertComponents();
//     return GestureDetector(
//       onTap: !item.merchant.isClose
//           ? () => null
//           : () {
//               if (defaultServiceName == 'SO_RENT') {
//                 showAddToCartRentDialog(context, model, item);
//               } else {
//                 showAddToCartDialog(context, model, item);
//               }
//             },
//       child: Padding(
//         padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
//         child: Container(
//           padding: EdgeInsets.only(top: 12, bottom: 12),
//           decoration: BoxDecoration(
//             border: Border(
//               bottom: BorderSide(
//                   width: 1.0,
//                   color: i == model.items.length - 1
//                       ? Colors.transparent
//                       : Colors.grey[300]),
//             ),
//             color: Colors.transparent,
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GestureDetector(
//                 onTap: () => alert.alertPreview(
//                     context,
//                     item.thumbnailMediumUrl ??
//                         'https://via.placeholder.com/150',
//                     description:
//                         item.imagesNote != null ? item.imagesNote[0] : ""),
//                 child: CachedNetworkImage(
//                   width: 60.0,
//                   imageUrl: item.thumbnailSmallUrl ??
//                       'https://via.placeholder.com/150',
//                   errorWidget: (_, i, o) =>
//                       Image.network('https://via.placeholder.com/150'),
//                   placeholder: (_, z) => LoadingBlock(),
//                 ),
//               ),
//               SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(item.name,
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15,
//                             color: !item.merchant.isClose
//                                 ? Colors.black
//                                 : Colors.black.withOpacity(0.2)),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis),
//                     SizedBox(height: 4),
//                     GestureDetector(
//                       onTap: () {
//                         model.byMerchant(item.merchantId, item.merchant.name);
//                       },
//                       child: Text(item.merchant.name,
//                           style: TextStyle(
//                               color: !item.merchant.isClose
//                                   ? Colors.blueAccent
//                                   : Colors.blueAccent.withOpacity(0.2),
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       item.description,
//                       style: TextStyle(
//                         color: !item.merchant.isClose
//                             ? Colors.black
//                             : Colors.black.withOpacity(0.2),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(rupiah(item.price.toString()),
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: !item.merchant.isClose
//                               ? Colors.black87
//                               : Colors.black87.withOpacity(0.2),
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis),
//                     if (item.merchant.isClose)
//                       Text("Tutup",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black87),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // SHOW DIALOG

//   void showAddToCartRentDialog(context, model, ProductModel item) {
//     showDialog(
//         context: context,
//         builder: (BuildContext dContext) {
//           return Builder(builder: (context) {
//             dynamic exists = model.find(defaultServiceName, item);
//             model.notesController.text = '';
//             int pickUpPrice = item.pickupPrice ?? 0;
//             int deliveryPrice = item.deliveryPrice ?? 0;
//             model.setQty(0);
//             model.isPickup = false;
//             model.isDelivery = false;
//             if (exists != null) {
//               model.notesController.text = exists.note;
//               model.setQty(exists.qty);
//               model.isPickup = exists.isPickup;
//               model.isDelivery = exists.isDelivery;
//             }
//             var rentUnit = item.rentUnit;
//             var unitName = 'pcs';
//             if (rentUnit == 'Hourly') {
//               rentUnit = 'PER JAM';
//               unitName = 'jam';
//             } else if (rentUnit == 'Daily') {
//               rentUnit = 'PER HARI';
//               unitName = 'hari';
//             } else if (rentUnit == 'Monthly') {
//               rentUnit = 'PER BULAN';
//               unitName = 'bulan';
//             }
//             if (!item.isRent) {
//               unitName = 'pcs';
//             }
//             return AlertDialog(
//               // title: Text(title, textAlign: TextAlign.center),
//               content: Container(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Container(
//                       // width: 130.0,
//                       height: 140.0,
//                       child: CachedNetworkImage(
//                         fit: BoxFit.cover,
//                         imageUrl: item.thumbnailMediumUrl ??
//                             'https://via.placeholder.com/150',
//                         errorWidget: (_, i, o) =>
//                             Image.network('https://via.placeholder.com/150'),
//                         placeholder: (_, z) => LoadingBlock(),
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.only(bottom: 2),
//                       margin: EdgeInsets.only(bottom: 5),
//                       // width: 120,
//                       decoration: BoxDecoration(
//                           border: Border(bottom: BorderSide(width: 0.7))),
//                       child: Text(
//                         "Periode Sewa",
//                         textAlign: TextAlign.left,
//                         style: TextStyle(fontSize: 12),
//                       ),
//                     ),
//                     Container(
//                       // width: 120,
//                       height: 30,
//                       color: Color.fromRGBO(220, 220, 220, 1),
//                       padding: EdgeInsets.only(top: 5),
//                       child: Text(
//                         item.isRent == true &&
//                                 (item.rentUnit != null || item.rentUnit != "")
//                             ? rentUnit
//                             : "PER PCS",
//                         style: TextStyle(
//                           fontSize: 15,
//                         ),
//                         textAlign: TextAlign.left,
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.only(bottom: 2),
//                       margin: EdgeInsets.only(bottom: 5),
//                       // width: 120,
//                       decoration: BoxDecoration(
//                           border: Border(bottom: BorderSide(width: 0.7))),
//                       child: Text(
//                         "Lama Sewa",
//                         textAlign: TextAlign.left,
//                         style: TextStyle(fontSize: 12),
//                       ),
//                     ),
//                     Container(
//                       color: Color.fromRGBO(220, 220, 220, 1),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           modifyQtyButton(model, type: 'minus', size: 35),
//                           Container(
//                             width: 50.0,
//                             height: 30.0,
//                             child: TextFormField(
//                               textAlign: TextAlign.center,
//                               controller: model.qtyController,
//                               style: TextStyle(fontSize: 12),
//                               autocorrect: false,
//                               enableSuggestions: false,
//                               keyboardType: TextInputType.number,
//                               onFieldSubmitted: (value) {},
//                             ),
//                           ),
//                           modifyQtyButton(model, type: 'add', size: 35),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     Container(
//                       width: 300,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (item.isDelivery == true || item.isPickup == true)
//                             Column(
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.only(bottom: 2),
//                                   margin: EdgeInsets.only(bottom: 5),
//                                   width: 300,
//                                   decoration: BoxDecoration(
//                                       border: Border(
//                                           bottom: BorderSide(width: 0.7))),
//                                   child: Text(
//                                     "Layanan Unit",
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(fontSize: 12),
//                                   ),
//                                 ),
//                                 Row(
//                                   children: [
//                                     if (item.isDelivery)
//                                       Row(
//                                         children: [
//                                           Checkbox(
//                                             value: model.isDelivery,
//                                             onChanged: (value) => model
//                                                 .setStatus('delivery', value),
//                                           ),
//                                           Text("Antar"),
//                                         ],
//                                       ),
//                                     if (item.isPickup && item.isDelivery)
//                                       SizedBox(
//                                         width: 20,
//                                       ),
//                                     if (item.isPickup)
//                                       Row(
//                                         children: [
//                                           Checkbox(
//                                             value: model.isPickup,
//                                             onChanged: (value) => model
//                                                 .setStatus('pickup', value),
//                                           ),
//                                           Text("Jemput"),
//                                         ],
//                                       )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           Container(
//                             padding: EdgeInsets.only(bottom: 2),
//                             margin: EdgeInsets.only(bottom: 5),
//                             width: 300,
//                             decoration: BoxDecoration(
//                                 border: Border(bottom: BorderSide(width: 0.7))),
//                             child: Text(
//                               "Detail Harga",
//                               textAlign: TextAlign.left,
//                               style: TextStyle(fontSize: 12),
//                             ),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Harga Unit",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(fontSize: 12),
//                               ),
//                               Text(
//                                 rupiah((int.tryParse(model.qtyController.text) *
//                                         item.price)
//                                     .toString()),
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(fontSize: 12),
//                               ),
//                             ],
//                           ),
//                           if (model.isDelivery)
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Antar",
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(fontSize: 12),
//                                 ),
//                                 Text(
//                                   rupiah(deliveryPrice),
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(fontSize: 12),
//                                 ),
//                               ],
//                             ),
//                           if (model.isPickup)
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Jemput",
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(fontSize: 12),
//                                 ),
//                                 Text(
//                                   rupiah(pickUpPrice),
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(fontSize: 12),
//                                 ),
//                               ],
//                             ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Total",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                     fontSize: 13, fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 rupiah(pickUpPrice +
//                                     deliveryPrice +
//                                     (int.tryParse(model.qtyController.text) *
//                                         item.price)),
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                     fontSize: 13, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     SizedBox(
//                       width: double.infinity,
//                       child: RaisedButton(
//                         onPressed: () {
//                           if (int.tryParse(model.qtyController.text) > 0) {
//                             Navigator.of(dContext).pop();
//                             if (exists == null) {
//                               model.add({
//                                 'service': defaultServiceName,
//                                 'merchantId': item.merchantId,
//                                 'merchantName': item.merchant.name,
//                                 'id': int.tryParse(item.id),
//                                 'name': item.name,
//                                 'description': item.description,
//                                 'qty': int.tryParse(model.qtyController.text),
//                                 'price': item.price,
//                                 'note': model.notesController.text,
//                                 'unit': unitName,
//                                 "isPickup": model.isPickup,
//                                 "isDelivery": model.isDelivery,
//                                 "deliveryPrice": item.deliveryPrice,
//                                 "pickupPrice": item.pickupPrice,
//                               });
//                             } else {
//                               model.update({
//                                 'service': defaultServiceName,
//                                 'merchantId': item.merchantId,
//                                 'merchantName': item.merchant.name,
//                                 'id': int.tryParse(item.id),
//                                 'name': item.name,
//                                 'description': item.description,
//                                 'qty': int.tryParse(model.qtyController.text),
//                                 'price': item.price,
//                                 'note': model.notesController.text,
//                                 'unit': unitName,
//                                 "isPickup": model.isPickup,
//                                 "isDelivery": model.isDelivery,
//                                 "deliveryPrice": item.deliveryPrice,
//                                 "pickupPrice": item.pickupPrice,
//                               });
//                             }
//                           }
//                         },
//                         child: Text(
//                           exists != null ? 'Perbarui Item' : 'Tambahkan',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.white,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                         elevation: 0,
//                         highlightElevation: 0,
//                       ),
//                     ),
//                     if (exists != null)
//                       Padding(
//                         padding: EdgeInsets.only(top: 8),
//                         child: SizedBox(
//                           width: double.infinity,
//                           child: RaisedButton(
//                             color: Colors.red,
//                             highlightColor: Colors.red,
//                             focusColor: Colors.red,
//                             onPressed: () {
//                               Navigator.of(dContext).pop();
//                               model.remove(defaultServiceName,
//                                   int.tryParse(item.id), item.merchantId);
//                             },
//                             child: Text(
//                               'Hapus',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                             elevation: 0,
//                             highlightElevation: 0,
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             );
//           });
//         });
//   }

//   Widget modifyQtyButton(model, {String type = 'add', double size = 50}) {
//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(size / 4)),
//         color: AppColors.orange,
//       ),
//       child: IconButton(
//         iconSize: size / 2,
//         icon:
//             Icon(type == 'add' ? Icons.add : Icons.remove, color: Colors.white),
//         onPressed: () {
//           if (type == 'add') {
//             model.addQty();
//           } else {
//             model.substractQty();
//           }
//         },
//       ),
//     );
//   }

//   // FOR CATEGORIES
//   generateCategories(context, model) {
//     if (defaultServiceName == 'SO_SNACK' || defaultServiceName == 'SO_ATK') {
//       return model.loadingCategory
//           ? initLoading
//           : ConstrainedBox(
//               constraints:
//                   BoxConstraints(maxWidth: double.infinity, maxHeight: 30),
//               child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   shrinkWrap: true,
//                   padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
//                   itemCount: model.categories.length,
//                   itemBuilder: (BuildContext context, index) {
//                     if (index == 0) {
//                       return Row(
//                         children: [
//                           boxCategory(context, model, index, true),
//                           boxCategory(context, model, index, false),
//                         ],
//                       );
//                     }
//                     return boxCategory(context, model, index, false);
//                   }));
//     } else {
//       return Text('');
//     }
//   }

//   boxCategory(context, model, index, all) {
//     double width = ((size.width - 24) / 2.5);
//     double marginLeft = (all ? 0 : 16);
//     int categoryId = 0;
//     String categoryName = 'All';
//     if (all == false) {
//       CategoryModel item = model.categories[index];
//       categoryId = int.tryParse(item.id);
//       categoryName = item.name;
//     }
//     return Container(
//       width: width,
//       child: GestureDetector(
//         onTap: () {
//           model.findByCategory(categoryId);
//         },
//         child: Card(
//           margin: EdgeInsets.fromLTRB(marginLeft, 0, 0, 0),
//           child: Padding(
//             padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [Text(categoryName)],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// String units(bool isRent, String unit) {
//   if (isRent) {
//     switch (unit) {
//       case "Hourly":
//         return "/Jam";
//       case "Daily":
//         return "/Hari";
//       case "Monthly":
//         return "/Bln";
//       default:
//         return "/Pcs";
//     }
//   }
//   return "/Pcs";
// }
