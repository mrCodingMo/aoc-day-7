import Foundation

func loadData() -> String{
    do {
        return try String(contentsOfFile: "/Users/moritzdiedenhofen/Documents/Daten/input.txt")
    } catch {
        return ""
    }
}

