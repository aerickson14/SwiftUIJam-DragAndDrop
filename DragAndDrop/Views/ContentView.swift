import SwiftUI
import UniformTypeIdentifiers
import Foundation

struct ContentView: View {

    @State private var folders: [Folder]

    init() {
        let folders: [Folder] = (1...3).map {
            let files = (1...3).map { File(name: "file\($0).txt") }
            return Folder(name: "Folder \($0)", files: files)
        }
        self._folders = State(initialValue: folders)
    }

    var body: some View {
        VStack(spacing: 0) {
            ForEach(folders, id: \.self) { folder in
                FolderView(folder: folder)
            }
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.sizeThatFits)
    }
}
