// ============================================================
// interests_screen.dart - Stitch Interests & Invitations Hub
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/interest_model.dart';
import '../data/dummy_data.dart';
import '../widgets/boost_banner.dart';
import '../widgets/app_image.dart';
import 'profile_detail_screen.dart';
import 'chat_screen.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedSubFilter = 'All Requests';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _acceptInterest(InterestModel item) {
    setState(() {
      item.status = 'Accepted';
      connectWithProfile(item.profile);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🎉 Connected with ${item.profile.name}! You can now start chatting.'),
        action: SnackBarAction(
          label: 'Chat Now',
          textColor: AppColors.secondary,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatScreen(selectedProfile: item.profile)),
            );
          },
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _declineInterest(InterestModel item) {
    setState(() {
      item.status = 'Declined';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Declined interest from ${item.profile.name}.'),
        duration: const Duration(seconds: 1),
      ),
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
          'Interests & Invitations',
          style: GoogleFonts.playfairDisplay(
            fontSize: 21,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune_rounded, color: AppColors.textPrimary),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              labelStyle: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              tabs: [
                Tab(text: 'Received (${receivedInterestsList.length})'),
                Tab(text: 'Sent (${sentInterestsList.length})'),
                Tab(text: 'Accepted (${receivedInterestsList.where((i) => i.status == 'Accepted').length + 1})'),
                Tab(text: 'Shortlisted (${shortlistedProfilesList.length})'),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Sub-filter Chips Bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  'All Requests',
                  '✨ High Kundali Match (30+)',
                  '👑 Premium Members',
                  '⏳ Expiring Soon',
                ].map((filter) {
                  final isSelected = _selectedSubFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(filter),
                      selected: isSelected,
                      onSelected: (selected) => setState(() => _selectedSubFilter = filter),
                      selectedColor: AppColors.primaryContainer,
                      backgroundColor: AppColors.background,
                      labelStyle: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? AppColors.primary : AppColors.textPrimary,
                      ),
                      side: BorderSide(
                        color: isSelected ? AppColors.primary : AppColors.outline,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Boost Profile Promo Banner
          const BoostBanner(),

          // Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildReceivedTab(),
                _buildSentTab(),
                _buildAcceptedTab(),
                _buildShortlistedTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceivedTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: receivedInterestsList.length,
      itemBuilder: (context, index) {
        final item = receivedInterestsList[index];
        return _buildReceivedCard(item);
      },
    );
  }

  Widget _buildReceivedCard(InterestModel item) {
    final p = item.profile;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.outline),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Candidate Avatar
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: AppImage(
                    imagePath: p.imagePath,
                    width: 76,
                    height: 76,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 14),

                // Name & Match Stats
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${p.name}, ${p.age}',
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.verified_rounded, size: 15, color: Color(0xFF3B82F6)),
                            ],
                          ),
                          Text(
                            item.date,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${p.occupation} • ${p.city}',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Kundali Score Pill
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.kundaliGradient.colors.first,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.secondary.withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          '✨ 89% Match • ${p.horoscope.totalGunas}/36 Gunas',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF92400E),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Personal Note (if provided)
          if (item.message != null && item.message!.isNotEmpty)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primaryContainer),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.chat_bubble_outline_rounded, size: 15, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item.message!,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: AppColors.textPrimary,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Action Buttons Footer
          Padding(
            padding: const EdgeInsets.all(16),
            child: item.status == 'Accepted'
                ? ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatScreen(selectedProfile: p)),
                      );
                    },
                    icon: const Icon(Icons.chat_bubble_rounded, size: 16),
                    label: const Text('Chat with Match'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(44),
                      backgroundColor: AppColors.primary,
                    ),
                  )
                : Row(
                    children: [
                      // Decline Button
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () => _declineInterest(item),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.outline),
                            foregroundColor: AppColors.textSecondary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Decline'),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Shortlist Button
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondaryLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.star_rounded, color: AppColors.secondary, size: 20),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${p.name} shortlisted!')),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Accept & Connect Button
                      Expanded(
                        flex: 2,
                        child: ElevatedButton.icon(
                          onPressed: () => _acceptInterest(item),
                          icon: const Icon(Icons.favorite_rounded, size: 16, color: Colors.white),
                          label: const Text('Accept & Connect'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSentTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sentInterestsList.length,
      itemBuilder: (context, index) {
        final item = sentInterestsList[index];
        final p = item.profile;
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AppImage(imagePath: p.imagePath, width: 60, height: 60, fit: BoxFit.cover),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${p.name}, ${p.age}', style: GoogleFonts.playfairDisplay(fontSize: 15, fontWeight: FontWeight.w700)),
                      Text('${p.occupation} • ${p.city}', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textSecondary)),
                      const SizedBox(height: 4),
                      Text('Status: ${item.status} • Sent ${item.date}', style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textMuted),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAcceptedTab() {
    final acceptedList = receivedInterestsList.where((i) => i.status == 'Accepted').toList();
    if (acceptedList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.favorite_outline_rounded, size: 48, color: AppColors.primary),
            const SizedBox(height: 12),
            Text('No accepted matches yet', style: GoogleFonts.playfairDisplay(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text('Accept invitations to begin chatting!', style: GoogleFonts.plusJakartaSans(fontSize: 13, color: AppColors.textSecondary)),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: acceptedList.length,
      itemBuilder: (context, index) {
        return _buildReceivedCard(acceptedList[index]);
      },
    );
  }

  Widget _buildShortlistedTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: shortlistedProfilesList.length,
      itemBuilder: (context, index) {
        final p = shortlistedProfilesList[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AppImage(imagePath: p.imagePath, width: 56, height: 56, fit: BoxFit.cover),
            ),
            title: Text('${p.name}, ${p.age}', style: GoogleFonts.playfairDisplay(fontSize: 15, fontWeight: FontWeight.w700)),
            subtitle: Text('${p.occupation} • ${p.horoscope.totalGunas}/36 Guna Match', style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textSecondary)),
            trailing: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileDetailScreen(profile: p)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              ),
              child: const Text('View Profile'),
            ),
          ),
        );
      },
    );
  }
}
