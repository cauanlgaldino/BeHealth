//
//  TrackableScrollView.swift
//  BeHealth
//
//  Created by honorio on 02/09/24.
//

import SwiftUI

struct TrackableScrollView<Header: View, Content: View>: View {
    @State private var canShowHeader = true // on of the header
    let header: () -> Header
    let content: () -> Content
    var body: some View {
        VStack {
            if canShowHeader {
                VStack {
                    header()
                        .padding(16)// header content
                }
                .transition(
                    .asymmetric(
                        insertion: .push(from: .top),
                        removal: .push(from: .bottom)
                    )
                )
            }
            GeometryReader { outerGeo in
                let outerHeight = outerGeo.size.height
                ScrollView(.vertical) {
                    content() // scorllable content
                        .background {
                            GeometryReader { innnerGeo in
                                let contentHeight = innnerGeo.size.height
                                let minY = max(
                                    min(0, innnerGeo.frame(in: .named("ScrollView")).minY),
                                    outerHeight - contentHeight
                                )
                                Color.clear
                                    .onChange(of: minY) { oldVal, newVal in
                                        if (canShowHeader && newVal < oldVal) || !canShowHeader && newVal > oldVal {
                                            canShowHeader = newVal > oldVal
                                        }
                                    }
                            }
                        }
                }
                .coordinateSpace(name: "ScrollView") // coordinator space
            }
            .padding(.top, 1)
        }
        .animation(.easeInOut, value: canShowHeader)
    }
}
