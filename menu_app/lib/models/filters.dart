class Filters {
  var glutenFree = false;
  var vegetarian = false;
  var vegan = false;
  var lactoseFree = false;

  @override
  String toString() {
    var output = '{\n'
        'glutenFree = $glutenFree\n'
        'vegetarian = $vegetarian\n'
        'vegan = $vegan\n'
        'lactoseFree = $lactoseFree\n'
        '}';
    return output;
  }
}
