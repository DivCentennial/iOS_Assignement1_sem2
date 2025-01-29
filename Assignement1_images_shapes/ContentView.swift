//
//  ContentView.swift
//  Assignment1_images_shapes
//
//  Created by Divyanshoo Sinha and Kashish Yadav on 2025-01-27.
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
    
    // Gradient background
        private let gradient = LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.26, green: 0.63, blue: 0.96),   // Soft blue
                Color(red: 0.41, green: 0.35, blue: 0.80),   // Muted purple
                Color(red: 0.22, green: 0.82, blue: 0.73)    // Fresh teal
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    
    var body: some View {
        
        ZStack {
            // Full-screen gradient background
            gradient
                .ignoresSafeArea()
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
                    .padding(12) // Reduced padding for better spacing
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
        .aspectRatio(1, contentMode: .fit) // Ensure cell remains square
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white, lineWidth: 4)
        )
        .padding(2) // Prevents border clipping
    }
}

#Preview {
    ContentView()
}
