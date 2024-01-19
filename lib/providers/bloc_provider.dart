import 'package:flutter/cupertino.dart';


// Lớp apstract
abstract class BlocBase{
  void dispose();
}

class BloCProvider<T extends BlocBase> extends StatefulWidget{
  final Widget child;
  final T? bloc;
  const BloCProvider({
    Key? key,
    required this.child,
    required this.bloc,
  }): super(key: key);

  @override
  _BloCProviderState<T> createState() => _BloCProviderState<T>();

  static T? of<T extends BlocBase>(BuildContext context){
    final _BloCProviderInherited<T>? provider = context
        .getElementForInheritedWidgetOfExactType<_BloCProviderInherited<T>>()
        ?.widget as _BloCProviderInherited<T>?;
    return provider?.bloc;
  }
  @override
  void dispose() {

  }

}
class _BloCProviderInherited<T> extends InheritedWidget{

  const _BloCProviderInherited({
    Key? key,
    required Widget child,
    required this.bloc,
  }): super(key: key, child:  child);

  final T bloc;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

}

class _BloCProviderState<T extends BlocBase> extends State<BloCProvider<T>>{
  @override
  void dispose(){
    widget.bloc?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
        return _BloCProviderInherited<T>(
            child: widget.child,
            bloc: widget.bloc!
        );
  }

}
