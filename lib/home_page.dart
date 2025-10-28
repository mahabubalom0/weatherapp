import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

   List<Map>persion_name=[
     {
       "name": "Md MAhabub Alom",
       "description": "App developer",
       "education":"Continue Diploma Enginnering "
     }, {
       "name": "Md Majharul Alom",
       "description": "App developer",
       "education":"Continue Diploma Enginnering "
     }, {
       "name": "Md Mehedi Alom",
       "description": "App developer",
       "education":"Continue Diploma Enginnering "
     }, {
       "name": "Md Saidul Alom",
       "description": "App developer",
       "education":"Continue Diploma Enginnering "
     }, {
       "name": "Md Imran Alom",
       "description": "App developer",
       "education":"Continue Diploma Enginnering "
     }, {
       "name": "Md Muhid Alom",
       "description": "App developer",
       "education":"Continue Diploma Enginnering "
     },
   ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text("Api ", style: TextStyle(fontSize: 22.0,color:Colors.black ),),
        centerTitle: true,
        leading:Icon(Icons.arrow_back_ios_new) ,

      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.lightBlueAccent,
        child:
          ListView.builder(
              itemCount:persion_name.length ,

              itemBuilder: (context, index){
            return ListTile(
              title: Text(persion_name[index]['name']),
              subtitle: Text(persion_name[index]['description']),


            );
          })

      ),
    );
  }
}
