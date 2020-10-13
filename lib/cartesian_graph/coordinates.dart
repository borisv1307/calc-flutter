class Coordinates{
  final double x;
  final double y;

  Coordinates(this.x,this.y);

  @override
  String toString(){
    return 'X:${x.toString()} Y:${y.toString()}';
  }
}