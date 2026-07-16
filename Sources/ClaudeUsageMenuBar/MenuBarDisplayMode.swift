import Foundation

enum MenuBarDisplayMode: String, CaseIterable {
    case cost = "cost"
    case tokens = "tokens"
    case both = "both"

    var displayName: String {
        switch self {
        case .cost:
            return "Cost"
        case .tokens:
            return "Tokens"
        case .both:
            return "Both"
        }
    }
}