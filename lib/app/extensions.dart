

import 'package:movieapp/data/mapper/mapper.dart';


extension NoNullString on String?{
  String orEmpty(){
    if(this == null){
      return EMPTY;
    }
    else{
      return this!;
    }
  }
}

extension NoNullInteger on int?{
  int orZero(){
    if(this == null){
      return ZERO;
    }
    else{
      return this!;
    }
  }
}

extension NoNullDouble on double?{
  double orZero(){
    if(this == null){
      return ZERODOUBLE;
    }
    else{
      return this!;
    }
  }
}

extension NoNullBool on bool?{
  bool orFalse(){
    if (this==null) {
      return false;
    } else {
      return this!;
    }
  }
}