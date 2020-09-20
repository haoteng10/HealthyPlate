import "package:oauth2/oauth2.dart";
import "package:http/http.dart" as http;
import "package:flutter_dotenv/flutter_dotenv.dart";
import "dart:convert";
import "package:nutrition/models/food.dart";
import "package:nutrition/models/api/serving.dart";

class FatSecretService {
  Client _oauthClient;

  //FatSecret OAuth2
  final String _fatSecretClientID = DotEnv().env["FATSECRET_CLIENT_ID"];
  final String _fatSecretClientSecret = DotEnv().env["FATSECRET_CLIENT_SECRET"];
  final _authorizationEndpoint =
      Uri.parse("https://oauth.fatsecret.com/connect/token");

  Future<bool> checkAndRefreshToken() async {
    if (_oauthClient == null || _oauthClient.credentials.isExpired) {
      await _fetchToken();
      return true;
    }
    return false;
  }

  Future<void> _fetchToken() async {
    Client client = await clientCredentialsGrant(
        _authorizationEndpoint, _fatSecretClientID, _fatSecretClientSecret);
    _oauthClient = client;
  }

  //Use the barcode to find id (Returns the id of the item in FatSecret) -1: invalid input/error, 0: not found in the database
  Future<int> findIDForBarcode(int barcode) async {
    await checkAndRefreshToken();

    if (barcode > 0) {
      http.Response response = await _oauthClient
          .post("https://platform.fatsecret.com/rest/server.api", body: {
        "method": "food.find_id_for_barcode",
        "barcode": barcode.toString(),
        "format": "json",
      });

      if (response.statusCode == 200) {
        Map jsonResponse = json.decode(response.body);
        return int.parse(jsonResponse["food_id"]["value"]);
      }
    }

    return -1;
  }

  //Use the item id to get nutritional values
  Future<FoodData> getFoodNutrition(int foodID) async {
    await checkAndRefreshToken();

    if (foodID > 0) {
      http.Response jsonResponse = await _oauthClient
          .post("https://platform.fatsecret.com/rest/server.api", body: {
        "method": "food.get.v2",
        "food_id": foodID.toString(),
        "format": "json",
      });

      if (jsonResponse.statusCode == 200) {
        Map response = json.decode(jsonResponse.body)["food"];

        Serving itemServing;

        // print(response);

        try {
          dynamic mapServing = response["servings"]["serving"];

          if (mapServing is List) {
            // multipleServings = true;
            itemServing = Serving(
              calories: mapServing[0]["calories"],
              carbohydrate: mapServing[0]["carbohydrate"],
              fat: mapServing[0]["fat"],
              measurementDescription: mapServing[0]["measurement_description"],
              servingAmount: mapServing[0]["metric_serving_amount"],
              servingUnit: mapServing[0]["metric_serving_unit"],
              numberOfUnits: mapServing[0]["number_of_units"],
              protein: mapServing[0]["protein"],
              servingDescription: mapServing[0]["serving_description"],
            );
          } else {
            itemServing = Serving(
              calories: mapServing["calories"],
              carbohydrate: mapServing["carbohydrate"],
              fat: mapServing["fat"],
              measurementDescription: mapServing["measurement_description"],
              servingAmount: mapServing["metric_serving_amount"],
              servingUnit: mapServing["metric_serving_unit"],
              numberOfUnits: mapServing["number_of_units"],
              protein: mapServing["protein"],
              servingDescription: mapServing["serving_description"],
            );
          }
        } catch (err) {
          itemServing = Serving(
            calories: "0",
            carbohydrate: "0",
            fat: "0",
            protein: "0",
            measurementDescription: "",
            servingAmount: "",
            servingUnit: "",
            numberOfUnits: "",
            servingDescription: "",
          );
          print(err);
          print("Serving failed to retrieve! Using backup values instead.");
        }

        FoodData foodItem;

        try {
          foodItem = FoodData(
            brandName: response["brand_name"] ?? "",
            foodName: response["food_name"] ?? "",
            foodUrl: response["food_url"] ?? "",
            serving: itemServing,
          );
        } catch (err) {
          print(err);
          print(
              "Something wrong with food names. Using backup values instead.");
          foodItem = FoodData();
        }

        return foodItem;
      }
    } else {
      print("===== Product not found! =====");
    }

    return null;
  }
}
