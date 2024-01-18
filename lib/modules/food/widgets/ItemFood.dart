import 'package:flutter/material.dart';

import '../models/FoodListModel.dart';

class ItemFood extends StatelessWidget{
  Data? itemFood;
  ItemFood({ required this.itemFood});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 100,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipOval(
              child: Image.network(

                itemFood!.uploadImage!, // Assuming imageUrl is the variable for the image URL
                fit: BoxFit.cover,
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(width: 15), // Add some space between the image and text
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemFood!.foodName!, // Assuming name is the variable for the user's name
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w200,
                  ),
                  maxLines: 1,
                ),
                Text(
                  itemFood!.price!.toString()+" đ", // Assuming phone is the variable for the phone number
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  "Loại món ăn: "+ itemFood!.category!, // Assuming email is the variable for the email address
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
  }

}