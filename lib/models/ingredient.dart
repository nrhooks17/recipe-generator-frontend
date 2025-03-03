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
}