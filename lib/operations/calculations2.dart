class Calculations2{
  static int price = 0;
  static int quantity = 0;
  static List<int> finalPrice = [];
  static int total = 0 ;
  static int temp1 = 0;
  static int reducePrice = 0;
  
  int genarateTotal(){
    if(temp1 == 0){
      for(final i in finalPrice){
      total = total + i;  
    }
      finalPrice.clear();
      return  total;
    }else if(temp1 == 1){
      temp1 = 0;
      return total =  total - reducePrice;
    }else{
      temp1 = 0;
      return total = 0;
    }
    
  }
}