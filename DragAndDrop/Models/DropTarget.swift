import SwiftUI

protocol DropTarget {
    func drop(file: File)
}

extension DropTarget {

    func performDrop(info: DropInfo) -> Bool {
        Logger.log("peformDrop")
        fetchFile(from: info, onComplete: { file in
            guard let file = file else { return }
            drop(file: file)
        })
        return true
    }

    private func fetchFile(from info: DropInfo, onComplete: @escaping (File?) -> Void) {
        guard info.hasItemsConforming(to: File.droppableTypeIdentifiers) else {
            Logger.warn("no items found")
            onComplete(nil)
            return
        }

        let itemProviders = info.itemProviders(for: File.droppableTypeIdentifiers)
        for itemProvider in itemProviders {
            _ = itemProvider.loadObject(ofClass: File.self) { file, error in
                if let error = error {
                    Logger.error(error.localizedDescription)
                    return
                }
                Logger.log("loadObject successful")
                guard let file = file as? File else {
                    Logger.error("unable to find file")
                    onComplete(nil)
                    return
                }
                Logger.log("file found")
                onComplete(file)
            }
        }
    }
}

struct FolderDropTarget: DropTarget, DropDelegate {

    let target: Folder

    func drop(file: File) {
        FileManager.shared.move(file: file, to: target)
    }
}

struct FileDropTarget: DropTarget, DropDelegate {

    let target: File

    func drop(file: File) {
        FileManager.shared.move(file, after: target)
    }
}
