//
//  Line.swift
//  SwiftUIChart
//
//  Created by WeIHa'S on 2021/12/5.
//

import SwiftUI

public struct Line: View {
    var data: ChartData
    var touchLocation: CGPoint
    var showIndicator: Bool
    
    var maxValue: Double
    var minValue: Double
    
    @State var showBackground: Bool = true
    @State private var showFull: Bool = false
    var gradient: GradientColor = GradientColor(.purple, .blue)
    var color: Color = .red
    
    var index: Int = 0
    var curvedLines: Bool = true
    
    public var body: some View {
        StraightLine(nodes: data.pointValues.map({($0 - minValue)/(maxValue - minValue)}))
            .trim(from: 0, to: self.showFull ? 1:0)
            .stroke(color ,style: StrokeStyle(lineWidth: 3, lineJoin: .round))
            .animation(Animation.easeOut(duration: 1.2).delay(Double(self.index)*0.4))
            .padding(.leading, 30)
            .padding(.bottom, 10)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.8) {
                    self.showFull = true
                }
            }
            .onDisappear {
                self.showFull = false
            }
    }
}

fileprivate struct StraightLine: Shape {
    var nodes: [Double]

    func path(in rect: CGRect) -> Path {
        var p = Path()
        guard let first = nodes.first, nodes.count > 1 else { p.move(to: rect.origin) ;return p  }
        var step = rect.width / Double(nodes.count - 1)
        if step > rect.width / 8.0 {
            step = rect.width / 8.0
        }
        p.move(to: CGPoint(x: rect.minX, y: rect.height * (1 - first)))
        for (index,node) in nodes.enumerated() where index > 0 {
            p.addLine(to: CGPoint(x: rect.minX + Double(index)*step, y: rect.height * (1 - node)))
        }
        return p
    }
}

//fileprivate struct CurveLine: Shape {
//    var nodes: [Double]
//
//    func path(in rect: CGRect) -> Path {
//        let p = Path()
//        p.move(to:  CGPoint(x: rect.minX, y: (1-(points.first - min)/(max - min)) * rect.height))
//
//        for point in points {
//            p.addQuadCurve(to: <#T##CGPoint#>, control: <#T##CGPoint#>)
//        }
//    }
//}



#if DEBUG
struct Line_Previews: PreviewProvider {
    static var previews: some View {
        Line(data: TestData.gpa, touchLocation: .zero, showIndicator: false, maxValue: 5, minValue: 0)
        Line(data: .init(values: [3.2]), touchLocation: .zero, showIndicator: false, maxValue: 5, minValue: 0)
        Line(data: .init(values: [3.2, 2.5]), touchLocation: .zero, showIndicator: false, maxValue: 5, minValue: 0)
    }
}
#endif
