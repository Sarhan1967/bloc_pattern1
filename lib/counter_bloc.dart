//bloc used instead of setState and widgets because the source may be not flutter---
import 'dart:async';
import 'package:bloc_pattern/counter_event.dart';

class CounterBloc {

  int _counter = 0;
//StreamController is a tool help reading----
  final _counterStateController = StreamController<int>();
  //input---------------private----------
  StreamSink<int> get _inController => _counterStateController.sink;
  //output----------global----------
  Stream<int> get outController =>  _counterStateController.stream;


//streamEvent to distinguish between input or output
  final _counterEventController = StreamController<CounterEvent> ();
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;


  //to receive the event---------------
  CounterBloc() {
    _counterEventController.stream.listen(_mapEventToState);
  }

  //the map
  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _counter++;
    } else {
      _counter--;
    }
    _inController.add(_counter);
  }

  // stop bloc streams to save memory-----------
  void dispose(){
    _counterStateController.close();
    _counterEventController.close();
  }
}