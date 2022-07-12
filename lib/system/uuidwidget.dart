import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class UuidWidget extends StatefulWidget {
  const UuidWidget({Key? key}) : super(key: key);

  @override
  State<UuidWidget> createState() => UuidWidgetState();
}

class UuidWidgetState extends State<UuidWidget> with WidgetsBindingObserver {

  late Set _set;
  late Uuid _uuid;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('$state');
  }

  @override
  void initState() {
    print('UuidWidget initState');
    _set = Set();
    _uuid = Uuid();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Generate a v1 (time-based) id
    var v1 = _uuid.v1(); // -> '6c84fb90-12c4-11e1-840d-7b25c5ee775a'
    var v1_exact = _uuid.v1(options: {
      'node': [0x01, 0x23, 0x45, 0x67, 0x89, 0xab],
      'clockSeq': 0x1234,
      'mSecs': DateTime.utc(2011, 11, 01).millisecondsSinceEpoch,
      'nSecs': 5678
    }); // -> '710b962e-041c-11e1-9234-0123456789ab'
    // Generate a v4 (random) id
    var v4 = _uuid.v4(); // -> '110ec58a-a0f2-4ac4-8393-c866d813b8d1'
    // Generate a v4 (crypto-random) id
    var v4_crypto = _uuid.v4(options: {'rng': UuidUtil.cryptoRNG});
    // -> '110ec58a-a0f2-4ac4-8393-c866d813b8d1'
    // Generate a v5 (namespace-name-sha1-based) id
    var v5 = _uuid.v5(Uuid.NAMESPACE_URL, 'www.google.com');
    // -> 'c74a196f-f19d-5ea9-bffd-a2742432fc9c'
    return Wrap(
      spacing: 15.0, // 主轴(水平)方向间距
      runSpacing: 5.0, // 纵轴（垂直）方向间距
      alignment: WrapAlignment.center, //沿主轴方向居中
      children: <Widget>[
        Chip(
            avatar: CircleAvatar(backgroundColor: Colors.green.shade300, child: _set.initText('V1'),),
            label: _set.initText('$v1')
        ),
        Chip(
            avatar: CircleAvatar(backgroundColor: Colors.green.shade300, child: _set.initText('V1Exact')),
            label: _set.initText('$v1_exact')
        ),
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.green.shade300, child: _set.initText('V4')),
          label: _set.initText('$v4'),
        ),
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.green.shade300, child: _set.initText('V4Crypto')),
          label: _set.initText('$v4_crypto'),
        ),
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.green.shade300, child: _set.initText('V5')),
          label: _set.initText('$v5'),
        ),
      ],
    );
  }

}