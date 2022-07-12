// @dart = 2.9

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_practice/set.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/utils.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'dart:ui' as ui;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class CameraDemo extends StatefulWidget {
  const CameraDemo({Key key, @required this.listCamera}) : super(key: key);

  final List<CameraDescription> listCamera;

  @override
  _CameraDemoState createState() => _CameraDemoState();
}

class _CameraDemoState extends State<CameraDemo> with WidgetsBindingObserver {

  Set set;
  CameraController _controller;
  VideoPlayerController videoController;
  bool _isCameraInitialized = false, _isRearCameraSelected = true, _isVideoCameraSelected = false, _isRecordingInProgress = false;
  FlashMode _currentFlashMode;
  List<ResolutionPreset> _resolutionPresets;
  ResolutionPreset currentResolutionPreset;
  double _minAvailableZoom, _maxAvailableZoom, _currentZoomLevel;
  double _minAvailableExposureOffset, _maxAvailableExposureOffset, _currentExposureOffset;
  File _saveFile;
  Directory _appDir;
  GlobalKey _globalKeyPreview;
  bool _isDirExist;
  String _filePath;
  DeviceInfoPlugin deviceInfoPlugin;
  XFile _xFile;
  Align _align;
  Positioned _positioned;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('$state');
    _setCameraController(state);
  }

  @override
  void initState() {
    print('CameraDemo initState');
    _setInit();
    _requestPermission();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    print('CameraDemo didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant CameraDemo oldWidget) {
    // 元件發生變化
    print('CameraDemo didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    print('CameraDemo setState');
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    print('CameraDemo deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    print('CameraDemo dispose');
    _controller?.dispose();
    videoController?.dispose();
    super.dispose();
  }

  _setInit(){
    deviceInfoPlugin = DeviceInfoPlugin();
    SystemChrome.setEnabledSystemUIOverlays([]); // Hide the status bar
    set = Set();
    _globalKeyPreview = GlobalKey();
    _resolutionPresets = ResolutionPreset.values;
    currentResolutionPreset = ResolutionPreset.high;
    _minAvailableZoom = 1.0;
    _maxAvailableZoom = 8.0;
    _currentZoomLevel = 1.0;
    _currentExposureOffset = 0.0;
    _minAvailableExposureOffset = -5.0;
    _maxAvailableExposureOffset = 5.0;
    onNewCameraSelected(widget.listCamera[0]);
  }

  _setCameraController(AppLifecycleState state){
    final CameraController cameraController = _controller;
    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same propertiess
      onNewCameraSelected(cameraController.description);
      _setZoomControl(cameraController);
      _setExposureControl(cameraController);
      _setFlashMode(cameraController);
    }
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = _controller;
    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      // ResolutionPreset.high,
      cameraDescription,
      currentResolutionPreset,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Replace with the new controller
    if (mounted) {
      setState(() {
        _controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    // Initialize controller
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    // Update the boolean
    if (mounted) {
      setState(() {
        _isCameraInitialized = _controller.value.isInitialized;
      });
    }
  }

  _setZoomControl(CameraController _cameraController){
    _cameraController.getMaxZoomLevel().then((value) => _maxAvailableZoom = value);
    _cameraController.getMinZoomLevel().then((value) => _minAvailableZoom = value);
  }

  _setExposureControl(CameraController _cameraController){
    _cameraController.getMinExposureOffset().then((value) => _minAvailableExposureOffset = value);
    _cameraController.getMaxExposureOffset().then((value) => _maxAvailableExposureOffset = value);
  }

  _setFlashMode(CameraController _cameraController){
    _currentFlashMode = _cameraController.value.flashMode;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: _isCameraInitialized ?
      Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: 5 / 9.5,//1 / _controller.value.aspectRatio,
            child: _controller.buildPreview()
          ),
          _positioned = Positioned(
              height: 25,
              width: 360,
              top: 20,
              child: _flashModeWidget()
          ),
          _align = Align(
            alignment: Alignment(1.2, -0.85),
            widthFactor: 1.0,
            child: _dropDownButtonWidget()
          ),
          _positioned = Positioned(
              height: 550,
              width: 45,
              top: 75,
              right: 10,
              child: _exposureWidget()
          ),
          _positioned = Positioned(
              height: 30,
              width: 340,
              bottom: 120.0,
              child: _zoomControlWidget()
          ),
          _align = Align(
            alignment: Alignment(-0.95, 0.85),
            child: _setFlipWidget(),
          ),
          _align = Align(
              alignment: Alignment(-0.0, 0.85),
              child: _isVideoCameraSelected ? _setVideoRecordWidget() : _setCameraWidget()
          ),
          _align = Align(
              alignment: Alignment(0.95, 0.84),
              child: _setGalleryWidget(context)
          ),
          _align = Align(
              alignment: Alignment.bottomCenter,
              child: _setSwitchButton()
          ),
          WillPopScope(
              child: Container(),
              onWillPop: () async {
                return true;
              },
          ),
        ],
       ) : Container(),
    );
  }

  Widget _dropDownButtonWidget(){
    return Container(
      color: Colors.black45,
      child: DropdownButton<ResolutionPreset>(
        borderRadius: BorderRadius.circular(10.0),
        alignment: Alignment.center,
        dropdownColor: Colors.black87,
        underline: Container(),
        value: currentResolutionPreset,
        items: [
          for (ResolutionPreset preset
          in _resolutionPresets)
            DropdownMenuItem(
              child: Text(
                preset
                    .toString()
                    .split('.')[1]
                    .toUpperCase(),
                style:
                TextStyle(color: Colors.white),
              ),
              value: preset,
            )
        ],
        onChanged: (value) {
          setState(() {
            currentResolutionPreset = value;
            _isCameraInitialized = false;
          });
          onNewCameraSelected(_controller.description);
        },
        hint: Text("Select item"),
      ),
    );
  }

  Widget _zoomControlWidget(){
    return Row(
      children: [
        Expanded(
          child: Slider(
            value: _currentZoomLevel,
            min: _minAvailableZoom,
            max: _maxAvailableZoom,
            activeColor: Colors.white,
            inactiveColor: Colors.white30,
            onChanged: (value) async {
              _currentZoomLevel = value;
              await _controller.setZoomLevel(_currentZoomLevel);
              setState(() {  });
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _currentZoomLevel.toStringAsFixed(1) + 'x',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _exposureWidget(){
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _currentExposureOffset.toStringAsFixed(1) + 'x',
              style: TextStyle(color: Colors.black),
              //textAlign: TextAlign.start,
            ),
          ),
        ),
        Expanded(
          child: RotatedBox(
            quarterTurns: 3,
            child: Container(
              height: 30,
              child: Slider(
                value: _currentExposureOffset,
                min: _minAvailableExposureOffset,
                max: _maxAvailableExposureOffset,
                activeColor: Colors.white,
                inactiveColor: Colors.white30,
                onChanged: (value) async {
                  setState(() {});
                  _currentExposureOffset = value;
                  await _controller.setExposureOffset(value);
                },
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _flashModeWidget(){
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () async {
              setState(() {
                _currentFlashMode = FlashMode.off;
              });
              await _controller.setFlashMode(
                FlashMode.off,
              );
            },
            child: Icon(
              Icons.flash_off,
              color: _currentFlashMode == FlashMode.off
                  ? Colors.amber
                  : Colors.white,
            ),
          ),
          InkWell(
            onTap: () async {
              setState(() {
                _currentFlashMode = FlashMode.auto;
              });
              await _controller.setFlashMode(
                FlashMode.auto,
              );
            },
            child: Icon(
              Icons.flash_auto,
              color: _currentFlashMode == FlashMode.auto
                  ? Colors.amber
                  : Colors.white,
            ),
          ),
          InkWell(
            onTap: () async {
              setState(() {
                _isCameraInitialized = false;
              });
              onNewCameraSelected(
                widget.listCamera[_isRearCameraSelected ? 1 : 0],
              );
              setState(() {
                _isRearCameraSelected = !_isRearCameraSelected;
              });
            },
            child: Icon(
              Icons.flash_on,
              color: _currentFlashMode == FlashMode.always
                  ? Colors.amber
                  : Colors.white,
            ),
          ),
          InkWell(
            onTap: () async {
              setState(() {
                _currentFlashMode = FlashMode.torch;
              });
              await _controller.setFlashMode(
                FlashMode.torch,
              );
            },
            child: Icon(
              Icons.highlight,
              color: _currentFlashMode == FlashMode.torch
                  ? Colors.amber
                  : Colors.white,
            ),
          ),
        ],
    );
  }

  Widget _setFlipWidget(){
    return InkWell(
      onTap: () {
        setState(() {
          _isCameraInitialized = false;
        });
        onNewCameraSelected(
          widget.listCamera[_isRearCameraSelected ? 0 : 1],
        );
        setState(() {
          _isRearCameraSelected = !_isRearCameraSelected;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.circle,
            color: Colors.black38,
            size: 60,
          ),
          Icon(
            _isRearCameraSelected
                ? Icons.camera_front
                : Icons.camera_rear,
            color: Colors.white,
            size: 30,
          ),
        ],
      ),
    );
  }

  Widget _setCameraWidget(){
    return InkWell(
      onTap: () async {
        _xFile = await takePicture();
        if(_xFile.isBlank == false){
          setState(() {
            _saveFile = File(_xFile.path);
          });
          _cropImage(_xFile);
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.circle, color: Colors.white38, size: 80),
          Icon(Icons.circle, color: Colors.white, size: 65),
        ],
      ),
    );
  }

  Future<XFile> takePicture() async {
    final CameraController cameraController = _controller;
    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }
    try {
      _xFile = await cameraController.takePicture();
      return _xFile;
    } on CameraException catch (e) {
      print('Error occured while taking picture: $e');
      return null;
    }
  }

  Widget _setSwitchButton(){
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 4.0,),
            child: TextButton(
              onPressed: _isRecordingInProgress ? null : () {
                if (_isVideoCameraSelected) {
                  setState(() {
                    _isVideoCameraSelected = false;
                  });
                }
              },
              style: TextButton.styleFrom(
                primary: _isVideoCameraSelected
                    ? Colors.black54
                    : Colors.black,
                backgroundColor: _isVideoCameraSelected
                    ? Colors.white30
                    : Colors.white,
              ),
              child: Text('IMAGE'),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 8.0),
            child: TextButton(
              onPressed: () {
                if (!_isVideoCameraSelected) {
                  setState(() {
                    _isVideoCameraSelected = true;
                  });
                }
              },
              style: TextButton.styleFrom(
                primary: _isVideoCameraSelected
                    ? Colors.black
                    : Colors.black54,
                backgroundColor: _isVideoCameraSelected
                    ? Colors.white
                    : Colors.white30,
              ),
              child: Text('VIDEO'),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> startVideoRecording() async {
    final CameraController cameraController = _controller;
    if (_controller.value.isRecordingVideo) {
      // A recording has already started, do nothing.
      return;
    }
    try {

      await cameraController.startVideoRecording();

      setState(() {
        _isRecordingInProgress = true;
        print(_isRecordingInProgress);
      });
    } on CameraException catch (e) {
      print('Error starting to record video: $e');
    }
  }

  void _requestPermission() async{
    if (defaultTargetPlatform == TargetPlatform.android) {
      if (await Permission.contacts.request().isGranted) {
        // 權限之前已經授予或用戶剛剛授予它。
      }
      // 您可以一次請求多個權限。
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
        Permission.camera,
      ].request();
      print(statuses[Permission.location]);
    }
  }

  Future<XFile> stopVideoRecording() async {
    if (!_controller.value.isRecordingVideo) {
      // Recording is already is stopped state
      return null;
    }
    try {
      _xFile = await _controller.stopVideoRecording();
      setState(() {
        _isRecordingInProgress = false;
        print(_isRecordingInProgress);
      });
      return _xFile;
    } on CameraException catch (e) {
      print('Error stopping video recording: $e');
      return null;
    }
  }

  Future<void> pauseVideoRecording() async {
    if (!_controller.value.isRecordingVideo) {
      // Video recording is not in progress
      return;
    }
    try {
      await _controller.pauseVideoRecording();
    } on CameraException catch (e) {
      print('Error pausing video recording: $e');
    }
  }

  Future<void> resumeVideoRecording() async {
    if (!_controller.value.isRecordingVideo) {
      // No video recording was in progress
      return;
    }
    try {
      await _controller.resumeVideoRecording();
    } on CameraException catch (e) {
      print('Error resuming video recording: $e');
    }
  }

  Widget _setVideoRecordWidget(){
    return InkWell(
      onTap: () async {
        if (_isRecordingInProgress) {
          _xFile = await stopVideoRecording();
          _saveFile = File(_xFile.path);
          _captureVideo();
          _startVideoPlayer();
        } else {
          await startVideoRecording();
        }
      }, //: () async {
        // code to handle image clicking
     // },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.circle,
            color: _isVideoCameraSelected
                ? Colors.white
                : Colors.white38,
            size: 80,
          ),
          Icon(
            Icons.circle,
            color: _isVideoCameraSelected
                ? Colors.red
                : Colors.white,
            size: 65,
          ),
          _isVideoCameraSelected && _isRecordingInProgress
              ? Icon(
            Icons.stop_rounded,
            color: Colors.white,
            size: 32,
          )
            : Container(),
        ],
      ),
    );
  }

  Future<void> _startVideoPlayer() async {
    if (_saveFile != null) {
      videoController = VideoPlayerController.file(_saveFile);
      await videoController.initialize().then((_) {
        // 確保視頻初始化後顯示第一幀，
        // 甚至在按下播放按鈕之前。
        setState(() {});
      });
      await videoController.setLooping(true);
      await videoController.play();
    }
  }

  Widget _setGalleryWidget(BuildContext context){
    return InkWell(
      child: Container(
        width: 47,
        height: 47,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(10.0),
          //border: Border.all(color: Colors.white, width: 2),
          /*image: _imageFile != null
              ? DecorationImage(
            image: FileImage(_imageFile),
            fit: BoxFit.cover,
          )
              : null,*/
        ),
        child: videoController != null && videoController.value.isInitialized
            ? ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: AspectRatio(
            aspectRatio: videoController.value.aspectRatio,
            child: VideoPlayer(videoController),
          ),
        )
            : RepaintBoundary(
          key: _globalKeyPreview,
          child: _saveFile != null
              ? _setImageView()
              : Center(
            child: Icon(Icons.photo, color: Colors.white, size: 33,),
          )
        ),
      ),
      onTap: () => _refreshAlreadyCapturedImages(context),
    );
  }

  Widget _setImageView() {
    return Image.file(_saveFile);
  }

  // To store the retrieved files
  List<File> allFileList = [];

  _refreshAlreadyCapturedImages(BuildContext context) async {
    // Get the directory
    if(_isVideoCameraSelected){
      _xFile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    }else{
      _xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _saveFile = File(_xFile.path);
    });
    /*List<FileSystemEntity> fileList = await _appDir.list().toList();
    allFileList.clear();

    List<Map<int, dynamic>> fileNames = [];

    // Searching for all the image and video files using
    // their default format, and storing them
    fileList.forEach((file) {
      if (file.path.contains('.jpg') || file.path.contains('.mp4')) {
        allFileList.add(File(file.path));
        String name = file.path.split('/').last.split('.').first;
        fileNames.add({0: int.parse(name), 1: file.path.split('/').last});
      }
    });

    // Retrieving the recent file
    if (fileNames.isNotEmpty) {
      final recentFile = fileNames.reduce((curr, next) => curr[0] > next[0] ? curr : next);
      String recentFileName = recentFile[1];

      // Checking whether it is an image or a video file
      setState(() {
        if (recentFileName.contains('.mp4')) {
          _videoFile = File('${_appDir.path}/$recentFileName');
        } else {
          _imageFile = File('${_appDir.path}/$recentFileName');
        }
      });
    }*/
  }

  _setDirectory() async{
    _appDir = await getTemporaryDirectory();
    _isDirExist = await _appDir.exists();
    final String dirPath = '${_appDir?.path}/Flutter';
    await Directory(dirPath).create(recursive: true);
    String _timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    if(_isVideoCameraSelected){
      _filePath = '$_appDir/${_timeStamp}.mp4';
    }else{
      _filePath = '$_appDir/${_timeStamp}.jpg';
      // _imageFile = await _imageFile.copy(_filePath);
      // String fileFormat = _imageFile.path.split('.').last;
      // await _imageFile.copy('${_appDir}/$_timeStamp.$fileFormat',);
    }
  }

  _captureImage() async {

    _setDirectory();

    var _resultPath;
    Uint8List _unit8List;

    RenderRepaintBoundary boundary = _globalKeyPreview.currentContext.findRenderObject() as RenderRepaintBoundary;
    final dpr = window.devicePixelRatio;
    ui.Image _image = await boundary.toImage(pixelRatio: dpr); // 将image转化成byte
    ByteData byteData = await _image.toByteData(format: ImageByteFormat.png);

    if(byteData != null) {
      if (Platform.isAndroid) {// 如果是Android 的话，直接使用image_gallery_saver就可以了
        // 图片byte数据转化unit8
        _unit8List = byteData.buffer.asUint8List();
        // 调用image_gallery_saver的saveImages方法，返回值就是图片保存后的路径
        _resultPath =  await ImageGallerySaver.saveImage(_unit8List);
        //await ImageGallerySaver.saveFile(filePath);
        // 需要去除掉file://开头。生成要使用的file
        //File saveFile = await File(result.replaceAll("file://", "")).writeAsBytes(_unit8List!);
        if (!_isDirExist) await Directory(_appDir.path).create();
        _saveFile = await File(_filePath).writeAsBytes(_unit8List);
      } else if (Platform.isIOS) {
        // 图片byte数据转化unit8
        _unit8List = byteData.buffer.asUint8List();
        // 判断路径是否存在
        if (!_isDirExist) await Directory(_appDir.path).create();
        // 直接保存，返回的就是保存后的文件
        _saveFile = await File("${_appDir?.path}${DateTime.now().toIso8601String()}.jpg").writeAsBytes(_unit8List);
      }
      set.showToast("保存圖片成功，路徑：${_resultPath['filePath']}");
    }
  }

  _captureVideo() async {
    if (_saveFile != null && _saveFile.path != null) {
      set.setLoadingDialog(context, false);
      await GallerySaver.saveVideo(_saveFile.path, albumName: 'FlutterVideo').then((bool success) {
        if (success) {
          Navigator.pop(context);
          set.showToast("保存影片成功，相簿名：FlutterVideo");
        }
      });
    }
  }

  _cropImage(XFile xFile) async {
    if (xFile != null) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      final croppedFile = await ImageCropper().cropImage(
        //maxWidth: screenWidth.toInt(),
        //maxHeight: screenHeight.toInt(),
        sourcePath: xFile.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: _setUISettings()
      );
      if (croppedFile != null) {
        setState(() {
          _saveFile = File(croppedFile.path);
        });
        _captureImage();
      }
    }
  }

  List<PlatformUiSettings> _setUISettings(){
    return [
      AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.green,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Cropper',
      ),
    ];
  }

}