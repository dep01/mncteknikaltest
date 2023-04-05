import 'package:teknikaltest/utils/constant.dart';
import 'package:flutter/material.dart';

class LoadingComponents {
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
}
