import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Aquí puedes agregar tu lógica de autenticación
    if (username == 'admin' && password == 'admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MapScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario o contraseña incorrectos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF22577A),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xFF38A3A5),
              borderRadius: BorderRadius.circular(15.0),
              border: Border(
                bottom: BorderSide(width: 3.0, color: Color.fromARGB(255, 117, 255, 209)), // Borde inferior
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.28, // 1/4 de la pantalla
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centrar el contenido
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start, // Justificar a la izquierda
                  children: [
                    Text(
  'Baires',
  style: TextStyle(
    fontSize: 40,
    color: Colors.white,
    fontWeight: FontWeight.bold, // Establecer negrita
  ),
),
Text(
  'Compare',
  style: TextStyle(
    fontSize: 40,
    color: Colors.white,
    fontWeight: FontWeight.bold, // Establecer negrita
  ),
),
                  ],
                ),
                SizedBox(width: 20), // Espaciado entre el texto y la imagen
                Image.network(
                  'https://img.icons8.com/?size=100&id=85122&format=png&color=FFFFFF', // URL de la imagen
                  height: 80, // Ajusta el tamaño de la imagen según sea necesario
                  width: 80, // Ajusta el tamaño de la imagen según sea necesario
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Inicio Sesión',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 40),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Usuario',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Color(0xFF334756),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Color(0xFF334756),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 30),
                  TextButton(
                    onPressed: () {
                      // Aquí puedes agregar la lógica para recuperar la contraseña
                    },
                    child: Text(
                      '¿Olvidó su contraseña?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF38A3A5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    onPressed: _login,
                    child: Text(
                      'Ingresar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(-34.604299305287064, -58.4034642318363), // Coordenadas de ejemplo
              zoom: 11.0,
            ),
            // Aquí van las otras propiedades del mapa
          ),
          Positioned(
            top: 100.0, // Ajustar la posición vertical según sea necesario
            right: 20.0,
            child: FloatingActionButton(
              onPressed: () {
                _showOptionsDialog(context);
              },
              child: Icon(Icons.settings),
            ),
          ),
          Positioned(
            top: 35.0,
            left: 10.0,
            right: 10.0,
            child: Container(
              height: 45.0,
              decoration: BoxDecoration(
                color: Color(0x99334756),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Row(
                children: [
                  SizedBox(width: 10.0),
                  Icon(Icons.search, color: Colors.white),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Buscar',
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Opciones'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Cerrar sesión'),
                  onTap: () {
                    Navigator.of(context).pop(); // Cerrar el diálogo
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
