import 'dart:ui';

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  // Get location by IP (works on Web)
  Future<Map<String, dynamic>> getLocationFromIP() async {
    final response = await http.get(Uri.parse('https://ipapi.co/json/'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'lat': data['latitude'],
        'lon': data['longitude'],
        'city': data['city'],
      };
    } else {
      throw Exception("Failed to fetch location");
    }
  }

  // Get weather from OpenMeteo (FREE)
  Future<Map<String, dynamic>> getWeather(double lat, double lon) async {
    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return {
        'temp': json['current_weather']['temperature'],
        'windspeed': json['current_weather']['windspeed'],
        'code': json['current_weather']['weathercode'],
      };
    } else {
      throw Exception("Failed to fetch weather");
    }
  }
}

class WeatherSquareWidget extends StatefulWidget {
  const WeatherSquareWidget({super.key});

  @override
  State<WeatherSquareWidget> createState() => _WeatherSquareWidgetState();
}

class _WeatherSquareWidgetState extends State<WeatherSquareWidget> {
  double scale = 1.0;
  bool isHovering = false;

  String city = "Loading...";
  double temp = 0;
  bool isDay = true;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadWeather();
  }

  // ----------- GET LOCATION (Free API) -----------
  Future<Map<String, dynamic>> _fetchLocation() async {
    final url = Uri.parse("https://ipapi.co/json/");
    final res = await http.get(url);
    final data = jsonDecode(res.body);
    return {
      "city": data["city"],
      "lat": data["latitude"],
      "lon": data["longitude"],
    };
  }

  // ----------- GET WEATHER (Open-Meteo Free API) -----------
  Future<Map<String, dynamic>> _fetchWeather(double lat, double lon) async {
    final url = Uri.parse(
      "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true",
    );

    final res = await http.get(url);
    final data = jsonDecode(res.body);

    return {"temp": data["current_weather"]["temperature"]};
  }

  Future<void> loadWeather() async {
    try {
      final loc = await _fetchLocation();
      final weather = await _fetchWeather(loc["lat"], loc["lon"]);

      city = loc["city"];
      temp = weather["temp"];

      final hour = DateTime.now().hour;
      isDay = hour >= 6 && hour < 18;

      setState(() => loading = false);
    } catch (e) {
      print("Weather Error: $e");
      setState(() => loading = false);
    }
  }

  // ------------ Animations like InfoSquareWidget ------------
  void _onTapDown(_) {
    setState(() => scale = 0.95);
  }

  void _onTapUp(_) {
    setState(() => scale = 1.0);
  }

  void _onTapCancel() {
    setState(() => scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    IconData weatherIcon = isDay ? Icons.wb_sunny : Icons.nightlight_round;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),

      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,

        child: AnimatedScale(
          scale: isHovering ? 1.03 : scale,
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            height: 120,
            padding: const EdgeInsets.all(14),

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.20),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: Colors.white.withOpacity(isHovering ? 0.25 : 0.15),
                width: 1.2,
              ),
              boxShadow: [
                if (isHovering)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
              ],
            ),

            child: loading
                ? const Center(
                    child: SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        weatherIcon,
                        color: isDay ? Colors.yellow : Colors.white,
                        size: 28,
                      ),

                      const Spacer(),

                      Text(
                        "${temp.toStringAsFixed(1)}°C",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        city,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
