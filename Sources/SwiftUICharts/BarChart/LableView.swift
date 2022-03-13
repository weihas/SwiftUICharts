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
        return max(-36,min(36, arrowOffset))
    }
    
    var body: some View {
        VStack{
            ArrowUp()
                .fill(Color.white)
                .frame(width: 20, height: 12, alignment: .center)
                .shadow(color: Color.gray, radius: 8, x: 0, y: 0)
                .offset(x: offset, y: 12)
            ZStack{
                RoundedRectangle(cornerRadius: 8).frame(width: 100, height: 32, alignment: .center).foregroundColor(Color.white).shadow(radius: 8)
                Text(self.title)
                    .font(.caption)
                    .bold()
                    .foregroundColor(.black)
                ArrowUp()
                    .fill(Color.white)
                    .frame(width: 20, height: 12, alignment: .center)
                    .zIndex(2)
                    .offset(x: offset, y: -20)

            }
        }
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

struct LabelView_Previews: PreviewProvider {
    static var previews: some View {
        LabelView(arrowOffset: 0, title: "Tesla model 3")
    }
}
