


String createCustomId(){
  final numbers = [0,1,2,3,4,5,6,7,8,9];
  numbers.shuffle();

  String id= numbers.join();

  print('new id created :$id');
  
  return id;
}