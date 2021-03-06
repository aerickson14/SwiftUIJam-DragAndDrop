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
        Logger.log("moving file \(file.name) to \(folder.name)")
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
            Logger.warn("unable to move \(file.name) after \(afterFile.name)")
            return
        }

        Logger.log("moving file \(file.name) after \(afterFile.name)")
        let toOffset = toIndex > fromIndex ? toIndex + 1 : toIndex
        folder.files.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: toOffset)

        updateFolder(folder)
    }

    private func add(file: File, to folder: Folder) {
        guard var folderToAddTo = folders.first(where: { $0 == folder }) else { return }
        Logger.log("adding \(file.name) to \(folder.name)")
        folderToAddTo.files.insert(file, at: 0)

        updateFolder(folderToAddTo)
    }

    private func remove(file: File, from folder: Folder) {
        guard
            var folderToRemoveFrom = folders.first(where: { $0 == folder }),
            let fileIndex = folderToRemoveFrom.files.firstIndex(where: { $0.id == file.id })
        else {
            Logger.error("unable to remove \(file.name) from \(folder.name)")
            return

        }
        Logger.log("removing \(file.name) from \(folder.name)")
        folderToRemoveFrom.files.remove(at: fileIndex)

        updateFolder(folderToRemoveFrom)
    }

    private func folder(for file: File) -> Folder? {
        guard let folder = folders.first(where: { $0.files.contains(where: { $0.id == file.id }) }) else {
            Logger.warn("could not find folder for \(file.name)")
            return nil
        }

        return folder
    }

    private func updateFolder(_ folder: Folder) {
        guard let folderIndex = folders.firstIndex(where: { $0.id == folder.id }) else {
            Logger.error("unable to update folder \(folder.name)")
            return
        }

        DispatchQueue.main.async {
            Logger.log("updating folder \(folder.name)")
            self.folders[folderIndex] = folder
        }
    }
}
