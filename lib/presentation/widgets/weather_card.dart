import 'package:flutter/material.dart';
import '../../data/models/weather_model.dart';

class WeatherCard extends StatefulWidget {
  final WeatherModel weather;

  const WeatherCard({super.key, required this.weather});

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> fadeAnimation;
  late Animation<double> slideAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    slideAnimation = Tween<double>(begin: 50, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    scaleAnimation = Tween<double>(begin: 0.85, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant WeatherCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  IconData getWeatherIcon(String condition) {
    final c = condition.toLowerCase();

    if (c.contains("cloud")) return Icons.cloud;
    if (c.contains("rain")) return Icons.grain;
    if (c.contains("clear")) return Icons.wb_sunny;
    if (c.contains("snow")) return Icons.ac_unit;
    if (c.contains("storm")) return Icons.flash_on;
    if (c.contains("mist")) return Icons.blur_on;

    return Icons.wb_cloudy;
  }

  List<Color> getGradient(String condition) {
    final c = condition.toLowerCase();

    if (c.contains("clear")) {
      return [const Color(0xfff7971e), const Color(0xffffd200)];
    }
    if (c.contains("cloud")) {
      return [const Color(0xff757f9a), const Color(0xffd7dde8)];
    }
    if (c.contains("rain")) {
      return [const Color(0xff4e54c8), const Color(0xff8f94fb)];
    }
    if (c.contains("snow")) {
      return [const Color(0xffe6dada), const Color(0xff274046)];
    }

    return [const Color(0xff141e30), const Color(0xff243b55)];
  }

  Widget buildTopSection() {
    return Column(
      children: [
        Text(
          widget.weather.city,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.weather.condition,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget buildTempSection() {
    return Column(
      children: [
        Text(
          "${widget.weather.temp.toStringAsFixed(1)}°",
          style: const TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget buildIconSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.15),
      ),
      child: Icon(
        getWeatherIcon(widget.weather.condition),
        size: 60,
        color: Colors.white,
      ),
    );
  }

  Widget buildBottomDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildMini("Feels", "${widget.weather.temp.toInt()}°"),
        buildMini("Humidity", "70%"),
        buildMini("Wind", "12 km/h"),
      ],
    );
  }

  Widget buildMini(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildGlassOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
      ),
    );
  }

  Widget buildCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: getGradient(widget.weather.condition),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          buildGlassOverlay(),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTopSection(),
              const SizedBox(height: 20),
              buildIconSection(),
              const SizedBox(height: 20),
              buildTempSection(),
              const SizedBox(height: 20),
              buildBottomDetails(),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: Transform.translate(
        offset: Offset(0, slideAnimation.value),
        child: ScaleTransition(
          scale: scaleAnimation,
          child: buildCard(),
        ),
      ),
    );
  }
}