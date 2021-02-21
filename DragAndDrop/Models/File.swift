import SwiftUI
import UniformTypeIdentifiers

struct File: Hashable, Codable, Draggable {

    var id = UUID()
    let name: String

    var jsonString: String {
        guard let data = try? JSONEncoder().encode(self) else { return "" }

        return String(data: data, encoding: .utf8) ?? ""
    }

    init(name: String) {
        self.name = name
    }
}

protocol Draggable {
    var jsonString: String { get }
}

extension Draggable {
    static var typeIdentifier: String { UTType.utf8PlainText.identifier }
}
