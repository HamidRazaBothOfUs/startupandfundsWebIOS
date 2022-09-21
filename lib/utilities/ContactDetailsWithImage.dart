import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../fonts/ApplicationFonts.dart';

class ContactDetailsWithImage extends StatefulWidget {
  ContactDetailsWithImage({super.key, required this.type, required this.value});

  String type;
  String? value;

  @override
  State<StatefulWidget> createState() => _ContactDetailsWithImage(type, value);
}

class _ContactDetailsWithImage extends State<StatefulWidget> {
  _ContactDetailsWithImage(this.type, this.value);

  String type;
  String? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (value != null && type=="email")ListTile(leading: Icon(Icons.email),title: Text(value!,style: getRobotoRegular().get12(),),onTap: (){
          setState(() {
            _launchInWebViewOrVC("mailto:" + value!);
          });
        },),
        if (value != null && (type=="webAddress" || type=="website"))ListTile(leading: Icon(Icons.link),title: Text(value!,style: getRobotoRegular().get12(),),onTap: (){
          _launchInWebViewOrVC(value!);
        },),
        if (value != null && type=="phoneNumber")ListTile(leading: Icon(Icons.phone),title: Text(value!,style: getRobotoRegular().get12(),),onTap: (){
          _launchInWebViewOrVC("tel:" + value!);
        },),
        if (value != null && (type=="twitter"||type=="twitterUrl"))ListTile(leading: FaIcon(FontAwesomeIcons.twitter),title: Text(value!,style: getRobotoRegular().get12(),),onTap: (){
          _launchInWebViewOrVC(value!);
        },),
        if (value != null && type=="facebook")ListTile(leading: FaIcon(FontAwesomeIcons.facebook),title: Text(value!,style: getRobotoRegular().get12(),),onTap:(){
          _launchInWebViewOrVC(value!);
        },),
        if (value != null && type=="tiktok")ListTile(leading: FaIcon(FontAwesomeIcons.tiktok),title: Text(value!,style: getRobotoRegular().get12(),),onTap: (){
          _launchInWebViewOrVC(value!);
        },),
        if (value != null && type=="whatsApp")ListTile(leading: FaIcon(FontAwesomeIcons.whatsapp),title: Text(value!,style: getRobotoRegular().get12(),),onTap: (){
          _launchInWebViewOrVC(value!);
        },),
        if (value != null && type=="linkedIn")ListTile(leading: FaIcon(FontAwesomeIcons.linkedin),title: Text(value!,style: getRobotoRegular().get12(),),onTap: (){
          _launchInWebViewOrVC(value!);
        },),
        if (value != null && (type=="firstName"||type=="lastName"||type=="title"))ListTile(title: Text(value!,style: getRobotoRegular().get12(),),),
        if (value != null && type=="address")ListTile(leading:Icon(Icons.house_outlined),title: Text(value!,style: getRobotoRegular().get12(),),),
      ],
    );
  }
  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

}
