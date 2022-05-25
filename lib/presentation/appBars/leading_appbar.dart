import 'package:flutter/material.dart';

class LeadingAppBar extends StatelessWidget {

  const LeadingAppBar(String titleText, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        alignment: Alignment.centerLeft,
        icon: const Icon(Icons.arrow_back),
        onPressed: (){Navigator.pop(context);},
      ),
      title: const Align(
        alignment: Alignment.center,
        child: Text(
          'titleText',
          style: TextStyle(color: Colors.black54, fontSize: 20),
        ),
      ),
    );
  }
}
