import SwiftUI
import UniformTypeIdentifiers
import Foundation

struct ContentView: View {

    @ObservedObject var fileManager: FileManager

    var showOhMy: Bool {
        fileManager.isSortedProperly()
    }

    init() {
        self.fileManager = FileManager.shared
    }

    var body: some View {
        VStack(spacing: 0) {
            ForEach(fileManager.folders, id: \.self) { folder in
                FolderView(folder: folder)
            }
            if showOhMy {
                VStack(alignment: .center) {
                    Text("Oh my! 😱")
                        .font(.title)
                        .fontWeight(.bold)
                }
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
