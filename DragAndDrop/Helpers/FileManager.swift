import Foundation

class FileManager: ObservableObject {

    static let shared = FileManager()

    @Published var folders: [Folder] = []

    private init() {
        // TEMP: example data
        self.folders = [
            Folder(
                name: "Animals",
                files: [
                    File(name: "🦁 Lion"),
                    File(name: "🐯 Tiger"),
                    File(name: "🐻 Bear")
                ]
            ),
            Folder(
                name: "Lions",
                files: []
            ),
            Folder(
                name: "Tigers",
                files: []
            ),
            Folder(
                name: "Bears",
                files: []
            )
        ]
    }

    func move(file: File, to folder: Folder) {
        print("moving file \(file.name) to \(folder.name)")
        if let previousFolder = self.folder(for: file) {
            remove(file: file, from: previousFolder)
        }
        add(file: file, to: folder)
    }

    func move(_ file: File, after afterFile: File) {
        guard
            var folder = folder(for: file),
            let fromIndex = folder.files.firstIndex(where: { $0.id == file.id }),
            let toIndex = folder.files.firstIndex(where: { $0.id == afterFile.id })
        else {
            print("unable to move \(file.name) after \(afterFile.name)")
            return
        }

        print("moving file \(file.name) after \(afterFile.name)")
        let toOffset = toIndex > fromIndex ? toIndex + 1 : toIndex
        folder.files.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: toOffset)

        updateFolder(folder)
    }

    private func add(file: File, to folder: Folder) {
        guard var folderToAddTo = folders.first(where: { $0 == folder }) else { return }
        print("adding \(file.name) to \(folder.name)")
        folderToAddTo.files.insert(file, at: 0)

        updateFolder(folderToAddTo)
    }

    private func remove(file: File, from folder: Folder) {
        guard
            var folderToRemoveFrom = folders.first(where: { $0 == folder }),
            let fileIndex = folderToRemoveFrom.files.firstIndex(where: { $0.id == file.id })
        else {
            print("unable to remove \(file.name) from \(folder.name)")
            return

        }
        print("removing \(file.name) from \(folder.name)")
        folderToRemoveFrom.files.remove(at: fileIndex)

        updateFolder(folderToRemoveFrom)
    }

    private func folder(for file: File) -> Folder? {
        let folder = folders.first(where: {
            let folderContainsFile = $0.files.contains(where: { $0.id == file.id })
            if folderContainsFile {
                print("\($0.name) contains \(file.name)")
            } else {
                print("\($0.name) does not contain \(file.name)")
                print("\($0.files.map { $0.name }.joined(separator: ", "))")
            }
            return folderContainsFile
        })
        if folder == nil {
            print("could not find folder for \(file.name)")
        }
        return folder
    }

    private func updateFolder(_ folder: Folder) {
        guard let folderIndex = folders.firstIndex(where: { $0.id == folder.id }) else {
            print("unable to update folder \(folder.name)")
            return
        }

        DispatchQueue.main.async {
            print("update folder \(folder.name)")
            self.folders[folderIndex] = folder
        }
    }
}
