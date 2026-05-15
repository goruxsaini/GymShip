//
//  PaymentsView.swift
//  GymShip
//
//  Created by Goru Saini on 26/11/25.
//

//import SwiftUI
//
//struct PaymentsView: View {
//    @State private var selectedPeriod = "Monthly"
//    var viewModel: MembersViewModel
//    
//    // Separate computed properties to avoid type-check issues
//    var totalIncome: Double {
//        StatisticsManager.shared.calculateTotalIncome(from: viewModel.members)
//    }
//    
//    var totalDue: Double {
//        StatisticsManager.shared.calculateTotalDue(from: viewModel.members)
//    }
//    
//    var totalCollection: Double {
//        totalIncome + totalDue
//    }
//    
//    var paidPercentage: Double {
//        totalCollection > 0 ? (totalIncome / totalCollection) * 100 : 0
//    }
//    
//    var pendingCount: Int {
//        StatisticsManager.shared.countPendingPayments(from: viewModel.members)
//    }
//    
//    var completedCount: Int {
//        StatisticsManager.shared.countCompletedPayments(from: viewModel.members)
//    }
//    
//    var body: some View {
//        NavigationStack {
//            ScrollView(showsIndicators: false) {
//                VStack(spacing: 20) {
//                    // MARK: - Header Stats
//                    VStack(spacing: 16) {
//                        HStack(spacing: 12) {
//                            Picker("Period", selection: $selectedPeriod) {
//                                Text("Daily").tag("Daily")
//                                Text("Monthly").tag("Monthly")
//                                Text("Yearly").tag("Yearly")
//                            }
//                            .pickerStyle(.segmented)
//                            .tint(.main)
//                            
//                            Spacer()
//                        }
//                        
//                        // Income Card
//                        StatCard(
//                            title: "Total Income",
//                            amount: totalIncome,
//                            icon: "arrow.down.circle.fill",
//                            color: .green,
//                            subtitle: "Collected"
//                        )
//                        
//                        // Due Card
//                        StatCard(
//                            title: "Total Due",
//                            amount: totalDue,
//                            icon: "exclamationmark.circle.fill",
//                            color: .orange,
//                            subtitle: "Pending"
//                        )
//                        
//                        // Total Collection Card
//                        StatCard(
//                            title: "Total Collection",
//                            amount: totalCollection,
//                            icon: "wallet.pass.fill",
//                            color: .main,
//                            subtitle: "Expected"
//                        )
//                    }
//                    .padding(16)
//                    .background(Color(.secondarySystemBackground))
//                    .cornerRadius(16)
//                    
//                    // MARK: - Progress Card
//                    VStack(spacing: 12) {
//                        HStack {
//                            Text("Collection Status")
//                                .font(.headline)
//                                .fontWeight(.semibold)
//                            
//                            Spacer()
//                            
//                            Text("\(Int(paidPercentage))%")
//                                .font(.headline)
//                                .fontWeight(.bold)
//                                .foregroundStyle(.main)
//                        }
//                        
//                        // Progress Bar
//                        VStack(spacing: 8) {
//                            ZStack(alignment: .leading) {
//                                Capsule()
//                                    .fill(Color(.systemGray5))
//                                    .frame(height: 12)
//                                
//                                Capsule()
//                                    .fill(
//                                        LinearGradient(
//                                            gradient: Gradient(colors: [.main, .green]),
//                                            startPoint: .leading,
//                                            endPoint: .trailing
//                                        )
//                                    )
//                                    .frame(width: CGFloat(paidPercentage) / 100 * (UIScreen.main.bounds.width - 64), height: 12)
//                            }
//                            
//                            HStack {
//                                HStack(spacing: 4) {
//                                    Circle().fill(.green).frame(width: 8, height: 8)
//                                    Text("Paid: ₹\(Int(totalIncome))")
//                                        .font(.caption)
//                                        .foregroundStyle(.gray)
//                                }
//                                
//                                Spacer()
//                                
//                                HStack(spacing: 4) {
//                                    Circle().fill(.orange).frame(width: 8, height: 8)
//                                    Text("Due: ₹\(Int(totalDue))")
//                                        .font(.caption)
//                                        .foregroundStyle(.gray)
//                                }
//                            }
//                        }
//                    }
//                    .padding(16)
//                    .background(Color(.secondarySystemBackground))
//                    .cornerRadius(16)
//                    
//                    // MARK: - Quick Stats
//                    HStack(spacing: 12) {
//                        QuickStatBox(
//                            title: "Members",
//                            value: "\(viewModel.members.count)",
//                            icon: "person.2.fill",
//                            color: .blue
//                        )
//                        
//                        QuickStatBox(
//                            title: "Pending",
//                            value: "\(pendingCount)",
//                            icon: "hourglass.fill",
//                            color: .orange
//                        )
//                        
//                        QuickStatBox(
//                            title: "Completed",
//                            value: "\(completedCount)",
//                            icon: "checkmark.circle.fill",
//                            color: .green
//                        )
//                    }
//                    
//                    // MARK: - Payments List Header
//                    HStack {
//                        Text("Payment Details")
//                            .font(.headline)
//                            .fontWeight(.semibold)
//                        
//                        Spacer()
//                        
//                        Text("All")
//                            .font(.caption)
//                            .fontWeight(.semibold)
//                            .foregroundStyle(.main)
//                    }
//                    .padding(.horizontal, 4)
//                    
//                    // MARK: - Payments List from Members
//                    if viewModel.members.isEmpty {
//                        VStack(spacing: 12) {
//                            Image(systemName: "creditcard.slash")
//                                .font(.system(size: 40))
//                                .foregroundStyle(.gray)
//                            
//                            Text("No Members Yet")
//                                .font(.headline)
//                                .fontWeight(.semibold)
//                            
//                            Text("Add members to see payment records")
//                                .font(.caption)
//                                .foregroundStyle(.gray)
//                        }
//                        .frame(maxWidth: .infinity)
//                        .padding(.vertical, 32)
//                    } else {
//                        VStack(spacing: 12) {
//                            ForEach(viewModel.members) { member in
//                                MemberPaymentRow(member: member)
//                            }
//                        }
//                    }
//                }
//                .padding(16)
//            }
//            .navigationTitle("Payments")
//            .navigationBarTitleDisplayMode(.automatic)
//        }
//    }
//}
//
//// MARK: - Member Payment Row
//struct MemberPaymentRow: View {
//    let member: Member
//    
//    var daysDifference: Int {
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.day], from: Date(), to: member.endDate)
//        return components.day ?? 0
//    }
//    
//    var statusColor: Color {
//        if member.paymentStatus == "Paid" {
//            return .green
//        } else if member.paymentStatus == "Partial" {
//            return .orange
//        } else {
//            return .red
//        }
//    }
//    
//    var dueText: String {
//        if member.paymentStatus == "Paid" {
//            return "Fully Paid"
//        } else if daysDifference < 0 {
//            return "\(abs(daysDifference)) days overdue"
//        } else if daysDifference == 0 {
//            return "Due today"
//        } else {
//            return "Due in \(daysDifference) days"
//        }
//    }
//    
//    var body: some View {
//        HStack(spacing: 12) {
//            // Avatar
//            Circle()
//                .fill(Color.main.opacity(0.2))
//                .frame(width: 50, height: 50)
//                .overlay(
//                    Text(String(member.name.prefix(1)))
//                        .font(.headline)
//                        .fontWeight(.bold)
//                        .foregroundStyle(.main)
//                )
//            
//            // Details
//            VStack(alignment: .leading, spacing: 4) {
//                Text(member.name)
//                    .font(.subheadline)
//                    .fontWeight(.semibold)
//                    .lineLimit(1)
//                
//                HStack(spacing: 8) {
//                    Image(systemName: "star.fill")
//                        .font(.caption2)
//                        .foregroundStyle(.main)
//                    
//                    Text(member.membershipPlan)
//                        .font(.caption2)
//                        .foregroundStyle(.gray)
//                    
//                    Divider()
//                        .frame(height: 8)
//                    
//                    Text(dueText)
//                        .font(.caption2)
//                        .foregroundStyle(daysDifference < 0 && member.paymentStatus != "Paid" ? .red : .gray)
//                }
//            }
//            
//            Spacer()
//            
//            // Amount & Status
//            VStack(alignment: .trailing, spacing: 4) {
//                VStack(alignment: .trailing, spacing: 2) {
//                    Text("₹\(Int(member.totalAmount))")
//                        .font(.caption)
//                        .foregroundStyle(.gray)
//                    
//                    Text("₹\(member.amountPaid)")
//                        .font(.subheadline)
//                        .fontWeight(.bold)
//                        .foregroundStyle(.black)
//                }
//                
//                HStack(spacing: 4) {
//                    Circle()
//                        .fill(statusColor)
//                        .frame(width: 6, height: 6)
//                    
//                    Text(member.paymentStatus)
//                        .font(.caption2)
//                        .fontWeight(.semibold)
//                        .foregroundStyle(statusColor)
//                }
//            }
//        }
//        .padding(12)
//        .background(Color(.secondarySystemBackground))
//        .cornerRadius(12)
//    }
//}
//
//// MARK: - Custom Components
//struct StatCard: View {
//    let title: String
//    let amount: Double
//    let icon: String
//    let color: Color
//    let subtitle: String
//    
//    var body: some View {
//        HStack(spacing: 12) {
//            VStack(alignment: .leading, spacing: 4) {
//                Text(title)
//                    .font(.caption)
//                    .foregroundStyle(.gray)
//                
//                HStack(alignment: .center, spacing: 4) {
//                    Text("₹\(Int(amount))")
//                        .font(.title2)
//                        .fontWeight(.bold)
//                        .foregroundStyle(.black)
//                    
//                    Text(subtitle)
//                        .font(.caption)
//                        .foregroundStyle(.gray)
//                }
//            }
//            
//            Spacer()
//            
//            Image(systemName: icon)
//                .font(.system(size: 32))
//                .foregroundStyle(color.opacity(0.7))
//        }
//        .padding(12)
//        .background(color.opacity(0.1))
//        .cornerRadius(12)
//    }
//}
//
//struct QuickStatBox: View {
//    let title: String
//    let value: String
//    let icon: String
//    let color: Color
//    
//    var body: some View {
//        VStack(spacing: 8) {
//            Image(systemName: icon)
//                .font(.system(size: 24))
//                .foregroundStyle(color)
//            
//            Text(value)
//                .font(.headline)
//                .fontWeight(.bold)
//            
//            Text(title)
//                .font(.caption2)
//                .foregroundStyle(.gray)
//        }
//        .frame(maxWidth: .infinity)
//        .padding(12)
//        .background(Color(.secondarySystemBackground))
//        .cornerRadius(12)
//    }
//}
//
//#Preview {
//    PaymentsView(viewModel: MembersViewModel())
//}
import SwiftUI

struct PaymentsView: View {
    @State private var selectedPeriod = "Monthly"
    var viewModel: MembersViewModel
    
    var totalIncome: Double {
        StatisticsManager.shared.calculateTotalIncome(from: viewModel.members)
    }
    
    var totalDue: Double {
        StatisticsManager.shared.calculateTotalDue(from: viewModel.members)
    }
    
    var totalCollection: Double {
        totalIncome + totalDue
    }
    
    var paidPercentage: Double {
        totalCollection > 0 ? (totalIncome / totalCollection) * 100 : 0
    }
    
    var pendingCount: Int {
        StatisticsManager.shared.countPendingPayments(from: viewModel.members)
    }
    
    var completedCount: Int {
        StatisticsManager.shared.countCompletedPayments(from: viewModel.members)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    VStack(spacing: 16) {
                        HStack(spacing: 12) {
                            Picker("Period", selection: $selectedPeriod) {
                                Text("Daily").tag("Daily")
                                Text("Monthly").tag("Monthly")
                                Text("Yearly").tag("Yearly")
                            }
                            .pickerStyle(.segmented)
                            .tint(.main)
                            
                            Spacer()
                        }
                        
                        StatCard(
                            title: "Total Income",
                            amount: totalIncome,
                            icon: "arrow.down.circle.fill",
                            color: .green,
                            subtitle: "Collected"
                        )
                        
                        StatCard(
                            title: "Total Due",
                            amount: totalDue,
                            icon: "exclamationmark.circle.fill",
                            color: .orange,
                            subtitle: "Pending"
                        )
                        
                        StatCard(
                            title: "Total Collection",
                            amount: totalCollection,
                            icon: "wallet.pass.fill",
                            color: .main,
                            subtitle: "Expected"
                        )
                    }
                    .padding(16)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(16)
                    
                    VStack(spacing: 12) {
                        HStack {
                            Text("Collection Status")
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text("\(Int(paidPercentage))%")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundStyle(.main)
                        }
                        
                        VStack(spacing: 8) {
                            ZStack(alignment: .leading) {
                                Capsule()
                                    .fill(Color(.systemGray5))
                                    .frame(height: 12)
                                
                                Capsule()
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [.main, .green]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .frame(width: CGFloat(paidPercentage) / 100 * (UIScreen.main.bounds.width - 64), height: 12)
                            }
                            
                            HStack {
                                HStack(spacing: 4) {
                                    Circle().fill(.green).frame(width: 8, height: 8)
                                    Text("Paid: ₹\(Int(totalIncome))")
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                                
                                Spacer()
                                
                                HStack(spacing: 4) {
                                    Circle().fill(.orange).frame(width: 8, height: 8)
                                    Text("Due: ₹\(Int(totalDue))")
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                    }
                    .padding(16)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(16)
                    
                    HStack(spacing: 12) {
                        QuickStatBox(
                            title: "Members",
                            value: "\(viewModel.members.count)",
                            icon: "person.2.fill",
                            color: .blue
                        )
                        
                        QuickStatBox(
                            title: "Pending",
                            value: "\(pendingCount)",
                            icon: "hourglass.fill",
                            color: .orange
                        )
                        
                        QuickStatBox(
                            title: "Completed",
                            value: "\(completedCount)",
                            icon: "checkmark.circle.fill",
                            color: .green
                        )
                    }
                    
                    HStack {
                        Text("Payment Details")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text("All")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.main)
                    }
                    .padding(.horizontal, 4)
                    
                    if viewModel.members.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "creditcard.slash")
                                .font(.system(size: 40))
                                .foregroundStyle(.gray)
                            
                            Text("No Members Yet")
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            Text("Add members to see payment records")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 32)
                    } else {
                        VStack(spacing: 12) {
                            ForEach(viewModel.members) { member in
                                MemberPaymentRow(member: member)
                            }
                        }
                    }
                }
                .padding(16)
            }
            .navigationTitle("Payments")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

struct MemberPaymentRow: View {
    let member: Member
    
    var daysDifference: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: Date(), to: member.endDate)
        return components.day ?? 0
    }
    
    var statusColor: Color {
        if member.paymentStatus == "Paid" {
            return .green
        } else if member.paymentStatus == "Partial" {
            return .orange
        } else {
            return .red
        }
    }
    
    var dueText: String {
        if member.paymentStatus == "Paid" {
            return "Fully Paid"
        } else if daysDifference < 0 {
            return "\(abs(daysDifference)) days overdue"
        } else if daysDifference == 0 {
            return "Due today"
        } else {
            return "Due in \(daysDifference) days"
        }
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Color.main.opacity(0.2))
                .frame(width: 50, height: 50)
                .overlay(
                    Text(String(member.name.prefix(1)))
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(.main)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(member.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                
                HStack(spacing: 8) {
                    Image(systemName: "star.fill")
                        .font(.caption2)
                        .foregroundStyle(.main)
                    
                    Text(member.membershipPlan)
                        .font(.caption2)
                        .foregroundStyle(.gray)
                    
                    Divider()
                        .frame(height: 8)
                    
                    Text(dueText)
                        .font(.caption2)
                        .foregroundStyle(daysDifference < 0 && member.paymentStatus != "Paid" ? .red : .gray)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                VStack(alignment: .trailing, spacing: 2) {
                    Text("₹\(Int(member.totalAmount))")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    Text("₹\(member.amountPaid)")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                }
                
                HStack(spacing: 4) {
                    Circle()
                        .fill(statusColor)
                        .frame(width: 6, height: 6)
                    
                    Text(member.paymentStatus)
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundStyle(statusColor)
                }
            }
        }
        .padding(12)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

struct StatCard: View {
    let title: String
    let amount: Double
    let icon: String
    let color: Color
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                HStack(alignment: .center, spacing: 4) {
                    Text("₹\(Int(amount))")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                    
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }
            
            Spacer()
            
            Image(systemName: icon)
                .font(.system(size: 32))
                .foregroundStyle(color.opacity(0.7))
        }
        .padding(12)
        .background(color.opacity(0.1))
        .cornerRadius(12)
    }
}

struct QuickStatBox: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundStyle(color)
            
            Text(value)
                .font(.headline)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption2)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(12)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

#Preview {
    PaymentsView(viewModel: MembersViewModel())
}
