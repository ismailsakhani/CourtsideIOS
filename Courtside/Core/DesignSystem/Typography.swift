import SwiftUI

public extension Font {
    struct Courtside {
        /// Massive, confident editorial greeting (Pinyon Script)
        public static var heroDisplay: Font {
            .custom("PinyonScript-Regular", size: 72)
        }
        
        /// Top Navigation Logo (Pinyon Script)
        public static var logo: Font {
            .custom("PinyonScript-Regular", size: 40)
        }
        
        /// Standard headings (Plus Jakarta Sans)
        public static var heading: Font {
            .custom("PlusJakartaSans-Regular", size: 32)
        }
        
        /// Call to action blocks (Plus Jakarta Sans)
        public static var callToAction: Font {
            .custom("PlusJakartaSans-Regular", size: 28)
        }
        
        /// Elegant sans-serif for dates/subtitles (Plus Jakarta Sans)
        public static var subtitle: Font {
            .custom("PlusJakartaSans-Regular", size: 24)
        }
        
        /// Button text (Plus Jakarta Sans)
        public static var button: Font {
            .custom("PlusJakartaSans-Regular", size: 16)
        }
        
        /// Standard body text (Plus Jakarta Sans)
        public static var body: Font {
            .custom("PlusJakartaSans-Regular", size: 16)
        }
        
        /// Small labels / tab bar (Plus Jakarta Sans)
        public static var caption: Font {
            .custom("PlusJakartaSans-Regular", size: 12)
        }
    }
}
