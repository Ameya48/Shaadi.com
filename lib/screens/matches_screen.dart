// ============================================================
// matches_screen.dart - Stitch Common Matches & Mutual Interests
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/profile_model.dart';
import '../data/dummy_data.dart';
import '../widgets/app_image.dart';
import 'profile_detail_screen.dart';
import 'horoscope_matching_screen.dart';
import 'chat_screen.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Daily Matches & Compatibility',
          style: GoogleFonts.playfairDisplay(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          labelStyle: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w700),
          tabs: const [
            Tab(text: 'Common Matches (6)'),
            Tab(text: '✨ High Kundali (4)'),
            Tab(text: '📍 Near Me (3)'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMatchList(dummyProfiles),
          _buildMatchList(dummyProfiles.where((p) => p.horoscope.totalGunas >= 30).toList()),
          _buildMatchList(dummyProfiles.where((p) => p.city == 'Mumbai' || p.city == 'Pune').toList()),
        ],
      ),
    );
  }

  Widget _buildMatchList(List<ProfileModel> profiles) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: profiles.length,
      itemBuilder: (context, index) {
        final p = profiles[index];
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
              // Photo & Overlay
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    child: AppImage(
                      imagePath: p.imagePath,
                      height: 260,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      alignment: const Alignment(0.0, -0.2),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.65),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${(p.compatibility * 100).round()}% Match',
                        style: GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.white),
                      ),
                    ),
                  ),
                  if (p.isGold)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'GOLD MEMBER',
                          style: GoogleFonts.plusJakartaSans(fontSize: 9.5, fontWeight: FontWeight.w800, color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(16),
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
                              style: GoogleFonts.playfairDisplay(fontSize: 17, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.verified_rounded, size: 16, color: Color(0xFF3B82F6)),
                          ],
                        ),
                        Text(
                          p.income,
                          style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary),
                        ),
                      ],
                    ),
                    Text(
                      '${p.occupation} at ${p.company} • ${p.city}',
                      style: GoogleFonts.plusJakartaSans(fontSize: 12.5, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 10),

                    // Horoscope & Common Interests
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: AppColors.kundaliGradient,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.25)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.auto_awesome_rounded, color: AppColors.secondary, size: 16),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${p.horoscope.totalGunas}/36 Gunas • ${p.horoscope.gunaVerdict}',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF78350F),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HoroscopeMatchingScreen(profile: p),
                                ),
                              );
                            },
                            child: Text(
                              'Kundali >',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: AppColors.secondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Mutual interests tags
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: p.interests.take(3).map((i) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            i,
                            style: GoogleFonts.plusJakartaSans(fontSize: 10.5, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 14),

                    // Action Buttons Row
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ProfileDetailScreen(profile: p)),
                              ).then((_) => setState(() {}));
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 11),
                              side: const BorderSide(color: AppColors.outline),
                            ),
                            child: const Text('View Bio'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: isConnectedWithProfile(p)
                              ? ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ChatScreen(selectedProfile: p)),
                                    ).then((_) => setState(() {}));
                                  },
                                  icon: const Icon(Icons.chat_bubble_rounded, size: 15),
                                  label: const Text('Chat Now'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.trustEmerald,
                                    padding: const EdgeInsets.symmetric(vertical: 11),
                                  ),
                                )
                              : ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      connectWithProfile(p);
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('🎉 Connected with ${p.name}! Chat unlocked.'),
                                        action: SnackBarAction(
                                          label: 'Chat Now',
                                          textColor: AppColors.secondary,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => ChatScreen(selectedProfile: p)),
                                            ).then((_) => setState(() {}));
                                          },
                                        ),
                                        backgroundColor: AppColors.trustEmerald,
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.favorite_rounded, size: 15),
                                  label: const Text('Connect'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    padding: const EdgeInsets.symmetric(vertical: 11),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
