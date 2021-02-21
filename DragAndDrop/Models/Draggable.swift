import Foundation

protocol Draggable {
    static var typeIdentifier: String { get }
    var jsonString: String { get }
}
