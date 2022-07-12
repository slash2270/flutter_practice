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
  String _strCount = '00:00:00', _strVideo = '播放';

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
    /// 在我們有機會初始化之前，應用程序狀態發生了變化
    if (!_cameraController.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _cameraController.description; ///最後使用的相機描述
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
    // 依賴變化
    if (kDebugMode) {
      print('Thirty didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant Thirty oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('Thirty didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('Thirty setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('Thirty deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
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
    // ImagePicker.pickImage(source: ImageSource.camera); 舊版本
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
                  set.initText2('保存圖片', Colors.black, Colors.transparent, 20),
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
                  set.initText2('保存網路圖片', Colors.black, Colors.transparent, 20),
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
                  set.initText2('保存Gif', Colors.black, Colors.transparent, 20),
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
                  set.initText2('儲存影片', Colors.black, Colors.transparent, 20),
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
                      child: set.initText('儲存')),
                  _sizedBox = SizedBox(height: 20.0,),
                  set.initText2('Image Picker 照相', Colors.black, Colors.transparent, 24),
                  _cameraFile == null ? Center(
                    child: set.initText2("請拍照", Colors.black, Colors.transparent, 20),
                  ) : RepaintBoundary(
                      key: _globalKeyPreview,
                      child: SafeArea(
                        child: _imageCamera,
                      )
                  ),
                  _elevatedButton = ElevatedButton(
                    onPressed: ()=> _imagePicker(ImageSource.camera),
                    child: set.initText('拍照'),
                  ),
                  _galleryFile == null ? Center(
                    child: set.initText2("請點選相簿", Colors.black, Colors.transparent, 20),
                  ) : _imageGallery,
                  _elevatedButton = ElevatedButton(
                    onPressed: ()=> _imagePicker(ImageSource.gallery),
                    child: set.initText('相簿'),
                  ),
                  Padding(
                    padding: set.initEdgeInsetsTop(20.0),
                    child: Column(
                      children: [
                        set.initText2('Camera 照相', Colors.black, Colors.transparent, 24),
                        _controllerFile == null
                            ? _container
                            : RepaintBoundary(
                            key: _globalKeyPreview,
                            child: SafeArea(
                              child: _imageController,
                            )
                        ),
                        set.initText2("請拍照", Colors.black, Colors.transparent, 20),
                        set.initText2("請錄影", Colors.black, Colors.transparent, 20),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            FutureBuilder<void>(
                              future: _futureCameraController,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) {
                                  // 如果 Future 完成，顯示預覽.
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
                                  // 否則，顯示加載指示器。
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
                          child: set.initText2('錄影：$_strCount', Colors.green, Colors.transparent, 20),
                        ),
                        Wrap(
                          spacing: 15.0, // 主轴(水平)方向间距
                          runSpacing: 5.0, // 纵轴（垂直）方向间距
                          alignment: WrapAlignment.center, //沿主轴方向居中
                          children: <Widget>[
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                    avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.camera)),
                                    label: set.initText('快門')
                                ),
                                onTap: () => _takePhotoController()
                            ),
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.start)),
                                  label: set.initText('開始預覽'),
                                ),
                                onTap: () => _buildPreview()
                            ),
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.flip_camera_ios)),
                                  label: set.initText('旋轉'),
                                ),
                                onTap: () => _rotateCamera()
                            ),
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.flip_camera_android)),
                                  label: set.initText('前後鏡頭'),
                                ),
                                onTap: () => _switchCamera()
                            ),
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.play_arrow_outlined)),
                                  label: set.initText('開始串流'),
                                ),
                                onTap: () => _startImageStream()
                            ),
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.stop_outlined)),
                                  label: set.initText('結束串流'),
                                ),
                                onTap: () => _stopImageStream()
                            ),
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.start)),
                                  label: set.initText('開始錄影'),
                                ),
                                onTap: () => _startVideo()
                            ),
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                    avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.stop)),
                                    label: set.initText('暫停錄影')
                                ),
                                onTap: () => _pauseVideo()
                            ),
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                    avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.play_circle_fill_outlined)),
                                    label: set.initText('繼續錄影')
                                ),
                                onTap: () => _resumeVideo()
                            ),
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.stop_circle)),
                                  label: set.initText('停止錄影'),
                                ),
                                onTap: () => _stopVideo()
                            ),
                            _gestureDetector = GestureDetector(
                                child: _chip = Chip(
                                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: set.initIcon(Icons.flash_auto)),
                                  label: set.initText('閃光燈模式'),
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
                                  label: set.initText('對焦模式'),
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
                                  label: set.initText('自動確定焦點'),
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
                                  label: set.initText('縮放級別'),
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
              set.initText2('VideoPlayer 影音播放器', Colors.black, Colors.transparent, 24),
              Stack(
                alignment: Alignment.center,
                children: [
                  FutureBuilder(
                    future: _futureVideoController,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // 如果 Future 完成，顯示預覽.
                        return !_cameraController.value.isInitialized
                            ? _container
                            : AspectRatio(
                          aspectRatio: _videoController.value.aspectRatio,
                          child: VideoPlayer(_videoController),
                        );
                      } else {
                        // 否則，顯示加載指示器。
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
                          _strVideo = '重來';
                        }else{
                          _videoController.play();
                          _strVideo = '暫停';
                        }
                      } else {
                        _videoController.pause();
                        _strVideo = '播放';
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
              set.initText2('Chewie 影音播放器', Colors.black, Colors.transparent, 20),
              Chewie(controller: _chewieController),
              _sizedBox = SizedBox(
                height: 20,
              ),
              set.initText2('BetterPlayer 影音播放器', Colors.black, Colors.transparent, 20),
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
    ///清晰度
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
            print('用戶拒絕相機訪問。');
            break;
          default:
            print('處理其他錯誤 $e。');
            break;
        }
      }
    });
  }

  _initVideoController() {
    _videoController = VideoPlayerController.asset('Asset資源路徑');
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
              print('用戶拒絕相機訪問。');
              break;
            default:
              print('處理其他錯誤 $e。');
              break;
          }
        }
    }).whenComplete(() { //异步执行完的回调
    setState(() {}); //刷新页面
    });
    /*获取当前视频播放的信息
    videoPlayerValue = _videoController.value;
    //是否初始化完成
    isInitialized = _videoController.value.isInitialized;
    //是否正在播放
    isPlaying = _videoController.value.isPlaying;
    //当前播放的视频的宽高比例
    aspectRatio = _videoController.value.aspectRatio;
    //当前视频是否缓存
    isBuffer = _videoController.value.isBuffering;
    //当前视频是否循环
    isLoop = _videoController.value.isLooping;
    //当前播放视频的总时长
    totalDuration = _videoController.value.duration;
    //当前播放视频的位置
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

  ///图片控件
  Image _ImageView(File file) {
    print('Thirty Image File $file');
    return Image.file(file);
  }

  _savePreview() async {
    _appDir = await getTemporaryDirectory();
    bool isDirExist = await _appDir.exists();
    final String dirPath = '${_appDir?.path}';
    if (!isDirExist) Directory(dirPath).create(recursive: true); // 判断路径是否存在
    _timeStamp = DateTime.now().millisecondsSinceEpoch.toString();

    if(_isCountDown){
      _filePath = '$dirPath/${_timeStamp}.mp4';

    }else{
      _filePath = '$dirPath/${_timeStamp}.jpg';
      RenderRepaintBoundary boundary = _globalKeyPreview.currentContext.findRenderObject() as RenderRepaintBoundary;
      double dpr = window.devicePixelRatio;
      // 将image转化成byte
      ui.Image _image = await boundary.toImage(pixelRatio: dpr);
      ByteData byteData = await _image.toByteData(format: ImageByteFormat.png);
      if(byteData != null){
        // 图片byte数据转化unit8
        _unit8List = byteData.buffer.asUint8List();
        if (Platform.isAndroid) {// 如果是Android 的话，直接使用image_gallery_saver就可以了
          // 调用image_gallery_saver的saveImages方法，返回值就是图片保存后的路径
          _resultPath =  await ImageGallerySaver.saveImage(_unit8List);
          //await ImageGallerySaver.saveFile(filePath);
          // 需要去除掉file://开头。生成要使用的file
          //File saveFile = await File(result.replaceAll("file://", "")).writeAsBytes(_unit8List!);
          saveFile = await File(_filePath).writeAsBytes(_unit8List);
        } else if (Platform.isIOS) {
          // 直接保存，返回的就是保存后的文件
          saveFile = await File("${_appDir?.path}${DateTime.now().toIso8601String()}.jpg").writeAsBytes(_unit8List);
        }
        _setToast("保存图片成功，保存路径为${_resultPath['filePath']}");
      }
    }

  }

  /// 拍照 相册
  _imagePicker(ImageSource source) async { // 一定要有size
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

  /// 快門
  _takePhotoController() async {
    if (!_cameraController.value.isInitialized) {
      set.snackBar(context, '錯誤：請先選擇相機。', '復原');
      return null;
    }
    if (_cameraController.value.isTakingPicture) {
      // 捕獲已經掛起，什麼都不做。
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

  /// 旋轉
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

  /// 翻转摄像头
  _switchCamera() async {
    final CameraDescription cameraDescription = (_cameraController.description == widget.cameras[0]) ? widget.cameras[1] : widget.cameras[0];
    await _cameraController.dispose();
    _cameraController = CameraController(cameraDescription, ResolutionPreset.medium);
    try {
      await _cameraController.initialize();
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          print('用戶拒絕相機訪問。');
          break;
        default:
          print('處理其他錯誤 $e。');
          break;
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  /// 錄製影片
  _startVideo() async {
    if (!_cameraController.value.isInitialized) {}
    /// 这里为我统计的录制时长
    if (_cameraController.value.isRecordingVideo) {
      return;
      /// 如果正在录制则无效
    }
    try {
      _setCountDown();
      await _cameraController.prepareForVideoRecording(); ///準備影片錄製的捕獲會話
      await _cameraController.startVideoRecording();
      /// 开始录制，会卡一下
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          print('用戶拒絕相機訪問。');
          break;
        default:
          print('處理其他錯誤 $e。');
          break;
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  ///開始預覽
  _buildPreview() async{
    if (_cameraController.value.isRecordingVideo || !_cameraController.value.isTakingPicture) {
      return; /// 如果在錄影或拍照 則無效
    }
    await _cameraController.buildPreview();
  }

  ///開始串流
  _startImageStream() async{
    if (_cameraController.value.isStreamingImages) {
      return; /// 如果在錄影或拍照 則無效
    }
    await _cameraController.startImageStream((image) => null);
  }

  ///停止串流
  _stopImageStream() async{
    if (!_cameraController.value.isStreamingImages) {
      return; /// 如果不在串流 則無效
    }
    await _cameraController.stopImageStream();
  }

  ///繼續錄影
  _resumeVideo() async{
    if (!_cameraController.value.isRecordingVideo) {
      return; /// 如果不在录制，则无效
    }
    setState(() { _isPause = false; });
    await _cameraController.resumePreview();
    await _cameraController.resumeVideoRecording();
  }

  /// 暫停錄影
  _pauseVideo() async{
    if (!_cameraController.value.isRecordingVideo) {
      return; /// 如果不在录制，则无效
    }
    setState(() { _isPause = true; });
    await _cameraController.pausePreview();
    await _cameraController.pauseVideoRecording();
  }

  /// 停止錄影
  _stopVideo() async {
    if (!_cameraController.value.isRecordingVideo) {
      return; /// 如果不在录制，则无效
    }
    try {
      _cancelTimer();
      setState(() {
        _isPause = false;
        _isStopVideo = true;
        _isCountDown = false;
      });
      XFile file = await _cameraController.stopVideoRecording(); /// 这里为文件地址，测试中我去找的时候未找到，但是可以拿到文件，应该是隐藏地址。
      _saveVideo(file);
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          print('用戶拒絕相機訪問。');
          break;
        default:
          print('處理其他錯誤 $e。');
          break;
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  /// 閃光燈模式
  _flashModeFunc() async{
    setState(() {
      if(_flashMode == FlashMode.torch){
        _flashMode = FlashMode.off;
      }else if(_flashMode == FlashMode.off){
        _flashMode = FlashMode.torch;
      }
    });
  }

  /// 對焦模式
  _focusModeFunc() async{
    setState(() {
      if(_focusMode == FocusMode.auto){
        _focusMode = FocusMode.locked;
      }else if(_focusMode == FocusMode.locked){
        _focusMode = FocusMode.auto;
      }
    });
  }

  /// 自動確定焦點
  _focusPointFunc() async{
    setState(() {
      if(_focusPoint == Offset(0,0)){
        _focusPoint = Offset(1,1);
      }else if(_focusPoint == Offset(1,1)){
        _focusPoint = Offset(0,0);
      }
    });
  }

  /// 縮放級別
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
      set.showToast("保存APP里的图片成功，保存路径为${_resultPath['filePath']}");
    }
  }

  // 保存APP里的图片
  _gallerySaveAssetsImg() async {
    RenderRepaintBoundary boundary = _globalKeyGallery.currentContext.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData _byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
    if(_byteData != null){
      _unit8List = _byteData.buffer.asUint8List();
      _resultPath = await ImageGallerySaver.saveImage(_unit8List);
      _setToast("保存APP里的图片成功，保存路径为${_resultPath['filePath']}");
    }
  }

  // 保存网络图片
  _gallerySaveNetworkImg(String imgUrl) async {
    final response = await Dio().get(imgUrl, options: Options(responseType: ResponseType.bytes));
    _timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    _unit8List = response.data;
    _resultPath = await ImageGallerySaver.saveImage(
        Uint8List.fromList(_unit8List),
        quality: 100,
        name: _timeStamp);
    _setToast("保存APP里的图片成功，保存路径为${_resultPath['filePath']}");
  }

  // 保存gif 影片
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
    _setToast("保存gif动画成功，保存路径为${_resultPath['filePath']}");
  }

  _saveVideo(XFile file) async{
    if (file.isBlank == false && file.path.isNotEmpty) {
      set.setLoadingDialog(context, _isStopVideo);
      await GallerySaver.saveVideo(file.path, albumName: 'FlutterVideo').then((bool success) {
        if (success) {
          Navigator.pop(context);
          set.showToast("保存影片成功，相簿名：FlutterVideo");
        }
      });
    }
  }

  void _setCountDown() {
    setState(() {
      _isCountDown = !_isCountDown;
      if (_isCountDown) {
        //获取当期时间
        /*DateTime now = DateTime.now();
        String timestamp = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
        print(now);
        print(timestamp);
        Duration duration = now.add(Duration()).difference(now);
        print(duration);
        //获取总秒数
        _seconds = duration.inSeconds;
        print(_seconds);*/
        _startTimer();
      } else {
        _cancelTimer();
      }
    });
  }

  void _startTimer() {
    //设置 1 秒回调一次
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      //更新界面
      setState(() {
        //秒数减一，因为一秒回调一次R
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