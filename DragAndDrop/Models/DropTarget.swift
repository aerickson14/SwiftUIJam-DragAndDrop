import SwiftUI

protocol DropTarget where DropObject: Codable {
    associatedtype DropObject

    static var supportedDropTypes: [String] { get set }
    func drop(object: DropObject)
}

extension DropTarget where Self: DropDelegate {

    func performDrop(info: DropInfo) -> Bool {
        Logger.log("peformDrop")
        fetchObject(from: info, onComplete: { object in
            guard let object = object else { return }
            drop(object: object)
        })
        return true
    }

    func dropUpdated(info: DropInfo) -> DropProposal? {
        let canDrop = !info.itemProviders(for: Self.supportedDropTypes).isEmpty
        let operation: DropOperation = canDrop ? .move : .forbidden
        return DropProposal(operation: operation)
    }
    
    func drop(object: DropObject) {}
    
    private func fetchObject(from info: DropInfo, onComplete: @escaping (DropObject?) -> Void) {
        guard info.hasItemsConforming(to: Self.supportedDropTypes) else {
            Logger.warn("no items found")
            onComplete(nil)
            return
        }

        let itemProviders = info.itemProviders(for: Self.supportedDropTypes)
        for itemProvider in itemProviders {
            _ = itemProvider.loadObject(ofClass: NSString.self) { nsString, error in
                if let error = error {
                    Logger.error(error.localizedDescription)
                    return
                }
                Logger.log("loadObject successful")
                guard let jsonString = nsString as? String else {
                    Logger.error("unable to find file jsonString")
                    onComplete(nil)
                    return
                }
                Logger.log("object json found")
                let object = decode(jsonString)
                onComplete(object)
            }
        }
    }

    private func decode(_ string: String) -> DropObject? {
        guard let data = string.data(using: .utf8) else { return nil }

        return try? JSONDecoder().decode(DropObject.self, from: data)
    }
}
