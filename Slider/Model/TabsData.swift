//
//  Tabs.swift
//  Slider
//
//  Created by Abhishek Agarwal on 02/08/22.
//

import SwiftUI

//MARK: - Tab Model
struct TabData: Identifiable {
    let id = UUID().uuidString
    let title: String
    let icon: String
    let backgroundColor: Color
    var tabLocation: CGRect = .zero
}


//MARK: - Tab Model Sample
let tabDataList = [
    TabData(title: "Scribble", icon: "scribble.variable", backgroundColor: .purple),
    TabData(title: "Lasso", icon: "plus.bubble", backgroundColor: .blue),
    TabData(title: "Lasson", icon: "lasso", backgroundColor: .green),
    TabData(title: "Pencil", icon: "pencil.and.outline", backgroundColor: .orange),
    TabData(title: "Picker", icon: "paintbrush.pointed.fill", backgroundColor: .pink),
    TabData(title: "Rotate", icon: "rotate.3d", backgroundColor: .indigo),
    TabData(title: "Settings", icon: "eyes.inverse", backgroundColor: .yellow)
]
