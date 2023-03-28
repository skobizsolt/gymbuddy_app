class Headers {
  Map<String, String> getPOSTHeadersWithToken(String token) => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

  Map<String, String> get getGETHeaders => {'Content-Type': 'application/json'};

  Map<String, String> get getPOSTHeaders =>
      {'Content-Type': 'application/json', 'Accept': 'application/json'};
}
