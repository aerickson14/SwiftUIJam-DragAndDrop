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
        guard info.hasItemsConforming(to: [File.typeIdentifier]) else {
            Logger.warn("no items found")
            onComplete(nil)
            return
        }

        let itemProviders = info.itemProviders(for: [File.typeIdentifier])
        for itemProvider in itemProviders {
            _ = itemProvider.loadObject(ofClass: NSString.self) { nsString, error in
                if let error = error {
                    Logger.error(error.localizedDescription)
                    return
                }
                Logger.log("loadObject successful")
                guard let jsonString = nsString as? String else {
                    Logger.error("unable to find file jsonString")
                    onComplete(nil)
                    return
                }
                Logger.log("file json found")
                let file = decode(jsonString)
                onComplete(file)
            }
        }
    }

    private func decode(_ string: String) -> File? {
        guard let data = string.data(using: .utf8) else { return nil }

        return try? JSONDecoder().decode(File.self, from: data)
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
