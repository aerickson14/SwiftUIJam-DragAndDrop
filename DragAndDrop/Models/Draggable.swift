import Foundation

protocol Draggable {
    static var typeIdentifier: String { get }
    var jsonString: String { get }
}

extension Draggable where Self: Codable {

    var jsonString: String {
        guard let data = try? JSONEncoder().encode(self) else { return "" }

        return String(data: data, encoding: .utf8) ?? ""
    }
}
