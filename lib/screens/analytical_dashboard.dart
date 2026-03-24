import 'package:flutter/material.dart';
import '../widgets/donut_chart.dart';
import '../widgets/info_card.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/calculation_breakdown_sheet.dart';
import '../models/policy_model.dart';
import '../utils/dashboard_constants.dart';
import 'dashboard_screen.dart';
import 'insights_screen.dart';

class AnalyticsDashboard extends StatelessWidget {
  final String customerName;
  final String customerId;

  const AnalyticsDashboard({
    super.key,
    required this.customerName,
    required this.customerId,
  });

  @override
  Widget build(BuildContext context) {
    final policies = PolicyData.getSamplePolicies();
    final totalPolicies = policies.length;
    // final expiringSoon = policies.where((p) => p.status == PolicyStatus.due || p.status == PolicyStatus.expiringsoon).length;

    // Calculate total values based on unexpired policies
    final unexpiredPolicies = policies.where((p) => p.status != PolicyStatus.expired).toList();
    
    final totalProtection = unexpiredPolicies
        .fold(0.0, (sum, p) => sum + p.sumInsured);
        
    final totalPremium = unexpiredPolicies
        .fold(0.0, (sum, p) => sum + p.annualPremium);

    return Scaffold(
      backgroundColor: const Color(0xFFE9EDF3),
      appBar: CustomAppBar(
        customerName: customerName,
        customerId: customerId,
        showBackButton: true,
        onLogoTap: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => DashboardScreen(customerId: customerId),
            ),
            (route) => false,
          );
        },
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final isMobile = width < 600;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 40,
              vertical: isMobile ? 16 : 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "User Analytics",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                /// ================= DONUT SECTION =================
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        offset: Offset(0, 8),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: DonutChart(
                          title: "Life Insurance",
                          percent: DashboardConstants.lifeCoveragePercent.toInt(),
                          label: DashboardConstants.getRating(DashboardConstants.lifeCoveragePercent),
                          onTap: () => _showBreakdown(
                            context,
                            title: "Life Insurance",
                            current: DashboardConstants.lifePresentCover,
                            ideal: DashboardConstants.lifeRecommendedCover,
                            percent: DashboardConstants.lifeCoveragePercent,
                            gap: DashboardConstants.lifeGap,
                            formula: "Recommended Cover = ${DashboardConstants.lifeRecommendedMultiplier.toInt()} × Annual Income (₹ ${(DashboardConstants.annualIncome / 100000).toStringAsFixed(1)} L)\nCoverage % = Current Cover / Recommended Cover",
                            rating: DashboardConstants.getRating(DashboardConstants.lifeCoveragePercent),
                          ),
                        ),
                      ),
                      Flexible(
                        child: DonutChart(
                          title: "Health Insurance",
                          percent: DashboardConstants.healthCoveragePercent.toInt(),
                          label: DashboardConstants.getRating(DashboardConstants.healthCoveragePercent),
                          onTap: () => _showBreakdown(
                            context,
                            title: "Health Insurance",
                            current: DashboardConstants.healthPresentCover,
                            ideal: DashboardConstants.healthRecommendedCover,
                            percent: DashboardConstants.healthCoveragePercent,
                            gap: DashboardConstants.healthGap,
                            formula: "Recommended Cover = ${DashboardConstants.healthRecommendedMultiplier} × Annual Income (₹ ${(DashboardConstants.annualIncome / 100000).toStringAsFixed(1)} L)\nCoverage % = Current Cover / Recommended Cover",
                            rating: DashboardConstants.getRating(DashboardConstants.healthCoveragePercent),
                          ),
                        ),
                      ),
                      Flexible(
                        child: DonutChart(
                          title: "Vehicle Insurance",
                          percent: DashboardConstants.vehicleCoveragePercent.toInt(),
                          label: DashboardConstants.getRating(DashboardConstants.vehicleCoveragePercent),
                          onTap: () => _showBreakdown(
                            context,
                            title: "Vehicle Insurance",
                            current: DashboardConstants.vehiclePresentCover,
                            ideal: DashboardConstants.vehicleIdealIDV,
                            percent: DashboardConstants.vehicleCoveragePercent,
                            gap: DashboardConstants.vehicleGap,
                            formula: "Ideal IDV = ₹ 7.6 L\nCoverage % = Current Cover / Ideal IDV",
                            rating: DashboardConstants.getRating(DashboardConstants.vehicleCoveragePercent),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                /// ================= INFO CARDS =================
                LayoutBuilder(
                  builder: (context, cardConstraints) {
                    final gridWidth = cardConstraints.maxWidth;
                    double cardWidth;
                    
                    if (width > 1200) {
                      cardWidth = (gridWidth - (3 * 20)) / 4;
                    } else if (width > 800) {
                      cardWidth = (gridWidth - 20) / 2;
                    } else {
                      cardWidth = gridWidth;
                    }

                    return Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: [
                        SizedBox(
                          width: cardWidth,
                          child: InfoCard(
                            icon: Icons.policy_outlined,
                            color: const Color(0xFF1A237E),
                            title: "Policies Linked",
                            value: "$totalPolicies",
                            subtitle: "Premium: ₹ ${_formatPremium(totalPremium)}",
                          ),
                        ),
                        SizedBox(
                          width: cardWidth,
                          child: InfoCard(
                            icon: Icons.security,
                            color: const Color(0xFF1A237E),
                            title: "Total Protection",
                            value: "₹ ${_formatProtection(totalProtection)}",
                            subtitle: "sum of all insurance",
                          ),
                        ),
                        SizedBox(
                          width: cardWidth,
                          child: InfoCard(
                            icon: Icons.error_outline,
                            color: const Color(0xFF1A237E),
                            title: "Coverage Gap",
                            value: "₹ ${_formatGap(DashboardConstants.totalGap)}",
                            subtitle: "to reach recommended levels",
                          ),
                        ),
                        SizedBox(
                          width: cardWidth,
                          child: InfoCard(
                            icon: Icons.warning_amber_rounded,
                            color: const Color(0xFF1A237E),
                            title: "Risk Status",
                            value: DashboardConstants.getRiskStatus(),
                            subtitle: "see insights",
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InsightsScreen(
                                  customerName: customerName,
                                  customerId: customerId,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatPremium(double amount) {
    if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(1)} L';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(0)}K';
    }
    return amount.toStringAsFixed(0);
  }

  String _formatProtection(double amount) {
    if (amount >= 10000000) {
      return '${(amount / 10000000).toStringAsFixed(1)} Cr';
    }
    return '${(amount / 100000).toStringAsFixed(1)} L';
  }

  String _formatGap(double amount) {
    if (amount >= 10000000) {
      return '${(amount / 10000000).toStringAsFixed(1)} Cr';
    } else if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(1)} L';
    }
    return amount.toStringAsFixed(0);
  }

  void _showBreakdown(
    BuildContext context, {
    required String title,
    required double current,
    required double ideal,
    required double percent,
    required double gap,
    required String formula,
    required String rating,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CalculationBreakdownSheet(
        title: title,
        currentCoverage: current,
        recommendedCoverage: ideal,
        coveragePercentage: percent,
        coverageGap: gap,
        formulaExplanation: formula,
        rating: rating,
      ),
    );
  }
}

