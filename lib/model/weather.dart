class Weather {
  // Utility function to get weather icon based on weather condition
  String getWeatherIcon(int condition) {
    if (condition < 300) return "🌩";
    if (condition < 400) return "🌧";
    if (condition < 600) return "☔️";
    if (condition < 700) return "☃️";
    if (condition < 800) return "🌫";
    if (condition == 800) return "☀️";
    if (condition <= 804) return "☁️";
    return "🤷‍";
  }

  // Utility function to get message based on temperature
  String getMessage(int temp) {
    if (temp > 25) return "It's 🍦 time";
    if (temp > 20) return "Time for shorts and 👕";
    if (temp < 10) return "You'll need 🧣 and 🧤";
    return "Bring a 🧥 just in case";
  }
}
