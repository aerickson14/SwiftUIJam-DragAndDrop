import SwiftUI
import UniformTypeIdentifiers

struct File: Hashable, Codable, Draggable {

    static var typeIdentifier: String { UTType.utf8PlainText.identifier }

    var id = UUID()
    let name: String

    init(name: String) {
        self.name = name
    }
}

struct FileDropTarget: DropTarget, DropDelegate {
    typealias DropObject = File

    static var supportedDropTypes = [File.typeIdentifier]

    let target: File

    func drop(object: File) {
        FileManager.shared.move(object, after: target)
    }
}
