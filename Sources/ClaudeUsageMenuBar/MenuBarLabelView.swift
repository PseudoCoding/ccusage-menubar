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
                return "\(TokenFormatter.compact(usageManager.todayTotalTokens)) tok"
            }
            return nil
        case .both:
            guard let todayCost = usageManager.todayCost else {
                return nil
            }
            return "\(TokenFormatter.compact(usageManager.todayTotalTokens)) tok (\(currencyManager.formatCurrency(todayCost)))"
        }
    }
}