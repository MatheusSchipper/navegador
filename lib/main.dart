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
      routes: {
        "/": (context) => MyHomePage(
              title: "Home Page",
            ),
        //Rotas podem ser declaradas na main ou em cada página
        "/screen2": (context) => Screen2(),
        //"/screen3": (context) => Screen3(),
      },

      // home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          //Sobrescreve ícone nativo de voltar da AppBar e realiza verificação se pode ou não fechar rotas
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              if (Navigator.canPop(context))
                Navigator.pop(context);
              else
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text("Sobrescrita do Botão Voltar Nativo"),
                    content: Text(
                        "Não é possível retornar, pois não há rotas anteriores"),
                    actions: [
                      CloseButton(),
                    ],
                    elevation: 30,
                    shape: RoundedRectangleBorder(),
                  ),
                  barrierDismissible:
                      false, //não deixa clicar fora do alert para dispensar.
                );
            },
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Navegação por:',
            ),
            RaisedButton(
              child: Text('push'),
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => Screen2()));
              },
            ),
            Text(
              'Rotas nomeadas:',
            ),
            RaisedButton(
              child: Text('Rota screen2'),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  "/screen2",
                );
              },
            ),
            Text(
              'Aula 5:',
            ),
            RaisedButton(
              child: Text('Inherit Widgets'),
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => InheritWidgets()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  Future<bool> _onWillPopScope() async {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Text("Sem volta"),
              actions: [
                RaisedButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.pop(context, false);
                    }),
                RaisedButton(
                    child: Text("Cancelar"),
                    onPressed: () {
                      Navigator.pop(context, true);
                    }),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: Scaffold(
        appBar: AppBar(
            title: Text("Screen 2"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              //MaybePop faz com que, tendo um WillPopScope, intercepte o botão voltar,
              //verificando se pode ou não voltar daquela rota, de acordo com o método
              //colocado no onWillPop.
              onPressed: () {
                Navigator.maybePop(context);
              },
            )),
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
                child: Text('push esperando parâmetro no retorno'),
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
                      shape: RoundedRectangleBorder(),
                    ),
                    barrierDismissible:
                        false, //não deixa clicar fora do alert para dispensar.
                  );
                },
              ),
              Text('Rotas nomeadas durante a navegação'),
              RaisedButton(
                child: Text('Rota screen3'),
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => Screen3(),
                          settings: RouteSettings(name: "/screen3")));
                },
              ),
              RaisedButton(
                child: Text('Rota screen3 com args'),
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => Screen3(),
                          settings: RouteSettings(
                              name: "/screen3", arguments: "argumento")));
                },
              ),
            ],
          ),
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
    final settingsRoute = ModalRoute.of(context).settings;
    print('Nome da rota: ${settingsRoute.name}\n' +
        'Argumentos: ${settingsRoute.arguments}');

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
            ),
            RaisedButton(
              child: Text('popUntil'),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName("/"));
              },
            ),
            RaisedButton(
              child: Text('pushAndRemoveUntil'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (context) => Screen4()),
                    //Destroi todas as rotas anteriores, já que predicado não vai achar equivalência
                    (route) => false
                    //Destroi todas as rotas até chegar na rota especificada
                    //ModalRoute.withName("/")
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Screen4 extends StatefulWidget {
  @override
  _Screen4State createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela 4"),
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
            ),
            RaisedButton(
              child: Text('popUntil'),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName("/"));
              },
            )
          ],
        ),
      ),
    );
  }
}

class CounterProvider extends InheritedWidget {
  final int counter;

  CounterProvider(this.counter, {Key key, this.child})
      : super(key: key, child: child);

  final Widget child;

  static CounterProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>(aspect: CounterProvider);
  }

  @override
  bool updateShouldNotify(CounterProvider oldWidget) {
    return true;
  }
}

class InheritWidgets extends StatefulWidget {
  @override
  _InheritWidgetsState createState() => _InheritWidgetsState();
}

class _InheritWidgetsState extends State<InheritWidgets> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inherit Widgets Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CounterProvider(_counter, child: GreatGrandFather()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        child: Icon(Icons.add),
      ),
    );
  }
}

class GreatGrandFather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: 400,
      height: 250,
      child: GrandFather(),
    );
  }
}

class GrandFather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.orange,
        width: 370,
        height: 220,
        child: Father(),
      ),
    );
  }
}

class Father extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.yellow,
        width: 300,
        height: 200,
        child: Child(),
      ),
    );
  }
}

class Child extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int counter = CounterProvider.of(context).counter;
    return Center(
      child: Container(
        color: Colors.green,
        width: 250,
        height: 150,
        child: Center(child: Text("Valor: $counter")),
      ),
    );
  }
}
