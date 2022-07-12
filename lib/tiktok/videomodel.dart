class VideoModel {
  ///视频名称
  String? videoName ='';
  ///视频链接
  String videoUrl ='';
  ///视频截图
  String? videoImage ='';
  ///是否关注
  bool? isAttention =false;
  ///关注的个数
  num? attentionCount =0;
  ///是否喜欢
  bool? isLike = false;
  ///点赞的个数
  num? likeCount = 0;
  ///分享的次数
  num? shareCount=0;

  VideoModel({this.videoName, required this.videoUrl, this.videoImage, this.isAttention, this.attentionCount, this.isLike, this.likeCount, this.shareCount});
}