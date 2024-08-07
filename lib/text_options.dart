///A class that specifies the desired text decoration.
class TextOptions {
  bool bold;
  bool italic;
  bool underlined;

  ///The constructor can add [bold], [italic], or [underline] styles. By default, all styles are set to false.
  TextOptions(
      {this.bold = false, this.italic = false, this.underlined = false});

  List<bool> toList() {
    return [bold, italic, underlined];
  }
}
