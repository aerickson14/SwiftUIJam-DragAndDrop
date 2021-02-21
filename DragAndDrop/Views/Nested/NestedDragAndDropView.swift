import SwiftUI

struct NestedDragAndDropView: View {

    @ObservedObject var columnManager: ColumnManager

    init() {
        self.columnManager = ColumnManager.shared
    }

    var body: some View {
        HStack {
            ForEach(columnManager.columns, id: \.self) { column in
                ColumnView(title: column.title, containers: column.containers)
            }
        }
        .padding()
    }
}

struct NestedDragAndDropView_Previews: PreviewProvider {
    static var previews: some View {
        NestedDragAndDropView()
            .previewLayout(.sizeThatFits)
    }
}
