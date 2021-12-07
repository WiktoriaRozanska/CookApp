import 'dart:ffi';

enum Units {
  grams,
  kilograms,
  slice,
  teaspoon,
  tablespoon,
  cup,
  pint,
  mililiter,
  liter
}

class Ingredient {
  String? name;
  double? quantity;
  Units? unit;

  Ingredient({this.name, this.quantity, this.unit});
}
