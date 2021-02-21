import SwiftUI

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
