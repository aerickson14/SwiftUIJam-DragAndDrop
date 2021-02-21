import SwiftUI

struct SquareView: View {

    var body: some View {
        Rectangle()
            .foregroundColor(.red)
            .frame(width: 100, height: 100)
    }
}

struct Square_Previews: PreviewProvider {
    static var previews: some View {
        SquareView()
            .previewLayout(.sizeThatFits)
    }
}
