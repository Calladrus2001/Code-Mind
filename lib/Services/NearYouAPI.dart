import 'package:geolocator/geolocator.dart';
import 'package:greencode/Models/SearchResult.dart';
import 'package:http/http.dart' as http;

class NearYouAPI {
  Future<SearchResult?> getResult(Position pos) async {
    final Uri url = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/textsearch/json?key=AIzaSyBSw7Tfvgu7fDjEtrFBPJUQGxP9WU_iy0w&location=${pos.latitude},${pos.longitude}&query=therapist&type=health&radius=2000");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return searchResultFromJson(response.body);
    } else {
      return null;
    }
  }
}
