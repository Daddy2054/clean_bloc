import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'custom_gradient_overlay.dart';

//import 'custom_gradient_overlay.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String assetPath;
  final String? caption;
  final String? username;

  const CustomVideoPlayer({
    super.key,
    required this.assetPath,
    this.caption,
    this.username,
  });

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController controller;

   @override
  void initState() {
    if (widget.assetPath.startsWith('assets')) {
      controller = VideoPlayerController.asset(widget.assetPath);
    } else {
      controller = VideoPlayerController.file(File(widget.assetPath));
    }

    controller.initialize().then((_) => setState(() {}));
    controller.setLooping(true);
    controller.play();
    debugPrint("Init controller: $controller");

    super.initState();
  }

  @override
  void dispose() {
    debugPrint("Dispose controller: $controller");
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const SizedBox();
    } else {
      return GestureDetector(
        onTap: () {
          setState(() {
            if (controller.value.isPlaying) {
              controller.pause();
            } else {
              controller.play();
            }
          });
        },
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: Stack(
            children: <Widget>[
              VideoPlayer(controller),
             const CustomGradientOverlay(),
              (widget.caption == null || widget.username == null)
                  ? const SizedBox()
                  : _VideoCaption(
                      username: widget.username!,
                      caption: widget.caption!,
                    ),
                  VideoProgressIndicator(controller, allowScrubbing: true),

            ],
          ),
        ),
      );
    }
  }
}

class _VideoCaption extends StatelessWidget {
  const _VideoCaption({
    Key? key,
    required this.username,
    required this.caption,
  }) : super(key: key);

  final String username;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: 125,
        width: MediaQuery.of(context).size.width * 0.75,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              username,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 5),
            Text(
              caption,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
