import SwiftUI
import UniformTypeIdentifiers

final class File: NSObject, Identifiable, Codable {

    static var droppableTypeIdentifiers = [UTType.fileURL.identifier]

    var id = UUID()
    let name: String

    init(name: String) {
        self.name = name
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
