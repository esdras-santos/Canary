String toToken(String value) {
  if (value.contains(".")) {
    var amount = value.split(".");
    if (amount[1].length < 8) {
      for (int i = amount[1].length; i < 18; i++) {
        amount[1] = amount[1] + "0";
      }
    }
    if (int.parse(amount[0]) == 0) {
      return "${int.parse(amount[1])}";
    }

    return amount[0] + "${amount[1]}";
  } else {
    value = value + "000000000000000000";
    return value;
  }
}

String toTokenFormat(String value) {
  if (value.length > 18) {
    var p1 = value.substring(0, value.length - 18);
    var p2 = value.substring(value.length - 18, value.length);
    while(p2[p2.length-1] =="0") {
      p2 = p2.substring(0, p2.length - 1);
      
    }
    return p1 + "." + p2;
  } else {
    var vl = value.length;
    while (value[value.length-1] == "0") {
      value = value.substring(0, value.length - 1);
    }
    for (int j = 0; j < 18 - vl; j++) {
      value = "0" + value;
    }
    return "0."+value;
  }
}
