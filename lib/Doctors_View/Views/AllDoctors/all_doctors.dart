import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AllDoctors extends StatefulWidget {
  const AllDoctors({super.key});

  @override
  State<AllDoctors> createState() => _AllDoctorsState();
}

class _AllDoctorsState extends State<AllDoctors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Emergency Contacts"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              EmergencyContacts("Sucidal Thoughts", "9152987821"),
              EmergencyContacts("Police Support", "100"),
              EmergencyContacts("Ambulance", "108"),
              EmergencyContacts("VIMHANS-child-care", "1800 11 3444"),
              EmergencyContacts("Anti Ragging Helpline", "18001805522"),
            ],
          ),
        ));
  }

  Container EmergencyContacts(String title, String phoneno) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        onTap: _launchCaller,
        leading: CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(title),
        subtitle: Text(phoneno),
      ),
    );
  }

  _launchCaller() async {
    const url = "tel:1234567";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
