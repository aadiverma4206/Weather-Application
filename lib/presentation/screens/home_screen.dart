import 'package:flutter/material.dart';
import '../../data/models/weather_model.dart';
import '../../data/services/api_service.dart';
import '../widgets/laoding_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/weather_card.dart';
import '../widgets/error_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Future<WeatherModel>? futureWeather;
  final TextEditingController controller = TextEditingController();

  late AnimationController _controller;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    futureWeather = ApiService.fetchWeather("Delhi");

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
  }

  void searchWeather() {
    final city = controller.text.trim();

    if (city.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter a city name")),
      );
      return;
    }

    setState(() {
      futureWeather = ApiService.fetchWeather(city);
      _controller.reset();
      _controller.forward();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _controller.dispose();
    super.dispose();
  }

  Widget buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: (_) => searchWeather(),
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Search city...",
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: searchWeather,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                ),
              ),
              child: const Icon(Icons.search, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Column(
      children: const [
        SizedBox(height: 20),
        Text(
          "Weather App",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 6),
        Text(
          "Live Weather Updates",
          style: TextStyle(color: Colors.white54),
        ),
      ],
    );
  }

  Widget buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff0f2027),
            Color(0xff203a43),
            Color(0xff2c5364),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget buildWeatherSection() {
    return Expanded(
      child: FutureBuilder<WeatherModel>(
        future: futureWeather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          }

          if (snapshot.hasError) {
            return const ErrorWidgetCustom(
              message: "City not found\nTry Delhi, Mumbai, London",
            );
          }

          if (snapshot.hasData) {
            return FadeTransition(
              opacity: fadeAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: WeatherCard(
                    key: ValueKey(snapshot.data!.city),
                    weather: snapshot.data!,
                  ),
                ),
              ),
            );
          }

          return const Center(
            child: Text(
              "Search a city",
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }

  Widget buildExtraUI() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildMiniCard(Icons.thermostat, "Temp"),
            buildMiniCard(Icons.air, "Wind"),
            buildMiniCard(Icons.water_drop, "Humidity"),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildMiniCard(IconData icon, String label) {
    return Container(
      width: 90,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white54),
          )
        ],
      ),
    );
  }

  Widget buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.location_on, color: Colors.white54),
          Icon(Icons.settings, color: Colors.white54),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(),
          SafeArea(
            child: Column(
              children: [
                buildHeader(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: buildSearchBar(),
                ),
                const SizedBox(height: 10),
                buildWeatherSection(),
                buildExtraUI(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: buildBottomBar(),
          )
        ],
      ),
    );
  }
}