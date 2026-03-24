import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../utils/dashboard_constants.dart';
// import '../models/policy_model.dart';

class InsightsScreen extends StatelessWidget {
  final String customerName;
  final String customerId;

  const InsightsScreen({
    super.key,
    required this.customerName,
    required this.customerId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9EDF3),
      appBar: CustomAppBar(
        customerName: customerName,
        customerId: customerId,
        showBackButton: true,
        onLogoTap: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Insurance Insights",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildOverallRiskCard(),
            const SizedBox(height: 24),
            const Text(
              "Detailed Breakdown",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
            const SizedBox(height: 16),
            _buildInsightSection(
              context,
              title: "Life Insurance",
              icon: Icons.favorite,
              percent: DashboardConstants.lifeCoveragePercent,
              current: DashboardConstants.lifePresentCover,
              recommended: DashboardConstants.lifeRecommendedCover,
              gap: DashboardConstants.lifeGap,
              color: Colors.redAccent,
            ),
            _buildInsightSection(
              context,
              title: "Health Insurance",
              icon: Icons.medical_services,
              percent: DashboardConstants.healthCoveragePercent,
              current: DashboardConstants.healthPresentCover,
              recommended: DashboardConstants.healthRecommendedCover,
              gap: DashboardConstants.healthGap,
              color: Colors.green,
            ),
            _buildInsightSection(
              context,
              title: "Vehicle Insurance",
              icon: Icons.directions_car,
              percent: DashboardConstants.vehicleCoveragePercent,
              current: DashboardConstants.vehiclePresentCover,
              recommended: DashboardConstants.vehicleIdealIDV,
              gap: DashboardConstants.vehicleGap,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallRiskCard() {
    final riskData = DashboardConstants.getDetailedRiskStatus();
    final riskStatus = riskData["riskStatus"];
    final averageGap = riskData["averageGap"];
    
    // Updated color logic for High Risk, Moderate Risk, Low Risk
    final riskColor = riskStatus == "High Risk" 
      ? Colors.red.shade700 
      : (riskStatus == "Moderate Risk" ? Colors.orange.shade700 : Colors.green.shade700);
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A237E),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Overall Financial Risk",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: riskColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: riskColor, width: 1),
                ),
                child: Text(
                  riskStatus.toUpperCase(),
                  style: TextStyle(
                    color: riskColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "₹ ${_formatCurrency(DashboardConstants.totalGap)} Gap",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 12),
              if (riskStatus != "No Coverage")
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "$averageGap% Avg Gap",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            "Total additional coverage recommended to secure your family's future.",
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required double percent,
    required double current,
    required double recommended,
    required double gap,
    required Color color,
  }) {
    final rating = DashboardConstants.getRating(percent);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (current > 0)
                Text(
                  rating,
                  style: TextStyle(
                    color: _getRatingColor(rating),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (current == 0)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 8),
                  Text(
                    "No policies of this type exist",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildValueColumn("Current Cover", "₹ ${_formatCurrency(current)}"),
                _buildValueColumn("Recommended", "₹ ${_formatCurrency(recommended)}"),
                _buildValueColumn("Gap", "₹ ${_formatCurrency(gap)}", isNegative: gap > 0),
              ],
            ),
          if (current > 0) ...[
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: (percent / 100).clamp(0.0, 1.0),
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(_getRatingColor(rating)),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _getAdvice(title, rating),
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildValueColumn(String label, String value, {bool isNegative = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: isNegative ? Colors.red.shade700 : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  String _formatCurrency(double amount) {
    if (amount >= 10000000) {
      return '${(amount / 10000000).toStringAsFixed(1)} Cr';
    } else if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(1)} L';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(0)}K';
    }
    return amount.toStringAsFixed(0);
  }

  Color _getRatingColor(String rating) {
    switch (rating) {
      case "Excellent":
        return Colors.green.shade700;
      case "Good":
        return Colors.green.shade500;
      case "Moderate":
        return Colors.blue.shade600;
      case "Fair":
        return Colors.orange.shade400;
      case "Low":
        return Colors.orange.shade700;
      case "Very Low":
        return Colors.red.shade400;
      case "Critical":
        return Colors.red.shade800;
      default:
        return Colors.grey;
    }
  }

  String _getAdvice(String category, String rating) {
    if (rating == "Excellent" || rating == "Good") {
      return "You are well covered in this category. Maintain your current policies.";
    }
    if (rating == "Moderate" || rating == "Fair") {
      return "Consider increasing your coverage slightly to better protect your assets.";
    }
    return "";
  }
}
