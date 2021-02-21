import SwiftUI
import UniformTypeIdentifiers
import Foundation

struct ContentView: View {

    var body: some View {
        NavigationView {
            List {
                NavigationLink("Files and Folders", destination: FileDragAndDropView())
                NavigationLink("Shapes", destination: ShapesDragAndDropView())
                NavigationLink("Nested Containers", destination: NestedDragAndDropView())
            }
            .navigationTitle("SwiftUI Drag and Drop")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.sizeThatFits)
    }
}
