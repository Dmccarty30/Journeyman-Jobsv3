import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:journeyman_jobs/design_system/design_system.dart';
import 'package:journeyman_jobs/core/models/contractor_model.dart';

class JJContractorCard extends StatelessWidget {
  final Contractor contractor;

  const JJContractorCard({
    super.key,
    required this.contractor,
  });

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final uri = Uri.parse('tel:$phoneNumber');
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $phoneNumber');
    }
  }

  Future<void> _sendEmail(String emailAddress) async {
    final uri = Uri.parse('mailto:$emailAddress');
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $emailAddress');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: [AppTheme.shadowSm],
        border: Border.all(
            color: AppTheme.primaryNavy.withValues(alpha: 0.1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            contractor.company,
            style: AppTheme.titleLarge.copyWith(color: AppTheme.primaryNavy),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Text(
            'Sign Up: ${contractor.howToSignup}',
            style: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondary),
          ),
          if (contractor.address != null && contractor.address!.isNotEmpty) ...[
            const SizedBox(height: AppTheme.spacingXs),
            Text(
              'Address: ${contractor.address}${contractor.city != null ? ', ${contractor.city}' : ''}${contractor.state != null ? ', ${contractor.state}' : ''}',
              style: AppTheme.bodySmall.copyWith(color: AppTheme.textLight),
            ),
          ],
          const SizedBox(height: AppTheme.spacingMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (contractor.website != null && contractor.website!.isNotEmpty)
                _buildActionButton(
                  icon: Icons.public,
                  label: 'Website',
                  onPressed: () => _launchUrl(contractor.website!),
                  color: AppTheme.infoBlue,
                ),
              if (contractor.phoneNumber != null &&
                  contractor.phoneNumber!.isNotEmpty)
                _buildActionButton(
                  icon: Icons.phone,
                  label: 'Call',
                  onPressed: () => _makePhoneCall(contractor.phoneNumber!),
                  color: AppTheme.primaryNavy,
                ),
              if (contractor.email != null && contractor.email!.isNotEmpty)
                _buildActionButton(
                  icon: Icons.email,
                  label: 'Email',
                  onPressed: () => _sendEmail(contractor.email!),
                  color: AppTheme.accentCopper,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: color),
          onPressed: onPressed,
        ),
        Text(
          label,
          style:
              AppTheme.labelSmall.copyWith(color: color.withValues(alpha: 0.8)),
        ),
      ],
    );
  }
}
