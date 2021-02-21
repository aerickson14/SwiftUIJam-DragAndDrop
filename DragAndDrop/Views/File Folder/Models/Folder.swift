import SwiftUI

struct Folder: Identifiable, Hashable {
    let id = UUID()
    let name: String
    var files: [File]
}

struct FolderDropTarget: DropTarget, DropDelegate {

    typealias DropObject = File

    static var supportedDropTypes: [String] = [File.typeIdentifier]
    let target: Folder

    func drop(object: File) {
        FileManager.shared.move(file: object, to: target)
    }
}
