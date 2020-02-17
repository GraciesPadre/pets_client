import 'package:flutter/material.dart';
import 'package:pets_client/models/pets_data_model.dart';
import 'package:pets_client/services/http_services.dart';

class PetsDisplayPage extends StatefulWidget {
  PetsDisplayPage({Key key, @required petRetrievalTag}) : _petRetrievalTag = petRetrievalTag, super(key: key);
  
  final String _petRetrievalTag;

  @override
  _PetsDisplayPageState createState() => _PetsDisplayPageState(_petRetrievalTag);
}

class _PetsDisplayPageState extends State<PetsDisplayPage> {
  _PetsDisplayPageState(petRetrievalTag) : _petRetrievalTag = petRetrievalTag, super();

  final String _petRetrievalTag;

  Widget _makeListView(BuildContext context, AsyncSnapshot snapshot, Function age) {
    AllPetsData allPetsData = snapshot.data;
    return new ListView.builder(
        itemCount: allPetsData.petsData.length + 1,

        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    const Text(
                      "Name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Age",
                      style: TextStyle(
                        fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Breed",
                      style: TextStyle(
                        fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            );
          }

          var dataIndex = index -1 ;

          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(allPetsData.petsData[dataIndex].name),
                  Text(age(allPetsData, dataIndex)),
                  Text(allPetsData.petsData[dataIndex].breed),
                ],
              ),
              Divider(
                height: 2.0,
              ),
            ],
          );
        },
    );
  }

  Widget _makePetListView(BuildContext context, AsyncSnapshot snapshot) {
    return _makeListView(
      context,
      snapshot,
      (allPetsData, index) => allPetsData.petsData[index].age.toString()
    );
  }

  FutureBuilder<AllPetsData> _makeFutureBuilder(Future<AllPetsData> httpFuture, BuildContext context, Function listViewMaker) {
    return FutureBuilder(
      future: httpFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else
              return listViewMaker(context, snapshot);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var url = "http://localhost:8080/pet" + (_petRetrievalTag.startsWith("Get 'em all") ? "" : "?name=" + _petRetrievalTag);
    Future<AllPetsData> httpFuture = HttpServices(url).getPetData();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pet Details"),
      ),
      body: Center(
        child: _makeFutureBuilder(httpFuture, context, (ctx, snap) => _makePetListView(ctx, snap)),
      ),
    );
  }
}
