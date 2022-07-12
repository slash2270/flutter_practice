import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:flutter_practice/set.dart';

class OctoImageWidget extends StatefulWidget {
  const OctoImageWidget({Key? key}) : super(key: key);

  @override
  State<OctoImageWidget> createState() => _OctoImageWidgetState();
}

class _OctoImageWidgetState extends State<OctoImageWidget> with WidgetsBindingObserver, AutomaticKeepAliveClientMixin, TickerProviderStateMixin {

  late Set set;
  late SizedBox sizedBox;

  @override
  bool get wantKeepAlive => false; // 是否需要缓存

  @override
  void initState() {
    print('OctoImage initState');
    set = Set();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          sizedBox = SizedBox(height: 20),
          set.initText2('ProgressAndIcon', Colors.black, Colors.transparent, 20),
          _progressAndIcon(),
          sizedBox = SizedBox(height: 20),
          set.initText2('BlurHash', Colors.black, Colors.transparent, 20),
          _simpleBlur(),
          sizedBox = SizedBox(height: 20),
          set.initText2('CircleAvatar', Colors.black, Colors.transparent, 20),
          _circleAvatar(),
        ],
    );
  }

  Widget _progressAndIcon() {
    return sizedBox = SizedBox(
      height: 150,
      child: OctoImage(
        image: const NetworkImage('https://via.placeholder.com/150'),
        progressIndicatorBuilder: (context, progress) {
          double? value;
          var expectedBytes = progress?.expectedTotalBytes;
          if (progress != null && expectedBytes != null) {
            value = progress.cumulativeBytesLoaded / expectedBytes;
          }
          return CircularProgressIndicator(value: value);
        },
        errorBuilder: (context, error, stacktrace) => set.initIcon(Icons.error),
      ),
    );
  }

  Widget _simpleBlur() {
    return AspectRatio(
      aspectRatio: 269 / 173,
      child: OctoImage(
        image: const NetworkImage('https://blurha.sh/assets/images/img1.jpg'),
        placeholderBuilder: OctoPlaceholder.blurHash(
          'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
        ),
        errorBuilder: OctoError.icon(color: Colors.red),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _circleAvatar() {
    return sizedBox = SizedBox(
      height: 75,
      child: OctoImage.fromSet(
        fit: BoxFit.cover,
        image: const NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Macaca_nigra_self-portrait_large.jpg/1024px-Macaca_nigra_self-portrait_large.jpg',),
        octoSet: OctoSet.circleAvatar(
          backgroundColor: Colors.red,
          text: set.initText("M"),
        ),
      ),
    );
  }

}