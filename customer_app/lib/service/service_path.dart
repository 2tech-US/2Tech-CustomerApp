class ServicePath {
  static const String apiUrl = "http://10.0.2.2:3000";
  static const String login = "$apiUrl/auth/login/passenger";
  static const String register = "$apiUrl/auth/register";

  //Passenger
  static const String getPassengerInfor = "$apiUrl/passengers/";

  //Booking
  static const String createBooking = "$apiUrl/bookings/request";

  //Google maps
  static const String googleMapsAPIKey =
      "AIzaSyDH75bfzU1Vy1VqSOAPBrVZ_OUCOlnLE8E";
}
