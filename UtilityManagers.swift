//
//  UtilityManagers.swift
//  GymShip
//
//  Created by Goru Saini on 26/11/25.
//

import Foundation
import Foundation
import UIKit

// MARK: - Membership Plan Model
struct MembershipPlan {
    let name: String
    let monthlyPrice: Double
    let description: String
    let features: [String]
}

// MARK: - Pricing Manager Class
class PricingManager {
    static let shared = PricingManager()
    
    let plans: [String: MembershipPlan] = [
        "Basic": MembershipPlan(
            name: "Basic",
            monthlyPrice: 2000,
            description: "Essential gym access",
            features: ["Gym Access", "Equipment Use", "Locker Facility"]
        ),
        "Premium": MembershipPlan(
            name: "Premium",
            monthlyPrice: 3000,
            description: "Gym + Trainer sessions",
            features: ["Gym Access", "Equipment Use", "Personal Trainer (2x/week)", "Locker Facility"]
        ),
        "Gold": MembershipPlan(
            name: "Gold",
            monthlyPrice: 4500,
            description: "Complete fitness experience",
            features: ["Gym Access", "Equipment Use", "Personal Trainer (5x/week)", "Nutrition Consultation", "Locker & Towel Service"]
        )
    ]
    
    func getPricePerMonth(for plan: String) -> Double {
        return plans[plan]?.monthlyPrice ?? 0
    }
    
    func getTotalPrice(for plan: String, months: String) -> Double {
        guard let monthCount = Int(months) else { return 0 }
        return getPricePerMonth(for: plan) * Double(monthCount)
    }
    
    func getPlanDetails(for plan: String) -> MembershipPlan? {
        return plans[plan]
    }
    
    func getAllPlanNames() -> [String] {
        return Array(plans.keys)
    }
}

// MARK: - Payment Calculator Class
class PaymentCalculator {
    static let shared = PaymentCalculator()
    
    func calculateTotalAmount(plan: String, months: String) -> Double {
        return PricingManager.shared.getTotalPrice(for: plan, months: months)
    }
    
    func calculateAmountDue(totalAmount: Double, amountPaid: Double) -> Double {
        return max(totalAmount - amountPaid, 0)
    }
    
    func determinePaymentStatus(totalAmount: Double, amountPaid: Double) -> String {
        if amountPaid >= totalAmount {
            return "Paid"
        } else if amountPaid > 0 {
            return "Partial"
        } else {
            return "Pending"
        }
    }
    
    func calculateDaysRemaining(from endDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: Date(), to: endDate)
        return max(components.day ?? 0, 0)
    }
    
    func isExpired(endDate: Date) -> Bool {
        return endDate < Date()
    }
    
    func isExpiringSoon(endDate: Date, days: Int = 7) -> Bool {
        let daysRemaining = calculateDaysRemaining(from: endDate)
        return daysRemaining <= days && daysRemaining > 0
    }
}

// MARK: - Date Manager Class
class DateManager {
    static let shared = DateManager()
    
    func calculateEndDate(startDate: Date, months: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .month, value: months, to: startDate) ?? Date()
    }
    
    func getMonthlyEndDate(startDate: Date) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .month, value: 1, to: startDate) ?? Date()
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    func getDaysDifference(from startDate: Date, to endDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        return components.day ?? 0
    }
}

// MARK: - Validation Manager Class
class ValidationManager {
    static let shared = ValidationManager()
    
    func isValidName(_ name: String) -> Bool {
        return !name.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func isValidPhone(_ phone: String) -> Bool {
        return phone.count >= 10 && phone.allSatisfy({ $0.isNumber })
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: email)
    }
    
    func isValidAge(_ age: String) -> Bool {
        guard let ageInt = Int(age) else { return false }
        return ageInt >= 13 && ageInt <= 100
    }
    
    func getNameError(_ name: String) -> String? {
        if !isValidName(name) {
            return "Name cannot be empty"
        }
        return nil
    }
    
    func getPhoneError(_ phone: String) -> String? {
        if phone.isEmpty {
            return "Phone number cannot be empty"
        }
        if !isValidPhone(phone) {
            return "Phone number must have at least 10 digits"
        }
        return nil
    }
    
    func getAgeError(_ age: String) -> String? {
        if age.isEmpty {
            return "Age cannot be empty"
        }
        if !isValidAge(age) {
            return "Age must be between 13 and 100"
        }
        return nil
    }
}

// MARK: - Member Builder Class
class MemberBuilder {
    static let shared = MemberBuilder()
    
    func createMember(
        name: String,
        age: String,
        gender: String,
        phone: String,
        address: String,
        profileImage: UIImage?,
        membershipPlan: String,
        membershipMonths: String,
        startDate: Date,
        endDate: Date,
        paymentMethod: String,
        amountPaid: String,
        emergencyContact: String,
        emergencyPhone: String,
        bloodGroup: String,
        notes: String
    ) -> Member? {
        
        // Validate inputs
        guard ValidationManager.shared.isValidName(name) else { return nil }
        guard ValidationManager.shared.isValidPhone(phone) else { return nil }
        guard ValidationManager.shared.isValidAge(age) else { return nil }
        
        // Calculate pricing
        let totalAmount = PaymentCalculator.shared.calculateTotalAmount(
            plan: membershipPlan,
            months: membershipMonths
        )
        
        let paidAmount = Double(amountPaid) ?? 0
        let amountDue = PaymentCalculator.shared.calculateAmountDue(
            totalAmount: totalAmount,
            amountPaid: paidAmount
        )
        
        let paymentStatus = PaymentCalculator.shared.determinePaymentStatus(
            totalAmount: totalAmount,
            amountPaid: paidAmount
        )
        
        // Create and return member
        let member = Member(
            name: name,
            age: age,
            gender: gender,
            phone: phone,
            address: address,
            profileImage: profileImage,
            membershipPlan: membershipPlan,
            membershipMonths: membershipMonths,
            startDate: startDate,
            endDate: endDate,
            paymentMethod: paymentMethod,
            amountPaid: String(Int(paidAmount)),
            emergencyContact: emergencyContact,
            emergencyPhone: emergencyPhone,
            bloodGroup: bloodGroup,
            notes: notes,
            totalAmount: totalAmount,
            amountDue: amountDue,
            paymentStatus: paymentStatus
        )
        
        return member
    }
}

// MARK: - Statistics Manager Class
class StatisticsManager {
    static let shared = StatisticsManager()
    
    func calculateTotalIncome(from members: [Member]) -> Double {
        return members
            .filter { $0.paymentStatus == "Paid" }
            .reduce(0) { $0 + $1.totalAmount }
    }
    
    func calculateTotalDue(from members: [Member]) -> Double {
        return members
            .reduce(0) { $0 + $1.amountDue }
    }
    
    func calculateTotalCollection(from members: [Member]) -> Double {
        return calculateTotalIncome(from: members) + calculateTotalDue(from: members)
    }
    
    func calculateCollectionPercentage(from members: [Member]) -> Double {
        let totalIncome = calculateTotalIncome(from: members)
        let totalCollection = calculateTotalCollection(from: members)
        return totalCollection > 0 ? (totalIncome / totalCollection) * 100 : 0
    }
    
    func countPendingPayments(from members: [Member]) -> Int {
        return members.filter { $0.paymentStatus == "Pending" }.count
    }
    
    func countPartialPayments(from members: [Member]) -> Int {
        return members.filter { $0.paymentStatus == "Partial" }.count
    }
    
    func countCompletedPayments(from members: [Member]) -> Int {
        return members.filter { $0.paymentStatus == "Paid" }.count
    }
    
    func getMembersWithExpiringMembership(from members: [Member], days: Int = 7) -> [Member] {
        return members.filter { member in
            PaymentCalculator.shared.isExpiringSoon(endDate: member.endDate, days: days)
        }
    }
    
    func getMembersWithExpiredMembership(from members: [Member]) -> [Member] {
        return members.filter { member in
            PaymentCalculator.shared.isExpired(endDate: member.endDate)
        }
    }
}

// MARK: - Payment Manager Class
class PaymentManager {
    static let shared = PaymentManager()
    
    func recordPayment(for member: inout Member, amount: Double, method: String) {
        let currentPaid = Double(member.amountPaid) ?? 0
        let newTotal = currentPaid + amount
        
        member.amountPaid = String(Int(newTotal))
        member.paymentMethod = method
        member.amountDue = PaymentCalculator.shared.calculateAmountDue(
            totalAmount: member.totalAmount,
            amountPaid: newTotal
        )
        member.paymentStatus = PaymentCalculator.shared.determinePaymentStatus(
            totalAmount: member.totalAmount,
            amountPaid: newTotal
        )
    }
    
    func getPaymentHistory(for member: Member) -> String {
        return "Paid: ₹\(member.amountPaid) | Due: ₹\(Int(member.amountDue)) | Status: \(member.paymentStatus)"
    }
}
