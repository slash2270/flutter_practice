import 'package:flutter/material.dart';

class RichTextWidget extends StatefulWidget {
  const RichTextWidget ({Key? key, required this.text, required this.linkStyle,}) : super(key: key);

  final String text;
  final TextStyle linkStyle;

  @override
  _RichTextWidgetState createState() => _RichTextWidgetState();
}

class _RichTextWidgetState extends State<RichTextWidget> {

  late TextSpan _textSpan;

  @override
  void initState() {
    _textSpan = parseText(widget.text);
    super.initState();
  }

  @override
  void didUpdateWidget(RichTextWidget oldWidget) {
    /**
     * 由于解析文本字符串，构建出TextSpan是一个耗时操作，为了不在每次build的时候都解析一次，所以我们在initState中对解析的结果进行了缓存，
     * 然后再build中直接使用解析的结果_textSpan。这看起来很不错，但是上面的代码有一个严重的问题，就是父组件传入的text发生变化时（组件树结构不变），
     * 那么MyRichText显示的内容不会更新，原因就是initState只会在State创建时被调用，所以在text发生变化时，parseText没有重新执行，
     * 导致_textSpan任然是旧的解析值。要解决这个问题也很简单，我们只需添加一个didUpdateWidget回调，然后再里面重新调用parseText即可
     */

    if (widget.linkStyle.color != oldWidget.linkStyle.color) {
      _textSpan = parseText(widget.text);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: _textSpan,
    );
  }

  TextSpan parseText(String text) { // 耗时操作：解析文本字符串，构建出TextSpan。
    _textSpan = TextSpan(text: text, style: widget.linkStyle);
    return _textSpan;
  }

}