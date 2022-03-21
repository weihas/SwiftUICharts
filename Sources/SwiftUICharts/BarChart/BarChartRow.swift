//
//  BarChartRow.swift
//  SwiftUIChart
//
//  Created by WeIHa'S on 2021/12/5.
//

import SwiftUI

struct BarChartRow : View {
    let data: ChartData
    
    
    @Binding var touchLocation: Double
    @Binding var showValue: Bool
    @Binding var showLabelValue: Bool
    @Binding var currentValue: Double
    
    var cellColor: Color
    var gradient: GradientColor?
    
   
    
    var width: Double
    
    var body: some View {
        HStack(alignment: .bottom, spacing: width/Double(data.count * 3)) {
            ForEach(data.nodes) { node in
                let selected = isSelected(node: node)
                BarChartCell(value: node.value/data.maxValue, index: node.index, color: cellColor, gradient: gradient)
                    .frame(maxWidth: width/8)
                    .opacity(selected ? 1 : 0.8)
                    .scaleEffect(selected ? CGSize(width: 1.4, height: 1.1) : CGSize(width: 1, height: 1), anchor: .bottom)
                    .animation(.spring())
                    .onTapGesture {
                        showValue.toggle()
                        showLabelValue.toggle()
                        touchLocation = Double(node.index)/Double(data.count)
                        currentValue = node.value
                    }
            }
        }
        .padding([.top, .leading, .trailing], 10)
    }
    
    func isSelected(node: ChartNode) -> Bool{
        (Double(node.index)/Double(data.count)..<Double(node.id+1)/Double(data.count)).contains(self.touchLocation)
    }
    
    
}


#if DEBUG
struct BarChartRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BarChartRow( data: .init(values: [0]), touchLocation: .constant(-1), showValue: .constant(false), showLabelValue: .constant(false), currentValue: .constant(0), cellColor: .orange, width: 300)
            BarChartRow( data: .init(values: [8,23,54,32,12,37,7]), touchLocation: .constant(-1), showValue: .constant(false), showLabelValue: .constant(false), currentValue: .constant(0), cellColor: .orange, width: 300)
        }
    }
}
#endif
