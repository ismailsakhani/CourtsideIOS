import CoreFoundation

public enum Spacing {
    /// 4pt — tight internal gaps (icon + label, indicator dots)
    public static let xs: CGFloat = 4
    /// 8pt — compact gaps (tag padding, small stacks)
    public static let sm: CGFloat = 8
    /// 12pt — medium gaps (pill padding, list gaps)
    public static let md: CGFloat = 12
    /// 16pt — standard element gap
    public static let lg: CGFloat = 16
    /// 24pt — primary horizontal screen margin; card internal padding
    public static let xl: CGFloat = 24
    /// 32pt — wide card padding; section-internal spacing
    public static let xxl: CGFloat = 32
    /// 48pt — between major page sections
    public static let section: CGFloat = 48
    /// 64pt — bottom clearance for sub-screens (above tab bar)
    public static let bottomClear: CGFloat = 64
    /// 120pt — bottom clearance on main tabs (tab bar + floating cart pill)
    public static let tabClear: CGFloat = 120
}
