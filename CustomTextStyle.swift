import SwiftUI

// MARK: - Font Extension for Custom Typography

public extension Font {
    
    /// Returns a custom scalable font based on the given `CustomTextStyle`.
    ///
    /// - Parameters:
    ///   - style: Predefined custom text style
    ///   - size: Optional override for font size
    ///   - weight: Optional override for font weight
    /// - Returns: A SwiftUI Font supporting Dynamic Type
    static func customFont(
        _ style: CustomTextStyle,
        size overrideSize: CGFloat? = nil,
        weight overrideWeight: CustomFontWeight? = nil
    ) -> Font {
        
        let fontSize = overrideSize ?? style.baseSize
        let fontWeight = overrideWeight ?? style.defaultWeight
        let fontName = "AppFont-\(fontWeight.rawValue)" // Replace "AppFont" with your font family name

        // If both size and weight are provided as overrides, use fixed size
        if overrideSize != nil && overrideWeight != nil {
            return .customFontFamily(fontWeight, ofSize: fontSize)
        }

        return Font.custom(fontName, size: style.baseSize, relativeTo: style.textStyle)
    }
    
    /// Fixed-size version of your custom font family
    static func customFontFamily(_ weight: CustomFontWeight, ofSize size: CGFloat) -> Font {
        Font.custom("AppFont-\(weight.rawValue)", fixedSize: size) // Replace "AppFont"
    }
}

// MARK: - Custom Font Weights

public enum CustomFontWeight: String {
    case light = "Light"       // 300
    case regular = "Regular"   // 400
    case medium = "Medium"     // 500
    case semibold = "SemiBold" // 600
    case bold = "Bold"         // 700
}

// MARK: - Custom Text Styles

public enum CustomTextStyle {
    case largeTitle, title1, title2, title3, headline, body, subheadline

    var baseSize: CGFloat {
        switch self {
        case .largeTitle: return 70
        case .title1: return 36
        case .title2: return 24
        case .title3: return 20
        case .headline: return 18
        case .body: return 16
        case .subheadline: return 14
        }
    }

    var defaultWeight: CustomFontWeight {
        switch self {
        case .largeTitle, .title2, .title3: return .bold
        case .title1, .headline, .body, .subheadline: return .medium
        }
    }

    var textStyle: Font.TextStyle {
        switch self {
        case .largeTitle: return .largeTitle
        case .title1: return .title
        case .title2: return .title2
        case .title3: return .title3
        case .headline: return .headline
        case .body: return .body
        case .subheadline: return .subheadline
        }
    }
}

// MARK: - View Modifier

private struct CustomTextStyleModifier: ViewModifier {
    
    let style: CustomTextStyle
    let sizeOverride: CGFloat?
    let weightOverride: CustomFontWeight?
    let dynamicTypeSize: DynamicTypeSize?
    let showsLargeContentViewer: Bool?
    
    func body(content: Content) -> some View {
        var modified = content
            .font(.customFont(style, size: sizeOverride, weight: weightOverride))
        
        if let dynamicTypeSize = dynamicTypeSize {
            modified = modified.dynamicTypeSize(dynamicTypeSize)
        } else {
            modified = modified.dynamicTypeSize(...DynamicTypeSize.xxxLarge)
        }
        
        if showsLargeContentViewer == true {
            modified = modified.accessibilityShowsLargeContentViewer()
        }
        
        return modified
    }
}

// MARK: - View Extension

public extension View {
    
    /// Applies a custom text style using the design system.
    ///
    /// - Parameters:
    ///   - style: The `CustomTextStyle` to apply
    ///   - size: Optional size override
    ///   - weight: Optional weight override
    ///   - dynamicTypeSize: Optional Dynamic Type support range
    ///   - showsLargeContentViewer: Enables large content viewer for accessibility
    func textStyle(
        _ style: CustomTextStyle,
        size: CGFloat? = nil,
        weight: CustomFontWeight? = nil,
        dynamicTypeSize: DynamicTypeSize? = nil,
        showsLargeContentViewer: Bool? = false
    ) -> some View {
        self.modifier(CustomTextStyleModifier(
            style: style,
            sizeOverride: size,
            weightOverride: weight,
            dynamicTypeSize: dynamicTypeSize,
            showsLargeContentViewer: showsLargeContentViewer
        ))
    }
}
