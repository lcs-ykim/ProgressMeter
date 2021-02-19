//
//  ContentView.swift
//  ProgressMeter
//
//  Created by Yeseo Kim on 2021-02-16.
//

import SwiftUI

struct ContentView: View {

    let meterWidth: CGFloat = 100
    
    let borderWidth: CGFloat = 2
   
    let verticalPadding: CGFloat = 44

    @State private var progressMeterOffset = CGSize.zero
    
    let correctResponses: Int = 10
    let questionCount: Int = 10

    private var fractionOfFullMeter: Double {
        Double(correctResponses) / Double(questionCount)
    }

    private var endColor: Color {

        let endingHue = fractionOfFullMeter * 120.0

        return Color(hue: endingHue / 360.0, saturation: 0.8, brightness: 0.9)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    ZStack {
                        
                        VStack(spacing: 0) {
                            // This pushes the filled part of the progress meter down
                                    Rectangle()
                                        .fill(Color.primary)
                                            .colorInvert()
                                        .frame(width: meterWidth, height: (geometry.size.height - verticalPadding) - CGFloat(fractionOfFullMeter) * (geometry.size.height - verticalPadding), alignment: .center)
                                    
                                    // "Fill" for progress meter; stationary
                                    Rectangle()
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color.red, endColor]),
                                                             startPoint: .bottom,
                                                             endPoint: .top))
                                        .frame(width: meterWidth, height: CGFloat(fractionOfFullMeter) * (geometry.size.height - verticalPadding), alignment: .center)
                        }
                        //Will slide up
                        Rectangle()
                        .fill(Color.primary)
                        .colorInvert()
                            .frame(width: meterWidth, height: geometry.size.height - verticalPadding, alignment: .center)
                        .offset(progressMeterOffset)
                        .onAppear(perform: {
                        withAnimation(Animation.easeIn(duration: 4.0)) {
                        //Offset is moves the opaque rectangle up
                            progressMeterOffset = CGSize(width: 0, height: -1 * (geometry.size.height - verticalPadding))
                        }
                        })
                        //Sits above the rectangle that slides up (in the z-axis)
                        //This means the rectangle sliding up will pass beneath this view
                        Rectangle()
                        .fill(Color(hue: 0, saturation: 0, brightness: 0, opacity: 0))
                            .frame(width: meterWidth + borderWidth, height: geometry.size.height - verticalPadding + borderWidth, alignment: .center)
                        .overlay(
                        Rectangle()
                            .stroke(Color.primary, lineWidth: borderWidth)
                        )
                    }
                    
                    Spacer()
                }
                
                Spacer()
                
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

