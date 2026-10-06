// ============================================================
// privacy_settings_screen.dart - Matrimony Privacy Controls & Shield
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../data/dummy_data.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  late bool _blurPhoto;
  late bool _hideContact;
  late bool _hideLastSeen;
  bool _blockScreenshot = true;
  bool _incognitoBrowsing = false;

  @override
  void initState() {
    super.initState();
    _blurPhoto = loggedInUserData.blurProfilePhoto;
    _hideContact = loggedInUserData.hideContactInfo;
    _hideLastSeen = loggedInUserData.hideLastSeen;
  }

  void _savePrivacySettings() {
    setState(() {
      loggedInUserData.blurProfilePhoto = _blurPhoto;
      loggedInUserData.hideContactInfo = _hideContact;
      loggedInUserData.hideLastSeen = _hideLastSeen;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🔒 Privacy Settings updated successfully!'),
        behavior: SnackBarBehavior.floating,
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
          'Privacy & Safety Shield',
          style: GoogleFonts.playfairDisplay(fontSize: 19, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
        child: Column(
          children: [
            // Trust Shield Header Banner
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.trustEmerald.withValues(alpha: 0.3)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.trustEmerald.withValues(alpha: 0.06),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: AppColors.trustEmeraldLight,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.shield_rounded, color: AppColors.trustEmerald, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '100% Privacy Protection',
                          style: GoogleFonts.playfairDisplay(fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'You decide who sees your photos, phone number, and active online status.',
                          style: GoogleFonts.plusJakartaSans(fontSize: 11.5, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Photo Privacy Controls
            _buildSettingCard(
              title: 'Photo Privacy Settings',
              icon: Icons.camera_alt_outlined,
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  activeTrackColor: AppColors.primary,
                  title: Text(
                    'Blur Photos for Non-Matches',
                    style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Your photos will appear blurred until you accept a connection request.',
                    style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textSecondary),
                  ),
                  value: _blurPhoto,
                  onChanged: (val) => setState(() => _blurPhoto = val),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  activeTrackColor: AppColors.primary,
                  title: Text(
                    'Block Screenshots & Recording',
                    style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Prevents others from screenshotting your photos and chat bio.',
                    style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textSecondary),
                  ),
                  value: _blockScreenshot,
                  onChanged: (val) => setState(() => _blockScreenshot = val),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Contact & Phone Privacy
            _buildSettingCard(
              title: 'Contact Number Privacy',
              icon: Icons.phone_android_rounded,
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  activeTrackColor: AppColors.primary,
                  title: Text(
                    'Mask Contact Information (+91 98••••)',
                    style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Require members to request permission before viewing your phone number.',
                    style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textSecondary),
                  ),
                  value: _hideContact,
                  onChanged: (val) => setState(() => _hideContact = val),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Activity & Last Seen Privacy
            _buildSettingCard(
              title: 'Online Activity & Last Seen',
              icon: Icons.visibility_outlined,
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  activeTrackColor: AppColors.primary,
                  title: Text(
                    'Hide Last Seen & Online Status',
                    style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Do not broadcast when you are active on the app.',
                    style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textSecondary),
                  ),
                  value: _hideLastSeen,
                  onChanged: (val) => setState(() => _hideLastSeen = val),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  activeTrackColor: AppColors.primary,
                  title: Text(
                    'Incognito Browsing (Diamond VIP)',
                    style: GoogleFonts.plusJakartaSans(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    'Browse member profiles without appearing in their "Recently Viewed" tab.',
                    style: GoogleFonts.plusJakartaSans(fontSize: 11, color: AppColors.textSecondary),
                  ),
                  value: _incognitoBrowsing,
                  onChanged: (val) => setState(() => _incognitoBrowsing = val),
                ),
              ],
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
          child: ElevatedButton(
            onPressed: _savePrivacySettings,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              minimumSize: const Size.fromHeight(48),
            ),
            child: const Text('Save Privacy Preferences'),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.outline),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.playfairDisplay(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }
}
