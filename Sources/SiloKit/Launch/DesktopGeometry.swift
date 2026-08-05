import AppKit

/// The `"<width>x<height>"` string wine's `explorer /desktop=<name>,<geometry>` expects.
///
/// Deliberately isolated in its own AppKit file so `LaunchOrchestrator` stays AppKit-free: `makePlan` is a
/// **pure**, exhaustively table-tested function, and keeping `NSScreen` out of it means those tests never
/// need a real display or a MainActor hop. Callers resolve the geometry at the UI layer (the view models
/// are already `@MainActor`) and pass the resulting string down.
public enum DesktopGeometry {
    /// The main display's native **pixel** resolution, or nil when there's no screen to ask (a genuinely
    /// headless session, or a call that isn't on the main actor).
    ///
    /// `NSScreen.frame` reports **points**; a Retina panel's real pixel count is that times
    /// `backingScaleFactor` (a 1512×982-point MacBook Pro panel at 2x is 3024×1964 pixels). Pixels are what
    /// the virtual desktop needs — wine renders its desktop window at the panel's native resolution, not at
    /// its point size, so passing points would hand the game a quarter of the display.
    @MainActor
    public static func mainScreen(_ screen: NSScreen? = .main) -> String? {
        guard let screen else { return nil }
        let scale = screen.backingScaleFactor
        let width = Int((screen.frame.width * scale).rounded())
        let height = Int((screen.frame.height * scale).rounded())
        guard width > 0, height > 0 else { return nil }
        return "\(width)x\(height)"
    }
}
