class PointState {

  int x = 0;
  int y = 0;
  int z = 0;

  //构造函数
  PointState(this.x, this.y, this.z);

  //重置操作调用
  factory PointState.reset() {
    return PointState(0, 0, 0);
  }

  //部分值修改时调用
  PointState.update(int x1, int y1, int z1) {
    x = x1;
    y = y1;
    z = z1;
  }

}