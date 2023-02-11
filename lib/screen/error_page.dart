import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error_outline, color: Colors.red, size: 50),
          SizedBox(height: 20),
          Text("Oops! Something went wrong.", style: TextStyle(fontSize: 20)),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text("Retry"),
            onPressed: () {
              // retry fetching data here
            },
          ),
        ],
      ),
    );
  }
}
