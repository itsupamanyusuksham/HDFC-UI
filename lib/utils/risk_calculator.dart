/// Simplified Policy model for risk calculation in the Analytical Dashboard
class DashboardPolicy {
  final bool exists;
  final double coverageGap; // percentage value (0.0 to 100.0)

  DashboardPolicy({
    required this.exists,
    required this.coverageGap,
  });
}

/// Calculates the overall risk status based on individual policy coverage gaps.
///
/// If no policies exist, returns "No Coverage".
/// Average gap calculation logic:
/// - Iterate through all policy categories.
/// - If a policy exists, include its coverage gap (%) in the average.
/// - If no policy exists, ignore that category.
/// - Risk Status determination:
///   - > 70 → "High Risk"
///   - 35 - 70 (inclusive) → "Moderate Risk"
///   - < 35 → "Low Risk"
Map<String, dynamic> calculateRiskStatus(List<DashboardPolicy> policies) {
  // Input safety: handle null or empty inputs
  if (policies.isEmpty) {
    return {
      "averageGap": 0.0,
      "riskStatus": "No Coverage",
    };
  }

  double totalGap = 0.0;
  int existingCount = 0;

  for (final policy in policies) {
    if (policy.exists) {
      totalGap += policy.coverageGap;
      existingCount++;
    }
  }

  // Handle edge case: no policies exist in any category
  if (existingCount == 0) {
    return {
      "averageGap": 0.0,
      "riskStatus": "No Coverage",
    };
  }

  // Compute the average coverage gap using only the included values
  final averageGap = totalGap / existingCount;

  // Determine the risk status string
  String riskStatus;
  if (averageGap > 70) {
    riskStatus = "High Risk";
  } else if (averageGap >= 35) {
    riskStatus = "Moderate Risk";
  } else {
    riskStatus = "Low Risk";
  }

  return {
    "averageGap": double.parse(averageGap.toStringAsFixed(1)),
    "riskStatus": riskStatus,
  };
}
