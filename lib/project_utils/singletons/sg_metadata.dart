class SgMetadata {
  SgMetadata._();

  static SgMetadata instance = SgMetadata._();
  
  static String _dir = ''; //some variables
  
  //Some Method
  void setDir(String dir){
    _dir = dir;
  }

  String get dir => _dir;
}