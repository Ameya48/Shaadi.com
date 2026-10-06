// ============================================================
// profile_model.dart - Rich Matrimony Profile & Kundali Model
// ============================================================

class HoroscopeDetail {
  final int totalGunas; // out of 36 (e.g. 32)
  final String rashi; // e.g. 'Dhanu (Sagittarius)'
  final String nakshatra; // e.g. 'Purva Ashadha'
  final int charan; // e.g. 2
  final String manglikStatus; // 'Non-Manglik', 'Manglik', 'Anshik Manglik'
  final Map<String, String> ashtakoota; // Varna: '1/1', Vashya: '2/2', etc.
  final String gunaVerdict; // 'Highly Auspicious (89%)'

  const HoroscopeDetail({
    this.totalGunas = 32,
    this.rashi = 'Dhanu (Sagittarius)',
    this.nakshatra = 'Purva Ashadha',
    this.charan = 2,
    this.manglikStatus = 'Non-Manglik',
    this.ashtakoota = const {
      'Varna (Work & Ego)': '1 / 1',
      'Vashya (Mutual Attraction)': '2 / 2',
      'Tara (Destiny & Health)': '3 / 3',
      'Yoni (Physical Compatibility)': '4 / 4',
      'Graha Maitri (Mental Harmony)': '5 / 5',
      'Gana (Temperament)': '5 / 6',
      'Bhakoot (Family Prosperity)': '7 / 7',
      'Nadi (Genetics & Health)': '8 / 8',
    },
    this.gunaVerdict = 'Highly Auspicious (89% Match)',
  });
}

class FamilyDetail {
  final String fatherOccupation;
  final String motherOccupation;
  final String siblings;
  final String familyValues; // 'Traditional', 'Moderate', 'Liberal'
  final String familyType; // 'Nuclear', 'Joint'
  final String familyLocation;

  const FamilyDetail({
    this.fatherOccupation = 'Retired Bank Manager (SBI)',
    this.motherOccupation = 'Homemaker',
    this.siblings = '1 Younger Brother (Software Engineer at Microsoft)',
    this.familyValues = 'Moderate',
    this.familyType = 'Nuclear',
    this.familyLocation = 'Mumbai, Maharashtra',
  });
}

class PartnerPreference {
  final String ageRange;
  final String heightRange;
  final String education;
  final String profession;
  final String diet;
  final String location;
  final int matchedCount;
  final int totalCount;

  const PartnerPreference({
    this.ageRange = '26 - 31 yrs',
    this.heightRange = '5\'8" or taller',
    this.education = 'Masters / Tech Degree',
    this.profession = 'Software / Product / Finance',
    this.diet = 'Vegetarian / Flexible',
    this.location = 'Mumbai / Bangalore',
    this.matchedCount = 8,
    this.totalCount = 9,
  });
}

class ProfileModel {
  final String id;
  final String name;
  final int age;
  final String gender; // 'Female', 'Male'
  final String familyType; // 'Nuclear', 'Joint'
  final String religion;
  final String caste;
  final String gotra;
  final String city;
  final String state;
  final String education;
  final String college;
  final String occupation;
  final String company;
  final String income;
  final String height;
  final String maritalStatus;
  final String diet;
  final String about;
  final String imagePath;
  final List<String> galleryImages;
  final double compatibility; // 0.0 to 1.0
  final List<String> interests;
  final List<String> personalityTraits;
  
  // Verification Badges
  final bool isVerified;
  final bool isIdVerified;
  final bool isPhotoVerified;
  final bool isPhoneVerified;
  final bool isHoroscopeVerified;

  // Membership & Status
  final bool isPremium;
  final bool isGold;
  final bool isDiamond;
  final bool isBoosted;

  // Horoscope & Astrology
  final String zodiacSign;
  final HoroscopeDetail horoscope;

  // Family & Preferences
  final FamilyDetail family;
  final PartnerPreference preferences;

  // Privacy & Status
  final String lastSeen;
  final String phone;
  final String email;
  final bool photosBlurred;

  ProfileModel({
    required this.id,
    required this.name,
    required this.age,
    this.gender = 'Female',
    this.familyType = 'Nuclear',
    required this.religion,
    required this.caste,
    this.gotra = 'Garg',
    required this.city,
    required this.state,
    required this.education,
    this.college = 'IIM Ahmedabad',
    required this.occupation,
    this.company = 'Google',
    required this.income,
    required this.height,
    required this.maritalStatus,
    this.diet = 'Vegetarian',
    required this.about,
    required this.imagePath,
    this.galleryImages = const [],
    required this.compatibility,
    required this.interests,
    this.personalityTraits = const ['Ambitious', 'Family-oriented', 'Spiritually inclined'],
    required this.isVerified,
    this.isIdVerified = true,
    this.isPhotoVerified = true,
    this.isPhoneVerified = true,
    this.isHoroscopeVerified = true,
    required this.isPremium,
    this.isGold = true,
    this.isDiamond = false,
    this.isBoosted = false,
    required this.zodiacSign,
    this.horoscope = const HoroscopeDetail(),
    this.family = const FamilyDetail(),
    this.preferences = const PartnerPreference(),
    this.lastSeen = 'Active 10m ago',
    this.phone = '+91 98•••• ••21',
    this.email = 'priyanka.s••••@gmail.com',
    this.photosBlurred = false,
  });
}
