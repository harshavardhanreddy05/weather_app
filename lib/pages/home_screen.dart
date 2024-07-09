import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/pages/const.dart';
import 'package:weather_icons/weather_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
  final WeatherFactory _wf = WeatherFactory(API);
  Weather? _weather;

  void _fetchWeather(String cityName) {
    _wf.currentWeatherByCityName(cityName).then((w) {
      setState(() {
        _weather = w;
      });
    }).catchError((error) {
      print('Error fetching weather: $error');
      _showErrorDialog(
          'Failed to fetch weather data. Please Enter Correct Location');
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather("Hyderabad");
  }

  void _performSearch() {
    String searchQuery = _searchController.text;
    if (searchQuery.isNotEmpty) {
      _fetchWeather(searchQuery);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[100],
        title: Text(
          "My Weather App",
          style: GoogleFonts.poppins(fontSize: 25),
        ),
      ),
      drawer: Drawer(),
      backgroundColor: const Color.fromRGBO(206, 226, 251, 1),
      body: SingleChildScrollView(
        child: _buildUI(),
      ),
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      // height: 200,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          _input(),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              height: 100,
              width: 360,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: const Color.fromRGBO(54, 116, 242, .8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _locationHeader(),
                  _dateTimeInfo(),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _weatherIcon(),
          const SizedBox(
            height: 20,
          ),
          // _currentTemp(),
          const SizedBox(
            height: 10,
          ),
          _extraInfo()
        ],
      ),
    );
  }

  Widget _input() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(
          color: Color.fromRGBO(54, 116, 242, 1), // Set the text color here
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromRGBO(254, 254, 255, 1),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(54, 116, 242, 1),
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(54, 116, 242, 1),
            ),
            borderRadius: BorderRadius.circular(14.0),
          ),
          hintText: 'Search',
          hintStyle: GoogleFonts.poppins(
            color: Color.fromRGBO(54, 116, 242, 1),
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Color.fromRGBO(54, 116, 242, 1),
          ),
        ),
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            _fetchWeather(value);
          }
        },
      ),
    );
  }

  Widget _locationHeader() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            size: 25,
            Icons.location_pin,
            color: Colors.white,
          ),
          Text(
            _weather?.areaName ?? "",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
            // style: const TextStyle(
            //   fontSize: 40,
            //   color: Color.fromRGBO(54, 116, 242, 1),
            //   fontWeight: FontWeight.w500,
            // ),
          ),
        ],
      ),
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              " ${DateFormat("d.M.y").format(now)}",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              DateFormat("h:mm a").format(now),
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 180,
          width: 360,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: const Color.fromRGBO(54, 116, 242, .8),
            // image: DecorationImage(
            //   alignment: AlignmentDirectional.centerEnd,
            //   image: NetworkImage(
            //       "https://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png",
            //       scale: 1),
            // ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(child: _currentTemp()),
              ),
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  child: Image.network(
                    "https://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png",
                    scale: 1,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _currentTemp() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        "${_weather?.temperature?.celsius?.toStringAsFixed(0)}℃",
        // style: const TextStyle(
        //   fontSize: 50,
        //   color: Color.fromRGBO(254, 254, 255, 1),
        //   fontWeight: FontWeight.w500,
        // ),
        style: GoogleFonts.poppins(
          color: const Color.fromRGBO(254, 254, 255, 1),
          fontSize: 50,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _extraInfo() {
    return Container(
        height: MediaQuery.of(context).size.height * .15,
        width: MediaQuery.of(context).size.width * .9,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(254, 254, 255, 1),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const BoxedIcon(
                      WeatherIcons.thermometer,
                      color: Color.fromRGBO(54, 116, 242, 1),
                      size: 30,
                    ),
                    Text(
                      " ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}℃",
                      style: GoogleFonts.poppins(
                        color: const Color.fromRGBO(54, 116, 242, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Max",
                      style: GoogleFonts.poppins(
                        color: const Color.fromRGBO(54, 116, 242, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const BoxedIcon(
                      WeatherIcons.thermometer,
                      size: 30,
                      color: Color.fromRGBO(54, 116, 242, 1),
                    ),
                    Text(
                      " ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}℃",
                      style: GoogleFonts.poppins(
                        color: const Color.fromRGBO(54, 116, 242, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Min",
                      style: GoogleFonts.poppins(
                        color: const Color.fromRGBO(54, 116, 242, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const BoxedIcon(
                      WeatherIcons.wind_beaufort_0,
                      size: 30,
                      color: Color.fromRGBO(54, 116, 242, 1),
                    ),
                    Text(
                      " ${_weather?.windSpeed?.toStringAsFixed(0)}m/s",
                      style: GoogleFonts.poppins(
                        color: const Color.fromRGBO(54, 116, 242, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Wind",
                      style: GoogleFonts.poppins(
                        color: const Color.fromRGBO(54, 116, 242, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const BoxedIcon(
                      WeatherIcons.day_haze,
                      size: 30,
                      color: Color.fromRGBO(54, 116, 242, 1),
                    ),
                    Text(
                      " ${_weather?.humidity?.toStringAsFixed(0)}%",
                      style: GoogleFonts.poppins(
                        color: const Color.fromRGBO(54, 116, 242, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Humidity",
                      style: GoogleFonts.poppins(
                        color: const Color.fromRGBO(54, 116, 242, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
