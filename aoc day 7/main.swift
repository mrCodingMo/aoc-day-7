import Foundation

func loadData() -> String{
    do {
        return try String(contentsOfFile: "/Users/moritzdiedenhofen/Documents/Daten/input.txt")
    } catch {
        return ""
    }
}

let data = loadData().split(separator: ",").map { Int($0) ?? 0 }
var primes = calculatePrimes()

let cleanedData = data.filter {!primes.contains($0) && !(0...1).contains($0)}.sorted()
let dividers = getDivider()
let smallestDivider = getSmallesDivider()
let usedFuel = calculateUsedFule()

print("total used fuel: \(usedFuel)")

func calculateUsedFule() -> Int {
    
    var fuel = 0
    
    for i in data.indices {
        
        let startPoint = data[i]
        var usedFuel = 0
        
        if (startPoint > smallestDivider) {
            usedFuel = (startPoint - smallestDivider)
        } else {
            usedFuel = (smallestDivider - startPoint)
        }
        
        fuel += usedFuel
    }
    
    return fuel
}

func getSmallesDivider() -> Int {
    
    let dic = Dictionary(grouping: dividers) {$0}
    
    var divider = 0
    
    for key in dic.keys {
        let num = dic[key]![0]
        
        if divider == 0 || num < divider {
            divider = num
            
        }
    }
    
    return divider
}

func getDivider() -> [Int] {
    var dividers = [Int]()
    
    for i in cleanedData.indices{
        dividers.append(contentsOf: calculateDivider(value: cleanedData[i]))
    }
    return dividers
}

func calculateDivider(value: Int) -> [Int]  {
    
    var divider = [Int]()
    
    for i in 2...value {
        if value % i == 0 {
            divider.append(i)
        }
    }
    
    return divider
}

func calculatePrimes() -> [Int] {
    
    var numbers = [Int]()
    
    for i in data {
       
        if isPrime(value: i) && !numbers.contains(i){
            numbers.append(i)
        }
    }
    return numbers
}

func isPrime(value: Int) -> Bool {
    
    if (0...1).contains(value) {return false}
    if (2...3).contains(value) {return true}
    
    for i in 2 ... Int(sqrt(Double(value))) {
        if value % i == 0 {return false}
    }
    
    return true
    
}
