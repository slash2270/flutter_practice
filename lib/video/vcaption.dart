import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VCaption extends StatefulWidget {
  const VCaption(
      this.videoPlayerController,
      );
  final VideoPlayerController videoPlayerController;
  @override
  _VCaptionState createState() => _VCaptionState();
}
class _VCaptionState extends State<VCaption> {
  String? selectedCaption = "";
  Map<int,String> captions = {5:"First subtitle", 20:"Second subtitle"};

  @override
  void initState() {
    widget.videoPlayerController.addListener(() {
      if(widget.videoPlayerController.value.isPlaying){
        setState(() {
          if(captions.containsKey(widget.videoPlayerController.value.position.inSeconds)){
            selectedCaption = captions[widget.videoPlayerController.value.position.inSeconds];
          }
        });
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ClosedCaption(
      text: selectedCaption,textStyle: TextStyle(fontSize: 15,color: Colors.white),);
  }
}