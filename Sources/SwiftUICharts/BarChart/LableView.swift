//
//  LableView.swift
//  SwiftUIChart
//
//  Created by WeIHa'S on 2021/12/5.
//

import SwiftUI

struct LabelView: View {
    var arrowOffset: Double
    var title:String
    
    private var offset: Double{
        return max(-18,min(18, arrowOffset))
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            ArrowUp()
                .fill(Color.white)
                .frame(width: 20, height: 12, alignment: .center)
                .shadow(color: Color.gray, radius: 8, x: 0, y: 0)
                .offset(x: offset)
            Text(title)
                .font(.caption)
                .bold()
                .foregroundColor(.black)
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                        .shadow(radius: 8)
                )
            
        }
        .frame(minWidth: 100)
    }
}

struct ArrowUp: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width/2, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.closeSubpath()
        return path
    }
}

#if DEBUG
struct LabelView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LabelView(arrowOffset: 0, title: "Tesla model 3")
            LabelView(arrowOffset: 36, title: "Tesla model 3")
            LabelView(arrowOffset: -36, title: "Tesla model 3")
        }
       
    }
}
#endif
