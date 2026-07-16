import SwiftUI

struct MenuBarLabelView: View {
    @EnvironmentObject var usageManager: UsageManager
    @StateObject private var currencyManager = CurrencyManager.shared
    
    var body: some View {
        if let labelText = menuBarLabelText() {
            Text(labelText)
                .font(.system(.caption, design: .monospaced))
                .foregroundColor(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        } else if usageManager.isLoading {
            // Only show loading state if no previous value exists
            Text("...")
                .font(.system(.caption, design: .monospaced))
                .foregroundColor(.secondary)
        } else {
            Text("--")
                .font(.system(.caption, design: .monospaced))
                .foregroundColor(.secondary)
        }
    }

    private func menuBarLabelText() -> String? {
        switch usageManager.menuBarDisplayMode {
        case .cost:
            guard let todayCost = usageManager.todayCost else {
                return nil
            }
            return currencyManager.formatCurrency(todayCost)
        case .tokens:
            if usageManager.todayTotalTokens > 0 || !usageManager.isLoading {
                return "\(formatTokens(usageManager.todayTotalTokens)) tok"
            }
            return nil
        case .both:
            guard let todayCost = usageManager.todayCost else {
                return nil
            }
            return "\(currencyManager.formatCurrency(todayCost)) \(formatTokens(usageManager.todayTotalTokens)) tok"
        }
    }

    private func formatTokens(_ count: Int) -> String {
        if count >= 1_000_000 {
            return String(format: "%.1fM", Double(count) / 1_000_000)
        } else if count >= 1_000 {
            return String(format: "%.1fK", Double(count) / 1_000)
        } else {
            return "\(count)"
        }
    }
}