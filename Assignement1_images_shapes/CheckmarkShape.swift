//
//  CheckmarkShape.swift
//  Assignement1_images_shapes
//
//  Created by Divyanshoo Sinha on 2025-01-28.
//

import SwiftUICore

struct CheckmarkShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Diamond shape
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: center.x, y: center.y - height/2))
        path.addLine(to: CGPoint(x: center.x + width/2, y: center.y))
        path.addLine(to: CGPoint(x: center.x, y: center.y + height/2))
        path.addLine(to: CGPoint(x: center.x - width/2, y: center.y))
        path.closeSubpath()
        
        // Checkmark
        let checkmarkPath = Path { path in
            path.move(to: CGPoint(x: center.x - width/4, y: center.y))
            path.addLine(to: CGPoint(x: center.x - width/8, y: center.y + height/4))
            path.addLine(to: CGPoint(x: center.x + width/4, y: center.y - height/4))
        }
        
        return path.strokedPath(StrokeStyle(lineWidth: 1)).union(checkmarkPath)
    }
}
