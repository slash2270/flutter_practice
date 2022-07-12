import 'package:flutter/cupertino.dart';

abstract class BlocBase{
  void dispose();
}
class BaseBloc<T extends BlocBase> extends StatefulWidget{

  final T bloc;
  final Widget child;
  const BaseBloc({
    required Key key,
    required this.child,
    required this.bloc,
  }) : super(key: key);

  @override
  _BaseBlocState<T> createState() => _BaseBlocState<T>();

  static Type _typeOf<T>() => T;

  static T of<T extends BlocBase>(BuildContext context){
    final type = _typeOf<BaseBloc<T>>();
    BaseBloc<T>? provider = context.findAncestorWidgetOfExactType();
    return provider!.bloc;
  }
}

class _BaseBlocState<T> extends State<BaseBloc<BlocBase>>{
  @override
  void dispose(){
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}