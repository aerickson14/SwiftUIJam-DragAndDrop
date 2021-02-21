import SwiftUI

struct FolderView: View {
    @State private var folder: Folder

    init(folder: Folder) {
        self._folder = State(initialValue: folder)
    }

    var body: some View {
        VStack {
            headerView
                .onDrop(of: File.droppableTypeIdentifiers, delegate: FolderDropTarget(target: folder))
            filesView
        }
    }

    var filesView: some View {
        ForEach(folder.files, id: \.self) { file in
            FileView(fileName: file.name)
                .onDrag({ NSItemProvider(object: file) })
                .onDrop(of: File.droppableTypeIdentifiers, delegate: FileDropTarget(target: file))
        }
        .padding(.leading, 8)
    }

    var headerView: some View {
        HStack {
            Image(systemName: "folder.fill")
                .foregroundColor(Color("FolderColor"))
            Text(folder.name)
            Spacer()
        }
        .padding(4)
    }
}

protocol DropTarget {
    func drop(file: File)
}

extension DropTarget {

    func performDrop(info: DropInfo) -> Bool {
        print("peformDrop")
        fetchFile(from: info, onComplete: { file in
            guard let file = file else { return }
            drop(file: file)
        })
        return true
    }

    private func fetchFile(from info: DropInfo, onComplete: @escaping (File?) -> Void) {
        guard info.hasItemsConforming(to: File.droppableTypeIdentifiers) else {
            print("no items found")
            onComplete(nil)
            return
        }

        let itemProviders = info.itemProviders(for: File.droppableTypeIdentifiers)
        for itemProvider in itemProviders {
            print("itemProvider")

            _ = itemProvider.loadObject(ofClass: File.self) { file, error in
                guard error == nil else {
                    print("Error: \(error?.localizedDescription ?? "")")
                    return
                }
                print("loadObject successful")
                guard let file = file as? File else {
                    print("unable to find file")
                    onComplete(nil)
                    return
                }
                print("file found")
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

struct FolderView_Previews: PreviewProvider {
    static let files = (1...3).map { File(name: "file\($0).txt") }
    static let folder = Folder(name: "Folder 1", files: files)

    static var previews: some View {
        FolderView(folder: folder)
            .previewLayout(.sizeThatFits)
    }
}
