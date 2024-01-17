import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CamScreen extends StatefulWidget {
  const CamScreen({super.key});

  @override
  State<CamScreen> createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  RtcEngine? engine;
  int? uid;
  int? otherUid;

  Future<bool> init() async {
    final resp = await [Permission.camera, Permission.microphone].request();

    final cameraPermission = resp[Permission.camera];
    final micPermission = resp[Permission.microphone];

    if (cameraPermission != PermissionStatus.granted ||
        micPermission != PermissionStatus.granted) {
      throw '카메라 또는 마이크 권한이 없습니다.';
    }

    if (engine == null) {
      // 엔진이 정의되지 않았으면 새로 정의하기
      engine = createAgoraRtcEngine();

      //아고라 엔진 초기화
      await engine!.initialize(
        //초기화 할때 사용할 설정 제공
        RtcEngineContext(
          // 미리 저장해둔 APP ID를 입력함
          appId: APP_ID,
          //라이브 동영상 송출에 최적화.
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        ),
      );

      engine!.registerEventHandler(
        RtcEngineEventHandler(
            onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          // 채널 접속에 성공했을 때 실행
          print('채널에 입장했습니다. uid: ${connection.localUid}');
          setState(() {
            this.uid = connection.localUid;
          });
        },
            // 채널을 퇴장 했을때 실행
            onLeaveChannel: (RtcConnection connection, RtcStats stats) {
          print('채널 퇴장');
          setState(() {
            uid == null;
          });
        }, onUserJoined:
                (RtcConnection connection, int remoteUid, int elapsed) {
          //다른 사용자가 접속 했을 때 실행
          print('상대가 채널에 입장했습니다. uid ;$remoteUid');
          setState(() {
            otherUid = null;
          });
        }),
      );

      //엔진으로 영상을 송출하겠다고 설정
      await engine!.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
      await engine!.enableVideo();
      await engine!.startPreview();
      // 채널에 들어가기
      await engine!.joinChannel(
        token: 'TEMP_TOKEN',
        channelId: 'CHANNEL_NAME',
        uid: 0,
        options: ChannelMediaOptions(),
      );
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LIVE'),
      ),
      body: Center(
        child: FutureBuilder(
          future: init(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      renderMainView(),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          color: Colors.grey,
                          height: 160,
                          width: 120,
                          child: renderSubView(),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (engine != null) {
                        await engine!.leaveChannel();
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text('채널 나가기'),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget renderSubView() {
    if (uid != null) {
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: engine!,
          canvas: const VideoCanvas(uid: 0),
        ),
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  Widget renderMainView() {
    if (otherUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: engine!,
          canvas: VideoCanvas(uid: otherUid),
          connection: const RtcConnection(channelId: 'CHANNEL_NAME'),
        ),
      );
    } else {
      return Center(
        child: const Text(
          '다른 사용자가 입장할 때까지 대기해주세요.',
          textAlign: TextAlign.center,
        ),
      );
    }
  }
}
