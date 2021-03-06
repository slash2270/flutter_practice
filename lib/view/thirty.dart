// @dart = 2.9

import 'dart:async';
import 'dart:core';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:better_player/better_player.dart';
import 'package:camera/camera.dart';
import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_practice/extensions/extension.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/utils/datetimeutils.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/utils.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import '../video/vcaption.dart';

Set set = Set();

class Thirty extends StatefulWidget {
  const Thirty({Key key, @required this.cameras}) : super(key: key);

  final List<CameraDescription> cameras;

  @override
  State<Thirty> createState() => ThirtyState();
}

class ThirtyState extends State<Thirty> with WidgetsBindingObserver, TickerProviderStateMixin{

  var _cameraFile, _galleryFile, _controllerFile, _resultPath, _unit8List;
  GlobalKey _globalKeyPreview, _globalKeyGallery;
  File saveFile;
  XFile _xFileQuestion;
  Future _futureCameraController, _futureVideoController;
  ElevatedButton _elevatedButton;
  CameraController _cameraController;
  Container _container;
  String _timeStamp, _savePath = '', _saveGifProgress = '', _saveVideoProgress = '', _filePath = '';
  SizedBox _sizedBox;
  Image _imageCamera,_imageGallery, _imageController;
  Directory _appDir;
  GestureDetector _gestureDetector;
  Chip _chip;
  bool _isSaveGif = false, _isSaveVideo = false, _isCountDown = false, _isPause = false, _isStopVideo = false;
  Timer _timer;
  FlashMode _flashMode = FlashMode.off;
  FocusMode _focusMode = FocusMode.locked;
  Offset _focusPoint = Offset(0, 0);
  double _zoomLevel = 1.0;
  ChewieController _chewieController;
  BetterPlayerController _betterPlayerController;
  VideoPlayerController _videoController, _videoPlayerController, _videoChewieController;
  int _intRotate = 0, _seconds = 0;
  String _strCount = '00:00:00', _strVideo = '??????';

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
    /// ?????????????????????????????????????????????????????????????????????
    if (!_cameraController.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _cameraController.description; ///???????????????????????????
      _futureCameraController = _initCameraController();
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('Thirty initState');
    }
    SystemChrome.setEnabledSystemUIOverlays([]);
    _container = Container();
    _globalKeyGallery = GlobalKey();
    _globalKeyPreview = GlobalKey();
    _futureCameraController = _initCameraController();
    _futureVideoController = _initVideoController();
    _initChewieController();
    _initBetterController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // ????????????
    if (kDebugMode) {
      print('Thirty didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant Thirty oldWidget) {
    // ??????????????????
    if (kDebugMode) {
      print('Thirty didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // ????????????
    if (kDebugMode) {
      print('Thirty setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // ????????????, ????????????????????????
    if (kDebugMode) {
      print('Thirty deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // ??????
    if (kDebugMode) {
      print('Thirty dispose');
    }
    if(_seconds != 0){
      _timer.cancel();
    }
    _cameraController.dispose();
    _videoController.dispose();
    _videoPlayerController.dispose();
    _videoChewieController.dispose();
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ImagePicker.pickImage(source: ImageSource.camera); ?????????
    return Scaffold(
      appBar: AppBar(
        title: set.initText('Thirty Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: set.initEdgeInsets(0.0, 20.0, 0.0, 20.0),
          child: Column(
            children: [
              set.initText2('ImageGallerySaver', Colors.black, Colors.transparent, 24),
              Column(
                children: [
                  set.initText2('????????????', Colors.black, Colors.transparent, 20),
                  RepaintBoundary(
                    key: _globalKeyGallery,
                    child: InkWell(
                        onTap: () {
                          set.checkPermission(_gallerySaveAssetsImg());
                        },
                        child: Image.asset(
                          'images/ellen.jpeg',
                          height: 200,
                        )),
                  ),
                  _sizedBox = SizedBox(height: 20.0,),
                  set.initText2('??????????????????', Colors.black, Colors.transparent, 20),
                  _sizedBox = SizedBox(
                    width: 200,
                    height: 100,
                    child: InkWell(
                        onTap: () {
                          set.checkPermission(_gallerySaveNetworkImg("https://pic.baike.soso.com/ugc/baikepic2/0/ori-20200629223328-1270116538_jpeg_220_330_21261.jpg/800"));
                        },
                        child: Image.network("https://pic.baike.soso.com/ugc/baikepic2/0/ori-20200629223328-1270116538_jpeg_220_330_21261.jpg/800",)
                    ),
                  ),
                  _sizedBox = SizedBox(height: 20.0,),
                  set.initText2('??????Gif', Colors.black, Colors.transparent, 20),
                  Visibility(
                    visible: _isSaveGif,
                    child: _saveGifProgress == '' ? Container() : Column(
                      children: [
                        LinearProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.green),
                          backgroundColor: Colors.black,
                          minHeight: 5,
                        ),
                        set.initText2(_saveGifProgress, Colors.black, Colors.transparent, 18)
                      ],
                    ),
                  ),
                  _sizedBox = SizedBox(
                    width: 200,
                    height: 100,
                    child: InkWell(
                        onTap: () {
                          set.checkPermission(_gallerySave("/temp.gif", "https://hyjdoc.oss-cn-beijing.aliyuncs.com/hyj-doc-flutter-demo-run.gif"));
                        },
                        child: Image.network("https://hyjdoc.oss-cn-beijing.aliyuncs.com/hyj-doc-flutter-demo-run.gif",
                        )),
                  ),
                  _sizedBox = SizedBox(height: 20.0,),
                  set.initText2('????????????', Colors.black, Colors.transparent, 20),
                  Visibility(
                    visible: _isSaveVideo,
                    child: _saveVideoProgress == '' ? Container() : Column(
                      children: [
                        LinearProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.green),
                          backgroundColor: Colors.black,
                          minHeight: 5,
                        ),
                        set.initText2(_saveVideoProgress, Colors.black, Colors.transparent, 18)
                      ],
                    ),
                  ),
                  _elevatedButton = ElevatedButton(
                      onPressed: () {
                        set.checkPermission(_gallerySave("/temp.mp4", "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"));
                      },
                      child: set.initText('??????')),
                  _sizedBox = SizedBox(height: 20.0,),
                  set.initText2('Image Picker ??????', Colors.black, Colors.transparent, 24),
                  _cameraFile == null ? Center(
                    child: set.initText2("?????????", Colors.black, Colors.transparent, 20),
                  ) : RepaintBoundary(
                      key: _globalKeyPreview,
                      child: SafeArea(
                        child: _imageCamera,
                      )
                  ),
                  _elevatedButton = ElevatedButton(
                    onPressed: ()=> _imagePicker(ImageSource.camera),
                    child: set.initText('??????'),
                  ),
                  _galleryFile == null ? Center(
                    child: set.initText2("???????????????", Colors.black, Colors.transparent, 20),
                  ) : _imageGallery,
                  _elevatedButton = ElevatedButton(
                    onPressed: ()=> _imagePicker(ImageSource.gallery),
                    child: set.initText('??????'),
                  ),
                  Padding(
                    padding: set.initEdgeInsetsTop(20.0),
                    child: Column(
                      children: [
                        set.initText2('Camera ??????', Colors.black, Colors.transparent, 24),
                        _controllerFile == null
                            ? _container
                            : RepaintBoundary(
                            key: _globalKeyPreview,
                            child: SafeArea(
                              child: _imageController,
                            )
                        ),
                        set.initText2("?????????", Colors.black, Colors.transparent, 20),
                        set.initText2("?????????", Colors.black, Colors.transparent, 20),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            FutureBuilder<void>(
                              future: _futureCameraController,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) {
                                  // ?????? Future ?????????????????????.
                                  return !_cameraController.value.isInitialized
                                      ? _container
                                      : AspectRatio(
                                    aspectRatio: _intRotate == 0 || _intRotate == 2 ?  5.0/8.0 : 8.0/5.0,
                                    child: RotatedBox(
                                      quarterTurns: _intRotate,
                                      child: CameraPreview(_cameraController),
                                    ),
                                  );
                                } else {
                                  // ?????????????????????????????????
                                  return Center(child: CircularProgressIndicator());
                                }
                              },
                            ),
                            Visibility(
                                visible: _isPause,
                                child: set.initIcon1(Icons.play_circle_outline, 60)
                            ),
                          ],
                        ),
                        Visibility(
                          visible: _isCountDown,
                          child: set.initText2('?????????$_strCount', Colors.green, Colors.transparent, 20),
                        ),
                        Wrap(
                          spacing: 15.0, // ??????(??????)????????????
                          runSpacing: 5.0, // ??????????????????????????????
                          alignment: WrapAlignment.center, //?????????????????????
                          children: <Widget>[
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                    avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.camera)),
                                    label: set.initText('??????')
                                ),
                                onTap: () => _takePhotoController()
                            ),
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.start)),
                                  label: set.initText('????????????'),
                                ),
                                onTap: () => _buildPreview()
                            ),
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.flip_camera_ios)),
                                  label: set.initText('??????'),
                                ),
                                onTap: () => _rotateCamera()
                            ),
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.flip_camera_android)),
                                  label: set.initText('????????????'),
                                ),
                                onTap: () => _switchCamera()
                            ),
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.play_arrow_outlined)),
                                  label: set.initText('????????????'),
                                ),
                                onTap: () => _startImageStream()
                            ),
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.stop_outlined)),
                                  label: set.initText('????????????'),
                                ),
                                onTap: () => _stopImageStream()
                            ),
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.start)),
                                  label: set.initText('????????????'),
                                ),
                                onTap: () => _startVideo()
                            ),
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                    avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.stop)),
                                    label: set.initText('????????????')
                                ),
                                onTap: () => _pauseVideo()
                            ),
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                    avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.play_circle_fill_outlined)),
                                    label: set.initText('????????????')
                                ),
                                onTap: () => _resumeVideo()
                            ),
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.stop_circle)),
                                  label: set.initText('????????????'),
                                ),
                                onTap: () => _stopVideo()
                            ),
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.flash_auto)),
                                  label: set.initText('???????????????'),
                                ),
                                onTap: () async {
                                  _flashModeFunc();
                                  await _cameraController.setFlashMode(_flashMode);
                                  setState(() {});
                                }
                            ),
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.center_focus_strong)),
                                  label: set.initText('????????????'),
                                ),
                                onTap: () async {
                                  _focusModeFunc();
                                  await _cameraController.setFocusMode(_focusMode);
                                  setState(() {});
                                }
                            ),
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.filter_center_focus_outlined)),
                                  label: set.initText('??????????????????'),
                                ),
                                onTap: () async {
                                  _focusPointFunc();
                                  await _cameraController.setFocusPoint(_focusPoint);
                                  setState(() {});
                                }
                            ),
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.zoom_in)),
                                  label: set.initText('????????????'),
                                ),
                                onTap: () async {
                                  _zoomLevelFunc();
                                  await _cameraController.setZoomLevel(_zoomLevel);
                                }
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _sizedBox = SizedBox(height: 20.0,),
              set.initText2('VideoPlayer ???????????????', Colors.black, Colors.transparent, 24),
              Stack(
                alignment: Alignment.center,
                children: [
                  FutureBuilder(
                    future: _futureVideoController,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // ?????? Future ?????????????????????.
                        return !_cameraController.value.isInitialized
                            ? _container
                            : AspectRatio(
                          aspectRatio: _videoController.value.aspectRatio,
                          child: VideoPlayer(_videoController),
                        );
                      } else {
                        // ?????????????????????????????????
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  !_videoController.value.isInitialized
                      ? _container
                      : AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: VideoPlayer(_videoController),
                  ),
                  Visibility(
                      visible: !_videoController.value.isPlaying,
                      child: set.initIcon1(Icons.play_circle_outline, 60)
                  ),
                ],
              ),
              _elevatedButton = ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (!_videoController.value.isPlaying) {
                        if(_videoController.value.duration == _videoController.value.position && _videoController.value.position > Duration.zero){
                          _videoController.seekTo(Duration.zero);
                          _videoController.pause();
                          _strVideo = '??????';
                        }else{
                          _videoController.play();
                          _strVideo = '??????';
                        }
                      } else {
                        _videoController.pause();
                        _strVideo = '??????';
                      }
                      /*_videoController.value.isPlaying
                          ? _videoController.pause()
                          : _videoController.play();*/
                    });
                  },
                  child: set.initText(_strVideo)),
              _sizedBox = SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      _videoPlayerController.value.isInitialized
                          ? AspectRatio(
                          aspectRatio: _videoPlayerController.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController))
                          : Container(),
                      Positioned(
                        bottom: 2,
                        width: MediaQuery.of(context).size.width,
                        child: _videoPlayerController.value.isInitialized
                            ? VCaption(_videoPlayerController)
                            : Container(),
                      ),
                      Positioned(
                          bottom: 0,
                          width: MediaQuery.of(context).size.width,
                          child: VideoProgressIndicator(
                            _videoPlayerController,
                            allowScrubbing: false,
                            colors: VideoProgressColors(
                                backgroundColor: Colors.blueGrey,
                                bufferedColor: Colors.blueGrey,
                                playedColor: Colors.blueAccent),
                          ))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade900),
                              fixedSize: MaterialStateProperty.all(Size(70, 70)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)))),
                          onPressed: () {
                            _videoPlayerController.pause();
                          },
                          child: Icon(Icons.pause)),
                      Padding(padding: EdgeInsets.all(2)),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade600),
                              fixedSize: MaterialStateProperty.all<Size>(Size(80, 80)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)))),
                          onPressed: () {
                            _videoPlayerController.play();
                          },
                          child: Icon(Icons.play_arrow)),
                      Padding(padding: EdgeInsets.all(2)),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade300),
                              fixedSize: MaterialStateProperty.all(Size(70, 70)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)))),
                          onPressed: () {
                            _videoPlayerController.seekTo(
                                Duration(seconds: _videoPlayerController.value.position.inSeconds + 10)
                            );
                          },
                          child: Icon(Icons.fast_forward))
                    ],
                  )
                ],
              ),
              _sizedBox = SizedBox(
                height: 20,
              ),
              set.initText2('Chewie ???????????????', Colors.black, Colors.transparent, 20),
              Chewie(controller: _chewieController),
              _sizedBox = SizedBox(
                height: 20,
              ),
              set.initText2('BetterPlayer ???????????????', Colors.black, Colors.transparent, 20),
              AspectRatio(
              aspectRatio: 5 / 8,
              child: BetterPlayer(
                controller: _betterPlayerController,
              )
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  _initCameraController() async {
    ///?????????
    //final resolutionPresets = ResolutionPreset.values;
    //ResolutionPreset currentResolutionPreset = ResolutionPreset.high;
    _cameraController = CameraController(widget.cameras[0], ResolutionPreset.max);
    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('???????????????????????????');
            break;
          default:
            print('?????????????????? $e???');
            break;
        }
      }
    });
  }

  _initVideoController() {
    _videoController = VideoPlayerController.asset('Asset????????????');
    _videoController = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              print('???????????????????????????');
              break;
            default:
              print('?????????????????? $e???');
              break;
          }
        }
    }).whenComplete(() { //????????????????????????
    setState(() {}); //????????????
    });
    /*?????????????????????????????????
    videoPlayerValue = _videoController.value;
    //?????????????????????
    isInitialized = _videoController.value.isInitialized;
    //??????????????????
    isPlaying = _videoController.value.isPlaying;
    //????????????????????????????????????
    aspectRatio = _videoController.value.aspectRatio;
    //????????????????????????
    isBuffer = _videoController.value.isBuffering;
    //????????????????????????
    isLoop = _videoController.value.isLooping;
    //??????????????????????????????
    totalDuration = _videoController.value.duration;
    //???????????????????????????
    currentDuration = _videoController.value.position;*/

    _videoPlayerController = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });
  }

  _initChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoChewieController = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
      aspectRatio:5/8,
      autoInitialize: true,
      autoPlay: true,
      looping: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: set.initText2(
            errorMessage,
            Colors.black,
            Colors.transparent,
            20
          ),
        );
      },
      subtitle: Subtitles([
        Subtitle(
          index: 0,
          start: Duration.zero,
          end: const Duration(seconds: 10),
          text: 'Hello from subtitles',
        ),
        Subtitle(
          index: 1,
          start: const Duration(seconds: 10),
          end: const Duration(seconds: 20),
          text: 'Whats up? :)',
        ),
      ]),
      subtitleBuilder: (context, subtitle) => Container(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          subtitle,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  _initBetterController(){
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4");
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(aspectRatio: 5/8),
        betterPlayerDataSource: betterPlayerDataSource
    );
  }

  ///????????????
  Image _ImageView(File file) {
    print('Thirty Image File $file');
    return Image.file(file);
  }

  _savePreview() async {
    _appDir = await getTemporaryDirectory();
    bool isDirExist = await _appDir.exists();
    final String dirPath = '${_appDir?.path}';
    if (!isDirExist) Directory(dirPath).create(recursive: true); // ????????????????????????
    _timeStamp = DateTime.now().millisecondsSinceEpoch.toString();

    if(_isCountDown){
      _filePath = '$dirPath/${_timeStamp}.mp4';

    }else{
      _filePath = '$dirPath/${_timeStamp}.jpg';
      RenderRepaintBoundary boundary = _globalKeyPreview.currentContext.findRenderObject() as RenderRepaintBoundary;
      double dpr = window.devicePixelRatio;
      // ???image?????????byte
      ui.Image _image = await boundary.toImage(pixelRatio: dpr);
      ByteData byteData = await _image.toByteData(format: ImageByteFormat.png);
      if(byteData != null){
        // ??????byte????????????unit8
        _unit8List = byteData.buffer.asUint8List();
        if (Platform.isAndroid) {// ?????????Android ?????????????????????image_gallery_saver????????????
          // ??????image_gallery_saver???saveImages????????????????????????????????????????????????
          _resultPath =  await ImageGallerySaver.saveImage(_unit8List);
          //await ImageGallerySaver.saveFile(filePath);
          // ???????????????file://???????????????????????????file
          //File saveFile = await File(result.replaceAll("file://", "")).writeAsBytes(_unit8List!);
          saveFile = await File(_filePath).writeAsBytes(_unit8List);
        } else if (Platform.isIOS) {
          // ????????????????????????????????????????????????
          saveFile = await File("${_appDir?.path}${DateTime.now().toIso8601String()}.jpg").writeAsBytes(_unit8List);
        }
        _setToast("????????????????????????????????????${_resultPath['filePath']}");
      }
    }

  }

  /// ?????? ??????
  _imagePicker(ImageSource source) async { // ????????????size
    _xFileQuestion = await ImagePicker().pickImage(source: source);
    if (_xFileQuestion != null) {
        switch(source){
          case ImageSource.camera:
          setState(() {
            _isCountDown = false;
            _cameraFile = File(_xFileQuestion.path);
            _imageCamera = _ImageView(_cameraFile);
          });
            _savePreview();
            break;
          case ImageSource.gallery:
          setState(() {
            _isCountDown = false;
            _galleryFile = File(_xFileQuestion.path);
            _imageGallery = _ImageView(_galleryFile);
          });
          break;
        }
     }
  }

  /// ??????
  _takePhotoController() async {
    if (!_cameraController.value.isInitialized) {
      set.snackBar(context, '??????????????????????????????', '??????');
      return null;
    }
    if (_cameraController.value.isTakingPicture) {
      // ???????????????????????????????????????
      return null;
    }
    _xFileQuestion = await _cameraController.takePicture();
    if (_xFileQuestion != null) {
      setState(() {
        _isCountDown = false;
        _controllerFile = File(_xFileQuestion.path);
        _imageController = _ImageView(_controllerFile);
      });
      _savePreview();
    }
  }

  /// ??????
  _rotateCamera() async {
    setState(() {
      switch(_intRotate){
        case 0:
          _intRotate = 1;
          break;
        case 1:
          _intRotate = 2;
          break;
        case 2:
          _intRotate = 3;
          break;
        case 3:
          _intRotate = 0;
          break;
      }
    });
  }

  /// ???????????????
  _switchCamera() async {
    final CameraDescription cameraDescription = (_cameraController.description == widget.cameras[0]) ? widget.cameras[1] : widget.cameras[0];
    await _cameraController.dispose();
    _cameraController = CameraController(cameraDescription, ResolutionPreset.medium);
    try {
      await _cameraController.initialize();
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          print('???????????????????????????');
          break;
        default:
          print('?????????????????? $e???');
          break;
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  /// ????????????
  _startVideo() async {
    if (!_cameraController.value.isInitialized) {}
    /// ?????????????????????????????????
    if (_cameraController.value.isRecordingVideo) {
      return;
      /// ???????????????????????????
    }
    try {
      _setCountDown();
      await _cameraController.prepareForVideoRecording(); ///?????????????????????????????????
      await _cameraController.startVideoRecording();
      /// ???????????????????????????
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          print('???????????????????????????');
          break;
        default:
          print('?????????????????? $e???');
          break;
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  ///????????????
  _buildPreview() async{
    if (_cameraController.value.isRecordingVideo || !_cameraController.value.isTakingPicture) {
      return; /// ???????????????????????? ?????????
    }
    await _cameraController.buildPreview();
  }

  ///????????????
  _startImageStream() async{
    if (_cameraController.value.isStreamingImages) {
      return; /// ???????????????????????? ?????????
    }
    await _cameraController.startImageStream((image) => null);
  }

  ///????????????
  _stopImageStream() async{
    if (!_cameraController.value.isStreamingImages) {
      return; /// ?????????????????? ?????????
    }
    await _cameraController.stopImageStream();
  }

  ///????????????
  _resumeVideo() async{
    if (!_cameraController.value.isRecordingVideo) {
      return; /// ??????????????????????????????
    }
    setState(() { _isPause = false; });
    await _cameraController.resumePreview();
    await _cameraController.resumeVideoRecording();
  }

  /// ????????????
  _pauseVideo() async{
    if (!_cameraController.value.isRecordingVideo) {
      return; /// ??????????????????????????????
    }
    setState(() { _isPause = true; });
    await _cameraController.pausePreview();
    await _cameraController.pauseVideoRecording();
  }

  /// ????????????
  _stopVideo() async {
    if (!_cameraController.value.isRecordingVideo) {
      return; /// ??????????????????????????????
    }
    try {
      _cancelTimer();
      setState(() {
        _isPause = false;
        _isStopVideo = true;
        _isCountDown = false;
      });
      XFile file = await _cameraController.stopVideoRecording(); /// ??????????????????????????????????????????????????????????????????????????????????????????????????????????????????
      _saveVideo(file);
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          print('???????????????????????????');
          break;
        default:
          print('?????????????????? $e???');
          break;
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  /// ???????????????
  _flashModeFunc() async{
    setState(() {
      if(_flashMode == FlashMode.torch){
        _flashMode = FlashMode.off;
      }else if(_flashMode == FlashMode.off){
        _flashMode = FlashMode.torch;
      }
    });
  }

  /// ????????????
  _focusModeFunc() async{
    setState(() {
      if(_focusMode == FocusMode.auto){
        _focusMode = FocusMode.locked;
      }else if(_focusMode == FocusMode.locked){
        _focusMode = FocusMode.auto;
      }
    });
  }

  /// ??????????????????
  _focusPointFunc() async{
    setState(() {
      if(_focusPoint == Offset(0,0)){
        _focusPoint = Offset(1,1);
      }else if(_focusPoint == Offset(1,1)){
        _focusPoint = Offset(0,0);
      }
    });
  }

  /// ????????????
  _zoomLevelFunc() async{
    setState(() {
      if(_zoomLevel == 1.0){
        _zoomLevel = 8.0;
      }else if(_zoomLevel == 8.0){
        _zoomLevel = 1.0;
      }
    });
  }

  _setToast(String msg){
    if (_resultPath['isSuccess']) {
      set.showToast("??????APP????????????????????????????????????${_resultPath['filePath']}");
    }
  }

  // ??????APP????????????
  _gallerySaveAssetsImg() async {
    RenderRepaintBoundary boundary = _globalKeyGallery.currentContext.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData _byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
    if(_byteData != null){
      _unit8List = _byteData.buffer.asUint8List();
      _resultPath = await ImageGallerySaver.saveImage(_unit8List);
      _setToast("??????APP????????????????????????????????????${_resultPath['filePath']}");
    }
  }

  // ??????????????????
  _gallerySaveNetworkImg(String imgUrl) async {
    final response = await Dio().get(imgUrl, options: Options(responseType: ResponseType.bytes));
    _timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    _unit8List = response.data;
    _resultPath = await ImageGallerySaver.saveImage(
        Uint8List.fromList(_unit8List),
        quality: 100,
        name: _timeStamp);
    _setToast("??????APP????????????????????????????????????${_resultPath['filePath']}");
  }

  // ??????gif ??????
  _gallerySave(String uri, String fileUrl) async {
    _appDir = await getTemporaryDirectory();
    _savePath = _appDir.path + uri;
    switch(uri){
      case "/temp.gif":
        _isSaveGif = true;
        await Dio().download(fileUrl, _savePath, onReceiveProgress: (count, total) {
          setState(() {
            _saveGifProgress = (count / total * 100).toStringAsFixed(0) + "%";
            if((count / total * 100).toStringAsFixed(0).parseInt() == 100){
              _isSaveGif = false;
            }
          });
        });
        break;
      case "/temp.mp4":
        _isSaveVideo = true;
        await Dio().download(fileUrl, _savePath, onReceiveProgress: (count, total) {
          setState(() {
            _saveVideoProgress = (count / total * 100).toStringAsFixed(0) + "%";
            if((count / total * 100).toStringAsFixed(0).parseInt() == 100){
              _isSaveVideo = false;
            }
          });
        });
        break;
    }
    _resultPath = await ImageGallerySaver.saveFile(_savePath);
    _setToast("??????gif??????????????????????????????${_resultPath['filePath']}");
  }

  _saveVideo(XFile file) async{
    if (file.isBlank == false && file.path.isNotEmpty) {
      set.setLoadingDialog(context, _isStopVideo);
      await GallerySaver.saveVideo(file.path, albumName: 'FlutterVideo').then((bool success) {
        if (success) {
          Navigator.pop(context);
          set.showToast("?????????????????????????????????FlutterVideo");
        }
      });
    }
  }

  void _setCountDown() {
    setState(() {
      _isCountDown = !_isCountDown;
      if (_isCountDown) {
        //??????????????????
        /*DateTime now = DateTime.now();
        String timestamp = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
        print(now);
        print(timestamp);
        Duration duration = now.add(Duration()).difference(now);
        print(duration);
        //???????????????
        _seconds = duration.inSeconds;
        print(_seconds);*/
        _startTimer();
      } else {
        _cancelTimer();
      }
    });
  }

  void _startTimer() {
    //?????? 1 ???????????????
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      //????????????
      setState(() {
        //???????????????????????????????????????R
        if(!_isPause){
          _seconds++;
          _strCount = DateTimeUtils.secondsToTime(_seconds);
        }
      });
    });
  }

  void _cancelTimer() {
    if (_seconds != 0) {
      _seconds = 0;
      _strCount = '';
      _timer.cancel();
    }
  }

}