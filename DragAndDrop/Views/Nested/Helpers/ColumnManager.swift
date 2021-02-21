import Foundation

class ColumnManager: ObservableObject {

    static let shared = ColumnManager()

    @Published var columns: [Column] = []

    private init() {
        self.columns = [
        Column(
            title: "Column 1",
            containers: [
                Container(name: "Container 1", items: ["Item 1", "Item 2", "Item 3"]),
                Container(name: "Container 2", items: ["Item 4", "Item 5"]),
                Container(name: "Container 3", items: ["Item 6", "Item 7", "Item 8"])
            ]
        ),
        Column(
            title: "Column 2",
            containers: [
                Container(name: "Container 4", items: ["Item 9", "Item 10", "Item 1"]),
                Container(name: "Container 5", items: ["Item 12", "Item 13"])
            ]
        )
    ]
    }

}
