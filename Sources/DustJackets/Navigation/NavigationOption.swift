import SwiftUI

public class NavigationOption<T>: ObservableObject, Identifiable where T: Comparable {
    @Published var image: Image
    var caption: String? = nil
    
    private var imageUnselected: Image
    private var imageSelected: Image
    
    private var id: T
    
    func update(_ new: T) {
        if self.id == new {
            select()
        }
        else {
            unselect()
        }
    }
    
    private func select() {
        image = imageSelected
    }
    
    private func unselect() {
        image = imageUnselected
    }
    
    public init(_ image: Image, selectedImage: Image? = nil, id: T) {
        self.imageUnselected = image
        self.imageSelected = selectedImage ?? image
        self.image = imageUnselected
        self.id = id
    }
}


