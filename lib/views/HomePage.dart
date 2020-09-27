import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impostor/utils/CustomButton.dart';

class HomePage extends StatelessWidget {
  final title;
  final TextEditingController ip = TextEditingController();
  final TextEditingController port = TextEditingController(text: "22023");

  HomePage({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 0, 18.0, 0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
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
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextFormField(
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
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.blue)),
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
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: TextFormField(
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
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.blue)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.0,),
            CustomButton(title: "Download Server File", onPress: ()=>print("Tapped!"))
          ],
        ),
      ),
    );
  }
}