import SwiftUI
import UniformTypeIdentifiers
import Foundation

struct ContentView: View {

    @ObservedObject var fileManager: FileManager

    init() {
        self.fileManager = FileManager.shared
    }

    var body: some View {
        VStack(spacing: 0) {
            ForEach(fileManager.folders, id: \.self) { folder in
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
