//
//  AddMembersView.swift
//  GymShip
//
//  Created by Goru Saini on 23/11/25.
//

import SwiftUI

import SwiftUI

struct AddMembersView: View {
    @State var showSheet: Bool = false
    var viewModel: MembersViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.secondarySystemBackground)
                    .frame(width: 370, height: 100)
                    .cornerRadius(20)
                    .overlay {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Add New")
                                    .font(.title)
                                    .fontWeight(.semibold)
                                Text("Member🚀")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                            }
                            Spacer()
                            Button {
                                showSheet.toggle()
                            } label: {
                                Text("Add")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(Color.main)
                                    .cornerRadius(15)
                                    .padding(.trailing, 30)
                            }
                            .sheet(isPresented: $showSheet) {
                                AddSheet2(viewModel: viewModel)
                            }
                        }
                        .padding(.leading, 10)
                    }
                
            }
        }
    }
}


#Preview {
    AddMembersView(viewModel: MembersViewModel())
}
