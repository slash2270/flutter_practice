import 'dart:io';
import 'dart:ui';

// ignore_for_file: unused_local_variable
import 'package:dartx/dartx.dart';
import 'package:dartx/dartx_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/dartx/dartx.dart';
import 'package:flutter_practice/set.dart';
import 'package:path_provider/path_provider.dart';
import 'package:time/time.dart';

class DartXDemo extends StatefulWidget {
  const DartXDemo({Key? key}) : super(key: key);

  @override
  State<DartXDemo> createState() => _DartXDemoState();
}

class _DartXDemoState extends State<DartXDemo> with WidgetsBindingObserver, TickerProviderStateMixin {

  late Set _set;
  late SizedBox sizedBox;
  late DartX _dartX;
  late double _doubleMinus;
  late String _dogsSort, _stringBuilder, _strRange1, _strRange2, _strPartial, _strAppendString, _strFileDir, _strDir;
  late File _file, _fileManifest;
  late Directory _directory, _directorySrcMain, _parentDirectory1, _parentDirectory2, _parentDirectory3, _parentDirectory4;
  late bool _isWithinDir, _isContains1, _isContains2, _isContains3, _isContains4, _isContainsSync1, _isContainsSync2, _isContainsSync3, _isContainsSync4;
  bool _isContain1 = false, _isContain2 = false, _isContain3 = false, _isContain4 = false;
  String? nullableStr;

  @override
  void initState() {
    print('OctoImage initState');
    _set = Set();
    _dartX = DartX();
    _doubleMinus = 123.0;
    _dogsSort = '';
    _stringBuilder = '';
    _strRange1 = '';
    _strRange2 = '';
    _strPartial = '';
    _strAppendString = '';
    _file = File('');
    _isWithinDir = false;
    _directory = Directory('');
    _directorySrcMain = Directory('');
    _fileManifest = File('');
    _parentDirectory1 = Directory('parent/dir');
    _parentDirectory2 = Directory('parent/dir');
    _parentDirectory3 = Directory('parent/dir');
    _parentDirectory4 = Directory('parent/dir');
    _isContains1 = false;
    _isContains2 = false;
    _isContains3 = false;
    _isContains4 = false;
    _isContainsSync1 = false;
    _isContainsSync2 = false;
    _isContainsSync3 = false;
    _isContainsSync4 = false;
    _setDogsSort();
    _setStringBuilder();
    _setRange();
    _setPartial();
    _setFile();
    _setAppendString();
    _setIsWithin();
    _setFileDir();
    _setDirectory();
    _setParentDirectory();
    _setContains();
    _isContains();
    //_setContainsSync();
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    String url, encodedUrl, decodeUrl;

    url = 'Hello Ladies + Gentlemen, a signed OAuth request!';
    encodedUrl = url.urlEncode;

    url = 'Hello%20Ladies%20+%20Gentlemen,%20a%20signed%20OAuth%20request!';
    decodeUrl = encodedUrl.urlDecode;

    int secondsInADay = 1.days.inSeconds;
    Duration totalTime = 12.5.seconds + 101.milliseconds + 2.5.minutes;
    DateTime oneWeekLater = DateTime.now() + 1.weeks;

    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0, bottom: 20.0),
      child: Text('slice最後 = ${_dartX.list.slice(-1)}\n\nslice最後一半 = ${_dartX.list.slice(3)}\n\n'
          'slice除了第一個和最後一個 = ${_dartX.list.slice(1,-2)}\n\nsortedBy&thenBy排序 = $_dogsSort\n\n'
          'distinctBy按不同的長度展開 = ${_dartX.words.distinctBy((it) => it.length)}\n\nflatten扁平化 = ${_dartX.nestedList.flatten()}\n\n'
          'minus減法: 123.0 - 3.0 = ${_doubleMinus.minus(3.0)}\n\nchunkWhile同時分塊 = ${_dartX.numbers.chunkWhile((a, b) => a + 1 == b)}\n\n'
          'splitWhen什麼時候分開 = ${_dartX.numbers.splitWhen((a, b) => a + 1 == b)}\n\nbuildString字符串生成器 = $_stringBuilder\n\n'
          'ordinal序數: 數1=${1.ordinal()} 數99=${99.ordinal()} 數100=${100.ordinal()} 數9999=${9999.ordinal()}\n\ncapitalize大寫化: abcd=${'abcd'.capitalize()} Abcd=${'Abcd'.capitalize()}\n\n'
          'decapitalize小寫化: abcd=${'abcd'.decapitalize()} Abcd=${'Abcd'.decapitalize()}\n\n判斷isAscii: abc123 !,.~"=${'abc123 !,.~'.isAscii} §3=${'§3'.isAscii}\n\n'
          '判斷isBlank: 點=${'  .  '.isBlank} 空=${'     '.isBlank}\n\n判斷isDouble: 空=${''.isDouble} a=${'a'.isDouble} 1=${'1'.isDouble} 1.0=${'1.0'.isDouble} 12345.67890=${'12345.67890'.isDouble} 1,000=${'1,000'.isDouble}\n\n'
          '判斷isInt: 空=${''.isInt} a=${'a'.isInt} 1=${'1'.isInt} 1.0=${'1.0'.isInt} 1,000=${'1,000'.isInt}\n\n判斷isLatin1: §Êü=${'§Êü'.isLatin1} ő=${'ő'.isLatin1}\n\n'
          '判斷isLowerCase: abc=${'abc'.isLowerCase} abC=${'abC'.isLowerCase} 空格=${'   '.isLowerCase} 空=${''.isLowerCase}\n\n判斷isNotBlank: 空=${''.isNotBlank} 點=${' . '.isNotBlank}\n\n'
          '判斷isNullOrEmpty: 空值=${null.isNullOrEmpty} 空=${''.isNullOrEmpty} 空格=${' '.isNullOrEmpty} n=${'\n'.isNullOrEmpty}\n\n判斷isNotNullOrEmpty: 空值=${null.isNotNullOrEmpty} 空=${''.isNotNullOrEmpty} 空格=${' '.isNotNullOrEmpty} n=${'\n'.isNotNullOrEmpty}'
          '判斷isNullOrBlank: 空值=${null.isNullOrBlank} 空=${''.isNullOrBlank} 空格=${' '.isNullOrBlank} n=${'\n'.isNullOrBlank} foo=${' foo '.isNullOrBlank}\n\n判斷isNotNullOrBlank: 空值=${null.isNotNullOrBlank} 空=${''.isNotNullOrBlank} 空格=${' '.isNotNullOrBlank} n=${'\n'.isNotNullOrBlank} foo=${' foo '.isNotNullOrBlank}\n\n'
          '判斷isUpperCase: ABC=${'ABC'.isUpperCase} ABc=${'ABc'.isUpperCase} 空格=${'   '.isUpperCase} 空=${''.isUpperCase}\n\n計算md5: abc=${'abc'.md5} ഐ⌛酪Б👨‍👨‍👧‍👦${'ഐ⌛酪Б👨‍👨‍👧‍👦'.md5}\n\n'
          '編碼urlEncode = ${encodedUrl}\n\n解碼urlDecode = ${decodeUrl}\n\n刪除前綴removePrefix:\nJames Bond -> ${'James Bond'.removePrefix('James ')}\n\n刪除後綴removeSuffix:\n100ms -> ${'100ms'.removeSuffix('ms')}\n\n刪除環繞removeSurrounding:\n<p>Some HTML</p> -> ${'<p>Some HTML</p>'.removeSurrounding(prefix: '<p>', suffix: '</p>')}\n\n'
          'slice取範圍:\n(0,6)=${'awesomeString'.slice(0,6)} (7)=${'awesomeString'.slice(7)}\n\n判斷doubleOrNull:\n1=${'1'.toDoubleOrNull()} 1.2=${'1.2'.toDoubleOrNull()} 空=${''.toDoubleOrNull()}\n\n'
          '解析整數toInt: 1=${'1'.toInt()} 2=${'100'.toInt(radix: 2)} 16=${'100'.toInt(radix: 16)}\n\n解析整數toIntOrNull:\n12345=${'12345'.toIntOrNull()} 123-45=${'123-45'.toIntOrNull()} 16=${'100'.toIntOrNull(radix: 16)}\n\n'
          '轉UTF-8:\n空=${''.toUtf8()} string=${'hi'.toUtf8()} emoji=${'😄'.toUtf8()}\n\n轉UTF-16:\n空=${''.toUtf16()} string=${'hi'.toUtf16()} emoji=${'😄'.toUtf16()}\n\n'
          '判斷空orEmpty: 空=${nullableStr.orEmpty()}\n\n正則matches as=${'as'.matches(RegExp('^.s\$'))} mst=${'mst'.matches(RegExp('^.s\$'))}\n\n'
          '時間利用率:\nsecondsInADay = $secondsInADay\ntotalTime = ${totalTime}\noneWeekLater = ${oneWeekLater}\n\n數字範圍coerceIn:\n123In0~1000 = ${123.coerceIn(0, 1000)}\n-123OutOf0~1000 = ${-123.coerceIn(0, 1000)}\n\n'
          '轉Byte:\n1234567890 = ${1234567890.toBytes()}\n\n轉Char: <1114111${123456.toChar()}\n\n範圍range:\nRange1=$_strRange1\tRange2=$_strRange2\n\n'
          '引數函式partial = $_strPartial\n\n檔案name:\nFileName=${_file.name}\nFileNameWithoutExtension=${_file.nameWithoutExtension}\n\n'
          '附加文字appendString:\n$_strAppendString\n\n檢查目錄isWithin = $_isWithinDir\n\n檔案資料夾file:\n$_strFileDir\n\n目錄資料夾:\n$_strDir\n\n'
          '父資料夾parentDirectory:\nsupport=${_parentDirectory1.path}\ndocument=${_parentDirectory2.path}\ntemporary=${_parentDirectory3.path}\nlibrary=${_parentDirectory3.path}\n\n'
          '包含異步contains:\nfile=${_isContains1}\tdirectory=${_isContains2}\trecursive=${_isContains3}\trecursive=${_isContains4}'
          //'\n\n包含同步containsSync:\nfile=${_isContainsSync1}\tdirectory=${_isContainsSync2}\trecursive=${_isContainsSync3}\trecursive=${_isContainsSync4}'
          ,
        style: TextStyle(color: Colors.black, backgroundColor: Colors.transparent, fontSize: 18, fontWeight: FontWeight.w300,
            fontFamily: 'Milonga',
            fontFeatures: <FontFeature>[
              FontFeature.alternativeFractions()
            ]
        ),
        textAlign: TextAlign.start, overflow: TextOverflow.visible, textScaleFactor: 1.0,
        textWidthBasis: TextWidthBasis.longestLine, textHeightBehavior: TextHeightBehavior(),
        textDirection: TextDirection.ltr,
      ),
    );
  }

  _setDogsSort() {
    setState(() {});
    _dartX.dogs.sortedBy((dog) => dog.name).thenByDescending((dog) => dog.age).forEach((element) {
      _dogsSort += '${element.name}${element.age}, ';
    });
  }

  _setStringBuilder() {
    setState(() {});
    _stringBuilder = buildString((sb) {
      for (var i = 0; i < 10; i++) {
        sb.write(i);
      }
    });
  }

  _setRange() {
    setState(() {});
    // 向上，默認1步長
    for (final i in 1.rangeTo(5)) {
      _strRange1 += i.toString() + " "; // 1, 2, 3, 4, 5
    }
    // 使用自定義步驟向下
    for (final i in 10.rangeTo(2).step(2)) {
      _strRange2 += i.toString() + " ";
    }
  }

  _setPartial() {
    setState(() {
    void greet(String firstName, String lastName) {
      _strPartial += 'Hi $firstName $lastName!';
    }
    final greetStark = greet.partial('Slash');
    greetStark('Parker');
    greetStark('Stark');
    });
  }

  _setFile() {
    _file = File('some/path/testFile.dart');
  }

  _setAppendString() async{
    //await _file.appendString(' + appendString');
    setState(() {
      _strAppendString = '${_file.name}/${_file.nameWithoutExtension}';
    });
  }

  _setIsWithin() {
    _directory = Directory('some/path');
    _file = File('some/path/file.dart');
    setState(() {
      _isWithinDir = _file.isWithin(_directory);
    });
  }

  _setFileDir() {
    _directory = Directory('flutter-app/android');
    _fileManifest = _directory.file("app/src/main/AndroidManifest.xml");
    setState(() {
      _strFileDir = _fileManifest.path;
    });
  }

  _setDirectory() {
    _directory = Directory('flutter-app/android');
    _directorySrcMain = _directory.directory("app/src/main");
    setState(() {
      _strDir = _directorySrcMain.path;
    });
  }

  _setParentDirectory() async{
    _parentDirectory1 = await getApplicationSupportDirectory();
    _parentDirectory2 = await getApplicationDocumentsDirectory();
    _parentDirectory3 = await getTemporaryDirectory();
    _parentDirectory4 = await getLibraryDirectory();
  }

  _setContains() async{
    _isContain1 = await _parentDirectory1.contains(_file);
    _isContain2 = await _parentDirectory2.contains(_directory);
    _isContain3 = await _parentDirectory3.contains(_file, recursive: true);
    _isContain4 = await _parentDirectory4.contains(_directory, recursive: true);
  }

  _isContains(){
    setState(() {
      _isContains1 = _isContain1;
      _isContains2 = _isContain2;
      _isContains3 = _isContain3;
      _isContains4 = _isContain4;
    });
  }

  _setContainsSync() {
    setState(() {
      _isContainsSync1 = _parentDirectory1.containsSync(_file);
      _isContainsSync2 = _parentDirectory2.containsSync(_directory);
      _isContainsSync3 = _parentDirectory3.containsSync(_file, recursive: true);
      _isContainsSync4 = _parentDirectory4.containsSync(_directory, recursive: true);
    });
  }

}