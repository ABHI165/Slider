//
//  HomeView.swift
//  Slider
//
//  Created by Abhishek Agarwal on 02/08/22.
//

import SwiftUI

struct HomeView: View {
    @State var selectedTab: TabData?
    @State var tabItem = tabDataList
    @State var startedTabPosition: CGRect = .zero
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 12) {
                ForEach($tabItem) { $tab in
                    TabView($tab)
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 12)
            .background {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(.white)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .shadow(color: .black.opacity(0.05), radius: 5, x: -5, y: -5)
                    .frame(width: 65)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .coordinateSpace(name: "AREA")
            .gesture (
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        
                        guard let first = tabItem.first else { return }
                        
                        if startedTabPosition == .zero {
                            startedTabPosition = first.tabLocation
                        }
                        let location = CGPoint(x: startedTabPosition.midX, y: value.location.y)
                        
                        if let index = tabItem.firstIndex(where: {$0.tabLocation.contains(location)}), selectedTab?.id != tabItem[index].id {
                            withAnimation(.interpolatingSpring(stiffness: 230, damping: 22)) {
                                selectedTab = tabItem[index]
                            }
                        }
                    }.onEnded({ _ in
                        withAnimation(.interactiveSpring(response: 0.1, dampingFraction: 1, blendDuration: 1)) {
                            selectedTab = nil
                        }
                    })
            )
        }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    @ViewBuilder
    func TabView(_ tab: Binding<TabData>) -> some View {
        HStack(spacing: 5) {
            Image(systemName: tab.wrappedValue.icon)
                .font(.title2)
                .frame(width: 45, height: 45)
                .padding(.leading, selectedTab?.id == tab.id ? 5 : 0)
                .background {
                    GeometryReader { proxy in
                        let location = proxy.frame(in: .named("AREA"))
                        Color.clear
                            .preference(key: ImageLocationKey.self, value: location)
                            .onPreferenceChange(ImageLocationKey.self) { rect in
                                tab.wrappedValue.tabLocation = rect
                            }
                    }
                }
            
            if selectedTab?.id == tab.id {
                Text(tab.wrappedValue.title)
                    .padding(.trailing, 16)
                    .foregroundColor(.white)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(tab.wrappedValue.backgroundColor)
        }
        .offset(x: selectedTab?.id == tab.wrappedValue.id ? 60 : 0)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


//MARK: - Image Location PreferenceKey
struct ImageLocationKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
