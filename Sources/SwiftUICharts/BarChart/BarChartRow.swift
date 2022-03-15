//
//  BarChartRow.swift
//  SwiftUIChart
//
//  Created by WeIHa'S on 2021/12/5.
//

import SwiftUI

struct BarChartRow : View {
    var data: [Double]
    
    @Binding var touchLocation: Double
    @Binding var showValue: Bool
    @Binding var showLabelValue: Bool
    
    var cellColor: Color
    var gradient: GradientColor?
    @Binding var currentValue: Double
    var width: Double
    
    private var maxValue: Double {
        guard let max = data.max(), max != 0 else { return 1 }
        return max
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: width/Double(data.count * 3)){
            ForEach(data.indices, id: \.self) { index in
                let isSelected = isSelected(index: index)
                BarChartCell(value: data[index]/maxValue,
                             index: index,
                             color: cellColor,
                             gradient: gradient)
                    .frame(maxWidth: width/8)
                    .opacity(isSelected ? 1 : 0.8)
                    .scaleEffect(isSelected ? CGSize(width: 1.4, height: 1.1) : CGSize(width: 1, height: 1), anchor: .bottom)
                    .animation(.spring())
                    .onTapGesture {
                        showValue = true
                        showLabelValue = true
                        touchLocation =  Double(index)/Double(data.count)
                        currentValue = data[index]
                    }
            }
        }
        .padding([.top, .leading, .trailing], 10)
    }
    
    func isSelected(index: Int) -> Bool{
        (self.touchLocation >= Double(index)/Double(data.count)) && (self.touchLocation < Double(index+1)/Double(data.count))
    }
    
    
}

#if DEBUG
struct BarChartRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BarChartRow( data: [], touchLocation: .constant(-1), showValue: .constant(false), showLabelValue: .constant(false), cellColor: .orange, currentValue: .constant(0), width: 300)
            BarChartRow( data: [8,23,54,32,12,37,7], touchLocation: .constant(-1), showValue: .constant(false), showLabelValue: .constant(false), cellColor: .orange, currentValue: .constant(0), width: 300)
        }
    }
}
#endif
