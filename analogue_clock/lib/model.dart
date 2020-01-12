import 'package:flutter/material.dart';

enum WeatherConditions {
  Sunny,
  Cloudy,
  PartlyCloudy,
  Thunderstorm,
  Rainy,
  Foggy,
  Windy,
  Snowy,
  Drizzle,
  Smog
}

class TemperatureModel extends ChangeNotifier {
  String _city = 'Cape Town';
  String get city => _city;
  set city(String city) {
    if (city != _city) {
      _city = city;
      notifyListeners();
    }
  }

  num _currentTemp = 27;
  get temperature {
    var _temp = _currentTemp;
    if (!_isCelcius) {
      _temp = toFarenheight(_temp);
    }
    return _currentTemp;
  }

  set temperature(num temperature) {
    if (temperature != _currentTemp) {
      if (!_isCelcius) {
        temperature = toCelcius(temperature);
      }
      _currentTemp = temperature;
      notifyListeners();
    }
  }

  String get temperatureString =>
      '${temperature.toStringAsFixed(0)} $getTemperatureUnit';

  num _high = 30;
  get high {
    var high = _high;
    if (!_isCelcius) {
      high = toFarenheight(high);
    }
    return high;
  }

  set high(num high) {
    if (!_isCelcius) {
      high = toCelcius(high);
    }
    if (high != _high) {
      if (high <= _low) {
        high = _low + 1;
      }
      _high = high;
      notifyListeners();
    }
  }

  String get highTempString => '${high.toStringAsFixed(0)} $getTemperatureUnit';

  num _low = 21;
  get low {
    var low = _low;
    if (!_isCelcius) {
      low = toFarenheight(_low);
    }
    return low;
  }

  set low(num low) {
    if (!_isCelcius) {
      low = toCelcius(low);
    }
    if (low != _low) {
      if (low >= _high) {
        low = _high - 1;
      }
      _low = low;
      notifyListeners();
    }
  }

  String get lowTempString => '${low.toStringAsFixed(0)} $getTemperatureUnit';

  num toCelcius(num value) {
    return (value - 32.0) * 5.0 / 9.0;
  }

  num toFarenheight(num value) {
    return value * 9.0 / 5.0 + 32.0;
  }

  bool _isCelcius = true;
  set isCelcius(bool value) {
    if (_isCelcius != value) {
      _isCelcius = value;
      notifyListeners();
    }
  }

  String get getTemperatureUnit {
    if (_isCelcius) {
      return '°C';
    } else {
      return '°F';
    }
  }

  WeatherConditions _condition = WeatherConditions.Sunny;
  WeatherConditions get weatherCondition => _condition;
  set weatherCondition(WeatherConditions condition) {
    if (_condition != condition) {
      _condition = condition;
      notifyListeners();
    }
  }

  String get weatherConditionString => _condition.toString().split('.').last;
}
