//
//  DefaultDonutChartUIView.swift
//  ChartsTesting
//
//  Created by David Iordan on 6/11/23.
//

import Charts
import SwiftUI

struct CategoryEarnRow {
    var category: String
    var color: UIColor
    var value: Double
}

struct DefaultDonutChartUIView: View {
    @State private var borderWidth: CGFloat = 0

    let data = [
        CategoryEarnRow(category: "In-store Purchases", color: .systemGreen, value: 19),
        CategoryEarnRow(category: "Online Purchases", color: .systemMint, value: 25),
        CategoryEarnRow(category: "Murphy's Gas", color: .magenta, value: 12),
        CategoryEarnRow(category: "Dining", color: .systemPink, value: 40)
    ]
    let totalPoints = 1496

    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(Color(red: 0.28, green: 0.28, blue: 0.28), lineWidth: borderWidth)
                .background(.clear)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            Chart(data, id: \.category) { element in
                SectorMark(
                    angle: .value("Amount", element.value),
                    innerRadius: .ratio(0.7),
                    angularInset: 2.5
                )
                .cornerRadius(5)
                .foregroundStyle(Color(element.color))
            }
            .chartBackground { chartProxy in
                GeometryReader { geometry in
                    let frame = geometry[chartProxy.plotAreaFrame]
                    VStack {
                        Text("+\(totalPoints)")
                            .font(.system(size: 22).bold())
                            .foregroundStyle(.primary)
                        Text("Points Earned in Last 90 Days")
                            .font(.system(size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.primary)
                    }
                    .position(x: frame.midX, y: frame .midY)
                    .frame(width: frame.width * 0.65, height: frame.height)
                    .onAppear {
                        /// `calculate the border width`
                        /// `frame.midX` represents the outer radius because it is calculated
                        ///  going from the origin along the x-axis (i.e. 0) to the midpoint
                        ///  of the view (the chart here)
                        ///
                        /// `frame.midX * 0.7` calculates the inner radius based on the innerRadius
                        ///  we set for the sector. in this case it's a ratio which is caluclated
                        ///  using the sector's outer radius which we know is `frame.midX`
                        ///
                        /// finally we add `10` because the circle object representing the border is
                        ///  padded at a `5` point difference across all directions from the chart.
                        ///  this is subject to change based on what someone sets for the chart's
                        ///  border width
                        borderWidth = frame.midX - (frame.midX * 0.7) + 10
                    }
                }
            }
            .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
        }
        // we have to set the frame here to force the dimensions to scale properly
        //  trying to constrain the height or width of the view inside of a UIKit
        //  ViewController causes some weird behavior
        .frame(width: 275, height: 275)
    }
}

#Preview {
    DefaultDonutChartUIView()
}
