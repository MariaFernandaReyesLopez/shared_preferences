import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class form extends StatefulWidget {
  @override
  _formularioRegistroState createState() => _formularioRegistroState();
}

class _formularioRegistroState extends State<form> {
  final formKey = new GlobalKey<FormState>();

  final _controllerUsuario = TextEditingController();
  final _controllerContrasena = TextEditingController();
  final _controllerCorreo = TextEditingController();

  String _user;
  String _password;
  String _email;

  String nombre = '';
  String contrasena = '';
  String correo = '';

  String nombreGuardado = '';
  String correoGuardado = '';

  @override
  Widget build(BuildContext context) {
    setState(() {
      obtenerPreferencias();
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        title: Text('Create an account', style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5),
            child: Center(
              child: Container(
                  width: 100,
                  height: 30
              ),
            ),
          ),
          new Center(
            child: Container(
              height: 150,
              width: 150,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    image: new NetworkImage ("https://www.hapeville.org/ImageRepository/Document?documentID=4302"),
                    fit: BoxFit.fill),

              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(
                                Icons.person,
                                size: 30,
                                color: Colors.black,
                              ),
                              onPressed: null),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 20.0, left: 20.0),
                              child: TextFormField(
                                validator: (valor) => valor.length < 3
                                    ? 'Name is not secure'
                                    : null,
                                controller: _controllerUsuario,
                                onSaved: (valor) => _user = valor,
                                decoration:
                                InputDecoration(labelText: 'User'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.lock,
                                  size: 30, color: Colors.black),
                              onPressed: null),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 20.0, left: 20.0),
                              child: TextFormField(
                                controller: _controllerContrasena,
                                validator: (valor) => valor.length < 3
                                    ? 'Password is not secure'
                                    : null,
                                onSaved: (valor) => _password = valor,
                                decoration:
                                InputDecoration(labelText: 'Password'),
                                obscureText: true,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.mail,
                                  size: 30, color: Colors.black),
                              onPressed: null),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 20.0, left: 20.0),
                              child: TextFormField(
                                controller: _controllerCorreo,
                                validator: (valor) => !valor.contains('@')
                                    ? 'Invalid e-mail'
                                    : null,
                                onSaved: (valor) => _email = valor,
                                decoration: InputDecoration(labelText: 'E-mail'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 60,
                          child: RaisedButton(
                            onPressed: () {
                              final form = formKey.currentState;
                              if (form.validate()) {
                                setState(() {
                                  nombre = _controllerUsuario.text;
                                  correo = _controllerCorreo.text;
                                  guardarPreferencias();
                                });
                                pushPage();
                              }
                            },
                            color: Colors.deepOrangeAccent,
                            child: Text(
                              'Check in',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future _checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('_sesion')) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepOrangeAccent,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              'Welcome',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: ListView(
            children: <Widget>[
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  'Personal data:',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('$nombreGuardado'),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('$correoGuardado'),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 60,
                    child: MaterialButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Sign off'),
                            content: Text(
                                'Are you sure?'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Yes'),
                                onPressed: () {
                                  Navigator.of(context).pop('Yes');
                                },
                              ),
                              FlatButton(
                                child: Text('No'),
                                onPressed: () {
                                  Navigator.of(context).pop('No');
                                },
                              )
                            ],
                          ),
                        ).then((result) {
                          if (result == 'Yes') {
                            cerrarSesion();
                          }
                        });
                      },
                      color: Colors.deepOrangeAccent,
                      child: Text(
                        'Sign off',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }));
    }
  }

  void pushPage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('_sesion', true);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Welcome',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                'Personal data',
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(nombre),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(correo),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 60,
                  child: MaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Sign off'),
                          content:
                          Text('Are you sure?'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Yes'),
                              onPressed: () {
                                Navigator.of(context).pop('Yes');
                              },
                            ),
                            FlatButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop('No');
                              },
                            )
                          ],
                        ),
                      ).then((result) {
                        if (result == 'Yes') {
                          cerrarSesion();
                        }
                      });
                    },
                    color: Colors.deepOrangeAccent,
                    child: Text(
                      'Sign off',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }));
  }

  Future<void> guardarPreferencias() async {
    SharedPreferences datos = await SharedPreferences.getInstance();
    datos.setString('Name', _controllerUsuario.text);
    datos.setString('E-mail', _controllerCorreo.text);
  }

  Future<void> obtenerPreferencias() async {
    SharedPreferences datos = await SharedPreferences.getInstance();
    setState(() {
      nombreGuardado = datos.get('Name') ?? nombre;
      correoGuardado = datos.get('E-mail') ?? correo;
    });
  }

  Future<void> cerrarSesion() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('_sesion', false);
    setState(() {
      nombreGuardado = '';
      correoGuardado = '';
    });
    Navigator.pop(context);
  }
}