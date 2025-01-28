//
//  ImageGridViewModel.swift
//  Assignement1_images_shapes
//
//  Created by Divyanshoo Sinha on 2025-01-28.
//

import Foundation

class ImageGridViewModel: ObservableObject {
    struct ImageInfo: Identifiable {
        let id = UUID()
        let imageName: String
        var isChecked: Bool
    }
    
    @Published var displayedImages: [ImageInfo] = []
    private var allImageNames = [
        "Image1", "Image2", "Image3", "Image4",
        "Image5", "Image6", "Image7", "Image8"
    ]
    private var unusedImageNames: Set<String>
    
    init() {
        unusedImageNames = Set(allImageNames)
        displayedImages = selectRandomImages()
    }
    
    private func selectRandomImages() -> [ImageInfo] {
        var selected = [ImageInfo]()
        var availableImages = Array(unusedImageNames)
        
        for _ in 0..<4 {
            guard let randomIndex = availableImages.indices.randomElement() else { break }
            let imageName = availableImages.remove(at: randomIndex)
            selected.append(ImageInfo(imageName: imageName, isChecked: false))
        }
        
        return selected
    }
    
    func toggleCheckmark(at index: Int) {
        displayedImages[index].isChecked.toggle()
    }
    
    func reshuffleImages() {
        var newImages = [ImageInfo]()
        
        // Keep checked images
        for image in displayedImages where image.isChecked {
            newImages.append(image)
            unusedImageNames.remove(image.imageName)
        }
        
        // Add new random images for unchecked positions
        while newImages.count < 4 {
            guard let randomImageName = unusedImageNames.randomElement() else { break }
            unusedImageNames.remove(randomImageName)
            newImages.append(ImageInfo(imageName: randomImageName, isChecked: false))
        }
        
        // Reset unused images pool if needed
        if unusedImageNames.isEmpty {
            unusedImageNames = Set(allImageNames)
            for image in newImages {
                unusedImageNames.remove(image.imageName)
            }
        }
        
        displayedImages = newImages
    }
}
