// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_practice/set.dart';

class PackageInfoPlusDemo  extends StatefulWidget {
  const PackageInfoPlusDemo ({Key? key}) : super(key: key);

  @override
  _PackageInfoPlusDemoState createState() => _PackageInfoPlusDemoState();
}

class _PackageInfoPlusDemoState extends State<PackageInfoPlusDemo> {

  late Set set;

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    set = Set();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Widget _infoTile(String title, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle.isEmpty ? 'Not set' : subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        set.initText2('PackageInfoPlus 應用程式詳細', Colors.black, Colors.transparent, 24),
        _infoTile('應用名稱', _packageInfo.appName),
        _infoTile('包名', _packageInfo.packageName),
        _infoTile('應用版本', _packageInfo.version),
        _infoTile('內部版本號', _packageInfo.buildNumber),
        _infoTile('構建簽名', _packageInfo.buildSignature),
      ],
    );
  }
}