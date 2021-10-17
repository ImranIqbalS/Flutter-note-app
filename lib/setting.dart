import 'package:flutter/material.dart';
import 'package:note_app/colors.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: bgColor,
        title: Text("Settings"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Sync",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Spacer(),
                Transform.scale(
                  scale: 1.3,
                  child: Switch.adaptive(
                      value: value,
                      onChanged: (switchValue) {
                        setState(() {
                          this.value = switchValue;
                        });
                      }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
