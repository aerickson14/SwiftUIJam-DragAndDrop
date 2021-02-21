import SwiftUI

struct FolderView: View {
    @State private var folder: Folder

    init(folder: Folder) {
        self._folder = State(initialValue: folder)
    }

    var body: some View {
        VStack {
            headerView
                .onDrop(of: FolderDropTarget.supportedDropTypes, delegate: FolderDropTarget(target: folder))
            filesView
        }
    }

    var filesView: some View {
        ForEach(folder.files, id: \.self) { file in
            FileView(fileName: file.name)
                .onDrag({ NSItemProvider(object: file.jsonString as NSString) })
                .onDrop(of: FileDropTarget.supportedDropTypes, delegate: FileDropTarget(target: file))
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

struct FolderView_Previews: PreviewProvider {
    static let files = (1...3).map { File(name: "file\($0).txt") }
    static let folder = Folder(name: "Folder 1", files: files)

    static var previews: some View {
        FolderView(folder: folder)
            .previewLayout(.sizeThatFits)
    }
}
