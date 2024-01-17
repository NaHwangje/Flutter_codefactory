import 'package:u_and_i/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
          //테마를 저장할 수 있는 클래스
          fontFamily: 'sunflower', // 기본 글씨체
          textTheme:  TextTheme(
            //글자 테마를 적용할 수 있는 클래스
            displayLarge: TextStyle(
              color: Colors.white,
              fontSize: 80.0,
              fontWeight: FontWeight.w700,
              fontFamily: 'parisienne',
            ),
            displayMedium: TextStyle(
              color: Colors.white,
              fontSize: 50.0,
              fontWeight: FontWeight.w700,
            ),
            bodyLarge: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
            ),
            bodyMedium: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          )),
      home: HomeScreen(),
    ),
  );
}
