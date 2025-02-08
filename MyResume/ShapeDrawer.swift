//
//  ShapeDrawer.swift
//  MyResume
//
//  Created by 郭蕙瑄 on 2025/2/4.
//

import SwiftUI

struct ShapeDrawer: Shape {
    
    enum LineStyle {
        case bottomHalf
        case full
        case topHalf
    }
    
    var lineWidth: CGFloat = 10
    var dotSize: CGFloat = 20
    var lineStyle: LineStyle = .full
    
    var dotPosition: CGFloat {
        switch lineStyle {
        case .bottomHalf:
            return 0.2
        case .full:
            return 0.5
        case .topHalf:
            return 0.8
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addEllipse(in: CGRect(x: rect.midX - (dotSize * 0.5),
                                   y: rect.maxY * dotPosition - (dotSize * 0.5),
                                   width: dotSize,
                                   height: dotSize))
        
        path.addRect(CGRect(x: rect.midX - (lineWidth * 0.5),
                            y: lineStyle == .bottomHalf ? rect.maxY * 0.2 : rect.minY,
                            width: lineWidth,
                            height: lineStyle == .full ? rect.height : rect.height * 0.8))
        return path
    }
    
}

#Preview {
    
    VStack(spacing: 0) {
        ShapeDrawer(lineStyle: .bottomHalf).background(Color.blue)
        ShapeDrawer().background(Color.yellow)
        ShapeDrawer(lineStyle: .topHalf).background(Color.red)
    }.frame(height: 300)
}
