import 'package:my_game_library/models/game.dart';

class Filter {
  TextFilter textFilter;
  PlatformFilter platformFilter;
  OwnershipFilter ownershipFilter;
  EditionFilter editionFilter;
  PlayStatusFilter playStatusFilter;

  Filter() {
    textFilter = TextFilter();
    platformFilter = PlatformFilter();
    ownershipFilter = OwnershipFilter();
    editionFilter = EditionFilter();
    playStatusFilter = PlayStatusFilter();
  }



  bool filter(Game game) {
    if (textFilter.filter(game)
      && platformFilter.filter(game) 
      && ownershipFilter.filter(game)
      && editionFilter.filter(game)
      && playStatusFilter.filter(game)
    ) return true;
    return false;
  }

}

class TextFilter {
  String text;
  bool includeName;
  bool includeNotes;
  
  TextFilter() {
    text = "";
    includeName = true;
    includeNotes = false;
  }
  TextFilter.fromFilter(TextFilter filter) {
    text = filter.text;
    includeName = filter.includeName;
    includeNotes = filter.includeNotes;
  }

  /// Will filter the provided game based off the data within the filter
  bool filter(Game game) {
    if (text == "") return true;
    if (includeName && game.name.toLowerCase().contains(text.toLowerCase())) return true;
    if (includeNotes && game.notes!=null && game.notes.toLowerCase().contains(text.toLowerCase())) return true;
    return false;
  }

  /// Reset parameters to default
  void reset() {
    text = "";
    includeName = true;
    includeNotes = false;
  }

  /// Returns whether this filter has data
  bool hasFilter () => text!="";

}

class PlatformFilter {
  Set<String> selectedPlatforms;

  PlatformFilter() {
    selectedPlatforms = Set();
  }
  PlatformFilter.fromFilter(PlatformFilter filter) {
    selectedPlatforms = filter.selectedPlatforms;
  }

  /// Will filter the provided game based off the data within the filter
  bool filter(Game game) {
    if (selectedPlatforms.isEmpty) return true;
    if (selectedPlatforms.contains(game.platform)) return true;
    return false;
  }

  /// Reset parameters to default
  void reset() {
    selectedPlatforms.clear();
  }

  /// Returns whether this filter has data
  bool hasFilter () => selectedPlatforms.isNotEmpty;

}

class OwnershipFilter {
  Set<String> selectedStatuses;

  OwnershipFilter() {
    selectedStatuses = Set();
  }
  OwnershipFilter.fromFilter(OwnershipFilter filter) {
    selectedStatuses = filter.selectedStatuses;
  }

  /// Will filter the provided game based off the data within the filter
  bool filter(Game game) {
    if (selectedStatuses.isEmpty) return true;
    if (selectedStatuses.contains(game.ownedStatus)) return true;
    return false;
  }

  /// Reset parameters to default
  void reset() {
    selectedStatuses.clear();
  }

  /// Returns whether this filter has data
  bool hasFilter () => selectedStatuses.isNotEmpty;
  
}

class EditionFilter {
  Set<String> selectedEditions;

  EditionFilter() {
    selectedEditions = Set();
  }
  EditionFilter.fromFilter(EditionFilter filter) {
    selectedEditions = filter.selectedEditions;
  }

/// Will filter the provided game based off the data within the filter
  bool filter(Game game) {
    if (selectedEditions.isEmpty) return true;
    if (selectedEditions.contains(game.edition)) return true;
    return false;
  }

  /// Reset parameters to default
  void reset() {
    selectedEditions.clear();
  }

  /// Returns whether this filter has data
  bool hasFilter () => selectedEditions.isNotEmpty;
  
}

class PlayStatusFilter {
  Set<String> selectedStatuses;

  PlayStatusFilter() {
    selectedStatuses = Set();
  }
  PlayStatusFilter.fromFilter(PlayStatusFilter filter) {
    selectedStatuses = filter.selectedStatuses;
  }

  /// Will filter the provided game based off the data within the filter
  bool filter(Game game) {
    if (selectedStatuses.isEmpty) return true;
    if (selectedStatuses.contains(game.playStatus)) return true;
    return false;
  }

  /// Reset parameters to default
  void reset() {
    selectedStatuses.clear();
  }

  /// Returns whether this filter has data
  bool hasFilter () => selectedStatuses.isNotEmpty;
  
}