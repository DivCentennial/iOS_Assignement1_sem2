//
//  ContentView.swift
//  Assignement1_images_shapes
//
//  Created by Divyanshoo Sinha on 2025-01-27.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ImageGridViewModel()
    
    let backgroundColors: [Color] = [
        .blue.opacity(0.3),
        .green.opacity(0.3),
        .orange.opacity(0.3),
        .purple.opacity(0.3)
    ]
    
    var body: some View {
        VStack {
            imageGrid
            
            Button("Reshuffle Images") {
                viewModel.reshuffleImages()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.bottom)
        }
    }
    
    private var imageGrid: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                gridCell(index: 0)
                gridCell(index: 1)
            }
            HStack(spacing: 0) {
                gridCell(index: 2)
                gridCell(index: 3)
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .padding()
    }
    
    private func gridCell(index: Int) -> some View {
        let imageInfo = viewModel.displayedImages[index]
        
        return ZStack {
            backgroundColors[index]
            
            if let image = UIImage(named: imageInfo.imageName) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .padding(8)
                    .onTapGesture {
                        viewModel.toggleCheckmark(at: index)
                    }
            }
            
            if imageInfo.isChecked {
                CheckmarkShape()
                    .stroke(Color.white, lineWidth: 3)
                    .background(
                        CheckmarkShape()
                            .fill(Color.blue.opacity(0.5))
                    )
                    .frame(width: 40, height: 40)
            }
        }
    }
}
