import SwiftUI

struct StarView: View {

    var body: some View {
        ZStack {
            Triangle()
                .frame(width: 100, height: 80)
                .padding(.bottom, 30)
            Triangle()
                .rotation(Angle(degrees: 180))
                .frame(width: 100, height: 80)
                .padding(.top, 30)
        }
            .foregroundColor(.yellow)
            .frame(width: 100, height: 100)
    }
}

struct StarView_Previews: PreviewProvider {
    static var previews: some View {
        StarView()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
