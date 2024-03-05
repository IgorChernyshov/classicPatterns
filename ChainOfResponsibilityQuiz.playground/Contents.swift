import UIKit

func data(from file: String) -> Data {
    let path1 = Bundle.main.path(forResource: file, ofType: "json")!
    let url = URL(fileURLWithPath: path1)
    let data = try! Data(contentsOf: url)
    return data
}

let data1 = data(from: "1")
let data2 = data(from: "2")
let data3 = data(from: "3")

// Data models

struct Employee: Codable {
  let name: String
  let age: Int
  let isDeveloper: Bool
}

struct JSONResponseWithData: Codable {
  let data: [Employee]
}

struct JSONResponseWithResult: Codable {
  let result: [Employee]
}

// Data parsers

protocol DataParser: AnyObject {
  var next: DataParser? { get set }
  func parse(data: Data) -> [Employee]
}

class PlainArrayParser: DataParser {
  
  var next: DataParser?
  
  func parse(data: Data) -> [Employee] {
    let decoder = JSONDecoder()
    return (try? decoder.decode([Employee].self, from: data)) ?? next?.parse(data: data) ?? []
  }
  
}

class DataWrappedArrayParser: DataParser {
  
  var next: DataParser?
  
  func parse(data: Data) -> [Employee] {
    let decoder = JSONDecoder()
    return (try? decoder.decode(JSONResponseWithData.self, from: data).data) ?? next?.parse(data: data) ?? []
  }
  
}

class ResultWrappedArrayParser: DataParser {
  
  var next: DataParser?
  
  func parse(data: Data) -> [Employee] {
    let decoder = JSONDecoder()
    return (try? decoder.decode(JSONResponseWithResult.self, from: data).result) ?? next?.parse(data: data) ?? []
  }
  
}

// Create parsers

let plainArrayParser = PlainArrayParser()
let dataWrappedArrayParser = DataWrappedArrayParser()
let resultWrappedArrayParser = ResultWrappedArrayParser()
let dataParser: DataParser = plainArrayParser

// Apply chain-of-responisibility pattern

plainArrayParser.next = dataWrappedArrayParser
dataWrappedArrayParser.next = resultWrappedArrayParser

// Print results

print("Parse data1: \(dataParser.parse(data: data1))")
print("Parse data2: \(dataParser.parse(data: data2))")
print("Parse data3: \(dataParser.parse(data: data3))")
