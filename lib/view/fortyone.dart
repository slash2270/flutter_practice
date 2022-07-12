import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_practice/image/octoimagewidget.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/system/urllauncherwidget.dart';
import 'package:flutter_practice/utils/datetimeutils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;

Set set = Set();

class FortyOne extends StatelessWidget {
  const FortyOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: set.initText('FortyOne Page'),
        ),
        body: const SingleChildScrollView(
          child: FortyOneStateFul(),
        ),
      resizeToAvoidBottomInset: true,
    );
  }
}

class FortyOneStateFul extends StatefulWidget {
  const FortyOneStateFul({Key? key}) : super(key: key);

  @override
  State<FortyOneStateFul> createState() => FortyOneStateFulState();
}

class FortyOneStateFulState extends State<FortyOneStateFul> with WidgetsBindingObserver {

  late String _timeAgo;
  late DateTime loadedTime;
  late List<String> _listTimeAgo;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('$state');
  }

  @override
  void initState() {
    print('FortyOne initState');
    loadedTime = new DateTime.now();
    _listTimeAgo = [];
    _timeAgo = '';
    _setLocaleMessage();
    _setTimeAgo();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    print('FortyOne didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FortyOneStateFul oldWidget) {
    // 元件發生變化
    print('FortyOne didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  /// import 'dart:html'衝突
  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    print('FortyOne setState');
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    print('FortyOne deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    print('FortyOne dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
            child: Column(
              children: [
                set.initText2('UniversalPlatform', Colors.black, Colors.transparent, 24),
                _setPlatForm(set.getPlatForm()),
                set.initSizedBox(20.0),
                _setPlatForm(set.getUniversalPlatform()),
                set.initSizedBox(20.0),
                set.initText2('OctoImage', Colors.black, Colors.transparent, 24),
                OctoImageWidget(),
                set.initSizedBox(20.0),
                set.initText2('TimeAgo', Colors.black, Colors.transparent, 24),
                set.initText2(_timeAgo, Colors.green.shade300, Colors.grey.shade300, 18),
                set.initSizedBox(20.0),
                set.initText2('UrlLauncher', Colors.black, Colors.transparent, 24),
                UrlLauncherWidget()
              ],
            )
        )
    );
  }

  Widget _setPlatForm(String platForm){
    return Container(
      width: 300,
      height: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade300),
      child: Text(platForm, style: GoogleFonts.notoSansJavanese(textStyle: _setTextStyle()), textAlign: TextAlign.center)
    );
  }

  TextStyle _setTextStyle(){
    return TextStyle(fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.lightGreen.shade300);
  }

  _setLocaleMessage(){
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    timeago.setLocaleMessages('ar_short', timeago.ArShortMessages());
    timeago.setLocaleMessages('az', timeago.AzMessages());
    timeago.setLocaleMessages('az_short', timeago.AzShortMessages());
    timeago.setLocaleMessages('ca', timeago.CaMessages());
    timeago.setLocaleMessages('ca_short', timeago.CaShortMessages());
    timeago.setLocaleMessages('cs', timeago.CsMessages());
    timeago.setLocaleMessages('cs_short', timeago.CsShortMessages());
    timeago.setLocaleMessages('da', timeago.DaMessages());
    timeago.setLocaleMessages('da_short', timeago.DaShortMessages());
    timeago.setLocaleMessages('de', timeago.DeMessages());
    timeago.setLocaleMessages('de_short', timeago.DeShortMessages());
    timeago.setLocaleMessages('dv', timeago.DvMessages());
    timeago.setLocaleMessages('dv_short', timeago.DvShortMessages());
    timeago.setLocaleMessages('en', timeago.EnMessages());
    timeago.setLocaleMessages('en_short', timeago.EnShortMessages());
    timeago.setLocaleMessages('es', timeago.EsMessages());
    timeago.setLocaleMessages('es_short', timeago.EsShortMessages());
    timeago.setLocaleMessages('et', timeago.EtMessages());
    timeago.setLocaleMessages('et_short', timeago.EtShortMessages());
    timeago.setLocaleMessages('fa', timeago.FaMessages());
    timeago.setLocaleMessages('fi', timeago.FiMessages());
    timeago.setLocaleMessages('fi_short', timeago.FiShortMessages());
    timeago.setLocaleMessages('fr', timeago.FrMessages());
    timeago.setLocaleMessages('fr_short', timeago.FrShortMessages());
    timeago.setLocaleMessages('gr', timeago.GrMessages());
    timeago.setLocaleMessages('gr_short', timeago.GrShortMessages());
    timeago.setLocaleMessages('he', timeago.HeMessages());
    timeago.setLocaleMessages('he', timeago.HeMessages());
    timeago.setLocaleMessages('he_short', timeago.HeShortMessages());
    timeago.setLocaleMessages('hi', timeago.HiMessages());
    timeago.setLocaleMessages('hi_short', timeago.HiShortMessages());
    timeago.setLocaleMessages('hu', timeago.HuMessages());
    timeago.setLocaleMessages('hu_short', timeago.HuShortMessages());
    timeago.setLocaleMessages('id', timeago.IdMessages());
    timeago.setLocaleMessages('it', timeago.ItMessages());
    timeago.setLocaleMessages('it_short', timeago.ItShortMessages());
    timeago.setLocaleMessages('ja', timeago.JaMessages());
    timeago.setLocaleMessages('km', timeago.KmMessages());
    timeago.setLocaleMessages('km_short', timeago.KmShortMessages());
    timeago.setLocaleMessages('ko', timeago.KoMessages());
    timeago.setLocaleMessages('ku', timeago.KuMessages());
    timeago.setLocaleMessages('ku_short', timeago.KuShortMessages());
    timeago.setLocaleMessages('mn', timeago.MnMessages());
    timeago.setLocaleMessages('mn_short', timeago.MnShortMessages());
    timeago.setLocaleMessages('ms_MY', timeago.MsMyMessages());
    timeago.setLocaleMessages('ms_MY_short', timeago.MsMyShortMessages());
    timeago.setLocaleMessages('nb_NO', timeago.NbNoMessages());
    timeago.setLocaleMessages('nb_NO_short', timeago.NbNoShortMessages());
    timeago.setLocaleMessages('nl', timeago.NlMessages());
    timeago.setLocaleMessages('nl_short', timeago.NlShortMessages());
    timeago.setLocaleMessages('nn_NO', timeago.NnNoMessages());
    timeago.setLocaleMessages('nn_NO_short', timeago.NnNoShortMessages());
    timeago.setLocaleMessages('pl', timeago.PlMessages());
    timeago.setLocaleMessages('pt_BR', timeago.PtBrMessages());
    timeago.setLocaleMessages('pt_BR_short', timeago.PtBrShortMessages());
    timeago.setLocaleMessages('ro', timeago.RoMessages());
    timeago.setLocaleMessages('ro_short', timeago.RoShortMessages());
    timeago.setLocaleMessages('ru', timeago.RuMessages());
    timeago.setLocaleMessages('ru_short', timeago.RuShortMessages());
    timeago.setLocaleMessages('rw', timeago.RwMessages());
    timeago.setLocaleMessages('rw_short', timeago.RwShortMessages());
    timeago.setLocaleMessages('sv', timeago.SvMessages());
    timeago.setLocaleMessages('sv_short', timeago.SvShortMessages());
    timeago.setLocaleMessages('ta', timeago.TaMessages());
    timeago.setLocaleMessages('th', timeago.ThMessages());
    timeago.setLocaleMessages('th_short', timeago.ThShortMessages());
    timeago.setLocaleMessages('tr', timeago.TrMessages());
    timeago.setLocaleMessages('uk', timeago.UkMessages());
    timeago.setLocaleMessages('uk_short', timeago.UkShortMessages());
    timeago.setLocaleMessages('ur', timeago.UrMessages());
    timeago.setLocaleMessages('vi', timeago.ViMessages());
    timeago.setLocaleMessages('vi_short', timeago.ViShortMessages());
    timeago.setLocaleMessages('zh_CN', timeago.ZhCnMessages());
    timeago.setLocaleMessages('zh', timeago.ZhMessages());
  }

  _setTimeAgo() {
    final currentTime = DateTime.now();
    final locale = 'zh';
    Duration duration;
    _listTimeAgo.add(timeago.format(currentTime.subtract(duration = Duration(microseconds: 1 * 44 * 1000)), locale: locale));
    _listTimeAgo.add(timeago.format(currentTime.subtract(duration = Duration(minutes: 1)), locale: locale));
    _listTimeAgo.add(timeago.format(currentTime.subtract(duration = Duration(minutes: 5)), locale: locale));
    _listTimeAgo.add(timeago.format(currentTime.subtract(duration = Duration(minutes: 50)), locale: locale));
    _listTimeAgo.add(timeago.format(currentTime.subtract(duration = Duration(hours: 5)), locale: locale));
    _listTimeAgo.add(timeago.format(currentTime.subtract(duration = Duration(days: 1)), locale: locale));
    _listTimeAgo.add(timeago.format(currentTime.subtract(duration = Duration(days: 5)), locale: locale));
    _listTimeAgo.add(timeago.format(currentTime.subtract(duration = Duration(days: 30)), locale: locale));
    _listTimeAgo.add(timeago.format(currentTime.subtract(duration = Duration(days: 30 * 5)), locale: locale));
    _listTimeAgo.add(timeago.format(currentTime.subtract(duration = Duration(days: 365)), locale: locale));
    _listTimeAgo.add(timeago.format(currentTime.subtract(duration = Duration(days: 365 * 5)), locale: locale));
    _listTimeAgo.add("-");
    _listTimeAgo.add(DateTimeUtils.timeUntil(currentTime.add(duration =Duration(microseconds: 1 * 44 * 1000)), locale));
    _listTimeAgo.add(DateTimeUtils.timeUntil(currentTime.add(duration =Duration(minutes: 1)), locale));
    _listTimeAgo.add(DateTimeUtils.timeUntil(currentTime.add(duration =Duration(minutes: 5)), locale));
    _listTimeAgo.add(DateTimeUtils.timeUntil(currentTime.add(duration =Duration(minutes: 50)), locale));
    _listTimeAgo.add(DateTimeUtils.timeUntil(currentTime.add(duration =Duration(hours: 5)), locale));
    _listTimeAgo.add(DateTimeUtils.timeUntil(currentTime.add(duration =Duration(days: 1)), locale));
    _listTimeAgo.add(DateTimeUtils.timeUntil(currentTime.add(duration = Duration(days: 5)), locale));
    _listTimeAgo.add(DateTimeUtils.timeUntil(currentTime.add(duration = Duration(days: 30)), locale));
    _listTimeAgo.add(DateTimeUtils.timeUntil(currentTime.add(duration = Duration(days: 30 * 5)), locale));
    _listTimeAgo.add(DateTimeUtils.timeUntil(currentTime.add(duration = Duration(days: 365)), locale));
    _listTimeAgo.add(DateTimeUtils.timeUntil(currentTime.add(duration = Duration(days: 365 * 5)), locale));
    _listTimeAgo.forEach((element) {
      _timeAgo += '$element\n';
    });
  }

}