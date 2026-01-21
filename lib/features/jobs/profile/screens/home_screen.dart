import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:journeyman_jobs/core/widgets/notification_badge.dart';
import 'package:journeyman_jobs/design_system/design_system.dart';
import 'package:journeyman_jobs/features/crews/crews.dart';
import 'package:journeyman_jobs/features/jobs/jobs.dart';
import 'package:journeyman_jobs/features/jobs/profile/models/user_model.dart';
import 'package:journeyman_jobs/features/navigation/navigation.dart';
import 'package:journeyman_jobs/features/auth/auth.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(jobsProvider.notifier).loadJobs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          const ElectricalCircuitBackground(
            opacity: 0.35,
            componentDensity: ComponentDensity.high,
          ),
          RefreshIndicator(
            onRefresh: () => ref.read(jobsProvider.notifier).refreshJobs(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWelcomeSection(ref),
                  const SizedBox(height: AppTheme.spacingLg),
                  _buildQuickActions(context, ref),
                  const SizedBox(height: AppTheme.spacingLg),
                  _buildSuggestedJobsHeader(context),
                  const SizedBox(height: AppTheme.spacingMd),
                  _buildSuggestedJobsList(ref),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.primaryNavy,
      elevation: 0,
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              gradient: AppTheme.buttonGradient,
              shape: BoxShape.circle,
            ),
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(
                Icons.construction,
                size: 20,
                color: AppTheme.white,
              ),
            ),
          ),
          const SizedBox(width: AppTheme.spacingSm),
          const Text(
            'Journeyman Jobs',
            style: AppTheme.headlineMedium,
          ),
        ],
      ),
      actions: [
        NotificationBadge(
          iconColor: AppTheme.white,
          showPopupOnTap: true,
        ),
      ],
    );
  }

  Widget _buildWelcomeSection(WidgetRef ref) {
    // Antigravity Kit 2.0: Use .select() for granular rebuilds
    final isAuthenticated =
        ref.watch(authProvider.select((s) => s.isAuthenticated));
    final userModelAsync = ref.watch(userModelStreamProvider);

    if (!isAuthenticated) {
      return _buildGuestWelcome();
    }

    return userModelAsync.when(
      data: (userModel) => _buildUserWelcome(userModel),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => _buildErrorWelcome(),
    );
  }

  Widget _buildGuestWelcome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Welcome Back!',
          style: AppTheme.headlineMedium,
        ),
        const SizedBox(height: AppTheme.spacingSm),
        const Text(
          'IBEW Member',
          style: AppTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildUserWelcome(UserModel userModel) {
    final photoUrl = userModel.avatarUrl;
    final displayName = userModel.displayNameStr;
    final userInitial =
        displayName.isNotEmpty ? displayName[0].toUpperCase() : 'U';
    final ticketNumber = userModel.ticketNumber;

    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: AppTheme.primaryNavy,
          backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
          child: photoUrl == null
              ? Text(
                  userInitial,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
        ),
        const SizedBox(width: AppTheme.spacingMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome Back!',
                style: AppTheme.headlineMedium,
              ),
              const SizedBox(height: AppTheme.spacingXs),
              Text(
                displayName.isNotEmpty ? displayName : 'IBEW Member',
                style: AppTheme.titleMedium.copyWith(
                  color: AppTheme.primaryNavy,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (ticketNumber.isNotEmpty) ...[
                const SizedBox(height: AppTheme.spacingSm),
                Text(
                  'Ticket #$ticketNumber',
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorWelcome() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: AppTheme.primaryNavy,
        ),
        const SizedBox(width: AppTheme.spacingMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome Back!',
                style: AppTheme.headlineMedium,
              ),
              const SizedBox(height: AppTheme.spacingSm),
              const Text(
                'IBEW Member',
                style: AppTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: AppTheme.headlineSmall,
        ),
        const SizedBox(height: AppTheme.spacingLg),
        Row(
          children: [
            Expanded(
              child: _buildElectricalActionCard(
                'Electrical Calc',
                Icons.calculate_outlined,
                () => context.push(AppRouter.electricalCalculators),
              ),
            ),
            const SizedBox(width: AppTheme.spacingMd),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final userCrews = ref.watch(userCrewsProvider);
                  if (userCrews.isNotEmpty) {
                    return _buildElectricalActionCard(
                      'View Crews',
                      Icons.group_outlined,
                      () => context.push(AppRouter.crews),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildElectricalActionCard(
      String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          boxShadow: [AppTheme.shadowSm],
          border: Border.all(
            color: AppTheme.accentCopper,
            width: AppTheme.borderWidthCopperThin,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppTheme.primaryNavy,
              size: AppTheme.iconLg,
            ),
            const SizedBox(height: AppTheme.spacingSm),
            Text(
              title,
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.primaryNavy,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestedJobsHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Suggested Jobs',
          style: AppTheme.headlineSmall,
        ),
        TextButton(
          onPressed: () => context.push(AppRouter.jobs),
          child: Text(
            'View All',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.accentCopper,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestedJobsList(WidgetRef ref) {
    // Antigravity Kit 2.0: Use .select() for granular rebuilds
    // Only rebuild when these specific properties change
    final isLoading = ref.watch(jobsProvider.select((s) => s.isLoading));
    final error = ref.watch(jobsProvider.select((s) => s.error));
    final jobs = ref.watch(jobsProvider.select((s) => s.jobs));

    if (isLoading && jobs.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(AppTheme.spacingLg),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.accentCopper),
          ),
        ),
      );
    }

    if (error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingLg),
          child: Column(
            children: [
              Text(
                'Error loading jobs',
                style: AppTheme.bodyLarge.copyWith(
                  color: AppTheme.errorRed,
                ),
              ),
              const SizedBox(height: AppTheme.spacingSm),
              ElevatedButton(
                onPressed: () => ref.read(jobsProvider.notifier).refreshJobs(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (jobs.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingLg),
          child: Column(
            children: [
              const Icon(
                Icons.work_off_outlined,
                size: 48,
                color: AppTheme.textSecondary,
              ),
              const SizedBox(height: AppTheme.spacingMd),
              Text(
                'No jobs available at the moment',
                style: AppTheme.bodyLarge.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: AppTheme.spacingSm),
              TextButton(
                onPressed: () => ref.read(jobsProvider.notifier).refreshJobs(),
                child: Text(
                  'Refresh',
                  style: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.accentCopper,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: jobs.take(5).map((job) {
        return RichTextJobCard(
          job: job,
          onDetails: () => _showJobDetailsDialog(context, job),
          onBid: () {
            // Handle bid action
          },
        );
      }).toList(),
    );
  }

  void _showJobDetailsDialog(BuildContext context, Job jobModel) {
    showDialog(
      context: context,
      builder: (context) => JobDetailsDialog(job: jobModel),
    );
  }
}
