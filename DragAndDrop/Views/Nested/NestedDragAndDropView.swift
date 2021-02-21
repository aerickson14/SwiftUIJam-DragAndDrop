import SwiftUI

struct NestedDragAndDropView: View {

    @ObservedObject var columnManager: ColumnManager

    init() {
        self.columnManager = ColumnManager.shared
    }

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(columnManager.columns, id: \.self) { column in
                    ColumnView(column: column)
                }
            }
            .padding()
        }
    }
}

struct NestedDragAndDropView_Previews: PreviewProvider {
    static var previews: some View {
        NestedDragAndDropView()
            .previewLayout(.sizeThatFits)
    }
}
