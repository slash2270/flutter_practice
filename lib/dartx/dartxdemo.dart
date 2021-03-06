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
    // ????????????
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
      child: Text('slice?????? = ${_dartX.list.slice(-1)}\n\nslice???????????? = ${_dartX.list.slice(3)}\n\n'
          'slice?????????????????????????????? = ${_dartX.list.slice(1,-2)}\n\nsortedBy&thenBy?????? = $_dogsSort\n\n'
          'distinctBy???????????????????????? = ${_dartX.words.distinctBy((it) => it.length)}\n\nflatten????????? = ${_dartX.nestedList.flatten()}\n\n'
          'minus??????: 123.0 - 3.0 = ${_doubleMinus.minus(3.0)}\n\nchunkWhile???????????? = ${_dartX.numbers.chunkWhile((a, b) => a + 1 == b)}\n\n'
          'splitWhen?????????????????? = ${_dartX.numbers.splitWhen((a, b) => a + 1 == b)}\n\nbuildString?????????????????? = $_stringBuilder\n\n'
          'ordinal??????: ???1=${1.ordinal()} ???99=${99.ordinal()} ???100=${100.ordinal()} ???9999=${9999.ordinal()}\n\ncapitalize?????????: abcd=${'abcd'.capitalize()} Abcd=${'Abcd'.capitalize()}\n\n'
          'decapitalize?????????: abcd=${'abcd'.decapitalize()} Abcd=${'Abcd'.decapitalize()}\n\n??????isAscii: abc123 !,.~"=${'abc123 !,.~'.isAscii} ??3=${'??3'.isAscii}\n\n'
          '??????isBlank: ???=${'  .  '.isBlank} ???=${'     '.isBlank}\n\n??????isDouble: ???=${''.isDouble} a=${'a'.isDouble} 1=${'1'.isDouble} 1.0=${'1.0'.isDouble} 12345.67890=${'12345.67890'.isDouble} 1,000=${'1,000'.isDouble}\n\n'
          '??????isInt: ???=${''.isInt} a=${'a'.isInt} 1=${'1'.isInt} 1.0=${'1.0'.isInt} 1,000=${'1,000'.isInt}\n\n??????isLatin1: ??????=${'??????'.isLatin1} ??=${'??'.isLatin1}\n\n'
          '??????isLowerCase: abc=${'abc'.isLowerCase} abC=${'abC'.isLowerCase} ??????=${'   '.isLowerCase} ???=${''.isLowerCase}\n\n??????isNotBlank: ???=${''.isNotBlank} ???=${' . '.isNotBlank}\n\n'
          '??????isNullOrEmpty: ??????=${null.isNullOrEmpty} ???=${''.isNullOrEmpty} ??????=${' '.isNullOrEmpty} n=${'\n'.isNullOrEmpty}\n\n??????isNotNullOrEmpty: ??????=${null.isNotNullOrEmpty} ???=${''.isNotNullOrEmpty} ??????=${' '.isNotNullOrEmpty} n=${'\n'.isNotNullOrEmpty}'
          '??????isNullOrBlank: ??????=${null.isNullOrBlank} ???=${''.isNullOrBlank} ??????=${' '.isNullOrBlank} n=${'\n'.isNullOrBlank} foo=${' foo '.isNullOrBlank}\n\n??????isNotNullOrBlank: ??????=${null.isNotNullOrBlank} ???=${''.isNotNullOrBlank} ??????=${' '.isNotNullOrBlank} n=${'\n'.isNotNullOrBlank} foo=${' foo '.isNotNullOrBlank}\n\n'
          '??????isUpperCase: ABC=${'ABC'.isUpperCase} ABc=${'ABc'.isUpperCase} ??????=${'   '.isUpperCase} ???=${''.isUpperCase}\n\n??????md5: abc=${'abc'.md5} ????????????????????????????????????${'????????????????????????????????????'.md5}\n\n'
          '??????urlEncode = ${encodedUrl}\n\n??????urlDecode = ${decodeUrl}\n\n????????????removePrefix:\nJames Bond -> ${'James Bond'.removePrefix('James ')}\n\n????????????removeSuffix:\n100ms -> ${'100ms'.removeSuffix('ms')}\n\n????????????removeSurrounding:\n<p>Some HTML</p> -> ${'<p>Some HTML</p>'.removeSurrounding(prefix: '<p>', suffix: '</p>')}\n\n'
          'slice?????????:\n(0,6)=${'awesomeString'.slice(0,6)} (7)=${'awesomeString'.slice(7)}\n\n??????doubleOrNull:\n1=${'1'.toDoubleOrNull()} 1.2=${'1.2'.toDoubleOrNull()} ???=${''.toDoubleOrNull()}\n\n'
          '????????????toInt: 1=${'1'.toInt()} 2=${'100'.toInt(radix: 2)} 16=${'100'.toInt(radix: 16)}\n\n????????????toIntOrNull:\n12345=${'12345'.toIntOrNull()} 123-45=${'123-45'.toIntOrNull()} 16=${'100'.toIntOrNull(radix: 16)}\n\n'
          '???UTF-8:\n???=${''.toUtf8()} string=${'hi'.toUtf8()} emoji=${'????'.toUtf8()}\n\n???UTF-16:\n???=${''.toUtf16()} string=${'hi'.toUtf16()} emoji=${'????'.toUtf16()}\n\n'
          '?????????orEmpty: ???=${nullableStr.orEmpty()}\n\n??????matches as=${'as'.matches(RegExp('^.s\$'))} mst=${'mst'.matches(RegExp('^.s\$'))}\n\n'
          '???????????????:\nsecondsInADay = $secondsInADay\ntotalTime = ${totalTime}\noneWeekLater = ${oneWeekLater}\n\n????????????coerceIn:\n123In0~1000 = ${123.coerceIn(0, 1000)}\n-123OutOf0~1000 = ${-123.coerceIn(0, 1000)}\n\n'
          '???Byte:\n1234567890 = ${1234567890.toBytes()}\n\n???Char: <1114111${123456.toChar()}\n\n??????range:\nRange1=$_strRange1\tRange2=$_strRange2\n\n'
          '????????????partial = $_strPartial\n\n??????name:\nFileName=${_file.name}\nFileNameWithoutExtension=${_file.nameWithoutExtension}\n\n'
          '????????????appendString:\n$_strAppendString\n\n????????????isWithin = $_isWithinDir\n\n???????????????file:\n$_strFileDir\n\n???????????????:\n$_strDir\n\n'
          '????????????parentDirectory:\nsupport=${_parentDirectory1.path}\ndocument=${_parentDirectory2.path}\ntemporary=${_parentDirectory3.path}\nlibrary=${_parentDirectory3.path}\n\n'
          '????????????contains:\nfile=${_isContains1}\tdirectory=${_isContains2}\trecursive=${_isContains3}\trecursive=${_isContains4}'
          //'\n\n????????????containsSync:\nfile=${_isContainsSync1}\tdirectory=${_isContainsSync2}\trecursive=${_isContainsSync3}\trecursive=${_isContainsSync4}'
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
    // ???????????????1??????
    for (final i in 1.rangeTo(5)) {
      _strRange1 += i.toString() + " "; // 1, 2, 3, 4, 5
    }
    // ???????????????????????????
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