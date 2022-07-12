import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:flutter_practice/set.dart';

class HtmlDemo extends StatelessWidget {
  const HtmlDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Set().initText2('WidgetFromHtml 網頁小部件', Colors.black, Colors.transparent, 24),
      HtmlWidget(
      // the first parameter (`html`) is required
      '''
  <h1>Heading 1</h1>
  <h2>Heading 2</h2>
  <h3>Heading 3</h3>
  This is a <b>bold</b> text.
  <a href="https://flutter.dev">Flutter</a>
  <abbr>ABBR</abbr>
  <acronym>ACRONYM</acronym>
  This is an <address>ADDRESS</address>
  <article>First.</article><article>Second one.</article>
  <aside>First.«/aside><aside>Second one.«/aside>
  <audio controls src="https://interactive-examples.mdn.mozilli"
  <code>AUDIO</code> support is not enabled.
  </audio>
  <big>Foo</bigs
  <blockquote>Foo</blockquote>
  1<br/>2
  <table border="1">
   «caption>Caption</caption>
   «foot><tr><td>Footer 1</td><td>Footer 2</td></tra</
   tfoot>
   <body><tr><td>Value 1</td><td>Value 2</td></tra«/
   tbody>
   «thead><tr><th>Header 1</th><th>Header 2</th></tr></
   thead>
  </table>
  <center>Foo</center>
  This is a <cite>citation</cite>.
  <code><span style="color: #000000"><span style="color:
  #0000BB">&it;?php phpinfo</span><span style="color:
  #007700'>0; </span><span style="color: #0000BB">?&gt;</
  span></span></code>
  <d|><dt>Foo</dt><dd>Bar</dd></dt>
  This is some <del>deleted</ del> text.
  <details>Foo</details>
  <details open>Foo</details>
  This is a <dfn>definition</dfn>
  <div>First.</div><div>Secondone.</div>
  <d|><dt>Foo</dt><dd>Bar</dd></dt>
  <d|><dt>Foo</dt><dd>Bar</dd></dt>
  This is an <em>emphasized</em> text.
  This is an emphasized text.
  <figure>
  <mg src= asset:logos/android.png" width="192"
  height="192" />
  <figcaption><i>fig. 1</i> Flutter logo (Android version)«/
  figcaption>
  </figure>
  <figure>
  <mg src= asset:logos/android.png" width="192"
height="192" />
  <figcaption><i>fig. 1</i> Flutter logo (Android version)«/
  figcaption>
  </figure>
  «font color="#F00">Foo</font><br />
  <font face="Courier">Foo</font><br />
  <font size="7 ›Size 7</font>
  «font size="6">Size 6</font>
  «font size="5">Size 5</font>
  «font size="4">Size 4</font>
  «font size="3">Size 3</font>
  «font size="2>Size 2</font>
  <font size="1">Size 1</font>
  <header>First.</header><footer>Second one.</footer>
  <h1>Heading 1</h1>
  <h2>Heading 2</h2>
  <h3>Heading 3</h3>
  <h4>Heading 4</h4>
  <h5>Heading 5</h5>
  <h6>Heading 6</h6>
  <header>First.</header><footer>Second one.</footer>
  chr/
  This is an <i>italic</i> text.
  <frame src="https://www.youtube.com/embed/iNQXAC9IVR"
  FRAME support is not enabled
  </iframe>
  Flutter <img src="asset:logos/android.png" width="12"
  height="12" /> is awesome.
  This is some <ins>inserted</ins> text.
  «kbd>ESC</kbd>=exit
  <01>
  <i>One</li>
  <i>Two</li>
  <li>Three</li>
  </01>
  <main>First.</main><nav>Second one.</nav>
  <mark>Foo</mark>
  <main>First.</main><nav>Second one.</nav>
  <script>document.write("SCRIPT is working"):</script>
  <noscript>SCRIPT is not working</noscript>
  <01>
  <i>One</li>
  <i>Two</li>
  <li>Three</li>
  </01>
  <o reversed><li>One</li><li>Two</li><li>Three</liscol>
  <o reversed start="99"><li>One</li><li>Two</li><li>Three</li><ol>
  <ol type="a"><li>One</li><li>Two</li><li>Three</li>sol>
  <ol type=" "><li>One</li><li>Two</li><li>Three</li>sol>
  <o type="A"><li>One</li><li>Two</li><li>Three</lissol>
  <ol type="I"><li>One</li><li>Two</li><li>Three</li>sol>
  <p>First.</p><p>Second one.</D>
  <pre>&lt;?php
  highlight_string('&it;?php phpinfo0; ?&gt;);
  ?&gt;</pre>
  Someone said <g>Foo</q>.
  <ruby>»k<rp>(</rp><rt>Ashita</rt><rp>)</rp></ruby>
  <ruby>»k<rp>(</rp><rt>Ashita</rt><rp>)</rp></ruby>
  <ruby>»k<rp>(</rp><rt>Ashita</rt><rp>)</rp></ruby>
  «S>F00</s>
  <samp>Disk fault</samp>
  <script>document.write("SCRIPT is working"):</script>
  <noscript>SCRIPT is not working</noscript>
  <section>First.</section><section>Second one.</section>
  <small>Foo</small>
  <strike>Foo</strike>
  This is a <strong>strong</strong> text
  <style>.xxx { color: red; ‡</style>
  <span class= xxx>Foo</span>
  <p>Almost every developer's favorite molecule is C<sub>8</
  sub>H<sub>10</sub>N<sub>4</sub>O<sub>2</sub>, also
  known as "caffeine. "</p>
  <details>
  <summary>Foo</summary>
  Bar
  </details>
  <p>The <b>Pythagorean theorem</b> is often expressed as
  the following equation:</p>
  <p>evar>a<sup>2</sup></var> + <var>b<sup>2</sup></var>
  = <var>c<sup>2</sup></var></p>
  <svg height="100" width="100">
  «circle cx="50" cy="50" r="40" stroke="black" stroke-width="3
  SVG support is not enabled.
  </svg>
  <table border="1">
  «caption>Caption</caption>
  «foot><tr><td>Footer 1</td><td>Footer 2</td></tra</
  tfoot>
  <body><tr><td>Value 1</td><td>Value 2</td></tra«/
  tbody>
  «thead><tr><th>Header 1</th><th>Header 2</th></tr></
  thead>
  </table>
  <table border="1">
  <caption>Source: <a
  href="https://www.w3schools.com/tags/att_td_colspanasp"›w3schools</a></caption>
  <tr>
  «th>Month</th>
  <th>Savings</th>
  </try
  <try
  «td>January</td>
  «td>100</td>
  </try
  <tr>
  <td>February</td>
  <d>80</td>
  </try
  etr>
  «td colspan="2">Sum:180</tds
  </try
  </table>
  <table border="1">
  <caption>Source: <a
  href="https://www.w3schools.com/tags/att_td_colspan
  asp"›w3schools</a></caption>
  <tr>
  «th>Month</th>
  <th>Savings</th>
  «th>Savings for holiday!</th>
  </try
  <try
  «td>January</td>
  <d>100</td>
  <td rowspan="2">50</td>
  </try
  etr>
  <td>February</td>
  <d>580</td>
  </try
  </table>
  <table border="1">
  «caption>Caption</caption>
  «foot><tr><td>Footer 1</td><td>Footer 2</td></tra</
  tfoot>
  <body><tr><td>Value 1</td><td>Value 2</td></tra«/
  tbody>
  «thead><tr><th>Header 1</th><th>Header 2</th></tr></
  thead>
  </table>
  <table border="1">
  «caption>Caption</caption>
  «foot><tr><td>Footer 1</td><td>Footer 2</td></tra</
  tfoot>
  <body><tr><td>Value 1</td><td>Value 2</td></tra«/
  tbody>
  «thead><tr><th>Header 1</th><th>Header 2</th></tr></
  thead>
  </table>
  <table border="1">
  «caption>Caption</caption>
  «foot><tr><td>Footer 1</td><td>Footer 2</td></tra</
  tfoot>
  <body><tr><td>Value 1</td><td>Value 2</td></tra«/
  tbody>
  «thead><tr><th>Header 1</th><th>Header 2</th></tr></
  thead>
  </table>
  <table border="1">
  «caption>Caption</caption>
  «foot><tr><td>Footer 1</td><td>Footer 2</td></tra</
  tfoot>
  <body><tr><td>Value 1</td><td>Value 2</td></tra«/
  tbody>
  «thead><tr><th>Header 1</th><th>Header 2</th></tr></
  thead>
  </table>
  <table border="1">
  «caption>Caption</caption>
  «foot><tr><td>Footer 1</td><td>Footer 2</td></tra</
  tfoot>
  <body><tr><td>Value 1</td><td>Value 2</td></tra«/
  tbody>
  «thead><tr><th>Header 1</th><th>Header 2</th></tr></
  thead>
  </table>
  <table border="1">
  «caption>Caption</caption>
  «foot><tr><td>Footer 1</td><td>Footer 2</td></tra</
  tfoot>
  <body><tr><td>Value 1</td><td>Value 2</td></tra«/
  tbody>
  «thead><tr><th>Header 1</th><th>Header 2</th></tr></
  thead>
  </table>
  <tt>Teletype</tt>
  This is an <u>underline</u> text.
  <ul>
  <li>One</li>
  <i>
  TWO
  <ul>
  <i>2.1</li>
  <i>
  2.2
  <u>
  <i>2.2.1</li>
  <i>2.2.2</li>
  <i>2.2.3</li>
  </u
  </is
  <i>2.3</li>
  </i>
  <i>Three</li>
  </us
  <var></var> = 1
  «video controls width="250">
  «source src=https://interactive-examples.mdn.mozilla.net/n
  «code>VIDEO</code> support is not enabled.</video>
  <!-- anything goes here -->
  ''',

      // 所有其他參數都是可選的，一些值得注意的參數：
      // 為元素指定自定義樣式
      // 請參閱下面支持的內聯樣式
      customStylesBuilder: (element) {
        if (element.classes.contains('foo')) {
          return {'color': 'red'};
        }
        return null;
      },

      // 渲染一個自定義小部件
      customWidgetBuilder: (element) {
        if (element.attributes['foo'] == 'bar') {
          return Text('FooBar');
        }
        return null;
      },

      // 這些回調在加載複雜元素時調用
      // 或無法渲染允許應用程序渲染進度指示器
      // 和後備小部件
      onErrorBuilder: (context, element, error) => Text('$element error: $error'),
      onLoadingBuilder: (context, element, loadingProgress) => CircularProgressIndicator(),

      // 當用戶點擊鏈接時將觸發此回調
      onTapUrl: (url) => true,

      // 選擇 HTML body 的渲染模式
      // 默認情況下，渲染一個簡單的 `Column`
      // 考慮使用 `ListView` 或 `SliverList` 以獲得更好的性能
      renderMode: RenderMode.column,

      // 設置文本的默認樣式
      textStyle: TextStyle(fontSize: 14),
    ),
      ],
    );
  }
}