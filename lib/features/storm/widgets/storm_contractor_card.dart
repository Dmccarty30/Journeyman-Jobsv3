import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../design_system/app_theme.dart';
import '../../../../core/models/contractor_model.dart';

class StormContractorCard extends StatelessWidget {
  final Contractor contractor;

  const StormContractorCard({
    super.key,
    required this.contractor,
  });

  Future<void> _launchUrl(String url) async {
    // If the URL is just a domain without scheme, add https://
    final launchUri = Uri.parse(url.startsWith('http') ? url : 'https://$url');
    if (!await launchUrl(launchUri)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final uri = Uri.parse('tel:$phoneNumber');
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $phoneNumber');
    }
  }

  Future<void> _sendSms(String phoneNumber, {String? body}) async {
    final uri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: body != null ? {'body': body} : null,
    );
    if (!await launchUrl(uri)) {
      throw Exception('Could not send SMS to $phoneNumber');
    }
  }

  Future<void> _sendEmail(String emailAddress) async {
    final uri = Uri.parse('mailto:$emailAddress');
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $emailAddress');
    }
  }

  /// Builds the logo background layer with faded watermark effect
  Widget _buildLogoBackground() {
    final logoUrl = contractor.logoUrl;
    final assetPath = contractor.localAssetPath;

    // Logo background layer (behind everything)
    return Positioned.fill(
      child: Opacity(
        opacity: 0.15, // Faded watermark
        child: _buildLogoImage(assetPath, logoUrl),
      ),
    );
  }

  Widget _buildLogoImage(String? assetPath, String? logoUrl) {
    // Try local asset first
    if (assetPath != null) {
      return Image.asset(
        assetPath,
        fit: BoxFit.contain,
        alignment: Alignment.center,
        errorBuilder: (context, error, stackTrace) {
          // If asset fails, try remote URL
          if (logoUrl != null && logoUrl.isNotEmpty) {
            return CachedNetworkImage(
              imageUrl: logoUrl,
              fit: BoxFit.contain,
              alignment: Alignment.center,
              placeholder: (context, url) => const SizedBox.shrink(),
              errorWidget: (context, url, error) => _buildFallbackIcon(),
            );
          }
          return _buildFallbackIcon();
        },
      );
    }

    // Fallback to remote URL if no asset path calculated
    if (logoUrl != null && logoUrl.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: logoUrl,
        fit: BoxFit.contain,
        alignment: Alignment.center,
        placeholder: (context, url) => const SizedBox.shrink(),
        errorWidget: (context, url, error) => _buildFallbackIcon(),
      );
    }

    return _buildFallbackIcon();
  }

  Widget _buildFallbackIcon() {
    return Center(
      child: Icon(
        Icons.flash_on,
        size: 200,
        color: AppTheme.accentCopper.withValues(alpha: 0.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppTheme.radiusMd),
            bottomRight: Radius.circular(AppTheme.radiusMd),
            topRight: Radius.circular(AppTheme.radiusXl),
            bottomLeft: Radius.circular(2)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryNavy.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(4, 4),
          ),
        ],
        border: Border.all(
          color: AppTheme.borderCopper, // Copper border
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppTheme.radiusMd),
            bottomRight: Radius.circular(AppTheme.radiusMd),
            topRight: Radius.circular(AppTheme.radiusXl),
            bottomLeft: Radius.circular(2)),
        child: Stack(
          children: [
            // NEW: Logo background layer (behind everything)
            _buildLogoBackground(),

            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          contractor.company,
                          style: AppTheme.headlineSmall.copyWith(
                            color: AppTheme.primaryNavy,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // PRIMARY SIGNUP ACTION
                  const SizedBox(height: AppTheme.spacingMd),
                  _buildSmartSignupAction(),

                  // Address Section
                  if (contractor.address != null &&
                      contractor.address!.isNotEmpty) ...[
                    const SizedBox(height: AppTheme.spacingMd),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: AppTheme.textLight,
                        ),
                        const SizedBox(width: AppTheme.spacingXs),
                        Expanded(
                          child: Text(
                            '${contractor.address}${contractor.city != null ? ', ${contractor.city}' : ''}${contractor.state != null ? ', ${contractor.state}' : ''}',
                            style: AppTheme.bodySmall
                                .copyWith(color: AppTheme.textLight),
                          ),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: AppTheme.spacingLg),
                  const Divider(color: AppTheme.lightGray),
                  const SizedBox(height: AppTheme.spacingSm),

                  // Data Fields & Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (contractor.website != null &&
                          contractor.website!.isNotEmpty)
                        _buildActionButton(
                          icon: FontAwesomeIcons.globe,
                          label: 'WEB',
                          onPressed: () => _launchUrl(contractor.website!),
                          color: AppTheme.infoBlue,
                        ),
                      if (contractor.phoneNumber != null &&
                          contractor.phoneNumber!.isNotEmpty) ...[
                        _buildActionButton(
                          icon: FontAwesomeIcons.phone,
                          label: 'CALL',
                          onPressed: () =>
                              _makePhoneCall(contractor.phoneNumber!),
                          color: AppTheme.primaryNavy,
                        ),
                      ],
                      if (contractor.email != null &&
                          contractor.email!.isNotEmpty)
                        _buildActionButton(
                          icon: FontAwesomeIcons.solidEnvelope,
                          label: 'EMAIL',
                          onPressed: () => _sendEmail(contractor.email!),
                          color: AppTheme.accentCopper,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmartSignupAction() {
    final howToSignup = contractor.howToSignup;
    final website = contractor.website;
    final phoneNumber = contractor.phoneNumber;

    // Online Signup
    if (howToSignup.toLowerCase().contains('online') &&
        website != null &&
        website.isNotEmpty) {
      return InkWell(
        onTap: () => _launchUrl(website),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
              vertical: AppTheme.spacingSm, horizontal: AppTheme.spacingMd),
          decoration: BoxDecoration(
            color: AppTheme.accentCopper.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            border:
                Border.all(color: AppTheme.accentCopper.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(FontAwesomeIcons.laptop,
                  size: 14, color: AppTheme.accentCopper),
              const SizedBox(width: AppTheme.spacingSm),
              Text(
                'Sign Up Online',
                style: AppTheme.labelLarge.copyWith(
                  color: AppTheme.accentCopper,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: AppTheme.spacingXs),
              const Icon(Icons.arrow_outward,
                  size: 14, color: AppTheme.accentCopper),
            ],
          ),
        ),
      );
    }

    // Text Signup
    if (howToSignup.toLowerCase().contains('text') &&
        phoneNumber != null &&
        phoneNumber.isNotEmpty) {
      // Try to parse a specific message like "Text 'join'"
      String? body;
      final match = RegExp(r"Text\s+['" "]?(\w+)['" "]?", caseSensitive: false)
          .firstMatch(howToSignup);
      if (match != null) {
        body = match.group(1);
      }

      return InkWell(
        onTap: () => _sendSms(phoneNumber, body: body),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
              vertical: AppTheme.spacingSm, horizontal: AppTheme.spacingMd),
          decoration: BoxDecoration(
            color: AppTheme.primaryNavy.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            border:
                Border.all(color: AppTheme.primaryNavy.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(FontAwesomeIcons.solidMessage,
                  size: 14, color: AppTheme.primaryNavy),
              const SizedBox(width: AppTheme.spacingSm),
              Text(
                body != null
                    ? 'Text "$body" to Apply'
                    : 'Text to Apply', // Fallback
                style: AppTheme.labelLarge.copyWith(
                  color: AppTheme.primaryNavy,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: AppTheme.spacingXs),
              const Icon(Icons.send, size: 14, color: AppTheme.primaryNavy),
            ],
          ),
        ),
      );
    }

    // Default: Just display the text
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingSm, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.lightGray,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'Sign Up: $howToSignup',
        style: AppTheme.labelSmall.copyWith(
          color: AppTheme.textSecondary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppTheme.radiusSm),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: AppTheme.spacingXs, horizontal: AppTheme.spacingSm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTheme.labelSmall.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 10,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
