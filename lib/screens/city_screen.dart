import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:test_clima_flutter/utilities/constants.dart';
class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {

  String newcity = '', Weath='';

  getWeath() async{
    String info='';
    Uri url1 = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$newcity&appid=cc5f0621c9c4796b8f0683e23d26dadf&units=metric");
    Response response = await get(url1);
    info= response.body;
    if (response.statusCode <= 299){
      return info;
    }
    else{
      return 'error';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'error');
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                    onChanged: (value){
                      newcity=value;
                    },
                    style : const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        icon: Icon(
                          Icons.location_city,
                          color: Colors.white,
                        ),
                        hintText: "Type your City here",
                        hintStyle: TextStyle(
                            color: Colors.grey
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide.none
                        )
                    )
                ),
              ),
              TextButton(
                onPressed: () async {
                  Weath = await getWeath();
                  Navigator.pop(context, Weath);
                },
                child: const Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
