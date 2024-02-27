// ignore_for_file: avoid_print, use_key_in_widget_constructors, file_names, todo, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:robbinlaw/widgets/mysnackbar.dart';

// Do not change the structure of this files code.
// Just add code at the TODO's.

final formKey = GlobalKey<FormState>();

// We must make the variable firstName nullable.
String? firstName;
final TextEditingController textEditingController = TextEditingController();

class MyFirstPage extends StatefulWidget {
  @override
  MyFirstPageState createState() => MyFirstPageState();
}

class MyFirstPageState extends State<MyFirstPage> {
  bool enabled = false;
  int timesClicked = 0;
  String msg1 = '';
  String msg2 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A2 - User Input'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //TODO: Replace this Text Widget
              // and build the label and switch here
              // as children of the row.
              const Text('Enable Buttons'),
              Switch(
                value: enabled,
                onChanged: (bool value) {
                  enabled = value;
                  setState(() {});
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //TODO: Build the two buttons here
              // as children of the row.
              // For each button use a
              // "Visibility Widget" and its child
              // will be an "ElevatedButton"
              Visibility(
                  visible: enabled,
                  child: ElevatedButton(
                    onPressed: () {
                      timesClicked++;
                      setState(() {});
                    },
                    child: timesClicked == 0
                        ? const Text('Click Me')
                        : Text('Clicked $timesClicked'),
                  )),
              Visibility(
                  visible: enabled,
                  child: ElevatedButton(
                    onPressed: () {
                      timesClicked = 0;
                      setState(() {});
                    },
                    child: const Text('Reset'),
                  )),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  //TODO: Build the text form field
                  // here as the first
                  // child of the column.
                  // Include as the second child
                  // of the column
                  // a submit button that will show a
                  // snackbar with the "firstName"
                  // if validation is satisfied.
                  TextFormField(
                    controller: textEditingController,
                    maxLength: 20,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.hourglass_top),
                        suffixIcon: Icon(Icons.check_circle),
                        hintText: 'First Name',
                        helperText: 'min 1, max 20'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your first name';
                      } else if (value.length > 20) {
                        return 'First name must be less than 20 characters';
                      } else {
                        return null;
                      }
                    }),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Icon(Icons.favorite, color: Colors.white),
                                Text('Hey There, Your name is ${textEditingController.text}')
                                ]
                              ),
                            duration: const Duration(seconds: 5),
                            action: SnackBarAction(
                              label: 'Click Me',
                              textColor: Colors.white,
                              onPressed: () {
                                print('Click Me Pressed');
                              },
                            ),
                          ),
                        );
                        setState(() {});
                      }
                    },
                    child: const Text('Submit'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
