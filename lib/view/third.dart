import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/set.dart';
import 'package:flutter_practice/bean/fivebean.dart';

Set set = Set();

class Third extends StatelessWidget {
  const Third({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: set.initText('Third Page'),
      ),
      body: const SingleChildScrollView(
        child: (Content()),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}

class Content extends StatefulWidget {
  const Content({Key? key}) : super(key: key);

  @override
  State<Content> createState() => ContentState(); // 生命週期開始
}

class ContentState extends State<Content> with WidgetsBindingObserver {
  late GlobalKey keyJump, keyAccount, keyPassWord, keyPrint;
  late TextEditingController tvEditController1, tvEditController2;
  late Size sizeJump, sizeText, sizePrint;
  late TextField textField;
  late String strPrint, _strText1, _strText2;
  late FormState formState;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (kDebugMode) {
      print('$state');
    }
  }

  @override
  void initState() {
    // 初始化
    if (kDebugMode) {
      print('initState Third');
    }
    keyJump = GlobalKey();
    keyAccount = GlobalKey();
    keyPassWord = GlobalKey<FormState>();
    keyPrint = GlobalKey();
    tvEditController1 = TextEditingController();
    tvEditController2 = TextEditingController();
    strPrint = "印出內容";
    _strText1 = 'TextUser';
    _strText2 = 'TextPassWord';
    //监听Widget是否绘制完毕
    //WidgetsBinding.instance?.addPostFrameCallback(getWidgetSize);
    WidgetsBinding.instance.addObserver(this);

    /// 添加兼听 当TextField 中内容发生变化时 回调 焦点变动 也会触发
    /// onChanged 当TextField文本发生改变时才会回调
    tvEditController1.addListener(() {
      ///获取输入的内容
      strPrint = tvEditController1.text;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    if (kDebugMode) {
      print('didChangeDependencies Third');
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant Content oldWidget) {
    // 元件發生變化
    if (kDebugMode) {
      print('didUpdateWidget Third');
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    if (kDebugMode) {
      print('setState Third');
    }
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    if (kDebugMode) {
      print('deactivate Third');
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    if (kDebugMode) {
      print('dispose Third');
    }
    tvEditController1.dispose();
    tvEditController2.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void getWidgetSize(_) {
    //getSize();
  }

  void getSize() {
    final RenderBox renderBoxJump = keyJump.currentContext?.findRenderObject() as RenderBox;
    sizeJump = renderBoxJump.size;
    final RenderBox renderBoxText = keyAccount.currentContext?.findRenderObject() as RenderBox;
    sizeText = renderBoxText.size;
    final RenderBox renderBoxPrint = keyPrint.currentContext?.findRenderObject() as RenderBox;
    sizePrint = renderBoxPrint.size;
    /*if (kDebugMode) {
      print("Third Widget size Jump: $sizeJump TextField: $sizeText Print: $sizePrint");
    }*/
  }

  @override
  Widget build(BuildContext context) {
    // 在didChangeDependencies之後, 建構畫面
    return Center(
      child: Container(
        color: Colors.green,
        alignment: Alignment.center,
        margin: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              margin: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
              //constraints: set.initBoxConstraint(300, 600, 50, 50),
              child: Wrap(children: [
                RaisedButton(
                  key: keyJump,
                  textColor: Colors.black,
                  child: set.initText('第二頁傳值'),
                  onPressed: () {
                    FiveBean bean = FiveBean(1, "名稱", "款式", "尺寸", "產品", "價格", "數量");
                    Navigator.of(context).pop(bean);
                  },
                ),
              ]),
            ),
            Container(
                alignment: Alignment.center,
                color: Colors.white,
                padding: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
                margin: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
                constraints: set.initBoxConstraint(350, 450, 0, 0),
                child: Wrap(children: [
                  Image.asset('images/ellen_cute1.jpeg', fit: BoxFit.fill,)
                ])),
            Container(
              alignment: Alignment.center,
              color: Colors.white,
              padding: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
              margin: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
              //constraints: set.initBoxConstraint(300, 600, 50, 50),
              child: Wrap(children: [
                Form(
                  child: TextField(
                  key: keyAccount,
                  controller: tvEditController1,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.green,
                  cursorRadius: const Radius.circular(10.0),
                  cursorWidth: 2.0,
                  obscureText: false,
                  //textInputAction:TextInputAction.go, 右下角按钮变为：前往或者Go
                  decoration: const InputDecoration(
                      hintText: '請輸入帳號...',
                      icon: Icon(Icons.supervised_user_circle),
                      suffixIcon: Icon(Icons.search),
                      prefixText: 'prefix',
                      suffixText: 'suffix',
                      labelText: "使用者名稱",
                      helperText: '請輸入使用者名稱、手機號',
                      prefixIcon: Icon(Icons.person),
                  ),
                  onChanged: (value1) {
                    _strText1 = 'TextUser onChange: $value1';
                    setState(() { });
                  },
                  onEditingComplete: () {
                    _strText1 = "TextUser onEditingComplete";
                    setState(() { });
                  },
                  onSubmitted: (value3) {
                    _strText1 = "TextUser onSubmitted: $value3";
                    setState(() { });
                  },
                )),
                Container(
                  margin: set.initEdgeInsets(0.0, 20.0, 0.0, 0.0),
                  child: Form(
                      key: keyPassWord,
                      child: TextField(
                        controller: tvEditController2,
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.green,
                        cursorRadius: const Radius.circular(20.0),
                        cursorWidth: 2.0,
                        obscureText: true,
                        //textInputAction:TextInputAction.go, 右下角按钮变为：前往或者Go
                        decoration: InputDecoration(
                            hintText: '請輸入密碼...',
                            contentPadding: const EdgeInsets.all(10.0), // 圆角矩形的输入框样式
                            border: OutlineInputBorder( // 圆角半径 10
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                        onChanged: (value1) {
                          _strText2 = "TextPassWord 中 onChange: $value1";
                          setState(() { });
                        },
                        onEditingComplete: () {
                          _strText2 = "TextPassWord onEditingComplete";
                          setState(() { });
                        },
                        onSubmitted: (value3) {
                          _strText2 = "TextPassWord 中 onSubmitted: $value3";
                          setState(() { });
                        },
                      )),
                ),
              ]),
            ),
            Container(
              child: set.initText2(_strText1, Colors.black, Colors.white, 18),
              padding: set.initEdgeInsets(15.0, 20.0, 15.0, 0.0),
            ),
            Container(
              child: set.initText2(_strText2, Colors.black, Colors.white, 18),
              padding: set.initEdgeInsets(15.0, 20.0, 15.0, 20.0),
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.green,
              //constraints: set.initBoxConstraint(300, 600, 50, 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 1,
                      child:  FlatButton(
                        key: keyPrint,
                        color: Colors.white,
                        minWidth: 20,
                        textColor: Colors.black,
                        child: set.initText(strPrint),
                        onPressed: () {
                          printInput();
                        },
                      ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      color: Colors.white,
                      minWidth: 20,
                      textColor: Colors.black,
                      child: set.initText('檢驗內容'),
                      onPressed: () {
                        printInput();
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      color: Colors.white,
                      minWidth: 20,
                      textColor: Colors.black,
                      child: set.initText('保存內容'),
                      onPressed: () {
                        printInput();
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: FlatButton(
                      color: Colors.white,
                      minWidth: 20,
                      textColor: Colors.black,
                      child: set.initText('清除內容'),
                      onPressed: () {
                        printInput();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void printInput() {
    setState(() {
      strPrint = tvEditController1.text;
      /*if (kDebugMode) {
        print('Third TextPrint $tvEditController1.text');
      }*/
    });
  }

  void clearPassWord() {
    setState(() {
      if (tvEditController2.text.isNotEmpty) {
        formState = keyPassWord.currentState as FormState;
        formState.reset();
        strPrint = tvEditController2.text;
        /*if (kDebugMode) {
          print('Third TextClear $tvEditController2.text');
        }*/
      }
    });
  }

  void savePassWord() {
    setState(() {
      if (tvEditController2.text.isNotEmpty) {
        formState = keyPassWord.currentState as FormState;
        formState.save();
        strPrint = tvEditController2.text;
        /*if (kDebugMode) {
          print('Third TextSave $tvEditController2.text');
        }*/
      }
    });
  }

  void checkPassWord() {
    setState(() {
      if (tvEditController2.text.isNotEmpty) {
        formState = keyPassWord.currentState as FormState;
        formState.validate();
        strPrint = formState.validate().toString();
        /*if (kDebugMode) {
          print('Third TextCheck $tvEditController2.text');
        }*/
      }
    });
  }

}