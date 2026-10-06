// ============================================================
// edit_profile_screen.dart - Stitch Profile & Partner Preferences Setup
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/dummy_data.dart';

class EditProfileScreen extends StatefulWidget {
  final int initialTabIndex;

  const EditProfileScreen({super.key, this.initialTabIndex = 0});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Personal Profile Controllers
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _genderController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _jobTitleController;
  late TextEditingController _professionController;
  late TextEditingController _educationController;
  late TextEditingController _collegeController;
  late TextEditingController _familyTypeController;
  late TextEditingController _familyCityController;
  late TextEditingController _aboutController;

  // Partner Preference State Options
  RangeValues _agePref = const RangeValues(24, 29);
  String _maritalStatusPref = 'Never Married';
  String _educationPref = 'MS / Masters';
  String _professionPref = 'Private Company';
  String _incomePref = '₹20 Lakhs and above';
  String _religionPref = 'Hindu';
  bool _casteNoBar = true;
  String _manglikPref = 'Must be Non-Manglik';
  double _minGunasPref = 24.0;
  String _familyPref = 'Either / Flexible';
  String _dietPref = 'Vegetarian';
  bool _nonDrinker = true;
  bool _nonSmoker = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialTabIndex);

    // Initialize personal fields from loggedInUserData
    _nameController = TextEditingController(text: loggedInUserData.name);
    _ageController = TextEditingController(text: loggedInUserData.age);
    _genderController = TextEditingController(text: loggedInUserData.gender);
    _cityController = TextEditingController(text: loggedInUserData.city);
    _stateController = TextEditingController(text: loggedInUserData.state);
    _jobTitleController = TextEditingController(text: loggedInUserData.jobTitle);
    _professionController = TextEditingController(text: loggedInUserData.profession);
    _educationController = TextEditingController(text: loggedInUserData.educationLevel);
    _collegeController = TextEditingController(text: loggedInUserData.college);
    _familyTypeController = TextEditingController(text: loggedInUserData.familyType);
    _familyCityController = TextEditingController(text: loggedInUserData.familyCity);
    _aboutController = TextEditingController(text: loggedInUserData.about);

    // Initialize preferences if available
    final minAge = double.tryParse(loggedInUserData.preferredMinAge) ?? 24;
    final maxAge = double.tryParse(loggedInUserData.preferredMaxAge) ?? 29;
    _agePref = RangeValues(minAge.clamp(21, 40), maxAge.clamp(21, 40));
    if (loggedInUserData.preferredEducation != 'Any' && loggedInUserData.preferredEducation.isNotEmpty) {
      _educationPref = loggedInUserData.preferredEducation;
    }
    if (loggedInUserData.preferredProfession != 'Any' && loggedInUserData.preferredProfession.isNotEmpty) {
      _professionPref = loggedInUserData.preferredProfession;
    }
    if (loggedInUserData.preferredFamilyType != 'Any' && loggedInUserData.preferredFamilyType.isNotEmpty) {
      _familyPref = loggedInUserData.preferredFamilyType;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _jobTitleController.dispose();
    _professionController.dispose();
    _educationController.dispose();
    _collegeController.dispose();
    _familyTypeController.dispose();
    _familyCityController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  void _savePersonalProfile() {
    setState(() {
      loggedInUserData.name = _nameController.text.trim();
      loggedInUserData.age = _ageController.text.trim();
      loggedInUserData.gender = _genderController.text.trim();
      loggedInUserData.city = _cityController.text.trim();
      loggedInUserData.state = _stateController.text.trim();
      loggedInUserData.jobTitle = _jobTitleController.text.trim();
      loggedInUserData.profession = _professionController.text.trim();
      loggedInUserData.educationLevel = _educationController.text.trim();
      loggedInUserData.college = _collegeController.text.trim();
      loggedInUserData.familyType = _familyTypeController.text.trim();
      loggedInUserData.familyCity = _familyCityController.text.trim();
      loggedInUserData.about = _aboutController.text.trim();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(
              'Profile details updated successfully!',
              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: AppColors.trustEmerald,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    Navigator.pop(context);
  }

  void _savePreferences() {
    setState(() {
      loggedInUserData.preferredMinAge = _agePref.start.round().toString();
      loggedInUserData.preferredMaxAge = _agePref.end.round().toString();
      loggedInUserData.preferredEducation = _educationPref;
      loggedInUserData.preferredProfession = _professionPref;
      loggedInUserData.preferredFamilyType = _familyPref;
      loggedInUserData.isHoroscopeVerified = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(
              '✨ Partner Preferences Saved! Updated matches are ready.',
              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Profile & Preferences',
          style: GoogleFonts.playfairDisplay(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          labelStyle: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w700),
          unselectedLabelStyle: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w500),
          tabs: const [
            Tab(
              icon: Icon(Icons.person_outline_rounded, size: 18),
              text: 'Personal Details & Bio',
            ),
            Tab(
              icon: Icon(Icons.tune_rounded, size: 18),
              text: 'Partner Preferences',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPersonalDetailsTab(),
          _buildPartnerPreferencesTab(),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // TAB 1: Personal Details & Bio
  // ------------------------------------------------------------
  Widget _buildPersonalDetailsTab() {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Info Card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFBFDBFE)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline_rounded, color: Color(0xFF2563EB), size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Keep your profile updated with your latest career, education, and lifestyle details for best compatibility.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: const Color(0xFF1E40AF),
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Section 1: Basic Information
            _buildSectionCard(
              title: 'Basic Information',
              icon: Icons.person_rounded,
              child: Column(
                children: [
                  _buildTextField(label: 'Full Name', controller: _nameController, icon: Icons.badge_outlined),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          label: 'Age',
                          controller: _ageController,
                          icon: Icons.cake_outlined,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextField(
                          label: 'Gender',
                          controller: _genderController,
                          icon: Icons.wc_outlined,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(label: 'City', controller: _cityController, icon: Icons.location_city_rounded),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextField(label: 'State', controller: _stateController, icon: Icons.map_outlined),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Section 2: Career & Education
            _buildSectionCard(
              title: 'Career & Education',
              icon: Icons.work_outline_rounded,
              child: Column(
                children: [
                  _buildTextField(
                    label: 'Job Title / Occupation',
                    controller: _jobTitleController,
                    icon: Icons.work_outline,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    label: 'Industry / Profession',
                    controller: _professionController,
                    icon: Icons.business_outlined,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    label: 'Education Degree',
                    controller: _educationController,
                    icon: Icons.school_outlined,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    label: 'College / University',
                    controller: _collegeController,
                    icon: Icons.account_balance_outlined,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Section 3: Family Details
            _buildSectionCard(
              title: 'Family Details',
              icon: Icons.family_restroom_rounded,
              child: Column(
                children: [
                  _buildTextField(
                    label: 'Family Type (e.g. Nuclear, Joint)',
                    controller: _familyTypeController,
                    icon: Icons.people_outline_rounded,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    label: 'Family Location / Native Place',
                    controller: _familyCityController,
                    icon: Icons.home_work_outlined,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Section 4: About Me Bio
            _buildSectionCard(
              title: 'About Me & Lifestyle',
              icon: Icons.format_quote_rounded,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Express your personality, interests, and what you are looking for:',
                    style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _aboutController,
                    maxLines: 4,
                    style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.textPrimary, height: 1.4),
                    decoration: InputDecoration(
                      hintText: 'Write a few lines about yourself...',
                      hintStyle: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.textMuted),
                      filled: true,
                      fillColor: AppColors.background,
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.outline),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.outline),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  side: const BorderSide(color: AppColors.outline),
                ),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _savePersonalProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 3,
                    shadowColor: AppColors.primary.withValues(alpha: 0.4),
                  ),
                  child: Text(
                    'Save Profile Details',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // TAB 2: Partner Preferences
  // ------------------------------------------------------------
  Widget _buildPartnerPreferencesTab() {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Live Dynamic Match Estimator Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFFBEB), Color(0xFFFEF3C7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.secondary.withValues(alpha: 0.3)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.auto_awesome_rounded, color: AppColors.secondary, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '✨ 380+ Compatible Verified Matches found based on your preferences!',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF78350F),
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Form Section 1: Basic & Physical Criteria
            _buildSectionCard(
              title: 'Basic & Physical Criteria',
              icon: Icons.favorite_border_rounded,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Preferred Age Range', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                      Text(
                        '${_agePref.start.round()} - ${_agePref.end.round()} yrs',
                        style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary),
                      ),
                    ],
                  ),
                  RangeSlider(
                    values: _agePref,
                    min: 21,
                    max: 40,
                    divisions: 19,
                    activeColor: AppColors.primary,
                    inactiveColor: AppColors.outline,
                    onChanged: (values) => setState(() => _agePref = values),
                  ),
                  const SizedBox(height: 10),
                  Text('Marital Status', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: ['Never Married', 'Divorced', 'Widowed', 'Awaiting Divorce'].map((status) {
                      return _buildChoiceChip(
                        status,
                        _maritalStatusPref == status,
                        () => setState(() => _maritalStatusPref = status),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Form Section 2: Education & Professional Background
            _buildSectionCard(
              title: 'Education & Professional Background',
              icon: Icons.school_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Education Qualification', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ['B.Tech / B.E.', 'MS / Masters', 'MBA', 'MBBS / MD', 'CA'].map((edu) {
                      return _buildChoiceChip(
                        edu,
                        _educationPref == edu,
                        () => setState(() => _educationPref = edu),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 14),
                  Text('Working Sector', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: ['Private Company', 'Govt / Civil Services', 'Business / Entrepreneur'].map((sec) {
                      return _buildChoiceChip(
                        sec,
                        _professionPref == sec,
                        () => setState(() => _professionPref = sec),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 14),
                  Text('Annual Income Preference', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: ['₹15 Lakhs+', '₹20 Lakhs and above', '₹35 Lakhs+', '₹50 Lakhs+'].map((inc) {
                      return _buildChoiceChip(
                        inc,
                        _incomePref == inc,
                        () => setState(() => _incomePref = inc),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Form Section 3: Sacred Heritage & Astrology (Vedic Milan)
            _buildSectionCard(
              title: 'Sacred Heritage & Astrology',
              icon: Icons.auto_awesome_rounded,
              isSacred: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Religion', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: ['Hindu', 'Jain', 'Sikh', 'Open to All'].map((rel) {
                      return _buildChoiceChip(
                        rel,
                        _religionPref == rel,
                        () => setState(() => _religionPref = rel),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    activeTrackColor: AppColors.primary,
                    title: Text('Caste No Bar', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w700)),
                    subtitle: Text('Show profiles irrespective of sub-caste',
                        style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textSecondary)),
                    value: _casteNoBar,
                    onChanged: (val) => setState(() => _casteNoBar = val),
                  ),
                  const Divider(height: 16, color: AppColors.outline),
                  Text('Manglik Status', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: ['Must be Non-Manglik', 'Manglik Only', 'Doesn\'t Matter'].map((m) {
                      return _buildChoiceChip(
                        m,
                        _manglikPref == m,
                        () => setState(() => _manglikPref = m),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Minimum Gunas for Vedic Match', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                      Text(
                        '${_minGunasPref.round()} / 36',
                        style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.secondary),
                      ),
                    ],
                  ),
                  Slider(
                    value: _minGunasPref,
                    min: 18,
                    max: 36,
                    divisions: 18,
                    activeColor: AppColors.secondary,
                    inactiveColor: AppColors.outline,
                    onChanged: (val) => setState(() => _minGunasPref = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Form Section 4: Lifestyle, Diet & Values
            _buildSectionCard(
              title: 'Lifestyle, Diet & Values',
              icon: Icons.restaurant_rounded,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dietary Habits', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: ['Vegetarian', 'Eggetarian', 'Non-Vegetarian', 'Jain Diet'].map((diet) {
                      return _buildChoiceChip(
                        diet,
                        _dietPref == diet,
                        () => setState(() => _dietPref = diet),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  Text('Family Living Preference', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: ['Nuclear Family', 'Joint Family', 'Either / Flexible'].map((f) {
                      return _buildChoiceChip(
                        f,
                        _familyPref == f,
                        () => setState(() => _familyPref = f),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: FilterChip(
                          label: Text('Non-Smoker', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w600)),
                          selected: _nonSmoker,
                          selectedColor: AppColors.primaryContainer,
                          checkmarkColor: AppColors.primary,
                          onSelected: (val) => setState(() => _nonSmoker = val),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: FilterChip(
                          label: Text('Non-Drinker', style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w600)),
                          selected: _nonDrinker,
                          selectedColor: AppColors.primaryContainer,
                          checkmarkColor: AppColors.primary,
                          onSelected: (val) => setState(() => _nonDrinker = val),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  side: const BorderSide(color: AppColors.outline),
                ),
                child: const Text('Back'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _savePreferences,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 3,
                    shadowColor: AppColors.primary.withValues(alpha: 0.4),
                  ),
                  child: Text(
                    'Save & Find My Matches →',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textSecondary),
        prefixIcon: Icon(icon, size: 18, color: AppColors.primary),
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
    bool isSacred = false,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSacred ? AppColors.secondary.withValues(alpha: 0.35) : AppColors.outline,
            width: isSacred ? 1.3 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: isSacred ? AppColors.secondary : AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.playfairDisplay(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceChip(String label, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryContainer : AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.outline,
            width: isSelected ? 1.4 : 1,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
