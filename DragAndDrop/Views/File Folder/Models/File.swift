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

struct FileDropTarget: DropTarget, DropDelegate {
    typealias DropObject = File

    var supportedDropTypes = [File.typeIdentifier]

    let target: File

    func drop(object: File) {
        FileManager.shared.move(object, after: target)
    }
}
