import 'package:flutter/material.dart';
import 'package:flutter_moviedb_api/view_models/detail_view_model.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({
    Key? key,
    required this.video_key,
  }) : super(key: key);

  final List<String> video_key;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  bool isMute = false;

  // late YoutubePlayerController _controller;
  // late final YoutubePlayerController _controller = YoutubePlayerController(
  //     initialVideoId: 'X8ipUgXH6jw',
  //     flags: YoutubePlayerFlags(
  //       autoPlay: false,
  //     ));

  late final YoutubePlayerController _controller;
  // = YoutubePlayerController(
  //   initialVideoId: 'K18cpp_-gP8',
  //   params: YoutubePlayerParams(
  //     playlist: ['nPt8bK2gbaU', 'gQDByCdjUXw'], // Defining custom playlist
  //     startAt: Duration(seconds: 30),
  //     showControls: true,
  //     showFullscreenButton: true,
  //   ),
  // );

  @override
  void initState() {
    super.initState();

    DetailViewModel detailViewModel =
        Provider.of<DetailViewModel>(context, listen: false);

    List<String> video_key = widget.video_key;
    bool video_keyIsOne = false;

    // _controller = YoutubePlayerController(
    //     initialVideoId: widget.video_key,
    //     flags: YoutubePlayerFlags(
    //       autoPlay: false,
    //     ));

    if (video_key.length == 1) {
      video_keyIsOne = true;
    } else if (video_key.length == 0) {
      video_keyIsOne = true;
      video_key.add('null');
    }

    _controller = YoutubePlayerController(
      initialVideoId: widget.video_key[0],
      params: video_keyIsOne
          ? YoutubePlayerParams(
              startAt: Duration(seconds: 0),
              showControls: true,
              showFullscreenButton: true,
            )
          : YoutubePlayerParams(
              playlist: [
                widget.video_key[0],
                widget.video_key[1],
                widget.video_key[2],
              ],
              startAt: Duration(seconds: 0),
              showControls: true,
              showFullscreenButton: true,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DetailViewModel detailViewModel = context.watch<DetailViewModel>();

    return Container(
      height: 220,
      child: YoutubePlayerIFrame(
        aspectRatio: 16 / 9,
        // bottomActions: [
        //   CurrentPosition(),
        //   ProgressBar(
        //     isExpanded: true,
        //     colors: ProgressBarColors(
        //         playedColor: Colors.red,
        //         handleColor: Colors.red,
        //         bufferedColor: Colors.white,
        //         backgroundColor: Colors.grey),
        //   ),
        //   InkWell(
        //     onTap: () {
        //       if (isMute) {
        //         _controller.unMute();
        //         setState(() {
        //           isMute = false;
        //         });
        //       } else {
        //         setState(() {
        //           isMute = true;
        //         });
        //         _controller.mute();
        //       }
        //     },
        //     child: Icon(
        //       isMute ? Icons.volume_off : Icons.volume_up_rounded,
        //       color: Colors.white,
        //     ),
        //   )
        // ],
        controller: _controller,
        // showVideoProgressIndicator: true,
        // progressIndicatorColor: Colors.amber,
        // progressColors: ProgressBarColors(
        //     playedColor: Colors.red,
        //     handleColor: Colors.red,
        //     bufferedColor: Colors.white,
        //     backgroundColor: Colors.grey),
        // onReady: () {
        //   // _controller.addListener(listener);
        // },
      ),
    );
  }
}
