//
//  MembersView.swift
//  GymShip
//
//  Created by Goru Saini on 08/10/25.
//

import SwiftUI

//struct MembersView: View {
//    @State private var showSheet : Bool = false
//    var body: some View {
//        NavigationStack{
//            ScrollView(showsIndicators: false){
//                ForEach(0..<5,id: \.self) { member in
//                    MembersCell()
//                }
//            }
//                .navigationTitle("Gym Members")
//                .navigationBarTitleDisplayMode(.automatic)
//                .navigationBarItems(trailing: EditButton())
//                .navigationBarItems(leading: Button("Add"){
//                    showSheet.toggle()
//                })
//                .sheet(isPresented: $showSheet) {
//                    AddSheet()
//                }
//        }.accentColor(.black)
//    }
//}

struct MembersView: View {
    @State private var showSheet: Bool = false
    @State private var viewModel = MembersViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                if viewModel.members.isEmpty {
                    VStack {
                        Text("No Members Added")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 50)
                } else {
                    ForEach(viewModel.members) { member in
                        MembersCell(member: member)
                    }
                }
            }
            .navigationTitle("Gym Members")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarItems(trailing: EditButton())
            .navigationBarItems(leading: Button("Add") {
                showSheet.toggle()
            })
            .sheet(isPresented: $showSheet) {
                AddSheet2(viewModel: viewModel)
            }
            .environment(\.editMode, .constant(.inactive))
        }
        .accentColor(.black)
    }
}
#Preview {
    MembersView()
}

