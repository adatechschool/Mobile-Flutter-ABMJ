//This class define the SurfSpot objects for later
class SurfSpot {
  String name;
  String url;
  String address;

  SurfSpot(this.name, this.url, this.address);

  @override
  String toString() {
    return '{ ${this.name}, ${this.url}, ${this.address} }';
  }
}
