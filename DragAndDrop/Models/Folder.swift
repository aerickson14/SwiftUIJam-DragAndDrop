import Foundation

struct Folder: Hashable, Codable {
    let name: String
    var files: [File]

    mutating func remove(_ file: File) {
        guard let index = files.firstIndex(of: file) else { return }
        files.remove(at: index)
    }

    mutating func add(_ file: File) {
        files.insert(file, at: 0)
    }
}
