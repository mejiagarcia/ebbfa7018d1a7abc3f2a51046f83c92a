/**
 Carlos: Why you didn't create a Date extension for this?
 Answer: We don't need it, since we are using this only once.
 */

import Foundation

struct Dates {
    static func dateToString(date: Date, style: DateFormatter.Style) -> String {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = style
        
        return formatter1.string(from: date)
    }
}
