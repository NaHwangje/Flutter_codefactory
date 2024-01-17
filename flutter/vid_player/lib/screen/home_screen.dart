import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_player/component/custom_video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;

  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: video == null ? renderEmpty() : renderVideo(),
    );
  }

  // 동영상 선택 전 보여줄 위젯
  Widget renderEmpty() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: getBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            onTap: onNewVideoPressed,
          ),
          SizedBox(height: 30.0),
          _AppName(),
        ],
      ),
    );
  }

  void onNewVideoPressed() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (video != null) {
      setState(() {
        this.video = video;
      });
    }
  }

  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
        //그라데이션으로 색상 적용하기
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
          Color(0xff2a3a7c),
          Color(0xff000118),
        ]));
  }

  // 동영상 선택 후 보여줄 위젯
  Widget renderVideo() {
    return Center(
      child: CustomVideoPlayer(
        video: video!, // 선택된 동영상 입력해주기
        onNewVideoPressed: onNewVideoPressed,
      ), //동영상 재생기 위젯
    );
  }
}

class _Logo extends StatelessWidget {
  final GestureTapCallback onTap;

  const _Logo({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        'asset/img/logo.png',
      ),
    );
  }
}

class _AppName extends StatelessWidget {
  const _AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'VIDEO',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          style: textStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
