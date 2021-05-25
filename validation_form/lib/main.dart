import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form validation',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
        title: 'Sign Up',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title}) : super();
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

bool _checkboxListTile = false;

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
                Text(
                  'The Sign up form',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                TextFormField(
                  controller: _nameController,
                  autofillHints: [AutofillHints.name],
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'User name',
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'This field is required';
                    }
                    if (value.length != 7) {
                      return 'Enter your name ';
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailController,
                  autofillHints: [AutofillHints.email],
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'Email id',
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'This field is required';
                    }
                    if (!value.contains('@')) {
                      return "A valid email should contain '@'";
                    }
                    if (!RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(value)) {
                      return "Please enter a valid email";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _phoneController,
                  autofillHints: [AutofillHints.telephoneNumber],
                  decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    hintText: 'Mobile no',
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'This field is required';
                    }
                    if (value.length != 11) {
                      return 'There should be 11 digits for valid phone number';
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.password),
                    hintText: 'Enter password',
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'This field is required';
                    }

                    if (value.toString().length < 5 ||
                        !RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value.toString()))
                      return 'Enter valid containing only alphabets & digits.';
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('I accept the terms & conditions'),
                  value: _checkboxListTile,
                  onChanged: (value) {
                    setState(() {
                      _checkboxListTile = !_checkboxListTile;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(108.0),
                              side: BorderSide(color: Colors.red)))),
                  onPressed: () {
                    if (!_checkboxListTile) {
                      setState(() {
                        Text('kindly accept the terms and conditions');
                      });
                    }
                    if (_formKey.currentState!.validate()) {
                      return;
                    }

                    showDialog(
                      builder: (context) => AlertDialog(
                        content: Text('Error'),
                      ),
                      context: context,
                    );
                  },
                  child: Text(
                    'Register',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
