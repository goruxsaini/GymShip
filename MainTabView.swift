//
//  TabView.swift
//  GymShip
//
//  Created by Goru Saini on 07/10/25.
//

//import SwiftUI
//
//struct MainTabView: View {
//    @State private var selectedTab = 0
//
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            
//            HomeView()
//                .tabItem {
//                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
//                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
//                    Text("Home")
//                }
//                .onAppear{selectedTab = 0}
//                .tag(0)
//            
//            MembersView()
//                .tabItem {
//                    Image(systemName: selectedTab == 1 ? "person.fill" : "person")
//                        .environment(\.symbolVariants, selectedTab == 1 ? .fill : .none)
//                    Text("Members")
//                }.onAppear{selectedTab = 1}
//                .tag(1)
//            
////            Text("Activity")
////                .tabItem {
////                    Image(systemName: selectedTab == 2 ? "heart.fill" : "heart")
////                        .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
////                    Text("Activity")
////                }.onAppear{selectedTab = 2}
////                .tag(2)
//            
//            Text("Settings")
//                .tabItem {
//                    Image(systemName: selectedTab == 2 ? "dumbbell.fill" : "dumbbell")
//                        .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
//                    Text("Settings")
//                }.onAppear{selectedTab = 2}
//                .tag(2)
//        }.accentColor(.main)
//            .navigationBarBackButtonHidden(true)
//            .navigationTitle("Dashboard")
//            .navigationBarTitleDisplayMode(.automatic)
//            .navigationBarItems(trailing: Image(systemName: "plus"))
//        
//            
//    }
//}
//
//#Preview {
//    MainTabView()
//}
//
import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var viewModel = MembersViewModel()

    var body: some View {
        TabView(selection: $selectedTab) {
            
            HomeView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                    Text("Home")
                }
                .onAppear{selectedTab = 0}
                .tag(0)
            
            MembersView()
                .tabItem {
                    Image(systemName: selectedTab == 1 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedTab == 1 ? .fill : .none)
                    Text("Members")
                }.onAppear{selectedTab = 1}
                .tag(1)
            
//            Text("Activity")
//                .tabItem {
//                    Image(systemName: selectedTab == 2 ? "heart.fill" : "heart")
//                        .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
//                    Text("Activity")
//                }.onAppear{selectedTab = 2}
//                .tag(2)
            
            SettingsView()
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "dumbbell.fill" : "dumbbell")
                        .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
                    Text("Settings")
                }.onAppear{selectedTab = 2}
                .tag(2)
        }.accentColor(.main)
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarItems(trailing: Image(systemName: "plus"))
    }
}

#Preview {
    MainTabView()
}
