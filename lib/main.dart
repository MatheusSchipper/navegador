import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => Screen2()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen 2"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Navegação por: ',
            ),
            RaisedButton(
              child: Text('pushReplacement'),
              onPressed: () {
                Navigator.pushReplacement(context,
                    CupertinoPageRoute(builder: (context) => Screen3()));
              },
            ),
            RaisedButton(
              child: Text('push'),
              onPressed: () async {
                final result = await Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => Screen3()));
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text("Parâmetro retornado"),
                    content: Text(result),
                    actions: [
                      CloseButton(),
                    ],
                    elevation: 30,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(),
                  ),
                  barrierDismissible: false,//não deixa clicar fora do alert para dispensar.
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Screen3 extends StatefulWidget {
  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela 3"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Voltar: ',
            ),
            RaisedButton(
              child: Text('com parâmetro'),
              onPressed: () {
                Navigator.pop(context, "Parâmetro Result");
              },
            )
          ],
        ),
      ),
    );
  }
}
