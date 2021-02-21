import SwiftUI

struct NestedDragAndDropView: View {

    let columns: [Column] = [
        Column(
            title: "Column 1",
            containers: [
                Container(name: "Container 1", items: ["Item 1", "Item 2", "Item 3"]),
                Container(name: "Container 2", items: ["Item 4", "Item 5"]),
                Container(name: "Container 3", items: ["Item 6", "Item 7", "Item 8"])
            ]
        ),
        Column(
            title: "Column 2",
            containers: [
                Container(name: "Container 4", items: ["Item 9", "Item 10", "Item 1"]),
                Container(name: "Container 5", items: ["Item 12", "Item 13"])
            ]
        )
    ]

    var body: some View {
        HStack {
            ForEach(columns, id: \.self) { column in
                ColumnView(title: column.title, containers: column.containers)
            }
        }
        .padding()
    }
}

struct Column: Hashable {
    let title: String
    let containers: [Container]
}

struct Container: Hashable {
    let name: String
    let items: [String]
}

struct ColumnView: View {

    let title: String
    let containers: [Container]

    var body: some View {
        VStack(spacing: 8) {
            ForEach(containers, id: \.self) { container in
                ContainerView(name: container.name, items: container.items)
            }
            Spacer()
        }
        .background(Color.gray)
        .cornerRadius(8)
        .onDrag ({ NSItemProvider(object: title as NSString) })
    }
}

struct ContainerView: View {

    let name: String
    let items: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ContainerHeaderView(name: name)
            VStack(spacing: 0) {
                ForEach(items, id: \.self) { item in
                    ItemView(name: item)
                }
            }
        }
        .cornerRadius(8)
        .padding()
        .onDrag ({ NSItemProvider(object: name as NSString) })
    }
}

struct ContainerHeaderView: View {

    let name: String

    var body: some View {
        HStack {
            Text(name)
                .fontWeight(.semibold)
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.2))
    }
}

struct ItemView: View {

    let name: String

    var body: some View {
        HStack {
            Text(name)
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.4))
        .onDrag ({ NSItemProvider(object: name as NSString) })
    }
}

struct NestedDragAndDropView_Previews: PreviewProvider {
    static var previews: some View {
        NestedDragAndDropView()
            .previewLayout(.sizeThatFits)
    }
}
