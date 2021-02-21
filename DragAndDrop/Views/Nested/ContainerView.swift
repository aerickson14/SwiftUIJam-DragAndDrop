import SwiftUI

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
