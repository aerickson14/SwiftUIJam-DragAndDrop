import Foundation

struct Folder: Identifiable, Hashable {
    let id = UUID()
    let name: String
    var files: [File]
}
