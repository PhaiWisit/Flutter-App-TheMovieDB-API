import 'package:flutter/material.dart';
import 'package:flutter_moviedb_api/view_models/detail_view_model.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({
    Key? key,
    required this.video_key,
  }) : super(key: key);

  final String video_key;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  bool isMute = false;

  late YoutubePlayerController _controller;

  // late YoutubePlayerController _controller = YoutubePlayerController(
  //     initialVideoId: 'X8ipUgXH6jw',
  //     flags: YoutubePlayerFlags(
  //       autoPlay: false,
  //     ));

  @override
  void initState() {
    super.initState();

    DetailViewModel detailViewModel =
        Provider.of<DetailViewModel>(context, listen: false);

    // if (detailViewModel.loading) {
    _controller = YoutubePlayerController(
        initialVideoId: widget.video_key,
        // initialVideoId: detailViewModel.movieVideoModel!.results[0].key,
        flags: YoutubePlayerFlags(
          autoPlay: false,
        ));
    // }
  }

  @override
  Widget build(BuildContext context) {
    DetailViewModel detailViewModel = context.watch<DetailViewModel>();

    return Container(
      height: 220,
      child: YoutubePlayer(
        bottomActions: [
          CurrentPosition(),
          ProgressBar(
            isExpanded: true,
            colors: ProgressBarColors(
                playedColor: Colors.red,
                handleColor: Colors.red,
                bufferedColor: Colors.white,
                backgroundColor: Colors.grey),
          ),
          InkWell(
            onTap: () {
              if (isMute) {
                _controller.unMute();
                setState(() {
                  isMute = false;
                });
              } else {
                setState(() {
                  isMute = true;
                });
                _controller.mute();
              }
            },
            child: Icon(
              isMute ? Icons.volume_off : Icons.volume_up_rounded,
              color: Colors.white,
            ),
          )
        ],
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
        progressColors: ProgressBarColors(
            playedColor: Colors.red,
            handleColor: Colors.red,
            bufferedColor: Colors.white,
            backgroundColor: Colors.grey),
        onReady: () {
          // _controller.addListener(listener);
        },
      ),
    );
  }
}
