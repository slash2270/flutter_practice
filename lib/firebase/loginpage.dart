import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool login = false;
  bool showpassword = false;
  late UserCredential auth;
  Map errors = {'account':null, 'password':null, 'other':null };
  final GlobalKey <FormState> _formkey = new GlobalKey<FormState>();
  final GlobalKey <FormFieldState<String>> _emailkey = new GlobalKey<FormFieldState<String>>();
  final GlobalKey <FormFieldState<String>> _passwordkey = new GlobalKey<FormFieldState<String>>();

  Future  _loginFirebase(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
        .then((value){
          auth = value;
          setState(() {
            login = true;
          });
        }
    ).catchError((error){
      RegExp exp = new RegExp(r'\d{5}');
      var err = exp.firstMatch(error.toString());
      setState((){
        if (err?.group(0) == '17011'){
          errors['account'] = "帳號錯誤";
        }
        if (err?.group(0) == '17009'){
          errors['password'] = "密碼錯誤";
        }else{
          errors['other'] = "請再次確認帳號以及密碼";
        }
      });
    });
  }
  void _login(){
    _formkey.currentState?.save();
    if (_formkey.currentState != null && _formkey.currentState!.validate()){
      _emailkey.currentState!.save();
      _passwordkey.currentState!.save();
      String email = _emailkey.currentState!.value!.toLowerCase().trimRight();
      String password = _passwordkey.currentState!.value!.toLowerCase().trimRight();
      _loginFirebase(email,password);
    }
  }
  void _clean(){
    _emailkey.currentState?.reset();
    _passwordkey.currentState?.reset();
    setState(()=>login=false);
  }

  _onchange(bool? value){
    setState(()=>
    showpassword = value!
    );
  }
  Widget _button(Function fun, String string, bool login){
    setState(() {
      if(login){

      }
    });
    return new RaisedButton(
      color: login? Colors.red : Colors.blue,
      onPressed: fun(),
      child: new Text(string),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: new Padding(
        padding: const EdgeInsets.all(10.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              width: 200.0,
              height: 200.0,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue[400],
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: new TextFormField(
                keyboardType:  TextInputType.emailAddress,
                initialValue: "",
                autofocus: false,
                key: _emailkey,
                decoration: new InputDecoration(
                  labelText: "Email",
                  icon:new Icon(Icons.email),
                  errorText: errors['account'],
                ),
              ),
            ),
            new TextFormField(
              keyboardType:  TextInputType.multiline,
              initialValue: "",
              obscureText: showpassword,
              key:_passwordkey,
              decoration: new InputDecoration(
                labelText: "Password",
                icon: new Icon(Icons.label),
                errorText: errors['password'],
              ),
            ),
            new Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Checkbox(
                      onChanged: _onchange,
                      value: showpassword,
                    ),
                    new Text("顯示密碼"),
                    new SizedBox(width: 10.0,),
                    login? _button( _clean, "clean" ,login) : _button(_login, "Login",login),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}