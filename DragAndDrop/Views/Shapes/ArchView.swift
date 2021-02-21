import SwiftUI

struct ArchView: View {

    var body: some View {
        Arch()
            .foregroundColor(.purple)
            .frame(width: 100, height: 100)
    }
}

struct ArchView_Previews: PreviewProvider {
    static var previews: some View {
        ArchView()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

struct Arch: Shape {

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 2/3 * rect.maxX, y: rect.maxY))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.maxY), radius: rect.width / 3, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: true)
        path.move(to: CGPoint(x: 1/3 * rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

        return path
    }
}
