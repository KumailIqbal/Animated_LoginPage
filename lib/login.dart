import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.bounceOut);
    _animation.addListener(() => this.setState(() {}));
    _animationController.forward();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void validate() {
    if (formKey.currentState!.validate()) {
      Navigator.pushNamed(context, "/home");
    } else {
      print("Not validated");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image(
            image: AssetImage("assets/girlpic.jpeg"),
            fit: BoxFit.cover,
            color: Colors.black54,
            colorBlendMode: BlendMode.darken,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterLogo(
                size: _animationController.value * 100,
              ),
              Form(
                  key: formKey,
                  child: Container(
                    padding: EdgeInsets.all(40.0),
                    child: Theme(
                      data: ThemeData(
                          primarySwatch: Colors.teal,
                          brightness: Brightness.dark,
                          inputDecorationTheme: InputDecorationTheme(
                              labelStyle: TextStyle(
                                  color: Colors.teal, fontSize: 20.0))),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                labelText: "Email",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            keyboardType: TextInputType.emailAddress,
                            validator: MultiValidator([
                              EmailValidator(errorText: "Invalid Email"),
                              RequiredValidator(errorText: "Required *"),
                            ]),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.password),
                                labelText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Required *";
                              } else if (value.length < 6) {
                                return "Password must have atleast 6 characters";
                              } else if (value.length > 15) {
                                return "Password should not have more than 15 characters";
                              } else {
                                return null;
                              }
                            },
                          ),
                          Padding(padding: EdgeInsets.only(top: 20.0)),
                          MaterialButton(
                            height: 50.0,
                            minWidth: 100.0,
                            onPressed: validate,
                            color: Colors.teal,
                            // textColor: Colors.white,
                            splashColor: Colors.orangeAccent,
                            child: Icon(Icons.login),
                          )
                        ],
                      ),
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
