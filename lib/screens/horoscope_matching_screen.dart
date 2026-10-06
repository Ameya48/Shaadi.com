// ============================================================
// horoscope_matching_screen.dart - Dedicated 36 Guna Kundali Milan
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/profile_model.dart';
import '../data/dummy_data.dart';
import '../widgets/app_image.dart';

class HoroscopeMatchingScreen extends StatelessWidget {
  final ProfileModel profile;

  const HoroscopeMatchingScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final horoscope = profile.horoscope;

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
          'Kundali Milan & Compatibility',
          style: GoogleFonts.playfairDisplay(fontSize: 19, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: AppColors.textPrimary),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Kundali Milan PDF shared with parents!')),
              );
            },
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
        child: Column(
          children: [
            // Side-by-Side Couple Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.outline),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // User
                  Column(
                    children: [
                      CircleAvatar(radius: 34, backgroundImage: getAppImageProvider(currentUser.imagePath)),
                      const SizedBox(height: 8),
                      Text(currentUser.name, style: GoogleFonts.playfairDisplay(fontSize: 14, fontWeight: FontWeight.w700)),
                      Text('Tula (Libra)', style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textSecondary)),
                    ],
                  ),

                  // Auspicious Ring Center
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryLight,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.favorite_rounded, color: AppColors.primary, size: 22),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${horoscope.totalGunas}/36 Gunas',
                        style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.secondary),
                      ),
                    ],
                  ),

                  // Candidate
                  Column(
                    children: [
                      CircleAvatar(radius: 34, backgroundImage: getAppImageProvider(profile.imagePath)),
                      const SizedBox(height: 8),
                      Text(profile.name, style: GoogleFonts.playfairDisplay(fontSize: 14, fontWeight: FontWeight.w700)),
                      Text(horoscope.rashi, style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textSecondary)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Overall Score Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.kundaliGradient,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.secondary.withValues(alpha: 0.35)),
              ),
              child: Column(
                children: [
                  Text(
                    'Overall Compatibility Score',
                    style: GoogleFonts.playfairDisplay(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF78350F)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${horoscope.totalGunas} / 36 Gunas',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF92400E),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      horoscope.gunaVerdict,
                      style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.trustEmerald),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Scores above 18 gunas are considered suitable for a long, prosperous marriage. A score of 32/36 indicates exceptional emotional, mental, and genetic harmony.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(fontSize: 11.5, color: const Color(0xFF78350F), height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Ashtakoota Guna Milan Table
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.outline),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ashtakoota 8-Koota Breakdown',
                    style: GoogleFonts.playfairDisplay(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 12),
                  _buildKootaRow('Varna Koota', 'Work, ego & social alignment', '1 / 1', '100%'),
                  _buildDivider(),
                  _buildKootaRow('Vashya Koota', 'Mutual attraction & respect', '2 / 2', '100%'),
                  _buildDivider(),
                  _buildKootaRow('Tara Koota', 'Health, destiny & longevity', '3 / 3', '100%'),
                  _buildDivider(),
                  _buildKootaRow('Yoni Koota', 'Physical & lifestyle harmony', '4 / 4', '100%'),
                  _buildDivider(),
                  _buildKootaRow('Graha Maitri', 'Mental temperament & friendship', '5 / 5', '100%'),
                  _buildDivider(),
                  _buildKootaRow('Gana Koota', 'Behavior & spiritual temperament', '5 / 6', '83%'),
                  _buildDivider(),
                  _buildKootaRow('Bhakoot Koota', 'Family prosperity & love', '7 / 7', '100%'),
                  _buildDivider(),
                  _buildKootaRow('Nadi Koota', 'Genetics, health & lineage', '8 / 8', '100%'),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Manglik & Dosha Verification
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.trustEmerald.withValues(alpha: 0.4)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.verified_user_rounded, color: AppColors.trustEmerald, size: 28),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Manglik Dosha: Safe Match',
                          style: GoogleFonts.plusJakartaSans(fontSize: 13.5, fontWeight: FontWeight.w700, color: AppColors.trustEmerald),
                        ),
                        Text(
                          'Both Rahul and ${profile.name} are Non-Manglik. No astrological remedies required.',
                          style: GoogleFonts.plusJakartaSans(fontSize: 11.5, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Download Report Button
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Downloading 12-page Certified Vedic Horoscope Report PDF...')),
                );
              },
              icon: const Icon(Icons.picture_as_pdf_rounded, size: 18),
              label: const Text('Download Detailed Horoscope PDF Report'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size.fromHeight(48),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKootaRow(String name, String desc, String score, String pct) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w700)),
                Text(desc, style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.secondaryLight,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              score,
              style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: FontWeight.w800, color: const Color(0xFF92400E)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 10, thickness: 0.8, color: AppColors.outline);
  }
}
