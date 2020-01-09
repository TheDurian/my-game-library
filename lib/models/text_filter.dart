class TextFilter {
  String text;
  bool includeNotes;
  bool includeName;

  TextFilter({
    this.text="",
    this.includeNotes=false,
    this.includeName=true
  });

  void reset() {
    text = "";
    includeNotes = false;
    includeName = true;
  }

}