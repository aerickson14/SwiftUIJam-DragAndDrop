import UniformTypeIdentifiers
import Foundation


protocol Draggable {
    var jsonString: String { get }
}

extension Draggable {
    static var typeIdentifier: String { UTType.utf8PlainText.identifier }
}
