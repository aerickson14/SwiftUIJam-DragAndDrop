import SwiftUI

struct ColumnView: View {

    let column: Column

    var hasContainers: Bool {
        !column.containers.isEmpty
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                HStack {
                    Spacer()
                    Text(column.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(8)
                if hasContainers {
                    ForEach(column.containers, id: \.self) { container in
                        ContainerView(name: container.name, items: container.items)
                    }
                } else {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: 100)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
            .background(Color.gray)
            .cornerRadius(8)
            .onDrag ({ NSItemProvider(object: column.title as NSString) })
            .onDrop(of: Column.supportedDropTypes, delegate: column)
        }
        .frame(width: 250)
    }
}

struct ColumnView_Previews: PreviewProvider {

    static var containers: [Container] = [
        Container(name: "Container 1", items: ["Item 1"]),
        Container(name: "Container 2", items: ["Item 1"])
    ]
    static var column = Column(title: "Column Title", containers: containers)
    static var emptyColumn = Column(title: "Empty Column", containers: [])

    static var previews: some View {
        ColumnView(column: column)
            .previewLayout(.sizeThatFits)

        ColumnView(column: emptyColumn)
            .previewLayout(.sizeThatFits)

    }
}
