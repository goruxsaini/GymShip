//
//  HomeView.swift
//  GymShip
//
//  Created by Goru Saini on 08/10/25.
//

//import SwiftUI
//
//struct HomeView: View {
//    var body: some View {
//        NavigationStack{
//            ScrollView{
//                VStack{
//                    HStack{
//                        NavigationLink {
//                            Text("Members Stats")
//                        } label: {
//                            VStack{
//                                Image(systemName: "person.fill")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .foregroundStyle(.main)
//                                    .frame(width: 90, height: 90)
//
//                                Text("Members")
//                                    .font(.title2)
//                                    .fontWeight(.medium)
//                                    .foregroundStyle(.black)
//                            }
//                            .frame(width: 180, height: 180)
//
//                                .background(Color(.secondarySystemBackground))
//                                .cornerRadius(20)
//                        }
//                        
//                        NavigationLink {
//                            Text("Members Stats")
//                        } label: {
//                            VStack{
//                                Image(systemName: "indianrupeesign.arrow.trianglehead.counterclockwise.rotate.90")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .foregroundStyle(.main)
//                                    .frame(width: 90, height: 90)
//                                Text("Payments")
//                                    .font(.title2)
//                                    .fontWeight(.medium)
//                                    .foregroundStyle(.black)
//                            }
//                            .frame(width: 180, height: 180)
//                            .background(Color(.secondarySystemBackground))
//                            .cornerRadius(20)
//                        }
//                    }.padding(.horizontal)
//                    
//                }
////                HStack{
////                    NavigationLink {
////                        Text("Members Stats")
////                    } label: {
////                        VStack{
////                            Image(systemName: "calendar")
////                                .resizable()
////                                .scaledToFit()
////                                .foregroundStyle(.main)
////                                .frame(width: 90, height: 90)
////                            Text("Attendance")
////                                .font(.title2)
////                                .fontWeight(.medium)
////                                .foregroundStyle(.black)
////                        }
////                        .frame(width: 180, height: 180)
////                            .background(Color(.secondarySystemBackground))
////                            .cornerRadius(20)
////                    }
////                    
////                    NavigationLink {
////                        Text("Members Stats")
////                    } label: {
////                        VStack{
////                            Image(systemName: "chart.bar.fill")
////                                .resizable()
////                                .scaledToFit()
////                                .foregroundStyle(.main)
////                                .frame(width: 90, height: 90)
////
////                            Text("Reports")
////                                .font(.title2)
////                                .fontWeight(.medium)
////                                .foregroundStyle(.black)
////                        }
////                        .frame(width: 180, height: 180)
////                        .background(Color(.secondarySystemBackground))
////                        .cornerRadius(20)
////                    }
////                }.padding(.horizontal)
//                ExpiryAlertView()
//                AddMembersView(viewModel: <#T##MembersViewModel#>)
//                GymQuotesView()
//                
//            }
//            .navigationTitle("Dashboard")
//            .navigationBarTitleDisplayMode(.automatic)
//            
//            
//        }
//    }
//}
//
//#Preview {
//    HomeView()
//}
//
//import SwiftUI
//
//struct HomeView: View {
//    @State private var viewModel = MembersViewModel()
//    
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                VStack {
//                    HStack {
//                        NavigationLink {
//                            Text("Members Stats")
//                        } label: {
//                            VStack {
//                                Image(systemName: "person.fill")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .foregroundStyle(.main)
//                                    .frame(width: 90, height: 90)
//
//                                Text("Members")
//                                    .font(.title2)
//                                    .fontWeight(.medium)
//                                    .foregroundStyle(.black)
//                            }
//                            .frame(width: 180, height: 180)
//                            .background(Color(.secondarySystemBackground))
//                            .cornerRadius(20)
//                        }
//                        
//                        NavigationLink {
//                            Text("Members Stats")
//                        } label: {
//                            VStack {
//                                Image(systemName: "indianrupeesign.arrow.trianglehead.counterclockwise.rotate.90")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .foregroundStyle(.main)
//                                    .frame(width: 90, height: 90)
//                                Text("Payments")
//                                    .font(.title2)
//                                    .fontWeight(.medium)
//                                    .foregroundStyle(.black)
//                            }
//                            .frame(width: 180, height: 180)
//                            .background(Color(.secondarySystemBackground))
//                            .cornerRadius(20)
//                        }
//                    }
//                    .padding(.horizontal)
//                    
//                }
////                HStack{
////                    NavigationLink {
////                        Text("Members Stats")
////                    } label: {
////                        VStack{
////                            Image(systemName: "calendar")
////                                .resizable()
////                                .scaledToFit()
////                                .foregroundStyle(.main)
////                                .frame(width: 90, height: 90)
////                            Text("Attendance")
////                                .font(.title2)
////                                .fontWeight(.medium)
////                                .foregroundStyle(.black)
////                        }
////                        .frame(width: 180, height: 180)
////                            .background(Color(.secondarySystemBackground))
////                            .cornerRadius(20)
////                    }
////
////                    NavigationLink {
////                        Text("Members Stats")
////                    } label: {
////                        VStack{
////                            Image(systemName: "chart.bar.fill")
////                                .resizable()
////                                .scaledToFit()
////                                .foregroundStyle(.main)
////                                .frame(width: 90, height: 90)
////
////                            Text("Reports")
////                                .font(.title2)
////                                .fontWeight(.medium)
////                                .foregroundStyle(.black)
////                        }
////                        .frame(width: 180, height: 180)
////                        .background(Color(.secondarySystemBackground))
////                        .cornerRadius(20)
////                    }
////                }.padding(.horizontal)
//                ExpiryAlertView()
//                    AddMembersView(viewModel: viewModel)
//                    GymQuotesView()
//                }
//            .navigationTitle("Dashboard")
//            .navigationBarTitleDisplayMode(.automatic)
//            }
//        }
//    }
//
//#Preview {
//    HomeView()
//}
 // final one
import SwiftUI

struct HomeView: View {
    var viewModel: MembersViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        NavigationLink {
                            MembersView()
                        } label: {
                            VStack {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.main)
                                    .frame(width: 90, height: 90)

                                Text("Members")
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black)
                            }
                            .frame(width: 180, height: 180)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(20)
                        }
                        
                        NavigationLink {
                            PaymentsView(viewModel: viewModel)
                        } label: {
                            VStack {
                                Image(systemName: "indianrupeesign.arrow.trianglehead.counterclockwise.rotate.90")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.main)
                                    .frame(width: 90, height: 90)
                                Text("Payments")
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.black)
                            }
                            .frame(width: 180, height: 180)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(20)
                        }
                    }
                    .padding(.horizontal)
                    
//                HStack{
//                    NavigationLink {
//                        Text("Members Stats")
//                    } label: {
//                        VStack{
//                            Image(systemName: "calendar")
//                                .resizable()
//                                .scaledToFit()
//                                .foregroundStyle(.main)
//                                .frame(width: 90, height: 90)
//                            Text("Attendance")
//                                .font(.title2)
//                                .fontWeight(.medium)
//                                .foregroundStyle(.black)
//                        }
//                        .frame(width: 180, height: 180)
//                            .background(Color(.secondarySystemBackground))
//                            .cornerRadius(20)
//                    }
//
//                    NavigationLink {
//                        Text("Members Stats")
//                    } label: {
//                        VStack{
//                            Image(systemName: "chart.bar.fill")
//                                .resizable()
//                                .scaledToFit()
//                                .foregroundStyle(.main)
//                                .frame(width: 90, height: 90)
//
//                            Text("Reports")
//                                .font(.title2)
//                                .fontWeight(.medium)
//                                .foregroundStyle(.black)
//                        }
//                        .frame(width: 180, height: 180)
//                        .background(Color(.secondarySystemBackground))
//                        .cornerRadius(20)
//                    }
//                }.padding(.horizontal)
                    
                    ExpiryAlertView()
//                    AddMembersView(viewModel: viewModel)
                    GymQuotesView()
                }
            }
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

#Preview {
    HomeView(viewModel: MembersViewModel())
}
