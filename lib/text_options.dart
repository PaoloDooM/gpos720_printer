class TextOptions{
  bool bold;
  bool italic;
  bool underlined;

  TextOptions({this.bold = false, this.italic = false, this.underlined = false});

  List<bool> toList(){
    return [bold, italic, underlined];
  }
}