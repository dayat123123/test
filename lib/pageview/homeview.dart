import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeViewUtils extends StatelessWidget {
  const HomeViewUtils({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.w),
                  width: 0.5.sw,
                  height: 200.h,
                  color: Colors.red,
                  child: Text(
                    'My actual width: ${0.5.sw}dp \n\n'
                    'My actual height: ${200.h}dp',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.w),
                  width: 0.3.sw,
                  height: 100.h,
                  color: Colors.red,
                  child: Text(
                    'My actual width: ${0.5.sw}dp \n\n'
                    'My actual height: ${200.h}dp',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 200.h,
              width: double.infinity,
              color: Colors.blue,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 200.h,
                  width: 0.5.sw,
                  color: Colors.red,
                ),
                Container(
                  height: 100.h,
                  width: 0.2.sw,
                  color: Colors.red,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
