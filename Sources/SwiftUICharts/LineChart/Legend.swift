//
//  Legend.swift
//  SwiftUIChart
//
//  Created by WeIHa'S on 2021/12/5.
//

import SwiftUI

struct Legend: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var data: ChartData
    var hideHorizontalLines: Bool
    
    var specifier: String = "%.2f"
    private let padding: Double = 3
    
    var min: Double {
        return data.points.map({$0.value}).min() ?? 0
    }
    
    var max: Double {
        return data.points.map({$0.value}).max() ?? 1
    }
    
    var body: some View {
        VStack(alignment: .trailing){
            ForEach((0...4), id: \.self) { index in
                HStack(alignment: .center){
                    Text("\(self.getTapsY(index: index), specifier: specifier)")
                        .foregroundColor(Color.legendText)
                        .font(.caption)
                    Line()
                        .stroke(self.colorScheme == .dark ? Color.LegendDarkColor
                                : Color.LegendColor, style: StrokeStyle(lineWidth: 1.5, lineCap: .round, dash: [5, index == 4 ? 0 : 10]))
                        .opacity(hideHorizontalLines ? 0 : 1)
                        .animation(.easeOut(duration: 0.2))
                        .clipped()
                }
            }
        }
    }
    
    private func getTapsY(index: Int) -> Double{
        let height = max - min
        return height / 4 * Double(4-index) + min
        
    }
    
    
    private struct Line: Shape{
        func path(in rect: CGRect) -> Path {
            let start = CGPoint(x: rect.minX, y: rect.midY)
            let end = CGPoint(x: rect.maxX, y: rect.midY)
            var p = Path()
            p.move(to: start)
            p.addLine(to: end)
            return p
        }
    }
    
    
    
    private func getYLegend() -> [Double]? {
        let points = self.data.pointValues
        guard let max = points.max() else { return nil }
        guard let min = points.min() else { return nil }
        let step = Double(max - min)/4
        return [min+step * 0, min+step * 1, min+step * 2, min+step * 3, min+step * 4]
    }
}

struct Legend_Previews: PreviewProvider {
    static var previews: some View {
        Group{
        Legend(data: ChartData(points: [0.2,0.4,1.4,4.5]), hideHorizontalLines: false)
            .frame(width: 320, height: 200)
            .preferredColorScheme(.light)
            Legend(data: ChartData(points: [0.2,0.4,1.4,4.5]), hideHorizontalLines: false)
                .frame(width: 320, height: 200)
                .preferredColorScheme(.dark)
        }
    }
}

