import 'package:flutter/material.dart';

// 웹 뷰 플러그인 임포트
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  WebViewController? controller; // 컨트롤러 변수 생성
  HomeScreen({Key? key}) : super(key: key); //const 삭제

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //앱 바 위젯 추가
        backgroundColor: Colors.orange,
        //앱 타이틀 설정
        title: Text('Code Factory'),
        //가운데 정렬
        centerTitle: true,

        actions: [
          IconButton(
            onPressed: () {
              if (controller != null) {
                //웹 뷰에서 보여줄 사이트 실행하기
                controller!.loadUrl('https://blog.codefactory.ai');
              }
            },
            icon: Icon(
              Icons.home,
            ),
          ),
        ],
      ),
      body: WebView(
        onWebViewCreated: (WebViewController controller) {
          this.controller = controller; // 위젯에 컨트롤러 저장
        },
        initialUrl: 'https://blog.codefactory.ai',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
