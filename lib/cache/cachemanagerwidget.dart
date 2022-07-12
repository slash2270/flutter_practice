// @dart = 2.9

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_practice/set.dart';

class CacheManagerWidget extends StatefulWidget {
  const CacheManagerWidget({Key key}) : super(key: key);

  @override
  State<CacheManagerWidget> createState() => CacheManagerWidgetState();
}

class CacheManagerWidgetState extends State<CacheManagerWidget> with WidgetsBindingObserver {

  GestureDetector _gestureDetector;
  Stream<FileResponse> _fileStream;
  String _url = 'https://blurha.sh/assets/images/img1.jpg';
  FileInfo _infoCache, _infoFile;
  File _file, _singleFile;
  Chip _chip;
  Set _set;

  @override
  void initState() {
    _set = Set();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(_file != null){
      return Column(
        children: [
          Image(
            image: CachedNetworkImageProvider(_url,),
          ),
          SafeArea(
              child: Image.file(_file,),
          ),
          _set.initSizedBox(20.0),
          Wrap(
            spacing: 15.0, // 主轴(水平)方向间距
            runSpacing: 5.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.center, //沿主轴方向居中
            children: <Widget>[
              _gestureDetector = GestureDetector(
                  child: _chip = Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.green.shade300, child: _set.initIcon(Icons.download)),
                      label: _set.initText('下載緩存')
                  ),
                  onTap: () {
                    _downloadCache();
                  }
              ),
              _gestureDetector = GestureDetector(
                  child: _chip = Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.green.shade300, child: _set.initIcon(Icons.download)),
                      label: _set.initText('下載文件')
                  ),
                  onTap: () {
                    _downloadFile();
                  }
              ),
              _gestureDetector = GestureDetector(
                  child: _chip = Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.green.shade300, child: _set.initIcon(Icons.clear)),
                      label: _set.initText('清理緩存')
                  ),
                  onTap: () => _clearCache()
              ),
              _gestureDetector = GestureDetector(
                  child: _chip = Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.green.shade300, child: _set.initIcon(Icons.remove)),
                      label: _set.initText('移除下載')
                  ),
                  onTap: () => _removeFile()
              ),
            ],
          )
        ],
      );
    }else{
      return Column(
        children: [
          Wrap(
            spacing: 15.0, // 主轴(水平)方向间距
            runSpacing: 5.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.center, //沿主轴方向居中
            children: <Widget>[
              _gestureDetector = GestureDetector(
                  child: _chip = Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.green.shade300, child: _set.initIcon(Icons.download)),
                      label: _set.initText('下載緩存')
                  ),
                  onTap: () {
                    _downloadCache();
                  }
              ),
              _gestureDetector = GestureDetector(
                  child: _chip = Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.green.shade300, child: _set.initIcon(Icons.download)),
                      label: _set.initText('下載文件')
                  ),
                  onTap: () {
                    _downloadFile();
                  }
              ),
              _gestureDetector = GestureDetector(
                  child: _chip = Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.green.shade300, child: _set.initIcon(Icons.clear)),
                      label: _set.initText('清理緩存')
                  ),
                  onTap: () => _clearCache()
              ),
              _gestureDetector = GestureDetector(
                  child: _chip = Chip(
                      avatar: CircleAvatar(backgroundColor: Colors.green.shade300, child: _set.initIcon(Icons.remove)),
                      label: _set.initText('移除下載')
                  ),
                  onTap: () => _removeFile()
              ),
            ],
          )
        ],
      );
    }
  }

  // '/data/user/0/home.slashtang.flutter_practice/cache/43bd8185-9efd-435e-874d-9cf4d7877eae4144348071461532478.jpg'
  // '/data/user/0/home.slashtang.flutter_practice/cache/libCachedImageData/8bbf8db0-e633-11ec-bfe8-c7c96bd91850.jpg'


  void _downloadCache() async{
    _infoCache = await DefaultCacheManager().getFileFromCache(_url);
    if(_infoCache != null){
      _singleFile = await DefaultCacheManager().getSingleFile(_url);
    }
    setState(() {
      _file = File(_singleFile.path);
      print('cacheFile $_file');
    });
  }

  void _downloadFile() async {
    _infoFile = await DefaultCacheManager().downloadFile(_url);
    setState(() {
      if(_infoFile != null){
        _file = File(_infoFile.file.path);
        print('downloadFile $_file');
      }
    });
  }

  void _downloadStream() {
    setState(() {
      _fileStream = DefaultCacheManager().getFileStream(_url, withProgress: true);
    });
  }

  void _clearCache() {
    DefaultCacheManager().emptyCache();
    setState(() {
      _file = null;
      //_fileStream = null;
    });
  }

  void _removeFile() {
    DefaultCacheManager().removeFile(_url).then((value) {
      //ignore: avoid_print
      print('CacheManager File removed');
    }).onError((error, stackTrace) {
      //ignore: avoid_print
      print(error);
    });
    setState(() {
      _file = null;
      //_fileStream = null;
    });
  }

}