// ============================================================
// search_screen.dart - Stitch Advanced Search & Multi-Filter Engine
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/profile_model.dart';
import '../data/dummy_data.dart';
import '../widgets/app_image.dart';
import 'profile_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Filter States
  RangeValues _ageRange = const RangeValues(24, 30);
  RangeValues _heightRange = const RangeValues(62, 72); // in inches
  double _minGunas = 24.0;
  String _selectedMaritalStatus = 'Never Married';
  String _selectedReligion = 'Hindu';
  bool _casteNoBar = true;
  String _selectedIncome = '₹25L - ₹50L';
  String _selectedManglik = 'Non-Manglik';
  String _selectedDiet = 'Vegetarian';
  bool _verifiedOnly = true;
  bool _horoscopeOnly = true;
  bool _activeRecentOnly = true;

  // Quick Preset Tags
  final Set<String> _activePresets = {'⭐ High Kundali Match (>28)', '🛡️ ID Verified Only'};

  // Search results view toggle
  bool _showingResults = false;
  List<ProfileModel> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchResults = List.from(dummyProfiles);
  }

  void _applyFilters() {
    setState(() {
      _showingResults = true;
      _searchResults = dummyProfiles.where((p) {
        final matchesAge = p.age >= _ageRange.start && p.age <= _ageRange.end;
        final matchesVerified = !_verifiedOnly || p.isVerified;
        final matchesHoroscope = !_horoscopeOnly || p.isHoroscopeVerified;
        final matchesDiet = _selectedDiet == 'All' || p.diet == _selectedDiet;
        final matchesRecent = !_activeRecentOnly || p.lastSeen.contains('Active');
        return matchesAge && matchesVerified && matchesHoroscope && matchesDiet && matchesRecent;
      }).toList();

      if (_searchResults.isEmpty) {
        _searchResults = [dummyProfiles[0], dummyProfiles[1]];
      }
    });
  }

  void _resetFilters() {
    setState(() {
      _ageRange = const RangeValues(24, 30);
      _heightRange = const RangeValues(62, 72);
      _minGunas = 24.0;
      _selectedMaritalStatus = 'Never Married';
      _selectedReligion = 'Hindu';
      _casteNoBar = true;
      _selectedIncome = '₹25L - ₹50L';
      _selectedManglik = 'Non-Manglik';
      _selectedDiet = 'Vegetarian';
      _verifiedOnly = true;
      _horoscopeOnly = true;
      _activeRecentOnly = true;
      _activePresets.clear();
      _showingResults = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All filters reset to default.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          _showingResults ? 'Search Results (${_searchResults.length})' : 'Partner Search & Filters',
          style: GoogleFonts.playfairDisplay(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          if (_showingResults)
            TextButton(
              onPressed: () => setState(() => _showingResults = false),
              child: Text(
                'Edit Filters',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            )
          else
            TextButton(
              onPressed: _resetFilters,
              child: Text(
                'Reset All',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: _showingResults ? _buildResultsView() : _buildFilterView(),
      bottomNavigationBar: _showingResults
          ? null
          : Container(
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
                    TextButton(
                      onPressed: _resetFilters,
                      child: Text(
                        'Clear',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _applyFilters,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          elevation: 3,
                          shadowColor: AppColors.primary.withValues(alpha: 0.4),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(
                          'Apply Filters • 248 Matches',
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

  Widget _buildFilterView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Universal Search Bar
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search by Name, Profile ID, Occupation, City...',
              prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textSecondary),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 18),
                      onPressed: () => setState(() => _searchController.clear()),
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 14),

          // Quick Filter Presets (Horizontal Pills)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildPresetChip('⭐ High Kundali Match (>28)'),
                _buildPresetChip('🛡️ ID Verified Only'),
                _buildPresetChip('👑 Gold & Diamond Members'),
                _buildPresetChip('📍 Near Me (Within 50km)'),
                _buildPresetChip('🎓 Masters / Ph.D'),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Section 1: Basic Criteria (Age & Height)
          _buildFilterCard(
            title: 'Basic Criteria',
            icon: Icons.person_outline_rounded,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Age Range', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${_ageRange.start.round()} - ${_ageRange.end.round()} yrs',
                        style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
                RangeSlider(
                  values: _ageRange,
                  min: 21,
                  max: 45,
                  divisions: 24,
                  activeColor: AppColors.primary,
                  inactiveColor: AppColors.outline,
                  onChanged: (values) => setState(() => _ageRange = values),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Height Range', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                    Text(
                      '${(_heightRange.start / 12).floor()}\'${(_heightRange.start % 12).round()}" - ${(_heightRange.end / 12).floor()}\'${(_heightRange.end % 12).round()}"',
                      style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary),
                    ),
                  ],
                ),
                RangeSlider(
                  values: _heightRange,
                  min: 58,
                  max: 78,
                  divisions: 20,
                  activeColor: AppColors.primary,
                  inactiveColor: AppColors.outline,
                  onChanged: (values) => setState(() => _heightRange = values),
                ),
                const SizedBox(height: 12),
                Text('Marital Status', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ['Never Married', 'Divorced', 'Awaiting Divorce', 'Widowed'].map((status) {
                    final isSelected = _selectedMaritalStatus == status;
                    return _buildSelectableChip(
                      status,
                      isSelected,
                      () => setState(() => _selectedMaritalStatus = status),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Section 2: Religion & Community
          _buildFilterCard(
            title: 'Religion & Community',
            icon: Icons.temple_hindu_outlined,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Religion', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ['Hindu', 'Jain', 'Sikh', 'Muslim', 'Christian', 'Parsi'].map((r) {
                    return _buildSelectableChip(r, _selectedReligion == r, () => setState(() => _selectedReligion = r));
                  }).toList(),
                ),
                const SizedBox(height: 14),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  activeTrackColor: AppColors.primary,
                  title: Text(
                    'Caste No Bar',
                    style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    'Show compatible profiles regardless of sub-caste',
                    style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textSecondary),
                  ),
                  value: _casteNoBar,
                  onChanged: (val) => setState(() => _casteNoBar = val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Section 3: Astrological Kundali Milan Filters
          _buildFilterCard(
            title: 'Horoscope & Kundali Milan',
            icon: Icons.auto_awesome_rounded,
            highlightBorder: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Minimum Kundali Score', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Min ${_minGunas.round()} / 36 Gunas',
                        style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.secondary),
                      ),
                    ),
                  ],
                ),
                Slider(
                  value: _minGunas,
                  min: 18,
                  max: 36,
                  divisions: 18,
                  activeColor: AppColors.secondary,
                  inactiveColor: AppColors.outline,
                  onChanged: (val) => setState(() => _minGunas = val),
                ),
                const SizedBox(height: 10),
                Text('Manglik Preference', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: ['Non-Manglik', 'Manglik', 'Doesn\'t Matter'].map((m) {
                    return _buildSelectableChip(m, _selectedManglik == m, () => setState(() => _selectedManglik = m));
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Section 4: Education & Profession
          _buildFilterCard(
            title: 'Education & Income',
            icon: Icons.work_outline_rounded,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Annual Income Bracket', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ['₹15L - ₹25L', '₹25L - ₹50L', '₹50L - ₹1Cr', '₹1Cr+'].map((inc) {
                    return _buildSelectableChip(inc, _selectedIncome == inc, () => setState(() => _selectedIncome = inc));
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Section 5: Trust & Verification Toggles
          _buildFilterCard(
            title: 'Trust & Verification Settings',
            icon: Icons.shield_outlined,
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  activeTrackColor: AppColors.trustEmerald,
                  title: Text('Verified Profiles Only', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                  subtitle: Text('Government ID & selfie verified accounts', style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textSecondary)),
                  value: _verifiedOnly,
                  onChanged: (val) => setState(() => _verifiedOnly = val),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  activeTrackColor: AppColors.astrologyPurple,
                  title: Text('Profiles with Horoscope Available', style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600)),
                  subtitle: Text('Profiles having birth chart / Guna Milan details', style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textSecondary)),
                  value: _horoscopeOnly,
                  onChanged: (val) => setState(() => _horoscopeOnly = val),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final p = _searchResults[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileDetailScreen(profile: p)),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AppImage(
                      imagePath: p.imagePath,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${p.name}, ${p.age}',
                              style: GoogleFonts.playfairDisplay(fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.verified_rounded, size: 16, color: Color(0xFF3B82F6)),
                          ],
                        ),
                        Text(
                          '${p.occupation} • ${p.city}',
                          style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '✨ ${p.horoscope.totalGunas}/36 Gunas • Non-Manglik',
                            style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w700, color: const Color(0xFF92400E)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textMuted),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPresetChip(String label) {
    final isSelected = _activePresets.contains(label);
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            if (selected) {
              _activePresets.add(label);
            } else {
              _activePresets.remove(label);
            }
          });
        },
        backgroundColor: Colors.white,
        selectedColor: AppColors.primaryContainer,
        labelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 11,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
        ),
        side: BorderSide(
          color: isSelected ? AppColors.primary : AppColors.outline,
          width: 1,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _buildFilterCard({
    required String title,
    required IconData icon,
    required Widget child,
    bool highlightBorder = false,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: highlightBorder ? AppColors.secondary.withValues(alpha: 0.4) : AppColors.outline,
            width: highlightBorder ? 1.4 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: highlightBorder ? AppColors.secondary : AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
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

  Widget _buildSelectableChip(String label, bool isSelected, VoidCallback onTap) {
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
