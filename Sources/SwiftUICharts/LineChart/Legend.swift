//
//  Legend.swift
//  SwiftUIChart
//
//  Created by WeIHa'S on 2021/12/5.
//

import SwiftUI

struct Legend: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var hideHorizontalLines: Bool = false
    
    let maxValue: Double
    let minValue: Double
    
    
    var specifier: String = "%.2f"
    private let padding: Double = 3
    
    var body: some View {
        VStack(alignment: .trailing){
            ForEach((0...4), id: \.self) { index in
                HStack(alignment: .center){
                    Text("\(getTapsY(index: index), specifier: specifier)")
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
        return (maxValue - minValue) / 4 * Double(4-index) + minValue
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
}


#if DEBUG
struct Legend_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            Legend(maxValue: 5, minValue: 0)
            .frame(width: 320, height: 200)
            .preferredColorScheme(.light)
            Legend(maxValue: 5, minValue: 0)
                .frame(width: 320, height: 200)
                .preferredColorScheme(.dark)
        }
    }
}
#endif
