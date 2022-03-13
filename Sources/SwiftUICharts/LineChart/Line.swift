//
//  Line.swift
//  SwiftUIChart
//
//  Created by WeIHa'S on 2021/12/5.
//

import SwiftUI

//public struct Line: View {
//    var data: ChartData
//    var touchLocation: CGPoint
//    var showIndicator: Bool
//    
//    @State private var showFull: Bool = false
//    @State var showBackground: Bool = true
//    var gradient: GradientColor = GradientColor(.purple, .blue)
//    var index: Int = 0
//    let padding: CGFloat = 30
//    var curvedLines: Bool = true
//    
//    struct CurveLine: Shape {
//        var points: [Double]
//        
//        
//        func path(in rect: CGRect) -> Path {
//            let p = Path()
//            p.move(to:  CGPoint(x: rect.minX, y: (1-(points.first - min)/(max - min)) * rect.height))
//            
//            for point in points {
//                p.addQuadCurve(to: <#T##CGPoint#>, control: <#T##CGPoint#>)
//            }
//        }
//    }
//    
//    var path: Path {
//        let points = self.data.pointValues
//        Path
//        return curvedLines ? Path.quadCurvedPathWithPoints(points: points, step: CGPoint(x: stepWidth, y: stepHeight), globalOffset: minDataValue) : Path.linePathWithPoints(points: points, step: CGPoint(x: stepWidth, y: stepHeight))
//    }
//    var closedPath: Path {
//        let points = self.data.pointValues
//        return curvedLines ? Path.quadClosedCurvedPathWithPoints(points: points, step: CGPoint(x: stepWidth, y: stepHeight), globalOffset: minDataValue) : Path.closedLinePathWithPoints(points: points, step: CGPoint(x: stepWidth, y: stepHeight))
//    }
//    
//    public var body: some View {
//        ZStack {
//            if(self.showFull && self.showBackground){
//                self.closedPath
//                    .fill(LinearGradient(gradient: Gradient(colors: [Colors.GradientUpperBlue, .white]), startPoint: .bottom, endPoint: .top))
//                    .transition(.scale)
//                    .animation(.easeIn(duration: 1.6 ))
//                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
//                    .rotationEffect(.degrees(180), anchor: .center)
//            }
//            self.path
//                .trim(from: 0, to: self.showFull ? 1:0)
//                .stroke(LinearGradient(gradient: gradient.getGradient(), startPoint: .leading, endPoint: .trailing) ,style: StrokeStyle(lineWidth: 3, lineJoin: .round))
//                .animation(Animation.easeOut(duration: 1.2).delay(Double(self.index)*0.4))
//                .rotationEffect(.degrees(180), anchor: .center)
//                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
//                
//                .onAppear {
//                    self.showFull = true
//                }
//                .onDisappear {
//                    self.showFull = false
//                }
//            if(self.showIndicator) {
//                IndicatorPoint()
//                    .position(self.getClosestPointOnPath(touchLocation: self.touchLocation))
//                    .rotationEffect(.degrees(180), anchor: .center)
//                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
//            }
//        }
//    }
//    
//    func getClosestPointOnPath(touchLocation: CGPoint) -> CGPoint {
//        let closest = self.path.point(to: touchLocation.x)
//        return closest
//    }
//    
//}
//
//struct Line_Previews: PreviewProvider {
//    static var previews: some View {
//        GeometryReader{ geometry in
//            Line(data: ChartData(points: [12,-230,10,54]), frame: .constant(geometry.frame(in: .local)), touchLocation: .constant(CGPoint(x: 100, y: 12)), showIndicator: .constant(true), minDataValue: .constant(nil), maxDataValue: .constant(nil))
//        }.frame(width: 320, height: 160)
//    }
//}
