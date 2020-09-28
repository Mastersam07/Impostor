import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impostor/utils/CustomButton.dart';
import 'package:impostor/utils/ServerFile.dart';

class HomePage extends StatelessWidget {
  // constants for among us
  static String regionName = "Impostor";
  static int serverPortNo = 22023;

  final title;
  final TextEditingController ip = TextEditingController();
  final TextEditingController port =
      TextEditingController(text: serverPortNo.toString());
  final GlobalKey<FormState> _impostorKey = GlobalKey();

  HomePage({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 0, 18.0, 0),
        child: Form(
          key: _impostorKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "IMPOSTOR",
                    style: GoogleFonts.lobster(
                      textStyle: TextStyle(fontSize: 40),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "AMONG US PRIVATE SERVER",
                    style: GoogleFonts.lobster(
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Connect to a Server",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: ip,
                decoration: InputDecoration(
                  // fillColor: Color(0xFFF5F5FF),
                  // filled: true,
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Server Ip',
                  hintStyle: TextStyle(
                    // color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Server Ip is Required';
                  }

                  if (!RegExp(
                          r"^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
                      .hasMatch(value)) {
                    return 'Please enter a valid ip address';
                  }

                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: port,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Port number is Required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  // fillColor: Color(0xFFF5F5FF),
                  // filled: true,
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Port number',
                  hintStyle: TextStyle(
                    // color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              CustomButton(
                  title: "Generate Server File",
                  onPress: () {
                    if (_impostorKey.currentState.validate()) {
                      var serverIp = ip.text.trim();
                      var serverPort = port.text.trim();
                      List<int> serverFileBytes = generateServerFile(
                          regionName, serverIp, int.tryParse(serverPort));
                      print("Correct details!");
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (_) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25.0),
                                ),
                              ),
                              child: AlertDialog(
                                title: Center(
                                  child: Text(
                                    "Are you sure you want to generate the server file? This would overwrite the existing one.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                content: Container(
                                  child: Icon(
                                    Icons.warning,
                                    size: 150,
                                    color: Colors.green,
                                  ),
                                ),
                                actions: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      writeConfig(serverFileBytes);
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "YES",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
