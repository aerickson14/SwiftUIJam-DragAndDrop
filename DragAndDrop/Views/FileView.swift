import SwiftUI

struct FileView: View {
    let fileName: String

    var body: some View {
        HStack {
            Image(systemName: "doc.plaintext")
            Text(fileName)
            Spacer()
        }
        .padding(4)
    }
}

struct FileView_Previews: PreviewProvider {
    static var previews: some View {
        FileView(fileName: "file.txt")
            .previewLayout(.sizeThatFits)
    }
}
