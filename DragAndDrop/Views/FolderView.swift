import SwiftUI

struct FolderView: View {
    @State private var folder: Folder
    @State private var fileBeingDragged: File?

    init(folder: Folder) {
        self._folder = State(initialValue: folder)
    }

    var body: some View {
        DisclosureGroup(
            content: {
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
            },
            label: { headerView
                .onDrop(of: File.droppableTypeIdentifiers, delegate: FolderDropDelegate(dragging: $fileBeingDragged, to: $folder)) }
        )
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

    @Binding var fileBeingDragged: File?
    @Binding var folder: Folder

    init(dragging fileBeingDragged: Binding<File?>, to folder: Binding<Folder>) {
        self._fileBeingDragged = fileBeingDragged
        self._folder = folder
    }

    func dropEntered(info: DropInfo) {
        print("dropEntered")
        guard
            let file = fileBeingDragged,
            var previousFolder = file.folder
        else {
            print("No file being dragged")
            return
        }
        previousFolder.remove(file)
        folder.add(file)
//        guard info.hasItemsConforming(to: File.droppableTypeIdentifiers) else {
//            print("no items found")
//            return
//        }
//
//        let itemProviders = info.itemProviders(for: File.droppableTypeIdentifiers)
//        for itemProvider in itemProviders {
//            print("itemProvider")
//            _ = itemProvider.loadObject(ofClass: File.self) { file, _ in
//                print("loadObject")
//                guard let file = file as? File else { return }
//
//                DispatchQueue.main.async {
//                    print("Inserting file \(file.name) into folder \(folder.name)")
//                    folder.add(file)
//                }
//            }
//        }
    }

    func performDrop(info: DropInfo) -> Bool {
        print("peformDrop")

        return true
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
        guard
            let fileBeingDragged = fileBeingDragged,
            fileBeingDragged != fileOverTopOf,
            let fromIndex = folder.files.firstIndex(of: fileOverTopOf),
            let toIndex = folder.files.firstIndex(of: fileBeingDragged)
        else { return }

        guard folder.files[toIndex].name != fileOverTopOf.name else { return }

        folder.files.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: toIndex > fromIndex ? toIndex + 1 : toIndex)
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
    static let folder = Folder(name: "Folder 1", files: [])

    static var previews: some View {
        FolderView(folder: folder)
            .previewLayout(.sizeThatFits)
    }
}
