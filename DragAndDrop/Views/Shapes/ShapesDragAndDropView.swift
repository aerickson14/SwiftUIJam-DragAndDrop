import SwiftUI

struct ShapesDragAndDropView: View {

    var body: some View {
        VStack(spacing: 32) {
            HStack(spacing: 32) {
                CircleView()
                    .onDrag({ NSItemProvider(object: "Circle" as NSString) })
//                    .onDrop(of: ["Circle"], delegate: CircleDropDelegate())
                SquareView()
                    .onDrag({ NSItemProvider(object: "Square" as NSString) })
            }
            HStack(spacing: 32) {
                TriangleView()
                    .onDrag({ NSItemProvider(object: "Triangle" as NSString) })
            }
        }
        .padding()
    }
}


//struct CircleDropTarget: DropTarget, DropDelegate {
//    typealias DropObject = Circle
//
//
//    func drop(file: File) {
//
//    }
//}

struct ShapesDragAndDropView_Previews: PreviewProvider {
    static var previews: some View {
        ShapesDragAndDropView()
            .previewLayout(.sizeThatFits)
    }
}
