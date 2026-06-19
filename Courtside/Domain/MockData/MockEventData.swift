import Foundation

let allEventsData: [EventSection] = [
    EventSection(title: "THIS WEEK", events: [
        EventItem(
            day: "20", month: "JUN", title: "Summer Solstice Mixer", time: "7:00 PM", location: "The Lounge", isFeatured: false,
            fullDate: "FRIDAY, JUNE 20 AT 7:00 PM",
            description: "Celebrate the longest day of the year with our signature matcha cocktails, curated small plates, and live acoustic music. A perfect evening to mingle with fellow members as the sun sets over the courts.",
            host: "The Optimist Cafe", skillLevel: "All Levels", capacity: "50 Spots", price: "Free for Members"
        ),
        EventItem(
            day: "21", month: "JUN", title: "Pro Exhibition Match", time: "5:00 PM", location: "Center Court", isFeatured: false,
            fullDate: "SATURDAY, JUNE 21 AT 5:00 PM",
            description: "Experience world-class tennis right here at home. Watch top-ranked local pros battle it out in a high-stakes exhibition match. VIP courtside seating includes champagne and canapés.",
            host: "Courtside Athletics", skillLevel: "Spectator", capacity: "200 Spots", price: "₹1,500"
        ),
        EventItem(
            day: "22", month: "JUN", title: "Sunday Recovery Flow", time: "8:00 AM", location: "Wellness Studio", isFeatured: false,
            fullDate: "SUNDAY, JUNE 22 AT 8:00 AM",
            description: "A 60-minute athletic yoga sequence designed specifically for padel and tennis players. Focus on mobility, deep fascial stretching, and breathwork to accelerate your post-match recovery.",
            host: "Dr. Elena Rostova", skillLevel: "All Levels", capacity: "15 Spots", price: "₹800"
        )
    ]),
    EventSection(title: "UPCOMING HIGHLIGHTS", events: [
        EventItem(
            day: "28", month: "JUN", title: "The Optimist Summer Gala", time: "8:00 PM", location: "Main Clubhouse", isFeatured: true,
            fullDate: "SATURDAY, JUNE 28 AT 8:00 PM",
            description: "Our highly anticipated annual black-tie event. An evening of uncompromised luxury featuring a five-course tasting menu, an open premium bar, and a live jazz orchestra under the stars.",
            host: "The Board of Directors", skillLevel: "All Levels", capacity: "120 Spots", price: "₹15,000"
        ),
        EventItem(
            day: "04", month: "JUL", title: "Courtside Wine Tasting", time: "6:30 PM", location: "The Lounge", isFeatured: false,
            fullDate: "THURSDAY, JULY 4 AT 6:30 PM",
            description: "Join our resident sommelier for an exclusive journey through the vineyards of Tuscany. Includes tasting flights of 5 premium Italian wines perfectly paired with artisanal cheeses and truffles.",
            host: "Sommelier Marco Rossi", skillLevel: "All Levels", capacity: "24 Spots", price: "₹3,500"
        ),
        EventItem(
            day: "12", month: "JUL", title: "Members' Mixed Doubles", time: "9:00 AM", location: "Courts 1-4", isFeatured: false,
            fullDate: "SUNDAY, JULY 12 AT 9:00 AM",
            description: "Our signature monthly tournament. Grab a partner and compete in a round-robin style mixed doubles event. The morning concludes with an awards brunch at The Optimist.",
            host: "Head Coach Marcus", skillLevel: "Intermediate+", capacity: "32 Teams", price: "₹2,000 / Team"
        ),
        EventItem(
            day: "18", month: "JUL", title: "Friday Night DJ Sessions", time: "8:00 PM", location: "Courtside Bar", isFeatured: false,
            fullDate: "FRIDAY, JULY 18 AT 8:00 PM",
            description: "Trade your sweatbands for something sleek. Transition from the courts to the club with live DJ sets, curated cocktails, and an electric atmosphere to kick off your weekend.",
            host: "DJ AURA", skillLevel: "All Levels", capacity: "80 Spots", price: "Free Entry"
        )
    ]),
    EventSection(title: "CLINICS & WELLNESS", events: [
        EventItem(
            day: "25", month: "JUL", title: "Beginner's Masterclass", time: "10:00 AM", location: "Court 2", isFeatured: false,
            fullDate: "SATURDAY, JULY 25 AT 10:00 AM",
            description: "Never held a racket? No problem. This 90-minute intensive breaks down the absolute fundamentals of grip, stance, and swing mechanics in a highly supportive, low-pressure environment.",
            host: "Coach Sarah Jenkins", skillLevel: "Beginner", capacity: "8 Spots", price: "₹1,200"
        ),
        EventItem(
            day: "26", month: "JUL", title: "Breathwork & Cold Plunge", time: "7:00 AM", location: "Recovery Deck", isFeatured: false,
            fullDate: "SUNDAY, JULY 26 AT 7:00 AM",
            description: "Master your nervous system. A guided 30-minute Wim Hof style breathwork session followed by a structured 3-minute plunge in our state-of-the-art ice baths. Breakfast included.",
            host: "Coach David Chen", skillLevel: "All Levels", capacity: "12 Spots", price: "₹1,000"
        ),
        EventItem(
            day: "02", month: "AUG", title: "Matcha Tasting & Networking", time: "11:00 AM", location: "The Lounge", isFeatured: false,
            fullDate: "SUNDAY, AUGUST 2 AT 11:00 AM",
            description: "A serene morning learning the ancient art of preparing ceremonial grade Uji matcha. Connect with fellow members and entrepreneurs while enjoying exclusive, off-menu matcha creations.",
            host: "The Optimist Cafe", skillLevel: "All Levels", capacity: "20 Spots", price: "₹800"
        ),
        EventItem(
            day: "09", month: "AUG", title: "Advanced Tactics Clinic", time: "4:00 PM", location: "Center Court", isFeatured: false,
            fullDate: "SUNDAY, AUGUST 9 AT 4:00 PM",
            description: "An elite clinic strictly for advanced players. Focus on high-percentage shot selection, transitional footwork, and aggressive net play strategies used on the professional tour.",
            host: "Head Coach Marcus", skillLevel: "Advanced", capacity: "6 Spots", price: "₹2,500"
        )
    ])
]
