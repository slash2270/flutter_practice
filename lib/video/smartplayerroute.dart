// @dart = 2.9

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/video/smartplayercontroller.dart';
import 'package:flutter_practice/video/smartplayerwidget.dart';

import '../utils/eventid.dart';

class SmartPlayerRoute extends StatefulWidget {
  const SmartPlayerRoute({Key key}) : super(key: key);

  @override
  State<SmartPlayerRoute> createState() => SmartPlayerRouteState();
}

class SmartPlayerRouteState extends State<SmartPlayerRoute> with WidgetsBindingObserver {

  SmartPlayerController player;
  //輸入需要播放的RTMP/RTSP url
  TextEditingController playback_url_controller_;
  //Event事件回撥顯示
  TextEditingController event_controller_;
  double aspectRatio = 4.0 / 3.0;
  bool is_playing_ = false;
  bool is_mute_ = false;
  var rotate_degrees_ = 0;

  Widget smartPlayerView() {
    return SmartPlayerWidget(
      onSmartPlayerCreated: onSmartPlayerCreated,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    if (kDebugMode) {
      print('ThirtyTwo initState');
    }
    player = SmartPlayerController();
    event_controller_ = TextEditingController();
    playback_url_controller_ = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('ThirtyTwo didChangeDependencies');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SmartPlayerRoute oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('ThirtyTwo didUpdateWidget');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('ThirtyTwo setState');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('ThirtyTwo deactivate');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('ThirtyTwo dispose');
    }
    player.dispose();
    event_controller_.dispose();
    playback_url_controller_.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Container(
          color: Colors.black,
          child: AspectRatio(
            child: smartPlayerView(),
            aspectRatio: aspectRatio,
          ),
        ),
        new TextField(
          controller: playback_url_controller_,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            icon: Icon(Icons.link),
            labelText: '請輸入RTSP/RTMP url',
          ),
          autofocus: false,
        ),
        new Row(
          children: [
            new RaisedButton(
                onPressed: this.onSmartPlayerStartPlay,
                child: new Text("開始播放")),
            new Container(width: 20),
            new RaisedButton(
                onPressed: this.onSmartPlayerStopPlay,
                child: new Text("停止播放")),
            new Container(width: 20),
            new RaisedButton(
                onPressed: this.onSmartPlayerMute,
                child: new Text("實時靜音")),
          ],
        ),
        new Row(
          children: [
            new RaisedButton(
                onPressed: this.onSmartPlayerSwitchUrl,
                child: new Text("實時切換URL")),
            new Container(width: 20),
            new RaisedButton(
                onPressed: this.onSmartPlayerSetRotation,
                child: new Text("實時旋轉View")),
          ],
        ),
        new TextField(
          controller: event_controller_,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            icon: Icon(Icons.event_note),
            labelText: 'Event狀態回撥',
          ),
          autofocus: false,
        ),
      ],
    );
  }

  void _eventCallback(int code, String param1, String param2, String param3) {
    String event_str;

    switch (code) {
      case EVENTID.EVENT_DANIULIVE_ERC_PLAYER_STARTED:
        event_str = "開始..";
        break;
      case EVENTID.EVENT_DANIULIVE_ERC_PLAYER_CONNECTING:
        event_str = "連線中..";
        break;
      case EVENTID.EVENT_DANIULIVE_ERC_PLAYER_CONNECTION_FAILED:
        event_str = "連線失敗..";
        break;
      case EVENTID.EVENT_DANIULIVE_ERC_PLAYER_CONNECTED:
        event_str = "連線成功..";
        break;
      case EVENTID.EVENT_DANIULIVE_ERC_PLAYER_DISCONNECTED:
        event_str = "連線斷開..";
        break;
      case EVENTID.EVENT_DANIULIVE_ERC_PLAYER_STOP:
        event_str = "停止播放..";
        break;
      case EVENTID.EVENT_DANIULIVE_ERC_PLAYER_RESOLUTION_INFO:
        event_str = "解析度資訊: width: " + param1 + ", height: " + param2;
        setState(() {
          aspectRatio = double.parse(param1) / double.parse(param2);
          //print('change aspectRatio:$aspectRatio');
        });
        break;
      case EVENTID.EVENT_DANIULIVE_ERC_PLAYER_NO_MEDIADATA_RECEIVED:
        event_str = "收不到媒體資料，可能是url錯誤..";
        break;
      case EVENTID.EVENT_DANIULIVE_ERC_PLAYER_SWITCH_URL:
        event_str = "切換播放URL..";
        break;
      case EVENTID.EVENT_DANIULIVE_ERC_PLAYER_CAPTURE_IMAGE:
        event_str = "快照: " + param1 + " 路徑: " + param3;

        if (int.parse(param1) == 0) {
          print("擷取快照成功。.");
        } else {
          print("擷取快照失敗。.");
        }
        break;
      case EVENTID.EVENT_DANIULIVE_ERC_PLAYER_RECORDER_START_NEW_FILE:
        event_str = "[record] new file: " + param3;
        break;
      case EVENTID.EVENT_DANIULIVE_ERC_PLAYER_ONE_RECORDER_FILE_FINISHED:
        event_str = "[record] record finished: " + param3;
        break;
      case EVENTID.EVENT_DANIULIVE_ERC_PLAYER_START_BUFFERING:
      //event_str = "Start Buffering";
        break;
      case EVENTID.EVENT_DANIULIVE_ERC_PLAYER_BUFFERING:
        event_str = "Buffering: " + param1 + "%";
        break;
      case EVENTID.EVENT_DANIULIVE_ERC_PLAYER_STOP_BUFFERING:
      //event_str = "Stop Buffering";
        break;
      case EVENTID.EVENT_DANIULIVE_ERC_PLAYER_DOWNLOAD_SPEED:
        event_str = "download_speed:" +
            (double.parse(param1) * 8 / 1000).toStringAsFixed(0) +
            "kbps" +
            ", " +
            (double.parse(param1) / 1024).toStringAsFixed(0) +
            "KB/s";
        break;
    }

    event_controller_.text = event_str;
  }

  void onSmartPlayerCreated(SmartPlayerController controller) async {
    player = controller;
    player.setEventCallback(_eventCallback);

    var ret = -1;

    //設定video decoder模式
    var is_video_hw_decoder = 0;
    if (defaultTargetPlatform == TargetPlatform.android) {
      ret = await player.setVideoDecoderMode(is_video_hw_decoder);
    }
    else if(defaultTargetPlatform == TargetPlatform.iOS) {
      is_video_hw_decoder = 1;
      ret = await player.setVideoDecoderMode(is_video_hw_decoder);
    }
    //設定緩衝時間
    var play_buffer = 100;
    ret = await player.setBuffer(play_buffer);

    //設定快速啟動
    var is_fast_startup = 1;
    ret = await player.setFastStartup(is_fast_startup);

    //是否開啟低延遲模式
    var is_low_latency_mode = 0;
    ret = await player.setPlayerLowLatencyMode(is_low_latency_mode);
    //set report download speed(預設5秒一次回撥 使用者可自行調整report間隔)
    ret = await player.setReportDownloadSpeed(1, 2);

    //設定RTSP超時時間
    var rtsp_timeout = 10;
    ret = await player.setRTSPTimeout(rtsp_timeout);
    var is_auto_switch_tcp_udp = 1;
    ret = await player.setRTSPAutoSwitchTcpUdp(is_auto_switch_tcp_udp);

    // 設定RTSP TCP模式
    //ret = await player.setRTSPTcpMode(1);
    //第一次啟動 為方便測試 設定個初始url
    playback_url_controller_.text = "rtmp://live.hkstv.hk.lxdns.com/live/hks2";
  }

  Future<void> onSmartPlayerStartPlay() async {
    var ret = -1;
    if (playback_url_controller_.text.length < 8) {
      playback_url_controller_.text =
      "rtmp://live.hkstv.hk.lxdns.com/live/hks1"; //給個初始url
    }
    //實時靜音設定
    ret = await player.setMute(is_mute_ ? 1 : 0);
    if (!is_playing_) {
      ret = await player.setUrl(playback_url_controller_.text);
      ret = await player.startPlay();
      if (ret == 0) {
        is_playing_ = true;
      }
    }
  }

  Future<void> onSmartPlayerStopPlay() async {
    if (is_playing_) {
      await player.stopPlay();
      playback_url_controller_.clear();
      is_playing_ = false;
      is_mute_ = false;
    }
  }

  Future<void> onSmartPlayerMute() async {
    if (is_playing_) {
      is_mute_ = !is_mute_;
      await player.setMute(is_mute_ ? 1 : 0);
    }
  }

  Future<void> onSmartPlayerSwitchUrl() async {
    if (is_playing_) {
      if (playback_url_controller_.text.length < 8) {
        playback_url_controller_.text =
        "rtmp://live.hkstv.hk.lxdns.com/live/hks2";
      }
      await player.switchPlaybackUrl(playback_url_controller_.text);
    }
  }

  Future<void> onSmartPlayerSetRotation() async {
    if (is_playing_) {
      rotate_degrees_ += 90;
      rotate_degrees_ = rotate_degrees_ % 360;
      if (0 == rotate_degrees_) {
        print("旋轉90度");
      } else if (90 == rotate_degrees_) {
        print("旋轉180度");
      } else if (180 == rotate_degrees_) {
        print("旋轉270度");
      } else if (270 == rotate_degrees_) {
        print("不旋轉");
      }
      await player.setRotation(rotate_degrees_);
    }
  }

}