class Ingredient{
  double amount;
  String unitOfMeasurement;
  String ingredientName;

  Ingredient({
    required this.amount,
    required this.unitOfMeasurement,
    required this.ingredientName,
  });

  Map<String, dynamic> toJson(){
      return {
        "amount": amount,
        "unitOfMeasurement": unitOfMeasurement,
        "ingredientName": ingredientName,
      };
  }

  static Ingredient fromJson(Map<String, dynamic> json){

    // check if amount is an int. if so, convert it to a double.
    if (json['amount'] is int) {
      json['amount'] = json['amount'].toDouble();
    }

    return Ingredient(
      amount: json['amount'],
      unitOfMeasurement: json['unitOfMeasurement'],
      ingredientName: json['ingredientName'],
    );
  }
}
