import SwiftUI

struct MenuBarLabelView: View {
    @EnvironmentObject var usageManager: UsageManager
    @StateObject private var currencyManager = CurrencyManager.shared
    
    var body: some View {
        if usageManager.showsTokenCountInMenuBar {
            if usageManager.todayTotalTokens > 0 || !usageManager.isLoading {
                Text("\(formatTokens(usageManager.todayTotalTokens)) tok")
                    .font(.system(.caption, design: .monospaced))
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            } else {
                Text("...")
                    .font(.system(.caption, design: .monospaced))
                    .foregroundColor(.secondary)
            }
        } else if let todayCost = usageManager.todayCost {
            Text(currencyManager.formatCurrency(todayCost))
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