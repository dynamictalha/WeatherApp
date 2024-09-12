import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weatherapp/Screen/consts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherFactory _weatherFactory = WeatherFactory(OPEN_WEATHER_API_KEY);

  Weather? _weather;

  void initState(){
    super.initState();
    _weatherFactory.currentWeatherByCityName("Karachi").then((value) {
      setState(() {
        _weather = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI(){
    if (_weather == null ) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg.jpg"), // Path to your image
              fit: BoxFit.cover, // Makes the image cover the entire background
            ),
          ),


      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height:MediaQuery.sizeOf(context).height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _locationHeader(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
            _dateTimeInfo(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            _weatherIcon(),
             SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
             _currentTemp(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
            _extraInfo(),
          ],
        ),
      ),
    );
  }
  Widget _locationHeader(){
    return Text(_weather?.areaName ?? "",
    style: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w900,
    ),
    );
  }
  Widget _dateTimeInfo(){
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(DateFormat("h:mm a").format(now),
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w400,
        ),
        ),
        SizedBox(height: 10,),
        Row(
          mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Text(DateFormat("EEEE").format(now),
        style: TextStyle(
          fontWeight: FontWeight.w900,
        ),
        ),
            Text( "  ${DateFormat("d.MMMM.y").format(now)}",
        style: TextStyle(
          fontWeight: FontWeight.w900,
        ),
        ),
          ],
        )
      ],
    );
  }
  Widget _weatherIcon(){
    return Column(
      mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
            image: DecorationImage(
              image:NetworkImage("https://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),
              ),
          ),
        ),
        Text(
          _weather?.weatherDescription ?? "",
           style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
       ),
      ],
    );
  }
  Widget _currentTemp(){
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(1)}° C",
       style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 40,
        ),
    );
  }

  Widget _extraInfo(){
    return Container(
       width: MediaQuery.sizeOf(context).width * 0.8,
      height:MediaQuery.sizeOf(context).height * 0.15 ,
      decoration: BoxDecoration(
        color: Color(0xFF0FB2F2),
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Row(
              mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("MAX: ${_weather?.tempMax?.celsius?.toStringAsFixed(1)}° C",
              style: TextStyle(
                color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 15,
              ),
              ),

              Text("MIN: ${_weather?.tempMin?.celsius?.toStringAsFixed(1)}° C",
              style: TextStyle(
                color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 15,
              ),
              ),
            ],
          ),

          // Wind Speed
          Row(
              mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Wind Speed: ${_weather?.windSpeed?.toStringAsFixed(1)} m/s",
              style: TextStyle(
                color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 15,
              ),
              ),

              Text("Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
              style: TextStyle(
                color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 15,
              ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}