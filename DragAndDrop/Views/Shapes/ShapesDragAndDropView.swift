import SwiftUI
import UniformTypeIdentifiers

struct ShapesDragAndDropView: View {

    var body: some View {
        VStack(spacing: 32) {
            HStack(spacing: 32) {
                CircleView()
                    .onDrag({ NSItemProvider(item: CircleShape().jsonString as NSString, typeIdentifier: CircleShape.typeIdentifier) })
                    .onDrop(of: CircleDropTarget.supportedDropTypes, delegate: CircleDropTarget())
                SquareView()
                    .onDrag({ NSItemProvider(item: SquareShape().jsonString as NSString, typeIdentifier: SquareShape.typeIdentifier) })
                    .onDrop(of: SquareDropTarget.supportedDropTypes, delegate: SquareDropTarget())
                StarView()
                    .onDrag({ NSItemProvider(item: StarShape().jsonString as NSString, typeIdentifier: StarShape.typeIdentifier) })
                    .onDrop(of: StarDropTarget.supportedDropTypes, delegate: StarDropTarget())
            }
            HStack(spacing: 32) {
                TriangleView()
                    .onDrag({ NSItemProvider(item: TriangleShape().jsonString as NSString, typeIdentifier: TriangleShape.typeIdentifier) })
                    .onDrop(of: TriangleDropTarget.supportedDropTypes, delegate: TriangleDropTarget())
                ArchView()
                    .onDrag({ NSItemProvider(item: ArchShape().jsonString as NSString, typeIdentifier: ArchShape.typeIdentifier) })
                    .onDrop(of: ArchDropTarget.supportedDropTypes, delegate: ArchDropTarget())
            }
        }
        .padding()
    }
}

struct CircleShape: Draggable, Codable {
    static var typeIdentifier: String { UTType.plainText.identifier } // FIXME: why do typeIdentifiers only work with UTType and not custom strings?
}

struct SquareShape: Draggable, Codable {
    static var typeIdentifier: String { UTType.mp3.identifier }

}

struct TriangleShape: Draggable, Codable {
    static var typeIdentifier: String { UTType.mpeg2Video.identifier }

}

struct ArchShape: Draggable, Codable {
    static var typeIdentifier: String { UTType.application.identifier }
}

struct StarShape: Draggable, Codable {
    static var typeIdentifier: String { UTType.bookmark.identifier }
}


struct CircleDropTarget: DropTarget, DropDelegate {

    typealias DropObject = CircleShape

    static var supportedDropTypes: [String] = [CircleShape.typeIdentifier, StarShape.typeIdentifier]
}

struct SquareDropTarget: DropTarget, DropDelegate {

    typealias DropObject = SquareShape

    static var supportedDropTypes: [String] = [CircleShape.typeIdentifier, SquareShape.typeIdentifier, TriangleShape.typeIdentifier, ArchShape.typeIdentifier, StarShape.typeIdentifier]
}

struct TriangleDropTarget: DropTarget, DropDelegate {

    typealias DropObject = TriangleShape

    static var supportedDropTypes: [String] = [TriangleShape.typeIdentifier]
}

struct ArchDropTarget: DropTarget, DropDelegate {

    typealias DropObject = ArchShape

    static var supportedDropTypes: [String] = []
}

struct StarDropTarget: DropTarget, DropDelegate {

    typealias DropObject = StarShape

    static var supportedDropTypes: [String] = []
}

struct ShapesDragAndDropView_Previews: PreviewProvider {
    static var previews: some View {
        ShapesDragAndDropView()
            .previewLayout(.sizeThatFits)
    }
}
