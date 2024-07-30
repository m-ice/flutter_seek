// ignore: prefer_generic_function_type_aliases
///订阅者回调签名
typedef void EventCallback(args);

class EventBus{
  EventBus._internal();

  static final EventBus _singleton=EventBus._internal();

  /// 工厂构造函数
  factory EventBus() => _singleton;


  /// 保存事件订阅者队列，key:事件名(id)，value: 对应事件的订阅者队列
  final Map<Object, List<EventCallback>?> _eMap = <Object, List<EventCallback>>{};
  final List<String> _list=[];
  /// 添加订阅者
  void on(eventName, EventCallback? f) {
    if (eventName == null || f == null) return;
    if(eventName.toString().contains('newMessage_')){
      _list.add(eventName.toString());
    }
    _eMap[eventName] ??= [];
    _eMap[eventName]!.add(f);
  }

  /// 移除订阅者
  void off(eventName,{EventCallback? f,Function(String eventName)? removeEvent}) {
    if(eventName.toString().contains('newMessage_')){
      _list.remove(eventName.toString());
    }
    if(_list.contains(eventName)) return;
    var list = _eMap[eventName];
    if (eventName == null || list == null) return;
    if (f == null) {
      _eMap[eventName] = null;
    } else {
      list.remove(f);
    }
    _eMap.remove(eventName);
    removeEvent?.call(eventName);
  }

  /// 是否存在key exist:存在 noExist:不存在
  void existKey({required String key,Function? exist,Function? noExist}){
    if(_eMap.containsKey(key)){
      exist?.call();
    }else{
      noExist?.call();
    }
  }


  /// 按名称列表清空事件
  void conditionsOff(eventName){
    for(int index=0;index<_eMap.keys.toList().length;index++){
      if(_eMap.keys.toList()[index].toString().contains(eventName)){
        _eMap[_eMap.keys.toList()[index]]=null;
      }
    }
  }
  void sendAllMatchEven(eventName){
   List<String>  list=_eMap.keys.map((e) => e.toString().contains(eventName)?e.toString():'').toList().toSet().toList();
   list.remove('');
   for(String name in list){
     send(name);
     off(name);
   }
  }
  /// 触发事件，事件触发后该事件所有订阅者会被调用
  void send(eventName, [arg]) {
    var list = _eMap[eventName];
    if (list == null) return;
    int len = list.length - 1;
    //反向遍历，防止订阅者在回调中移除自身带来的下标错位
    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }
}

var bus = EventBus();