import 'package:flutter/material.dart';
import 'package:flutter_crud/crud/create_page.dart';
import 'package:flutter_crud/crud/details_page.dart';

class CrudHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Macappstudio"
        ),
      ),
      body: _buildCrudHomeBody(context),
    );
  }

  _buildCrudHomeBody( BuildContext context ) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50,),
            Card(
              color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      "Add Employee Details",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 15,),
                    RaisedButton(
                      onPressed: () {
                        _goToCreatePage(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Create",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      color: Colors.indigo,
                    ),
                    SizedBox(height: 35,),
                    Text(
                      "See Employee Details",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 15,),
                    RaisedButton(
                      onPressed: (){
                        _goToDetailsPage(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Details",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      color: Colors.indigo,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _goToCreatePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => CreatePage()
      ),
    );
  }

  _goToDetailsPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute( builder: (context) => DetailsPage(), ),);
  }

}
