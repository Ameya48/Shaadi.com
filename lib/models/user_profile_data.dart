// ============================================================
// UserProfileData Model
// This is a MUTABLE class (no 'final' fields) that holds all
// the editable information about the logged-in user.
//
// We use a regular class (not final) so that we can UPDATE
// the fields when the user saves the Edit Profile form.
//
// Think of this as the "form data" for our profile.
// ============================================================

class UserProfileData {
  // ---- Personal Information ----
  String name;
  String age;        // stored as String so TextField is easy
  String gender;     // 'Male', 'Female', 'Other'
  String city;       // location
  String state;
  String about;

  // ---- Education ----
  String educationLevel;   // e.g. 'B.Tech', 'MBA'
  String college;          // college/university name

  // ---- Profession ----
  String profession;   // broad field e.g. 'Engineering'
  String jobTitle;     // specific title e.g. 'Software Engineer'

  // ---- Family Background ----
  String familyType;   // 'Nuclear', 'Joint'
  String familyValues; // 'Traditional', 'Moderate', 'Liberal'
  String familyCity;   // where family is located

  // ---- Partner Preferences ----
  String preferredMinAge;   // minimum age they want
  String preferredMaxAge;   // maximum age they want
  String preferredCity;     // preferred city of partner
  String preferredEducation;
  String preferredProfession;
  String preferredFamilyType;

  // ---- Verification & Completeness & Privacy Flags ----
  bool isIdVerified;
  bool isPhotoVerified;
  bool isPhoneVerified;
  bool isHoroscopeVerified;
  bool hasPhoto;
  bool blurProfilePhoto;
  bool hideContactInfo;
  bool hideLastSeen;

  // ---- Membership Plan Flags ----
  // These booleans track which paid plan the user has activated.
  // In a real app, this would come from a server. Here we just toggle them.
  bool isGold;       // true when Gold plan is active
  bool isDiamond;    // true when Diamond plan is active
  bool isBoosted;    // true when Profile Boost is active

  // Constructor with default/initial values
  UserProfileData({
    this.name = 'Rahul Sharma',
    this.age = '28',
    this.gender = 'Male',
    this.city = 'Mumbai',
    this.state = 'Maharashtra',
    this.about =
        'Product builder with a passion for emerging tech, weekend cycling, and classical acoustic music. Looking for an ambitious, intellectually curious partner who values deep family bonds.',
    this.educationLevel = 'B.Tech + MBA',
    this.college = 'IIT Bombay • IIM Ahmedabad',
    this.profession = 'Engineering',
    this.jobTitle = 'Lead Product Manager',
    this.familyType = 'Nuclear',
    this.familyValues = 'Moderate',
    this.familyCity = 'Mumbai',
    this.preferredMinAge = '24',
    this.preferredMaxAge = '29',
    this.preferredCity = 'Mumbai, Pune, Bangalore',
    this.preferredEducation = 'MS / Masters',
    this.preferredProfession = 'Private Company',
    this.preferredFamilyType = 'Flexible',
    this.isIdVerified = true,
    this.isPhotoVerified = true,
    this.isPhoneVerified = true,
    this.isHoroscopeVerified = true,
    this.hasPhoto = true,
    this.blurProfilePhoto = false,
    this.hideContactInfo = false,
    this.hideLastSeen = false,
    // Membership defaults: Gold plan active
    this.isGold = true,
    this.isDiamond = false,
    this.isBoosted = false,
  });

  // Calculate profile completeness percentage (returns 0.0 to 1.0)
  double get completenessPercentage {
    int totalSections = 6;
    int completedSections = 0;

    // Section 1: Basic Info
    if (name.isNotEmpty && age.isNotEmpty && city.isNotEmpty && about.isNotEmpty) {
      completedSections++;
    }
    // Section 2: Education
    if (educationLevel.isNotEmpty && college.isNotEmpty) {
      completedSections++;
    }
    // Section 3: Profession
    if (profession.isNotEmpty && jobTitle.isNotEmpty) {
      completedSections++;
    }
    // Section 4: Family Details
    if (familyType.isNotEmpty && familyCity.isNotEmpty) {
      completedSections++;
    }
    // Section 5: Partner Preferences
    if (preferredMinAge.isNotEmpty && preferredCity.isNotEmpty) {
      completedSections++;
    }
    // Section 6: Photo & Horoscope
    if (hasPhoto && isHoroscopeVerified) {
      completedSections++;
    } else if (hasPhoto || isHoroscopeVerified) {
      completedSections++;
    }

    return completedSections / totalSections;
  }

  // Get percentage as integer (e.g. 100)
  int get completenessInt => (completenessPercentage * 100).round();

  // Return simple improvement suggestions
  List<String> get completenessSuggestions {
    List<String> suggestions = [];

    if (!hasPhoto) {
      suggestions.add('Add your profile photo');
    }
    if (!isHoroscopeVerified) {
      suggestions.add('Add horoscope details & verify');
    }
    if (!isIdVerified) {
      suggestions.add('Verify Government ID card');
    }
    if (!isPhoneVerified) {
      suggestions.add('Verify phone number');
    }
    if (familyCity.isEmpty) {
      suggestions.add('Complete family details');
    }
    if (about.isEmpty) {
      suggestions.add('Write an about me bio');
    }

    if (suggestions.isEmpty || completenessInt >= 100) {
      return ['All profile sections & verifications completed ✨'];
    }

    return suggestions;
  }
}

