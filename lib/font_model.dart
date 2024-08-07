///A class to specify the desired font for printing.
class Font {
  String fontName;

  ///The constructor receives the font name as a parameter, and the font must be available in the assets folder under the directory "/fonts". By default, it is set to "NORMAL".
  Font({this.fontName = 'NORMAL'});
}
