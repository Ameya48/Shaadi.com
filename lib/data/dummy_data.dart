// ============================================================
// dummy_data.dart - Rich Matrimony Data with Horoscope & Badges
// ============================================================

import '../models/profile_model.dart';
import '../models/user_profile_data.dart';
import '../models/interest_model.dart';
import 'user_avatar_base64.dart';

// ---- Dummy Logged-In User Profile ----
final ProfileModel currentUser = ProfileModel(
  id: 'user_001',
  name: 'Rahul Sharma',
  age: 28,
  gender: 'Male',
  religion: 'Hindu',
  caste: 'Brahmin',
  gotra: 'Vashishta',
  city: 'Mumbai',
  state: 'Maharashtra',
  education: 'B.Tech + MBA',
  college: 'IIT Bombay • IIM Ahmedabad',
  occupation: 'Lead Product Manager',
  company: 'Microsoft',
  income: '₹35 - 45 LPA',
  height: '5\'11" (180 cm)',
  maritalStatus: 'Never Married',
  diet: 'Vegetarian',
  about:
      'Product builder with a passion for emerging tech, weekend cycling, and classical acoustic music. Looking for an ambitious, intellectually curious partner who values deep family bonds.',
  imagePath: userProfileAvatarBase64,
  galleryImages: [
    userProfileAvatarBase64,
  ],
  compatibility: 0.88,
  interests: ['✈️ World Travel', '☕ Specialty Coffee', '🚴 Cycling', '📚 Philosophy', '🎵 Indie & Indian Classical'],
  personalityTraits: ['Thoughtful', 'Ambitious', 'Family-first'],
  isVerified: true,
  isIdVerified: true,
  isPhotoVerified: true,
  isPhoneVerified: true,
  isHoroscopeVerified: true,
  isPremium: true,
  isGold: true,
  zodiacSign: 'Libra',
  horoscope: const HoroscopeDetail(
    totalGunas: 32,
    rashi: 'Tula (Libra)',
    nakshatra: 'Chitra',
    charan: 3,
    manglikStatus: 'Non-Manglik',
  ),
);

// ---- Featured Candidates List ----
final List<ProfileModel> dummyProfiles = [
  // Profile 1: Priyanka Sharma (Lead Candidate)
  ProfileModel(
    id: 'p001',
    name: 'Priyanka Sharma',
    age: 26,
    gender: 'Female',
    familyType: 'Nuclear',
    religion: 'Hindu',
    caste: 'Brahmin',
    gotra: 'Garg',
    city: 'Mumbai',
    state: 'Maharashtra',
    education: 'MS Design & Tech',
    college: 'NID Ahmedabad',
    occupation: 'Senior Product Designer',
    company: 'Google',
    income: '₹38 Lakhs/year',
    height: '5\'6" (168 cm)',
    maritalStatus: 'Never Married',
    diet: 'Vegetarian',
    about:
        'Designing playful digital experiences by day, classical Kathak dancer by passion. Looking for an ambitious partner who enjoys sunrise treks, lively family get-togethers, and artisanal filter coffee.',
    imagePath: 'https://wsrv.nl/?url=https://i.pinimg.com/736x/00/ef/6a/00ef6acc468af278589080b331b535a9.jpg',
    galleryImages: [
      'https://wsrv.nl/?url=https://i.pinimg.com/736x/00/ef/6a/00ef6acc468af278589080b331b535a9.jpg',
      'https://wsrv.nl/?url=https://i.pinimg.com/736x/02/04/a9/0204a9e5344c7ca453c3f266c8913258.jpg',
    ],
    compatibility: 0.89,
    interests: ['🎵 Classical Music', '✈️ World Travel', '☕ Specialty Coffee', '🌿 Trekking', '🏸 Badminton'],
    personalityTraits: ['Ambitious', 'Family-oriented', 'Creative', 'Spiritually Inclined'],
    isVerified: true,
    isIdVerified: true,
    isPhotoVerified: true,
    isPhoneVerified: true,
    isHoroscopeVerified: true,
    isPremium: true,
    isGold: true,
    isDiamond: false,
    isBoosted: true,
    zodiacSign: 'Sagittarius',
    horoscope: const HoroscopeDetail(
      totalGunas: 32,
      rashi: 'Dhanu (Sagittarius)',
      nakshatra: 'Purva Ashadha',
      charan: 2,
      manglikStatus: 'Non-Manglik',
      gunaVerdict: 'Highly Auspicious (89% Match)',
    ),
    family: const FamilyDetail(
      fatherOccupation: 'Retired Bank Manager (SBI)',
      motherOccupation: 'Homemaker',
      siblings: '1 Younger Brother (Software Engineer at Microsoft)',
      familyValues: 'Moderate',
      familyType: 'Nuclear',
      familyLocation: 'Bandra West, Mumbai',
    ),
    preferences: const PartnerPreference(
      ageRange: '26 - 31 yrs',
      heightRange: '5\'8" or taller',
      education: 'Masters / Tech / Business Degree',
      profession: 'Software / Product / Finance / Civil Services',
      diet: 'Vegetarian / Flexible',
      location: 'Mumbai / Bangalore / Pune',
      matchedCount: 8,
      totalCount: 9,
    ),
    lastSeen: 'Active 10m ago',
    phone: '+91 98•••• ••21',
    email: 'priyanka.s••••@gmail.com',
  ),

  // Profile 2: Ananya Deshmukh
  ProfileModel(
    id: 'p002',
    name: 'Ananya Deshmukh',
    age: 25,
    gender: 'Female',
    familyType: 'Nuclear',
    religion: 'Hindu',
    caste: 'Maratha',
    gotra: 'Kashyap',
    city: 'Bangalore',
    state: 'Karnataka',
    education: 'B.Tech + M.Tech CS',
    college: 'IIIT Hyderabad',
    occupation: 'AI Research Engineer',
    company: 'Microsoft',
    income: '₹42 Lakhs/year',
    height: '5\'5" (165 cm)',
    maritalStatus: 'Never Married',
    diet: 'Eggetarian',
    about:
        'Building autonomous AI models, passionate violinist, and avid book collector. Looking for a partner with intellectual curiosity and a strong moral compass.',
    imagePath: 'https://wsrv.nl/?url=https://i.pinimg.com/736x/4a/87/60/4a8760ae79db5857b3b024ac40e34507.jpg',
    galleryImages: [
      'https://wsrv.nl/?url=https://i.pinimg.com/736x/4a/87/60/4a8760ae79db5857b3b024ac40e34507.jpg',
      'https://wsrv.nl/?url=https://i.pinimg.com/1200x/44/56/77/445677818d2563c330003e169c8ade77.jpg',
    ],
    compatibility: 0.91,
    interests: ['🎻 Violin', '🤖 AI & Tech', '📚 Literature', '🏔️ High Altitude Trekking'],
    personalityTraits: ['Curious', 'Warm', 'Independent'],
    isVerified: true,
    isIdVerified: true,
    isPhotoVerified: true,
    isPhoneVerified: true,
    isHoroscopeVerified: true,
    isPremium: true,
    isGold: true,
    isDiamond: true,
    zodiacSign: 'Scorpio',
    horoscope: const HoroscopeDetail(
      totalGunas: 31,
      rashi: 'Vrischika (Scorpio)',
      nakshatra: 'Anuradha',
      charan: 1,
      manglikStatus: 'Non-Manglik',
      gunaVerdict: 'Very Good (86% Match)',
    ),
    lastSeen: 'Active now',
  ),

  // Profile 3: Sneha Patel
  ProfileModel(
    id: 'p003',
    name: 'Dr. Sneha Patel',
    age: 26,
    gender: 'Female',
    familyType: 'Joint',
    religion: 'Hindu',
    caste: 'Patel / Leva',
    gotra: 'Shandilya',
    city: 'Pune',
    state: 'Maharashtra',
    education: 'MD Pediatrics',
    college: 'BJ Medical College, Pune',
    occupation: 'Pediatric Consultant',
    company: 'Sahyadri Hospitals',
    income: '₹28 Lakhs/year',
    height: '5\'4" (163 cm)',
    maritalStatus: 'Never Married',
    diet: 'Vegetarian',
    about:
        'Pediatrician dedicated to children\'s wellness. Passionate about classical sitar, organic gardening, and weekend baking with family.',
    imagePath: 'https://wsrv.nl/?url=https://i.pinimg.com/1200x/3e/0c/ac/3e0cac7f4e46eae47debb501ae947de3.jpg',
    galleryImages: [
      'https://wsrv.nl/?url=https://i.pinimg.com/1200x/3e/0c/ac/3e0cac7f4e46eae47debb501ae947de3.jpg',
      'https://wsrv.nl/?url=https://i.pinimg.com/1200x/b4/0a/d1/b40ad1eac1767c790af5dff8f44789b4.jpg',
    ],
    compatibility: 0.94,
    interests: ['🩺 Healthcare', '🌱 Gardening', '🍰 Baking', '🎶 Sitar'],
    personalityTraits: ['Empathetic', 'Traditional Roots', 'Caring'],
    isVerified: true,
    isIdVerified: true,
    isPhotoVerified: true,
    isPhoneVerified: true,
    isHoroscopeVerified: true,
    isPremium: true,
    isGold: false,
    isDiamond: false,
    zodiacSign: 'Cancer',
    horoscope: const HoroscopeDetail(
      totalGunas: 34,
      rashi: 'Karka (Cancer)',
      nakshatra: 'Pushya',
      charan: 4,
      manglikStatus: 'Non-Manglik',
      gunaVerdict: 'Superb Auspicious Match (94%)',
    ),
    lastSeen: 'Active 2h ago',
  ),

  // Profile 4: Kavya Nair
  ProfileModel(
    id: 'p004',
    name: 'Kavya Nair',
    age: 27,
    gender: 'Female',
    familyType: 'Nuclear',
    religion: 'Hindu',
    caste: 'Nair',
    gotra: 'Bharadwaja',
    city: 'Kochi / Mumbai',
    state: 'Kerala',
    education: 'MBA Marketing',
    college: 'ISB Hyderabad',
    occupation: 'VP Brand Strategy',
    company: 'Unilever',
    income: '₹45 Lakhs/year',
    height: '5\'7" (170 cm)',
    maritalStatus: 'Never Married',
    diet: 'Flexible',
    about:
        'Brand builder, scuba diver, and documentary enthusiast. Looking for a progressive partner who celebrates personal independence and teamwork.',
    imagePath: 'https://wsrv.nl/?url=https://i.pinimg.com/736x/58/a1/aa/58a1aaa70c08169d8cb9a770b6b56048.jpg',
    galleryImages: [
      'https://wsrv.nl/?url=https://i.pinimg.com/736x/58/a1/aa/58a1aaa70c08169d8cb9a770b6b56048.jpg',
      'https://wsrv.nl/?url=https://i.pinimg.com/736x/c7/c2/81/c7c28198c29b078dc03a0c26072159d0.jpg',
    ],
    compatibility: 0.84,
    interests: ['🌊 Scuba Diving', '🎬 Cinema', '🧘 Yoga', '🍷 Food & Wine'],
    personalityTraits: ['Bold', 'Expressive', 'Adventurous'],
    isVerified: true,
    isIdVerified: true,
    isPhotoVerified: true,
    isPhoneVerified: true,
    isHoroscopeVerified: false,
    isPremium: true,
    isGold: true,
    isDiamond: true,
    zodiacSign: 'Aquarius',
    horoscope: const HoroscopeDetail(
      totalGunas: 28,
      rashi: 'Kumbha (Aquarius)',
      nakshatra: 'Shatabhisha',
      charan: 2,
      manglikStatus: 'Non-Manglik',
      gunaVerdict: 'Good Match (78%)',
    ),
    lastSeen: 'Active 1d ago',
  ),

  // Profile 5: Riya Singh
  ProfileModel(
    id: 'p005',
    name: 'Riya Singh',
    age: 25,
    gender: 'Female',
    familyType: 'Joint',
    religion: 'Sikh',
    caste: 'Jat Sikh',
    gotra: 'Dhillon',
    city: 'Delhi NCR',
    state: 'Delhi',
    education: 'BA LLB (Hons)',
    college: 'NALSAR Hyderabad',
    occupation: 'Corporate Lawyer',
    company: 'Shardul Amarchand',
    income: '₹32 Lakhs/year',
    height: '5\'5" (165 cm)',
    maritalStatus: 'Never Married',
    diet: 'Vegetarian',
    about:
        'Advocate passionate about constitutional rights, Punjabi poetry, and gourmet food expeditions.',
    imagePath: 'https://wsrv.nl/?url=https://i.pinimg.com/736x/b8/ae/d5/b8aed588f75fc5034f5cdd57b0ca6d7b.jpg',
    galleryImages: [
      'https://wsrv.nl/?url=https://i.pinimg.com/736x/b8/ae/d5/b8aed588f75fc5034f5cdd57b0ca6d7b.jpg',
      'https://wsrv.nl/?url=https://i.pinimg.com/736x/57/67/6e/57676e6f12f5abf6015f0ed7c2a372f2.jpg',
    ],
    compatibility: 0.76,
    interests: ['⚖️ Law', '🍛 Food Walks', '✈️ Road Trips', '🎶 Sufi Music'],
    personalityTraits: ['Articulate', 'Spirited', 'Kind'],
    isVerified: true,
    isIdVerified: true,
    isPhotoVerified: true,
    isPhoneVerified: true,
    isHoroscopeVerified: false,
    isPremium: false,
    zodiacSign: 'Aries',
    horoscope: const HoroscopeDetail(
      totalGunas: 26,
      rashi: 'Mesha (Aries)',
      nakshatra: 'Ashwini',
      charan: 3,
      manglikStatus: 'Non-Manglik',
      gunaVerdict: 'Moderate Match (72%)',
    ),
    lastSeen: 'Active 3h ago',
  ),
];

// ---- Invitations Received & Sent Lists ----
final List<InterestModel> receivedInterestsList = [
  InterestModel(
    profile: dummyProfiles[1], // Ananya Deshmukh
    status: 'Pending',
    date: '5 hours ago',
    message: 'Hi Rahul, we have mutual interests in tech and classical music. Let\'s connect!',
    isHighKundaliMatch: true,
  ),
  InterestModel(
    profile: dummyProfiles[3], // Kavya Nair
    status: 'Accepted',
    date: '3 days ago',
    message: 'Glad we connected! Excited to get to know you.',
    isHighKundaliMatch: false,
  ),
];

final List<InterestModel> sentInterestsList = [
  InterestModel(
    profile: dummyProfiles[3],
    status: 'Accepted',
    date: '3 days ago',
  ),
];

final List<ProfileModel> shortlistedProfilesList = [
  dummyProfiles[0],
  dummyProfiles[1],
  dummyProfiles[2],
  dummyProfiles[3],
];

// Helper to check connection status
bool isConnectedWithProfile(ProfileModel profile) {
  final inReceived = receivedInterestsList.any(
    (item) => item.profile.id == profile.id && item.status == 'Accepted',
  );
  final inSent = sentInterestsList.any(
    (item) => item.profile.id == profile.id && item.status == 'Accepted',
  );
  return inReceived || inSent;
}

String getConnectionStatus(ProfileModel profile) {
  if (isConnectedWithProfile(profile)) return 'Accepted';
  final inReceivedPending = receivedInterestsList.any(
    (item) => item.profile.id == profile.id && item.status == 'Pending',
  );
  final inSentPending = sentInterestsList.any(
    (item) => item.profile.id == profile.id && item.status == 'Pending',
  );
  if (inReceivedPending || inSentPending) return 'Pending';
  return 'None';
}

void connectWithProfile(ProfileModel profile) {
  bool updated = false;
  for (var item in receivedInterestsList) {
    if (item.profile.id == profile.id) {
      item.status = 'Accepted';
      updated = true;
    }
  }
  for (var item in sentInterestsList) {
    if (item.profile.id == profile.id) {
      item.status = 'Accepted';
      updated = true;
    }
  }
  if (!updated) {
    sentInterestsList.insert(
      0,
      InterestModel(
        profile: profile,
        status: 'Accepted',
        date: 'Just now',
      ),
    );
  }

  // Ensure conversation thread exists
  final convIndex = dummyConversations.indexWhere((c) => c.profile.id == profile.id);
  if (convIndex < 0) {
    dummyConversations.insert(
      0,
      ChatConversation(
        profile: profile,
        lastMessage: '🎉 Connected! Say hello and start your conversation.',
        time: 'Just now',
        unreadCount: 0,
        isOnline: true,
        messages: [
          ChatMessageItem(
            text: 'You and ${profile.name} are now mutually connected! 🌟 Feel free to introduce yourself and discuss compatibility.',
            isUser: false,
            time: 'Just now',
            isAstrologyBadge: true,
            badgeText: 'Mutually Connected 🤝',
          ),
        ],
      ),
    );
  }
}

// Helper to send interest (in frontend walkthrough demo, connecting immediately unlocks chat!)
void sendInterestToProfile(ProfileModel profile) {
  connectWithProfile(profile);
}

// ---- Dummy Conversations ----
class ChatMessageItem {
  final String text;
  final bool isUser;
  final String time;
  final bool isAstrologyBadge;
  final String? badgeText;

  ChatMessageItem({
    required this.text,
    required this.isUser,
    required this.time,
    this.isAstrologyBadge = false,
    this.badgeText,
  });
}

class ChatConversation {
  final ProfileModel profile;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;
  final List<ChatMessageItem> messages;

  ChatConversation({
    required this.profile,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.isOnline,
    required this.messages,
  });
}

final List<ChatConversation> dummyConversations = [
  ChatConversation(
    profile: dummyProfiles[0], // Priyanka Sharma
    lastMessage: 'Yes! I usually trek in Lonavala during monsoons.',
    time: '10:21 AM',
    unreadCount: 2,
    isOnline: true,
    messages: [
      ChatMessageItem(
        text: 'Namaste! Thank you for accepting my interest. I saw that our families both value traditional roots with a modern outlook.',
        isUser: false,
        time: '10:15 AM',
      ),
      ChatMessageItem(
        text: 'Hi Priyanka! Yes, absolutely! I also noticed you love trekking and artisanal filter coffee. Have you visited the Sahyadris recently?',
        isUser: true,
        time: '10:18 AM',
      ),
      ChatMessageItem(
        text: 'We matched 5/5 in Graha Maitri (Mental Harmony)! 🌟 I usually trek in Lonavala during monsoons. Designing by day, mountains by weekend! How about your family?',
        isUser: false,
        time: '10:21 AM',
        isAstrologyBadge: true,
        badgeText: 'Graha Maitri: 5/5 Mental Harmony 🌟',
      ),
    ],
  ),
  ChatConversation(
    profile: dummyProfiles[1], // Ananya Deshmukh
    lastMessage: 'Sure, let\'s schedule a 10-min intro call this weekend.',
    time: 'Yesterday',
    unreadCount: 0,
    isOnline: true,
    messages: [
      ChatMessageItem(
        text: 'Hello Rahul! Loved your work in AI and product.',
        isUser: false,
        time: 'Yesterday 4:00 PM',
      ),
      ChatMessageItem(
        text: 'Thanks Ananya! Would love to chat about your research as well.',
        isUser: true,
        time: 'Yesterday 4:15 PM',
      ),
    ],
  ),
  ChatConversation(
    profile: dummyProfiles[2], // Sneha Patel
    lastMessage: 'I shared your Kundali with my parents, they are very happy!',
    time: '2 days ago',
    unreadCount: 0,
    isOnline: false,
    messages: [
      ChatMessageItem(
        text: 'I shared your Kundali with my parents, they are very happy!',
        isUser: false,
        time: '2 days ago',
      ),
    ],
  ),
  ChatConversation(
    profile: dummyProfiles[3], // Kavya Nair
    lastMessage: 'Let\'s connect over a virtual coffee call this Sunday!',
    time: '3 days ago',
    unreadCount: 1,
    isOnline: true,
    messages: [
      ChatMessageItem(
        text: 'Hello Rahul! Loved your passion for product strategy and travel.',
        isUser: false,
        time: '3 days ago',
      ),
      ChatMessageItem(
        text: 'Let\'s connect over a virtual coffee call this Sunday!',
        isUser: false,
        time: '3 days ago',
      ),
    ],
  ),
  ChatConversation(
    profile: dummyProfiles[4], // Riya Singh
    lastMessage: 'Namaste! Looking forward to discussing compatibility.',
    time: '4 days ago',
    unreadCount: 0,
    isOnline: false,
    messages: [
      ChatMessageItem(
        text: 'Namaste! Looking forward to discussing compatibility.',
        isUser: false,
        time: '4 days ago',
      ),
    ],
  ),
];

// Global mutable user state
UserProfileData loggedInUserData = UserProfileData();
