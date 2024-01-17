import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vid_player/component/custom_icon_button.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  // 선택한 동영상을 저장할 변수
  //XFile은 ImagePicker로 영상 또는 이미지를 선택했을 때 반환하는 타입
  final XFile video;

  //새로운 동영상을 선택하면 실행되는 함수
  final GestureTapCallback onNewVideoPressed;

  const CustomVideoPlayer({
    required this.video, // 상위에서 선택한 동영상 주입하기
    required this.onNewVideoPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  bool showControls = false;
  VideoPlayerController? videoController;

  @override
  // covarient 키워드는 CustomVideoPlayer 클래스의 상속된 값도 허용해줍니다.
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    //새로 선택한 동영상이 같은 동영상인지 확인
    if (oldWidget.video.path != widget.video.path) {
      initalizeController();
    }
  }

  @override
  void initState() {
    super.initState();

    initalizeController(); //컨트롤러 초기화
  }

  initalizeController() async {
    // 선택한 동영상으로 컨트롤러 초기화
    final videoController = VideoPlayerController.file(
      File(widget.video.path),
    );

    await videoController.initialize();

    videoController.addListener(videoControllerListener);

    setState(() {
      this.videoController = videoController;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 동영상 컨트롤러가 준비중일 때 로딩 표시
    if (videoController == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          showControls = !showControls;
        });
      },
      child: AspectRatio(
        //동영상 화면 비율에 따른 렌더링
        aspectRatio: videoController!.value.aspectRatio,
        //children 위젯을 위로 쌓을 수 있는 위젯
        child: Stack(
          children: [
            //VideoPlayer 위젯을 스택으로 이동
            VideoPlayer(
              videoController!,
            ),
            if (showControls)
              Container(
                color: Colors.black.withOpacity(0.5),
              ),

            //child 위젯의 위치를 정할 수 있는 위젯
            if (showControls)
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                // 동영상 재생 상태를 보여주는 슬라이더
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      renderTimeTextFromDuration(
                        // 동영상 현재 위치
                        videoController!.value.position,
                      ),
                      Expanded(
                        //슬라이더가 남는 공간을 모두 차지하도록 구현
                        child: Slider(
                          onChanged: (double val) {
                            videoController!.seekTo(
                              Duration(seconds: val.toInt()),
                            );
                          },
                          value: videoController!.value.position.inSeconds
                              .toDouble(),
                          min: 0,
                          max: videoController!.value.duration.inSeconds
                              .toDouble(),
                        ),
                      ),
                      renderTimeTextFromDuration(
                        videoController!.value.duration,
                      ),
                    ],
                  ),
                ),
              ),
            if (showControls)
              Align(
                alignment: Alignment.topRight,
                child: CustomIconButton(
                  onPressed: widget.onNewVideoPressed,
                  iconData: Icons.photo_camera_back,
                ),
              ),
            if (showControls)
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomIconButton(
                      onPressed: onReversePressed,
                      iconData: Icons.rotate_left,
                    ),
                    CustomIconButton(
                      onPressed: onPlayPressed,
                      iconData: videoController!.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                    CustomIconButton(
                      onPressed: onForwardPressed,
                      iconData: Icons.rotate_right,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void onReversePressed() {
    final currentPosition = videoController!.value.position;

    Duration position = Duration();
    if (currentPosition.inSeconds > 10) {
      position = currentPosition - Duration(seconds: 10);
    }

    videoController!.seekTo(position);
  }

  void onPlayPressed() {
    if (videoController!.value.isPlaying) {
      videoController!.pause();
    } else {
      videoController!.play();
    }
  }

  void onForwardPressed() {
    final maxPosition = videoController!.value.duration;
    final currentPosition = videoController!.value.position;

    Duration position = maxPosition;
    if ((maxPosition - Duration(seconds: 10)).inSeconds >
        currentPosition.inSeconds) {
      position = currentPosition + Duration(seconds: 10);
    }

    videoController!.seekTo(position);
  }

  void videoControllerListener() {
    setState(() {});
  }

  @override
  void dispose() {
    videoController?.removeListener(videoControllerListener);
    super.dispose();
  }

  Widget renderTimeTextFromDuration(Duration duration) {
    return Text(
        '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration
            .inSeconds % 60).toString().padLeft(2, '0')}',
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }
}
