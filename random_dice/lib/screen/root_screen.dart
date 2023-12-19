import 'package:flutter/material.dart';
import 'package:random_dice/screen/home_screen.dart';
import 'package:random_dice/screen/settings_screen.dart';
import 'dart:math';
import 'package:shake/shake.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with TickerProviderStateMixin {
  TabController? controller;
  double threshold = 2.7;
  int number = 1;
  ShakeDetector? shakeDetector;

  void onPhoneShake() {
    final rand = new Random();

    setState(() {
      number = rand.nextInt(5) + 1;
    });
  }

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 2, vsync: this);
    //컨트롤러 속성이 변경 될 때마다 실행할 함수 등록
    controller!.addListener(tabListener);

    shakeDetector = shakeDetector.autoStart(
      //흔들기 감지 시작
      shakeSlopTimeMS: 100, //감지 주기
      shakeThresholdGravity: threshold, // 감지 민감도
      onPhoneShake: onPhoneShake, // 감지 후 실행할 함수
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        //탭 화면을 보여줄 위젯
        children: renderChildren(),
      ),
      // 아래 탭 내비게이션을 구현하는 매개변수
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  List<Widget> renderChildren() {
    return [
      HomeScreen(number: number),
      SettingsScreen(
        threshold: threshold,
        onTresHoldChange: onTresHoldChange,
      ),
    ];
  }

  tabListener() {
    setState(() {});
  }

  @override
  void dispose() {
    controller!.removeListener(tabListener);
    shakeDetector!.stopListening();
    super.dispose();
  }

  BottomNavigationBar renderBottomNavigation() {
    //탭 네비게이션을 구현하는 위젯
    return BottomNavigationBar(
      // 현재 화면에 렌더링 되는 탭의 인덱스
      currentIndex: controller!.index,
      onTap: (int index) {
        setState(() {
          controller!.animateTo(index);
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.edgesensor_high_outlined),
          label: '주사위',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
          ),
          label: '설정',
        ),
      ],
    );
  }

  //슬라이더값 변경시 실행 함수
  void onTresHoldChange(double val) {
    setState(() {
      threshold = val;
    });
  }
}
