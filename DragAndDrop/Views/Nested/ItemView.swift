import SwiftUI

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
