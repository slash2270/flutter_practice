import 'package:flutter/material.dart';
import 'package:flutter_practice/utils/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginPage> {
  final mobileTextController = TextEditingController();
  final smsTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text('登入/註冊'),
      ),
      body: _buildLoginContent(context),
    );
  }

  Widget _buildLoginContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildTitle(context),
            SizedBox(height: 30),
            _buildSignArea(context),
            SizedBox(height: 50),
            _buildLoginBtn(context),
            SizedBox(height: 16),
          ],
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('用戶登錄',
          style: TextStyle(fontSize: 22),
        ),
        SizedBox(
          height: 8,
        ),
        Text('Flutter MVVM 登錄',)
      ],
    );
  }

  Widget _buildSignArea(BuildContext context) {
    return Container(
      width: 270,
      child: Column(
        children: <Widget>[
          _buildMobile(context),
          Container(
            height: 0.5,
            color: Color(0xFF6a6a6a),
          ),
          _buildSMS(context),
          Container(
            height: 0.5,
            color: Color(0xFF6a6a6a),
          ),
        ],
      ),
    );
  }

  Widget _buildMobile(BuildContext context) {
    return TextField(
      keyboardAppearance: Brightness.light,
      keyboardType: TextInputType.number,
      controller: mobileTextController,
      maxLength: 11,
      style: TextStyle(
        fontSize: 14,
        color: Color(0xFF191919),
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        counterText: '',
        hintText: '請輸入手機號',
        hintStyle: TextStyle(
          fontSize: 14,
          color: Color(0xFFa5a5a5),
        ),
      ),
    );
  }

  Widget _buildSMS(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: smsTextController,
            maxLength: 4,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF191919),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: '',
              hintText: '請輸入簡訊驗證碼',
              hintStyle: TextStyle(
                fontSize: 14,
                color: Color(0xFFa5a5a5),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {},
          child: Text(
            '發送簡訊驗證碼',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6a6a6a),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildLoginBtn(BuildContext context) {
    return ButtonTheme(
      minWidth: 270,
      height: 45,
      buttonColor: Color(0xFF08ba07),
      child: RaisedButton(
        onPressed: () async {
          Navigator.of(context).pushNamed(Constants.HOME);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: Text('登入',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

}