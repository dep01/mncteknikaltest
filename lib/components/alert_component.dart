import 'package:cached_network_image/cached_network_image.dart';
import 'package:teknikaltest/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AlertComponents {
  void alertIcon(context, String alert, IconData icons) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Builder(builder: (context) {
            return AlertDialog(
              title: Text(
                alert,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Center(
                    child: Icon(
                  icons,
                  size: 100.0,
                  color: Colors.orange,
                )),
              ),
            );
          });
        });
  }

  void alertPopIcon(context,
      {String alert = "",
      IconData icon = Icons.info_outline,
      Color iconColor = Colors.blue,
      Color backGroundColor = Colors.white,
      double size = 10.0}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Builder(builder: (context) {
            return AlertDialog(
              // Transform.translate(offset: const Offset(-4.0, 0.0), child: Text("xx"))
              title: Transform.translate(
                offset: const Offset(0.0, -50.0),
                child: Container(
                  child: Center(
                    child: Container(
                      // padding: EdgeInsets.only(bottom: size * 10),
                      height: size,
                      width: size,
                      child: Center(
                        child: Icon(
                          icon,
                          color: iconColor,
                          size: size,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: backGroundColor,
                        borderRadius: BorderRadius.circular(size / 2),
                      ),
                    ),
                  ),
                ),
              ),
              content: Transform.translate(
                offset: const Offset(0.0, -50.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: SingleChildScrollView(
                    child: Text(
                      alert != null ? alert : "",
                      softWrap: true,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  void alertIconAction(
      context,
      String title,
      String alert,
      IconData icons,
      Function onOK,
      Function okCancel,
      String onOkTitle,
      String onCancelTitle) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Builder(builder: (context) {
            return AlertDialog(
              title: Text(
                alert,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Center(
                    child: Icon(
                  icons,
                  size: 100.0,
                  color: Colors.orange,
                )),
              ),
            );
          });
        });
  }

  void alertPreview(context, String image, {String description = ""}) {
    showDialog(
        context: context,
        builder: (BuildContext icontext) {
          return Builder(builder: (context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    // width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                    imageUrl: image ?? 'https://via.placeholder.com/150',
                    errorWidget: (_, i, o) =>
                        Image.network('https://via.placeholder.com/150'),
                    placeholder: (_, z) => LoadingBlock(),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  description != "" ? Text(description) : SizedBox(height: 1)
                ],
              ),
            );
          });
        });
  }

  void alertAction(context,
      {String alert = "",
      String title = "",
      Function onOk,
      Function onCancel,
      String onOkText = "YES",
      String onCancelText = "NO"}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Builder(builder: (context) {
            return AlertDialog(
              title: Text(
                title != null ? title : "",
                softWrap: true,
                textAlign: TextAlign.start,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              content: Text(
                alert != null ? alert : "",
                softWrap: true,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.normal),
              ),
              actions: [
                onCancel != null
                    ? RaisedButton(
                        onPressed: () async {
                          await onCancel();
                        },
                        color: Colors.white,
                        disabledTextColor: Colors.black45,
                        child: Text(
                          onCancelText.toUpperCase(),
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        elevation: 0,
                        highlightElevation: 0,
                      )
                    : SizedBox(
                        width: 1.0,
                      ),
                onOk != null
                    ? RaisedButton(
                        onPressed: () async {
                          await onOk();
                        },
                        disabledTextColor: Colors.black45,
                        color: Colors.white,
                        child: Text(
                          onOkText.toUpperCase(),
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        elevation: 0,
                        highlightElevation: 0,
                      )
                    : SizedBox(
                        width: 1.0,
                      ),
              ],
            );
          });
        });
  }

  void alertColumnAction(context,
      {String title = "",
      String alert = "",
      IconData icon = Icons.check,
      String image = "",
      List<Widget> action,
      Color textColorTitle = Colors.black,
      Color textColorAlert = Colors.black,
      Color iconColor = Colors.black}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Builder(builder: (context) {
            return AlertDialog(
                title: Text(
                  title,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: textColorTitle, fontWeight: FontWeight.bold),
                ),
                content: Container(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    alert != ""
                        ? Text(
                            alert,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: textColorAlert,
                                fontWeight: FontWeight.normal),
                          )
                        : SizedBox(
                            height: 1.0,
                          ),
                    alert != ""
                        ? SizedBox(
                            height: 12.0,
                          )
                        : SizedBox(
                            height: 1.0,
                          ),
                    image != ""
                        ? SvgPicture.asset(
                            image,
                            fit: BoxFit.fitHeight,
                            color: iconColor,
                          )
                        : Icon(
                            icon,
                            size: 100.0,
                            color: iconColor,
                          ),
                    SizedBox(
                      height: 12.0,
                    ),
                    action != null
                        ? Column(
                            children: action,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                          )
                        : SizedBox(height: 1.0)
                  ]),
                ));
          });
        });
  }
}
