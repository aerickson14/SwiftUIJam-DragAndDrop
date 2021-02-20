import SwiftUI

struct FolderView: View {
    @State private var folder: Folder
    @State private var fileBeingDragged: File? {
        didSet {
            print("didSet fileBeingDragged: nil? \(fileBeingDragged == nil)")
        }
    }

    init(folder: Folder) {
        self._folder = State(initialValue: folder)
    }

    var body: some View {
        VStack {
            headerView
                .onDrop(of: File.droppableTypeIdentifiers, delegate: FolderDropDelegate(folder: $folder))
            filesView
        }
    }

    // TODO: will the drop logic work on DisclosureGroup?
    var disclosureGroup: some View {
        DisclosureGroup(
            content: {
                filesView
            },
            label: { headerView }
        )
        .onDrop(of: File.droppableTypeIdentifiers, delegate: FolderDropDelegate(folder: $folder))
    }

    var filesView: some View {
        ForEach(folder.files, id: \.self) { file in
            FileView(fileName: file.name)
                .onDrag({
                    self.fileBeingDragged = file
                    print("File being dragged: \(file.name)")
                    return NSItemProvider(object: file)
                })
                .onDrop(
                    of: File.droppableTypeIdentifiers,
                    delegate: FileDropDelegate(dragging: $fileBeingDragged, in: $folder, over: file)
                )
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

struct FolderDropDelegate: DropDelegate {

    @Binding var folder: Folder

    init(folder: Binding<Folder>) {
        self._folder = folder
    }

    func dropEntered(info: DropInfo) {
        print("folder dropEntered")

        // objects will not be able to be loaded/found at this point
        //moveFileToFolder(using: info)
    }

    func validateDrop(info: DropInfo) -> Bool {
        print("validateDrop")
        return true
    }

    func dropExited(info: DropInfo) {
        print("dropExited")
    }

    func dropUpdated(info: DropInfo) -> DropProposal? {
        //print("dropUpdated")
        return DropProposal(operation: .move)
    }

    func performDrop(info: DropInfo) -> Bool {
        print("peformDrop")
        moveFileToFolder(using: info)
        return true
    }

    private func moveFileToFolder(using info: DropInfo) {
        guard info.hasItemsConforming(to: File.droppableTypeIdentifiers) else {
            print("no items found")
            return
        }

        let itemProviders = info.itemProviders(for: File.droppableTypeIdentifiers)
        for itemProvider in itemProviders {
            print("itemProvider")

            // FIXME: loadObject never calls the completion handler
            _ = itemProvider.loadObject(ofClass: File.self) { file, error in
                guard error == nil else {
                    print("Error: \(error?.localizedDescription ?? "")")
                    return
                }
                print("loadObject successful")
                guard let file = file as? File else { return }
                print("file found")

                FileManager.shared.move(file: file, to: folder)
            }
        }
    }
}

struct FileDropDelegate: DropDelegate {
    @Binding var fileBeingDragged: File?
    @Binding var folder: Folder
    let fileOverTopOf: File

    init(dragging fileBeingDragged: Binding<File?>, in folder: Binding<Folder>, over fileOverTopOf: File) {
        self._fileBeingDragged = fileBeingDragged
        self._folder = folder
        self.fileOverTopOf = fileOverTopOf
    }

    func dropEntered(info: DropInfo) {
        print("file dropEntered")
        guard
            let fileBeingDragged = fileBeingDragged,
            fileBeingDragged != fileOverTopOf
        else { return }

        FileManager.shared.move(fileBeingDragged, after: fileOverTopOf)
    }

    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }

    func performDrop(info: DropInfo) -> Bool {
        self.fileBeingDragged = nil
        return true
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
