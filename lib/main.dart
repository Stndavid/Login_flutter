import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Animado',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AnimatedLoginPage(),
    );
  }
}

class AnimatedLoginPage extends StatefulWidget {
  @override
  _AnimatedLoginPageState createState() => _AnimatedLoginPageState();
}

class _AnimatedLoginPageState extends State<AnimatedLoginPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..forward();
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _animationController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo con imagen
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/login.jpg'), // Asegúrate de agregar esta imagen en la carpeta assets
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Contenido principal
          Center(
            child: FadeTransition(
              opacity: _animation,
              child: Container(
                margin: EdgeInsets.all(20.0),
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Título
                      Text(
                        'Iniciar Sesión',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Campo de nombre
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Nombre',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu nombre.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // Campo de correo
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Correo electrónico',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu correo.';
                          }
                          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Por favor ingresa un correo válido.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // Campo de contraseña
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu contraseña.';
                          }
                          if (value.length < 4) {
                            return 'La contraseña debe tener al menos 4 caracteres.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      // Botón siguiente
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // Acción al presionar siguiente
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('¡Éxito!'),
                                content: Text('Has ingresado los datos correctamente.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 22, 151, 71), // Color atractivo para el botón "Siguiente"
                          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 40), // Hacer el botón más ancho
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0), // Bordes más redondeados
                          ),
                          textStyle: TextStyle(fontSize: 18), // Aumentar tamaño de texto
                        ),
                        child: const Text(
                          'Siguiente',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Botón salir
                      ElevatedButton(
                        onPressed: () {
                          // Acción al presionar salir
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 156, 150, 150),  // Color brillante para el botón "Salir"
                          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 55), // Hacer el botón más ancho
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0), // Bordes redondeados
                          ),
                          textStyle: TextStyle(fontSize: 18), // Aumentar tamaño de texto
                        ),
                        child: const Text(
                          'Salir',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
