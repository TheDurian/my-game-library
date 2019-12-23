class Game {
  int id; //Done
  String name; //Done
  String platform; //Done
  String notes; //Done
  String ownedStatus; //Done
  
  String edition;
  double price; 
  String playStatus;
  DateTime dateOfLastCompletion;
  int playtime;


  static final ownedStatuses = ["Emulated", "Physical", "Digital", "Wishlist"];
  static final editions = ["Standard", "Steelbook", "Metalcase/Other"];
  static final playStatuses = [
    "Backlog",
    "On Hold",
    "Playing",
    "Beaten",
    "Polishing",
    "Platinum/All Achievements",
    "100%"
  ];
  static final platforms = [
    "PC",
    "PSX",
    "PS2",
    "PS3",
    "PS4",
    "PSP",
    "Vita",
    "NES",
    "SNES",
    "N64",
    "Gamecube",
    "Wii",
    "Wii U",
    "Switch",
    "GBC",
    "GBA",
    "DS",
    "3DS",
    "Xbox",
    "Xbox 360",
    "Xbox One",
    "Other"
  ];

  Game({
    this.id, 
    this.name, 
    this.ownedStatus, 
    this.edition, 
    this.price, 
    this.platform, 
    this.playStatus, 
    this.dateOfLastCompletion, 
    this.playtime, 
    this.notes
  });
  
  Map<String,dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ownedStatus': ownedStatus,
      'edition': edition,
      'price': price,
      'platform': platform,
      'playStatus': playStatus,
      'dateOfLastCompletion': dateOfLastCompletion?.millisecondsSinceEpoch,
      'playtime': playtime,
      'notes': notes
    };
  }

  Game.fromDb(Map<String,dynamic> map) {
      id = map['id'];
      name = map['name'];
      ownedStatus = map['ownedStatus'];
      edition = map['edition'];
      price = map['price'];
      platform = map['platform'];
      playStatus = map['playStatus'];
      dateOfLastCompletion = (map['dateOfLastCompletion']!=null) ? DateTime.fromMillisecondsSinceEpoch(map['dateOfLastCompletion']) : null;
      playtime = map['playtime'];
      notes = map['notes'];
  }

  
    
  bool isOwned() => ownedStatus != null && ownedStatus != "Wishlist";

  bool hasBeaten() => ["Beaten","Polishing","Platinum/All Achievements","100%"].contains(playStatus);

  void modifyOwnershipFields(String status) {
    ownedStatus = status;
 
    if (ownedStatus == "Wishlist") {
      playStatus = null;
      dateOfLastCompletion = null;
      playtime = null;
    }
  }

  @override
  String toString() => this.toMap().toString();
  

}