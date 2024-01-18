import 'package:dio/dio.dart';
import '../models/FoodListModel.dart';

class FoodListRepo {
  Future<List<Data>?> TakeAllFoodListByUserId() async {
    try {
      final res = await Dio(BaseOptions(baseUrl: "https://cca5-2402-800-6342-8760-60d9-2003-33a0-9ad1.ngrok-free.app/"))
          .get("api/store/TakeAllFoodListByStoreId",
        queryParameters: {"Id": 1}, // User Id = 1
      );

      print(res.data);

      if (res.statusCode != 200) {
        if (res.statusCode == 404) {
          // Handle 404 Not Found error
          print("Resource not found");
          return null;
        } else {
          // Handle other non-success status codes
          print("Error: ${res.statusCode}");
          return null;
        }
      }

      List data = res.data['Data'];
      return data.map((json) => Data.fromJson(json)).toList();
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }
}
