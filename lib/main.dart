import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'counter_bloc.dart';
import 'counter_event.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /**int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }*/

  //this bloc replaced by the above setState----------
  final _bloc = CounterBloc();


  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
//--------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
         child: StreamBuilder(
             stream: _bloc.outController,
             initialData: 0,
           builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            // Under Column wrapped by the  Above StreamBuilder------
             return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                Center(
                child: Padding(
                padding: const EdgeInsets.only(left: 70.0,right: 70,),
                child: Text(
                'You have pushed the button this many times:',
                ),
                ),
                ),
                SizedBox(height: 10,),
                Text(
                //'$_counter',
                  '${snapshot.data}',

                  style: Theme.of(context).textTheme.headline4,
                ),
             ],
        );
           }
         ),
      ),
      floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:<Widget>[
            FloatingActionButton(
              //onPressed: _incrementCounter,
              onPressed: () => _bloc.counterEventSink.add(IncrementEvent()),
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
            FloatingActionButton(
              //onPressed: _decrementCounter,
              onPressed: () => _bloc.counterEventSink.add(DecrementEvent()),
              tooltip: 'Decrement',
              child: Icon(Icons.remove),
            ),
          ]

      )
    );// This trailing comma makes auto-formatting nicer for build methods.
  }
}




