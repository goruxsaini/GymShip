//
//  MembersCell.swift
//  GymShip
//
//  Created by Goru Saini on 08/10/25.
//

import SwiftUI

//struct MembersCell: View {
//    @State var timePeriod = false
//    @State var memberName : String = ""
//    var body: some View {
//        NavigationStack{
//            ZStack {
//                Color(.secondarySystemBackground)
//                    .frame(width:UIScreen.main.bounds.width-8, height: 130)
//                    .cornerRadius(20)
//                HStack {
//                    Image("MemberImage")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 110)
//                        .clipShape(.circle)
//                    VStack(alignment: .leading) {
//                        Text("Name")
//                            .font(.title)
//                            .fontWeight(.semibold)
//                        Text("Premium")
//                            .font(.subheadline)
//                            .foregroundStyle(.gray)
//                            .padding(.bottom,3)
//                        Text("13 Days Left")
//                            .font(.subheadline)
//                            .fontWeight(.semibold)
//                            .foregroundStyle(timePeriod ? .main : .red)
////                            .lineLimit(1)
////                            .multilineTextAlignment(.center)
//                    }
//                    Spacer()
//                    NavigationLink {
//                           
//                    } label: {
//                        Image("Chevron")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 30, height: 30)
//                    }
//                }
//                .padding(.horizontal)
//            }.padding(.horizontal)
//        }
//    }
//}
//struct MembersCell: View {
//    @State var timePeriod = false
//    let member: Member
//    
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Color(.secondarySystemBackground)
//                    .frame(width: UIScreen.main.bounds.width - 8, height: 130)
//                    .cornerRadius(20)
//                HStack {
//                    if let profileImage = member.profileImage {
//                        Image(uiImage: profileImage)
//                            .resizable()
//                            .scaledToFill()
//                            .frame(width: 110, height: 110)
//                            .clipShape(.circle)
//                    } else {
//                        Image(systemName: "person.crop.circle.fill")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 110)
//                            .foregroundStyle(.gray)
//                            .clipShape(.circle)
//                    }
//                    
//                    VStack(alignment: .leading) {
//                        Text(member.name)
//                            .font(.title)
//                            .fontWeight(.semibold)
//                            .lineLimit(1)
//                        Text("Premium")
//                            .font(.subheadline)
//                            .foregroundStyle(.gray)
//                            .padding(.bottom, 3)
//                        Text("13 Days Left")
//                            .font(.subheadline)
//                            .fontWeight(.semibold)
//                            .foregroundStyle(timePeriod ? .main : .red)
//                    }
//                    Spacer()
//                    NavigationLink {
//                        Text("Member Details")
//                    } label: {
//                        Image("Chevron")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 30, height: 30)
//                    }
//                }
//                .padding(.horizontal)
//            }
//            .padding(.horizontal)
//        }
//    }
//}
//#Preview {
//    MembersCell(member: Member(
//        name: "John Doe",
//        age: "25",
//        gender: "Male",
//        phone: "9876543210",
//        address: "123 Gym Street",
//        profileImage: UIImage(systemName: "person.crop.circle.fill")
//    ))
//}
import SwiftUI

struct MembersCell: View {
    let member: Member
    @State private var showDetails = false
    
    var daysRemaining: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: Date(), to: member.endDate)
        return max(components.day ?? 0, 0)
    }
    
    var isExpiringSoon: Bool {
        daysRemaining <= 7 && daysRemaining > 0
    }
    
    var isExpired: Bool {
        daysRemaining <= 0
    }
    
    var statusColor: Color {
        if isExpired {
            return .red
        } else if isExpiringSoon {
            return .orange
        } else {
            return .main
        }
    }
    
    var statusText: String {
        if isExpired {
            return "Expired"
        } else if daysRemaining == 0 {
            return "Expires Today"
        } else if daysRemaining == 1 {
            return "1 Day Left"
        } else {
            return "\(daysRemaining) Days Left"
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background Card
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.secondarySystemBackground))
                    .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
                
                // Status Bar
                VStack(spacing: 0) {
                    HStack {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 12) {
                                // Profile Image
                                if let profileImage = member.profileImage {
                                    Image(uiImage: profileImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 70, height: 70)
                                        .clipShape(.circle)
                                        .overlay(Circle().stroke(Color.main, lineWidth: 2))
                                } else {
                                    Circle()
                                        .fill(Color(.systemBackground))
                                        .frame(width: 70, height: 70)
                                        .overlay(
                                            Image(systemName: "person.crop.circle.fill")
                                                .font(.system(size: 40))
                                                .foregroundStyle(.gray)
                                        )
                                        .overlay(Circle().stroke(Color.main, lineWidth: 2))
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(member.name)
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .lineLimit(1)
                                    
                                    HStack(spacing: 6) {
                                        Image(systemName: "star.fill")
                                            .font(.caption)
                                            .foregroundStyle(.main)
                                        Text(member.membershipPlan)
                                            .font(.caption)
                                            .fontWeight(.medium)
                                            .foregroundStyle(.gray)
                                    }
                                    
                                    HStack(spacing: 4) {
                                        Image(systemName: "phone.fill")
                                            .font(.caption2)
                                            .foregroundStyle(.gray)
                                        Text(member.phone)
                                            .font(.caption2)
                                            .foregroundStyle(.gray)
                                            .lineLimit(1)
                                    }
                                }
                                
                                Spacer()
                                
                                NavigationLink {
                                    MemberDetailView(member: member)
                                } label: {
                                    Image(systemName: "chevron.right")
                                        .font(.headline)
                                        .foregroundStyle(.main)
                                        .padding(8)
                                        .background(Circle().fill(Color.main.opacity(0.1)))
                                }
                            }
                            
                            // Status and Dates
                            HStack(spacing: 12) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Membership Status")
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                    
                                    HStack(spacing: 6) {
                                        Circle()
                                            .fill(statusColor)
                                            .frame(width: 8, height: 8)
                                        
                                        Text(statusText)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(statusColor)
                                    }
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text("Valid Until")
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                    
                                    Text(member.endDate.formatted(date: .abbreviated, time: .omitted))
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.black)
                                }
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.main.opacity(0.05))
                            .cornerRadius(10)
                        }
                        .padding(12)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 180)
            .padding(.horizontal)
        }
    }
}

// MARK: - Placeholder Detail View
struct MemberDetailView: View {
    let member: Member
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Profile Header
                    VStack(alignment: .center, spacing: 12) {
                        if let profileImage = member.profileImage {
                            Image(uiImage: profileImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(.circle)
                                .overlay(Circle().stroke(Color.main, lineWidth: 3))
                        } else {
                            Circle()
                                .fill(Color(.secondarySystemBackground))
                                .frame(width: 120, height: 120)
                                .overlay(
                                    Image(systemName: "person.crop.circle.fill")
                                        .font(.system(size: 60))
                                        .foregroundStyle(.gray)
                                )
                                .overlay(Circle().stroke(Color.main, lineWidth: 3))
                        }
                        
                        Text(member.name)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HStack(spacing: 12) {
                            Label(member.membershipPlan, systemImage: "star.fill")
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.main.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    
                    // Details Sections
                    DetailSection(title: "Personal Information", icon: "person.fill") {
                        DetailRow(label: "Age", value: member.age)
                        DetailRow(label: "Gender", value: member.gender)
                        DetailRow(label: "Blood Group", value: member.bloodGroup)
                    }
                    
                    DetailSection(title: "Contact", icon: "phone.fill") {
                        DetailRow(label: "Phone", value: member.phone)
                        DetailRow(label: "Address", value: member.address)
                        DetailRow(label: "Emergency Contact", value: member.emergencyContact)
                        DetailRow(label: "Emergency Phone", value: member.emergencyPhone)
                    }
                    
                    DetailSection(title: "Membership", icon: "creditcard.fill") {
                        DetailRow(label: "Plan", value: member.membershipPlan)
                        DetailRow(label: "Start Date", value: member.startDate.formatted(date: .abbreviated, time: .omitted))
                        DetailRow(label: "End Date", value: member.endDate.formatted(date: .abbreviated, time: .omitted))
                    }
                    
                    DetailSection(title: "Payment", icon: "banknote.fill") {
                        DetailRow(label: "Method", value: member.paymentMethod)
                        DetailRow(label: "Amount Paid", value: "₹\(member.amountPaid)")
                    }
                    
                    if !member.notes.isEmpty {
                        DetailSection(title: "Notes", icon: "note.text") {
                            Text(member.notes)
                                .font(.body)
                                .foregroundStyle(.black)
                        }
                    }
                }
                .padding(16)
            }
            .navigationTitle("Member Details")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(false)
        }
    }
}

// MARK: - Helper Components
struct DetailSection<Content: View>: View {
    let title: String
    let icon: String
    let content: Content
    
    init(title: String, icon: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.headline)
                    .foregroundStyle(.main)
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                content
            }
            .padding(12)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
        }
        .padding(12)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.main.opacity(0.1), lineWidth: 1))
    }
}

struct DetailRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundStyle(.gray)
            Spacer()
            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
                .lineLimit(1)
        }
    }
}

#Preview {
    MembersCell(member: Member(
        name: "John Doe",
        age: "25",
        gender: "Male",
        phone: "9876543210",
        address: "123 Gym Street",
        profileImage: nil,
        membershipPlan: "Premium",
        membershipMonths: "3",
        startDate: Date(),
        endDate: Date().addingTimeInterval(7776000),
        paymentMethod: "Card",
        amountPaid: "3000",
        emergencyContact: "Jane Doe",
        emergencyPhone: "9876543211",
        bloodGroup: "O+",
        notes: "New member, prefers morning sessions"
    ))
}
