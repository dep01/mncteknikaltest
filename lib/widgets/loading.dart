import 'package:teknikaltest/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:responsive_screen/responsive_screen.dart';

class Loading extends StatelessWidget {
  bool show = false;

  Loading(this.show);

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return Positioned(
        child: show
            ? Material(
                child: Center(
                  child: Container(
                    width: hp(20),
                    height: hp(20),
                    decoration: new BoxDecoration(
                        color: Theme.of(context).primaryColorDark,
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(15.0))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: hp(10),
                          height: hp(10),
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        Text("Loading...",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: hp(2.5)))
                      ],
                    ),
                  ),
                ),
                color: Colors.white.withOpacity(0.8),
              )
            : Container());
  }
}

class LoadingBlock extends StatelessWidget {
  Color colors;
  LoadingBlock([this.colors]);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
            colors ?? Theme.of(context).primaryColorDark),
      ),
    );
  }
}

Widget get initLoading {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 15,
          height: 15,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: new AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
        SizedBox(width: 8),
        Text(
          'Loading...',
          style: TextStyle(color: Colors.black54),
        )
      ],
    ),
  );
}
