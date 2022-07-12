// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';
import 'package:flutter_practice/utils/constants.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:dotenv/dotenv.dart' show load, env;
import 'package:flutter_practice/set.dart';

class IpiftyDemo  extends StatefulWidget {
  const IpiftyDemo ({Key? key}) : super(key: key);

  @override
  _IpiftyDemoState createState() => _IpiftyDemoState();
}

class _IpiftyDemoState extends State<IpiftyDemo> {

  late Set set;
  late String ipifyApiKeyName, getIpify = '', ipV4, ipV6, ipV4json, ipV64json;
  late var IPIFY_API_KEY;
  late var myGeo, someGeo, balance;

  @override
  void initState() {
    super.initState();
    set = Set();
    load();
    _setApiKey();
  }

  _getApiKey() async{
    ipV4 = await Ipify.ipv4();
    print(ipV4);
    ipV6 = await Ipify.ipv64();
    print(ipV6);
    ipV4json = await Ipify.ipv4(format: Format.JSON);
    print(ipV4json);
    ipV64json = await Ipify.ipv64(format: Format.JSON);
    print(ipV64json);
    /*myGeo = await Ipify.geo(IPIFY_API_KEY.toString());
    print(myGeo);
    someGeo = await Ipify.geo(IPIFY_API_KEY.toString(), ip: '8.8.8.8');
    print(someGeo);
    final balance = await Ipify.balance(IPIFY_API_KEY.toString());
    print(balance);*/

    setState(() {
      //getIpify = 'ipV4:$ipV4\nipV6:\n$ipV6\nipV4json:\n$ipV4json\nipV64json:\n$ipV64json\nmyGeo:\n${myGeo.location}\nsomeGeo:\n${someGeo.location}\nbalance:\n${balance}';
      getIpify = 'ipV4:$ipV4\nipV6:\n$ipV6\nipV4json:\n$ipV4json\nipV64json:\n$ipV64json';
    });
  }

  _setApiKey() {
    ipifyApiKeyName = Constants.api;
    IPIFY_API_KEY = env.containsKey(ipifyApiKeyName) ? env[ipifyApiKeyName] : '';
  }

  @override
  Widget build(BuildContext context) {
    _getApiKey();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        set.initText2('DartIpify Ip 詳細', Colors.black, Colors.transparent, 24),
        set.initText2(getIpify, Colors.green.shade400, Colors.transparent, 18),
      ],
    );
  }
}