import SwiftUI

struct CircleView: View {

    var body: some View {
        Circle()
            .foregroundColor(.blue)
            .frame(width: 100, height: 100)
    }
}

struct Circle_Previews: PreviewProvider {
    static var previews: some View {
        CircleView()
            .previewLayout(.sizeThatFits)
    }
}
