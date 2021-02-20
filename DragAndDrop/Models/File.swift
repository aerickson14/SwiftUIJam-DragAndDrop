import SwiftUI
import UniformTypeIdentifiers

final class File: NSObject, Codable {

    static var droppableTypeIdentifiers = [UTType.fileURL.identifier]

    let name: String
    var folder: Folder?

    init(name: String) {
        self.name = name
    }

    func add(to folder: Folder) {
        self.folder = folder
    }
}

extension File: NSItemProviderWriting {
    static var writableTypeIdentifiersForItemProvider: [String] {
        [UTType.fileURL.identifier]
    }

    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        let progress = Progress(totalUnitCount: 1)

        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(self)
            progress.completedUnitCount = 1
            completionHandler(data, nil)
        } catch {
            completionHandler(nil, error)
        }

        return progress
    }
}

extension File: NSItemProviderReading {
    static var readableTypeIdentifiersForItemProvider: [String] {
        return [UTType.fileURL.identifier]
    }

    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> File {
        try JSONDecoder().decode(File.self, from: data)
    }
}
