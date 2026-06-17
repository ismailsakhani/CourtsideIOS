import Foundation
import CoreText

let fontURL = URL(fileURLWithPath: "/Users/ismailsakhani/Downloads/courtside/Courtside/Resources/Pinyon_Script,Plus_Jakarta_Sans/Pinyon_Script/PinyonScript-Regular.ttf")
guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
      let font = CGFont(fontDataProvider) else {
    print("Failed to load font")
    exit(1)
}
if let postScriptName = font.postScriptName {
    print("PostScript Name: \(postScriptName)")
} else {
    print("No PostScript name found")
}
