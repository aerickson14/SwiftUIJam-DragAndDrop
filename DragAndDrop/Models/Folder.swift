import Foundation

struct Folder: Identifiable, Hashable, Codable {
    var id = UUID() // TODO: var because Xcode complains about decoding, but this shouldnt be able to change
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
