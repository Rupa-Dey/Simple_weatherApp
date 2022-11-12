import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:flutter/src/foundation/key.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:weather_app/models/Weather.dart';

import 'package:http/http.dart' as http;

class currentWeatherPage extends StatefulWidget {
  const currentWeatherPage({Key? key}) : super(key: key);

  @override
  State<currentWeatherPage> createState() => _currentWeatherPageState();
}

class _currentWeatherPageState extends State<currentWeatherPage> {
  //set weaTher(Object? weaTher) {}

  //late Weather _weather;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
          appBar: new AppBar(
            backgroundColor: Color.fromARGB(255, 85, 58, 48),
            title: new Text('Weather Application',style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),),
          ),
      body: Center(
        child: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot != null) {
              print(snapshot);
              Weather _weather = snapshot.data;
              print("today's weather is : ${_weather}");
              if (_weather == null) {
                return Text("Error getting weather");
              } else {
                return weatherBox(_weather);
              }
            } else {
              return CircularProgressIndicator();
            }
          },
          future: getCurrentWeather(),
        ),
      ), //
    );
  }
}

Widget weatherBox(Weather _weather) {
  return Column(mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        margin: const EdgeInsets.all(10.0),
        child: Text("${_weather.temp}°C",
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 70),
        ),
      ),
      Container(
       child: 
      Text("${_weather.description}",
      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),
      ),),
      Text(" Feels:${_weather.feelslike}°C"),
      Text("High: ${_weather.high}°C   Low: ${_weather.low}°C"),
    ],
  );
}

Future getCurrentWeather() async {
  late Weather weather;
  var url =
      "https://api.openweathermap.org/data/2.5/weather?q=Rajshahi&appid=db7e8f8d800906537acc20b8ec2168d7&units=metric";
  final response = await http.get(url);
  print(response.body);
  if (response.statusCode == 200) {
    // print(response.body);
    weather = Weather.fromJson(jsonDecode(response.body));
  }
  return weather;
}
