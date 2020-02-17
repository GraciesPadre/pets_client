import 'package:flutter/material.dart';
import 'package:pets_client/pages/pets_display_page.dart';

// TDOD: Use a form for data entry & validation

class PetsClientPage extends StatefulWidget {
  PetsClientPage({Key key}) : super(key: key);

  @override
  _PetsClientPageState createState() => _PetsClientPageState();
}


class _PetsClientPageState extends State<PetsClientPage> {
  static final String _initialPetRetrievalTag = "Get 'em all!";
  static final TextEditingController _textController = TextEditingController(text: _initialPetRetrievalTag);
  TextField _petTagTextField;
  RaisedButton _showPetDetailsButton;

  @override void initState() {
    _showPetDetailsButton = RaisedButton(
      child: const Text("Get Pet Details"),
      onPressed: () {
        if (_textController.text.length > 0) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PetsDisplayPage(petRetrievalTag: _textController.text,)));
        } else {
          _showPetNamTagEmptyDialog();
        }
      },
    );

    _petTagTextField = TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Which pet's info would you like to get?",
        labelText: "Pet Name"
      ),
      controller: _textController,
    );

    super.initState();
  }

  void _showPetNamTagEmptyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Please enter a pet name or "Get \'em all"'),
          actions: <Widget>[
            RaisedButton(
              child: Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Pets"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _petTagTextField,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: _showPetDetailsButton,
            ),
          ],
        ),
      ),
    );
  }
}
