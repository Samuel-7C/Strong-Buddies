class Buddy {
  String _id;
  String _gender;
  String _displayName;
  String _preferTimeWorkout;
  String _gymMemberShip;
  List<String> _pictures;
  List<String> _workoutTypes;

  Buddy({
    String id,
    String gender,
    String displayName,
    String preferTimeWorkout,
    String gymMemberShip,
    List<String> pictures,
    List<String> workoutTypes,
  }) {
    this._gender = gender;
    this._displayName = displayName;
    this._preferTimeWorkout = preferTimeWorkout;
    this._gymMemberShip = gymMemberShip;
    this._pictures = pictures;
    this._workoutTypes = workoutTypes;
    this._id = id;
  }

  String get gender => _gender;
  set gender(String gender) => _gender = gender;

  String get displayName => _displayName;
  set displayName(String displayName) => _displayName = displayName;

  String get preferTimeWorkout => _preferTimeWorkout;
  set preferTimeWorkout(String preferTimeWorkout) =>
      _preferTimeWorkout = preferTimeWorkout;

  String get gymMemberShip => _gymMemberShip;
  set gymMemberShip(String gymMemberShip) => _gymMemberShip = gymMemberShip;

  List<String> get pictures => _pictures;
  set pictures(List<String> pictures) => _pictures = pictures;

  List<String> get workoutTypes => _workoutTypes;
  set workoutTypes(List<String> workoutTypes) => _workoutTypes = workoutTypes;

  String get id => _id;
  set id(String id) => _id = id;

  Buddy.fromJson(Map<String, dynamic> json) {
    _gender = json['gender'];
    _displayName = json['displayName'];
    _preferTimeWorkout = json['preferTimeWorkout'];
    _gymMemberShip = json['gymMemberShip'];
    _pictures = json['pictures'].cast<String>();
    _workoutTypes = json['workoutTypes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this._gender;
    data['displayName'] = this._displayName;
    data['preferTimeWorkout'] = this._preferTimeWorkout;
    data['gymMemberShip'] = this._gymMemberShip;
    data['pictures'] = this._pictures;
    data['workoutTypes'] = this._workoutTypes;
    return data;
  }
}