import SwiftUI
import UniformTypeIdentifiers

struct Column: Hashable, Codable {
    let title: String
    let containers: [Container]
}

extension Column: Draggable {
    static var typeIdentifier: String = UTType.rtf.identifier
}

extension Column: DropTarget, DropDelegate {

    typealias DropObject = Column

    static var supportedDropTypes: [String] = [Column.typeIdentifier]

    func drop(object: Column) {
        Logger.log("Dropped \(object.title)")
    }
    
}
