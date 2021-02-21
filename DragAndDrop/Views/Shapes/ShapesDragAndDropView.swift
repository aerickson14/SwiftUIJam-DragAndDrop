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
            }
            HStack(spacing: 32) {
                TriangleView()
                    .onDrag({ NSItemProvider(item: TriangleShape().jsonString as NSString, typeIdentifier: TriangleShape.typeIdentifier) })
                    .onDrop(of: TriangleDropTarget.supportedDropTypes, delegate: TriangleDropTarget())
            }
        }
        .padding()
    }
}

struct CircleShape: Draggable, Codable {
    static var typeIdentifier: String { UTType.plainText.identifier } // FIXME: why do typeIdentifiers only work with UTType and not custom strings?

    var jsonString: String {
        guard let data = try? JSONEncoder().encode(self) else { return "" }

        return String(data: data, encoding: .utf8) ?? ""
    }
}

struct SquareShape: Draggable, Codable {
    static var typeIdentifier: String { UTType.mp3.identifier }

    var jsonString: String {
        guard let data = try? JSONEncoder().encode(self) else { return "" }

        return String(data: data, encoding: .utf8) ?? ""
    }
}

struct TriangleShape: Draggable, Codable {
    static var typeIdentifier: String { UTType.mpeg2Video.identifier }

    var jsonString: String {
        guard let data = try? JSONEncoder().encode(self) else { return "" }

        return String(data: data, encoding: .utf8) ?? ""
    }
}


struct CircleDropTarget: DropTarget, DropDelegate {

    typealias DropObject = CircleShape

    static var supportedDropTypes: [String] = [CircleShape.typeIdentifier]
}

struct SquareDropTarget: DropTarget, DropDelegate {

    typealias DropObject = SquareShape

    static var supportedDropTypes: [String] = [CircleShape.typeIdentifier, SquareShape.typeIdentifier, TriangleShape.typeIdentifier]
}

struct TriangleDropTarget: DropTarget, DropDelegate {

    typealias DropObject = TriangleShape

    static var supportedDropTypes: [String] = [TriangleShape.typeIdentifier]
}

struct ShapesDragAndDropView_Previews: PreviewProvider {
    static var previews: some View {
        ShapesDragAndDropView()
            .previewLayout(.sizeThatFits)
    }
}
