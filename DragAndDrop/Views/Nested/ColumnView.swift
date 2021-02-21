import SwiftUI

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
