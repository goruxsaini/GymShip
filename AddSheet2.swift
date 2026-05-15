//
//  extraFile.swift
//  GymShip
//
//  Created by Goru Saini on 26/11/25.
//

//import SwiftUI
//import PhotosUI
//
//struct AddSheet2: View {
//    @Environment(\.dismiss) var dismiss
//    var viewModel: MembersViewModel
//    
//    @State var name: String = ""
//    @State var age: String = ""
//    @State var gender: String = ""
//    @State var phone: String = ""
//    @State var address: String = ""
//    @State var selectedImage: UIImage?
//    @State var photosPickerItem: PhotosPickerItem?
//    @State var membershipPlan: String = "Premium"
//    @State var membershipMonths: String = "1"
//    @State var startDate = Date()
//    @State var endDate = Date().addingTimeInterval(2592000)
//    @State var paymentMethod: String = "Cash"
//    @State var amountPaid: String = ""
//    @State var emergencyContact: String = ""
//    @State var emergencyPhone: String = ""
//    @State var bloodGroup: String = "O+"
//    @State var notes: String = ""
//    
//    let membershipPlans = ["Basic", "Premium", "Gold"]
//    let paymentMethods = ["Cash", "Card", "UPI", "Bank Transfer"]
//    let bloodGroups = ["O+", "O-", "A+", "A-", "B+", "B-", "AB+", "AB-"]
//    
//    // Computed properties using PricingManager
//    var monthlyPrice: Double {
//        PricingManager.shared.getPricePerMonth(for: membershipPlan)
//    }
//    
//    var totalAmount: Double {
//        PaymentCalculator.shared.calculateTotalAmount(
//            plan: membershipPlan,
//            months: membershipMonths
//        )
//    }
//    
//    var amountDue: Double {
//        let paid = Double(amountPaid) ?? 0
//        return PaymentCalculator.shared.calculateAmountDue(
//            totalAmount: totalAmount,
//            amountPaid: paid
//        )
//    }
//    
//    var pricingInfo: String {
//        "₹\(Int(monthlyPrice))/month × \(membershipMonths) months = ₹\(Int(totalAmount))"
//    }
//    
//    var body: some View {
//        NavigationStack {
//            ScrollView(showsIndicators: false) {
//                VStack(spacing: 24) {
//                    // MARK: - Profile Picture Section
//                    VStack(spacing: 12) {
//                        PhotosPicker(selection: $photosPickerItem, matching: .images) {
//                            ZStack(alignment: .bottomTrailing) {
//                                if let selectedImage {
//                                    Image(uiImage: selectedImage)
//                                        .resizable()
//                                        .scaledToFill()
//                                        .frame(width: 120, height: 120)
//                                        .clipShape(.circle)
//                                        .overlay(Circle().stroke(Color.main, lineWidth: 3))
//                                } else {
//                                    Circle()
//                                        .fill(Color(.secondarySystemBackground))
//                                        .frame(width: 120, height: 120)
//                                        .overlay(
//                                            Image(systemName: "person.crop.circle.fill")
//                                                .font(.system(size: 60))
//                                                .foregroundStyle(.gray)
//                                        )
//                                        .overlay(Circle().stroke(Color.main, lineWidth: 3))
//                                    
//                                    Image(systemName: "camera.circle.fill")
//                                        .font(.system(size: 40))
//                                        .foregroundStyle(.main)
//                                        .background(Circle().fill(Color(.systemBackground)))
//                                }
//                            }
//                        }
//                        .onChange(of: photosPickerItem) { oldValue, newValue in
//                            Task {
//                                if let data = try? await newValue?.loadTransferable(type: Data.self) {
//                                    if let uiImage = UIImage(data: data) {
//                                        selectedImage = uiImage
//                                    }
//                                }
//                            }
//                        }
//                        
//                        if selectedImage == nil {
//                            Text("Tap to add profile picture")
//                                .font(.caption)
//                                .foregroundStyle(.gray)
//                        }
//                    }
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical, 16)
//                    
//                    // MARK: - Personal Information Section
//                    VStack(spacing: 16) {
//                        SectionHeader(title: "Personal Information", icon: "person.fill")
//                        
//                        FormTextField(label: "Full Name", placeholder: "Enter name", text: $name, icon: "person")
//                        FormTextField(label: "Phone Number", placeholder: "Enter phone", text: $phone, icon: "phone")
//                        FormTextField(label: "Age", placeholder: "Enter age", text: $age, icon: "calendar", keyboardType: .numberPad)
//                        
//                        VStack(alignment: .leading, spacing: 8) {
//                            Label("Gender", systemImage: "person.2")
//                                .font(.subheadline)
//                                .fontWeight(.semibold)
//                                .foregroundStyle(.black)
//                            
//                            Picker("Gender", selection: $gender) {
//                                Text("Male").tag("Male")
//                                Text("Female").tag("Female")
//                                Text("Other").tag("Other")
//                            }
//                            .pickerStyle(.segmented)
//                            .tint(.main)
//                        }
//                        
//                        FormTextField(label: "Blood Group", placeholder: "Select", text: $bloodGroup, icon: "drop.fill", isDropdown: true, items: bloodGroups)
//                    }
//                    .padding(16)
//                    .background(Color(.secondarySystemBackground))
//                    .cornerRadius(16)
//                    
//                    // MARK: - Address Section
//                    VStack(spacing: 16) {
//                        SectionHeader(title: "Address", icon: "location.fill")
//                        FormTextField(label: "Address", placeholder: "Enter address", text: $address, icon: "building.2")
//                    }
//                    .padding(16)
//                    .background(Color(.secondarySystemBackground))
//                    .cornerRadius(16)
//                    
//                    // MARK: - Membership Section with Pricing
//                    VStack(spacing: 16) {
//                        SectionHeader(title: "Membership Details", icon: "creditcard.fill")
//                        
//                        VStack(alignment: .leading, spacing: 8) {
//                            Label("Membership Plan", systemImage: "star.fill")
//                                .font(.subheadline)
//                                .fontWeight(.semibold)
//                                .foregroundStyle(.black)
//                            
//                            Picker("Plan", selection: $membershipPlan) {
//                                ForEach(membershipPlans, id: \.self) { plan in
//                                    Text(plan).tag(plan)
//                                }
//                            }
//                            .pickerStyle(.segmented)
//                            .tint(.main)
//                        }
//                        
//                        // MARK: - Plan Pricing Cards
//                        VStack(spacing: 8) {
//                            ForEach(membershipPlans, id: \.self) { plan in
//                                if let planDetails = PricingManager.shared.getPlanDetails(for: plan) {
//                                    PlanPriceCard(
//                                        plan: plan,
//                                        price: planDetails.monthlyPrice,
//                                        description: planDetails.description,
//                                        isSelected: membershipPlan == plan
//                                    )
//                                }
//                            }
//                        }
//                        .padding(12)
//                        .background(Color.main.opacity(0.05))
//                        .cornerRadius(10)
//                        
//                        // Plan Info Card
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text(pricingInfo)
//                                .font(.subheadline)
//                                .fontWeight(.semibold)
//                                .foregroundStyle(.black)
//                            
//                            if let planDetails = PricingManager.shared.getPlanDetails(for: membershipPlan) {
//                                Text(planDetails.description)
//                                    .font(.caption)
//                                    .foregroundStyle(.gray)
//                                
//                                VStack(alignment: .leading, spacing: 4) {
//                                    Text("Features:")
//                                        .font(.caption2)
//                                        .fontWeight(.semibold)
//                                        .foregroundStyle(.black)
//                                    
//                                    ForEach(planDetails.features, id: \.self) { feature in
//                                        HStack(spacing: 6) {
//                                            Image(systemName: "checkmark.circle.fill")
//                                                .font(.caption2)
//                                                .foregroundStyle(.main)
//                                            Text(feature)
//                                                .font(.caption2)
//                                                .foregroundStyle(.gray)
//                                        }
//                                    }
//                                }
//                                .padding(.top, 8)
//                            }
//                        }
//                        .padding(12)
//                        .background(Color.main.opacity(0.1))
//                        .cornerRadius(10)
//                        
//                        VStack(alignment: .leading, spacing: 8) {
//                            Label("Duration (Months)", systemImage: "clock.fill")
//                                .font(.subheadline)
//                                .fontWeight(.semibold)
//                                .foregroundStyle(.black)
//                            
//                            Menu {
//                                ForEach(1...12, id: \.self) { month in
//                                    Button(action: {
//                                        membershipMonths = String(month)
//                                        endDate = DateManager.shared.calculateEndDate(
//                                            startDate: startDate,
//                                            months: month
//                                        )
//                                    }) {
//                                        HStack {
//                                            Text("\(month) Month\(month > 1 ? "s" : "")")
//                                            if membershipMonths == String(month) {
//                                                Image(systemName: "checkmark")
//                                                    .foregroundStyle(.main)
//                                            }
//                                        }
//                                    }
//                                }
//                            } label: {
//                                HStack {
//                                    Text("\(membershipMonths) Month\(Int(membershipMonths) ?? 1 > 1 ? "s" : "")")
//                                        .foregroundStyle(.black)
//                                    Spacer()
//                                    Image(systemName: "chevron.down")
//                                        .foregroundStyle(.main)
//                                }
//                                .padding(12)
//                                .background(Color(.systemBackground))
//                                .cornerRadius(12)
//                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.main.opacity(0.3), lineWidth: 1))
//                            }
//                        }
//                        
//                        HStack(spacing: 12) {
//                            VStack(alignment: .leading, spacing: 8) {
//                                Label("Start Date", systemImage: "calendar")
//                                    .font(.subheadline)
//                                    .fontWeight(.semibold)
//                                    .foregroundStyle(.black)
//                                
//                                DatePicker("", selection: $startDate, displayedComponents: .date)
//                                    .labelsHidden()
//                                    .datePickerStyle(.compact)
//                                    .tint(.main)
//                                    .onChange(of: startDate) { oldValue, newValue in
//                                        endDate = DateManager.shared.calculateEndDate(
//                                            startDate: newValue,
//                                            months: Int(membershipMonths) ?? 1
//                                        )
//                                    }
//                            }
//                            
//                            VStack(alignment: .leading, spacing: 8) {
//                                Label("End Date", systemImage: "calendar")
//                                    .font(.subheadline)
//                                    .fontWeight(.semibold)
//                                    .foregroundStyle(.black)
//                                
//                                DatePicker("", selection: $endDate, displayedComponents: .date)
//                                    .labelsHidden()
//                                    .datePickerStyle(.compact)
//                                    .tint(.main)
//                            }
//                        }
//                    }
//                    .padding(16)
//                    .background(Color(.secondarySystemBackground))
//                    .cornerRadius(16)
//                    
//                    // MARK: - Payment Section with Auto-calculated amounts
//                    VStack(spacing: 16) {
//                        SectionHeader(title: "Payment Information", icon: "banknote.fill")
//                        
//                        VStack(alignment: .leading, spacing: 8) {
//                            Label("Payment Method", systemImage: "creditcard")
//                                .font(.subheadline)
//                                .fontWeight(.semibold)
//                                .foregroundStyle(.black)
//                            
//                            Picker("Method", selection: $paymentMethod) {
//                                ForEach(paymentMethods, id: \.self) { method in
//                                    Text(method).tag(method)
//                                }
//                            }
//                            .pickerStyle(.menu)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .tint(.main)
//                        }
//                        
//                        FormTextField(label: "Amount Paid", placeholder: "Enter amount", text: $amountPaid, icon: "indianrupeesign", keyboardType: .decimalPad)
//                        
//                        // Total Amount Display
//                        VStack(spacing: 12) {
//                            HStack {
//                                Text("Total Amount")
//                                    .font(.subheadline)
//                                    .foregroundStyle(.gray)
//                                Spacer()
//                                Text("₹\(Int(totalAmount))")
//                                    .font(.headline)
//                                    .fontWeight(.bold)
//                                    .foregroundStyle(.black)
//                            }
//                            
//                            HStack {
//                                Text("Amount Paid")
//                                    .font(.subheadline)
//                                    .foregroundStyle(.gray)
//                                Spacer()
//                                Text("₹\(amountPaid.isEmpty ? "0" : amountPaid)")
//                                    .font(.headline)
//                                    .fontWeight(.bold)
//                                    .foregroundStyle(.green)
//                            }
//                            
//                            HStack {
//                                Text("Amount Due")
//                                    .font(.subheadline)
//                                    .foregroundStyle(.gray)
//                                Spacer()
//                                Text("₹\(Int(amountDue))")
//                                    .font(.headline)
//                                    .fontWeight(.bold)
//                                    .foregroundStyle(amountDue > 0 ? .orange : .green)
//                            }
//                        }
//                        .padding(12)
//                        .background(Color.main.opacity(0.05))
//                        .cornerRadius(10)
//                    }
//                    .padding(16)
//                    .background(Color(.secondarySystemBackground))
//                    .cornerRadius(16)
//                    
//                    // MARK: - Emergency Contact Section
//                    VStack(spacing: 16) {
//                        SectionHeader(title: "Emergency Contact", icon: "phone.badge.checkmark")
//                        
//                        FormTextField(label: "Contact Name", placeholder: "Enter name", text: $emergencyContact, icon: "person")
//                        FormTextField(label: "Contact Phone", placeholder: "Enter phone", text: $emergencyPhone, icon: "phone")
//                    }
//                    .padding(16)
//                    .background(Color(.secondarySystemBackground))
//                    .cornerRadius(16)
//                    
//                    // MARK: - Notes Section
//                    VStack(spacing: 16) {
//                        SectionHeader(title: "Additional Notes", icon: "note.text")
//                        
//                        TextEditor(text: $notes)
//                            .frame(height: 80)
//                            .padding(12)
//                            .background(Color(.systemBackground))
//                            .cornerRadius(12)
//                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.main.opacity(0.3), lineWidth: 1))
//                    }
//                    .padding(16)
//                    .background(Color(.secondarySystemBackground))
//                    .cornerRadius(16)
//                    
//                    // MARK: - Save Button
//                    Button(action: saveMember) {
//                        HStack {
//                            Image(systemName: "checkmark.circle.fill")
//                            Text("Save Member")
//                                .fontWeight(.semibold)
//                        }
//                        .font(.title3)
//                        .frame(maxWidth: .infinity)
//                        .frame(height: 56)
//                        .foregroundStyle(.white)
//                        .background(Color.main)
//                        .cornerRadius(16)
//                    }
//                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty || phone.trimmingCharacters(in: .whitespaces).isEmpty)
//                    .opacity(name.isEmpty || phone.isEmpty ? 0.6 : 1.0)
//                    .padding(.top, 8)
//                }
//                .padding(16)
//            }
//            .navigationTitle("Add New Member")
//            .navigationBarTitleDisplayMode(.inline)
//            .background(Color(.systemBackground))
//        }
//    }
//    
//    private func saveMember() {
//        // Validate using ValidationManager
//        guard ValidationManager.shared.isValidName(name) else { return }
//        guard ValidationManager.shared.isValidPhone(phone) else { return }
//        guard ValidationManager.shared.isValidAge(age) else { return }
//        
//        // Create member using MemberBuilder
//        if let newMember = MemberBuilder.shared.createMember(
//            name: name,
//            age: age,
//            gender: gender,
//            phone: phone,
//            address: address,
//            profileImage: selectedImage,
//            membershipPlan: membershipPlan,
//            membershipMonths: membershipMonths,
//            startDate: startDate,
//            endDate: endDate,
//            paymentMethod: paymentMethod,
//            amountPaid: amountPaid,
//            emergencyContact: emergencyContact,
//            emergencyPhone: emergencyPhone,
//            bloodGroup: bloodGroup,
//            notes: notes
//        ) {
//            viewModel.addMember(newMember)
//            dismiss()
//        }
//    }
//}
//
//// MARK: - Plan Price Card Component
//struct PlanPriceCard: View {
//    let plan: String
//    let price: Double
//    let description: String
//    let isSelected: Bool
//    
//    var body: some View {
//        HStack(spacing: 12) {
//            VStack(alignment: .leading, spacing: 4) {
//                Text(plan)
//                    .font(.subheadline)
//                    .fontWeight(.semibold)
//                    .foregroundStyle(.black)
//                
//                Text(description)
//                    .font(.caption2)
//                    .foregroundStyle(.gray)
//            }
//            
//            Spacer()
//            
//            VStack(alignment: .trailing, spacing: 2) {
//                Text("₹\(Int(price))")
//                    .font(.headline)
//                    .fontWeight(.bold)
//                    .foregroundStyle(.main)
//                
//                Text("per month")
//                    .font(.caption2)
//                    .foregroundStyle(.gray)
//            }
//            
//            if isSelected {
//                Image(systemName: "checkmark.circle.fill")
//                    .font(.title3)
//                    .foregroundStyle(.main)
//            }
//        }
//        .padding(10)
//        .background(isSelected ? Color.main.opacity(0.1) : Color(.systemBackground))
//        .cornerRadius(8)
//        .overlay(RoundedRectangle(cornerRadius: 8).stroke(isSelected ? Color.main : Color.main.opacity(0.2), lineWidth: 1))
//    }
//}
//
//// MARK: - Helper Components
//struct SectionHeader: View {
//    let title: String
//    let icon: String
//    
//    var body: some View {
//        HStack(spacing: 12) {
//            Image(systemName: icon)
//                .font(.title3)
//                .foregroundStyle(.main)
//            
//            Text(title)
//                .font(.headline)
//                .fontWeight(.semibold)
//                .foregroundStyle(.black)
//            
//            Spacer()
//        }
//    }
//}
//
//struct FormTextField: View {
//    let label: String
//    let placeholder: String
//    @Binding var text: String
//    let icon: String
//    var keyboardType: UIKeyboardType = .default
//    var isDropdown: Bool = false
//    var items: [String] = []
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            Label(label, systemImage: icon)
//                .font(.subheadline)
//                .fontWeight(.semibold)
//                .foregroundStyle(.black)
//            
//            if isDropdown {
//                Picker(label, selection: $text) {
//                    ForEach(items, id: \.self) { item in
//                        Text(item).tag(item)
//                    }
//                }
//                .pickerStyle(.menu)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .tint(.main)
//            } else {
//                TextField(placeholder, text: $text)
//                    .keyboardType(keyboardType)
//                    .padding(12)
//                    .background(Color(.systemBackground))
//                    .cornerRadius(12)
//                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.main.opacity(0.3), lineWidth: 1))
//            }
//        }
//    }
//}
//
//#Preview {
//    AddSheet2(viewModel: MembersViewModel())
//}
import SwiftUI
import PhotosUI

struct AddSheet2: View {
    @Environment(\.dismiss) var dismiss
    var viewModel: MembersViewModel
    
    @State var name: String = ""
    @State var age: String = ""
    @State var gender: String = ""
    @State var phone: String = ""
    @State var address: String = ""
    @State var selectedImage: UIImage?
    @State var photosPickerItem: PhotosPickerItem?
    @State var membershipPlan: String = "Premium"
    @State var membershipMonths: String = "1"
    @State var startDate = Date()
    @State var endDate = Date().addingTimeInterval(2592000)
    @State var paymentMethod: String = "Cash"
    @State var amountPaid: String = ""
    @State var emergencyContact: String = ""
    @State var emergencyPhone: String = ""
    @State var bloodGroup: String = "O+"
    @State var notes: String = ""
    
    let membershipPlans = ["Basic", "Premium", "Gold"]
    let paymentMethods = ["Cash", "Card", "UPI", "Bank Transfer"]
    let bloodGroups = ["O+", "O-", "A+", "A-", "B+", "B-", "AB+", "AB-"]
    
    var monthlyPrice: Double {
        PricingManager.shared.getPricePerMonth(for: membershipPlan)
    }
    
    var totalAmount: Double {
        PaymentCalculator.shared.calculateTotalAmount(
            plan: membershipPlan,
            months: membershipMonths
        )
    }
    
    var amountDue: Double {
        let paid = Double(amountPaid) ?? 0
        return PaymentCalculator.shared.calculateAmountDue(
            totalAmount: totalAmount,
            amountPaid: paid
        )
    }
    
    var pricingInfo: String {
        "₹\(Int(monthlyPrice))/month × \(membershipMonths) months = ₹\(Int(totalAmount))"
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    VStack(spacing: 12) {
                        PhotosPicker(selection: $photosPickerItem, matching: .images) {
                            ZStack(alignment: .bottomTrailing) {
                                if let selectedImage {
                                    Image(uiImage: selectedImage)
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
                                    
                                    Image(systemName: "camera.circle.fill")
                                        .font(.system(size: 40))
                                        .foregroundStyle(.main)
                                        .background(Circle().fill(Color(.systemBackground)))
                                }
                            }
                        }
                        .onChange(of: photosPickerItem) { oldValue, newValue in
                            Task {
                                if let data = try? await newValue?.loadTransferable(type: Data.self) {
                                    if let uiImage = UIImage(data: data) {
                                        selectedImage = uiImage
                                    }
                                }
                            }
                        }
                        
                        if selectedImage == nil {
                            Text("Tap to add profile picture")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    
                    VStack(spacing: 16) {
                        SectionHeader(title: "Personal Information", icon: "person.fill")
                        
                        FormTextField(label: "Full Name", placeholder: "Enter name", text: $name, icon: "person")
                        FormTextField(label: "Phone Number", placeholder: "Enter phone", text: $phone, icon: "phone")
                        FormTextField(label: "Age", placeholder: "Enter age", text: $age, icon: "calendar", keyboardType: .numberPad)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Label("Gender", systemImage: "person.2")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                            
                            Picker("Gender", selection: $gender) {
                                Text("Male").tag("Male")
                                Text("Female").tag("Female")
                                Text("Other").tag("Other")
                            }
                            .pickerStyle(.segmented)
                            .tint(.main)
                        }
                        
                        FormTextField(label: "Blood Group", placeholder: "Select", text: $bloodGroup, icon: "drop.fill", isDropdown: true, items: bloodGroups)
                    }
                    .padding(16)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(16)
                    
                    VStack(spacing: 16) {
                        SectionHeader(title: "Address", icon: "location.fill")
                        FormTextField(label: "Address", placeholder: "Enter address", text: $address, icon: "building.2")
                    }
                    .padding(16)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(16)
                    
                    VStack(spacing: 16) {
                        SectionHeader(title: "Membership Details", icon: "creditcard.fill")
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Label("Membership Plan", systemImage: "star.fill")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                            
                            Picker("Plan", selection: $membershipPlan) {
                                ForEach(membershipPlans, id: \.self) { plan in
                                    Text(plan).tag(plan)
                                }
                            }
                            .pickerStyle(.segmented)
                            .tint(.main)
                        }
                        
                        VStack(spacing: 8) {
                            ForEach(membershipPlans, id: \.self) { plan in
                                if let planDetails = PricingManager.shared.getPlanDetails(for: plan) {
                                    PlanPriceCard(
                                        plan: plan,
                                        price: planDetails.monthlyPrice,
                                        description: planDetails.description,
                                        isSelected: membershipPlan == plan
                                    )
                                }
                            }
                        }
                        .padding(12)
                        .background(Color.main.opacity(0.05))
                        .cornerRadius(10)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(pricingInfo)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                            
                            if let planDetails = PricingManager.shared.getPlanDetails(for: membershipPlan) {
                                Text(planDetails.description)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Features:")
                                        .font(.caption2)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.black)
                                    
                                    ForEach(planDetails.features, id: \.self) { feature in
                                        HStack(spacing: 6) {
                                            Image(systemName: "checkmark.circle.fill")
                                                .font(.caption2)
                                                .foregroundStyle(.main)
                                            Text(feature)
                                                .font(.caption2)
                                                .foregroundStyle(.gray)
                                        }
                                    }
                                }
                                .padding(.top, 8)
                            }
                        }
                        .padding(12)
                        .background(Color.main.opacity(0.1))
                        .cornerRadius(10)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Label("Duration (Months)", systemImage: "clock.fill")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                            
                            Menu {
                                ForEach(1...12, id: \.self) { month in
                                    Button(action: {
                                        membershipMonths = String(month)
                                        endDate = DateManager.shared.calculateEndDate(
                                            startDate: startDate,
                                            months: month
                                        )
                                    }) {
                                        HStack {
                                            Text("\(month) Month\(month > 1 ? "s" : "")")
                                            if membershipMonths == String(month) {
                                                Image(systemName: "checkmark")
                                                    .foregroundStyle(.main)
                                            }
                                        }
                                    }
                                }
                            } label: {
                                HStack {
                                    Text("\(membershipMonths) Month\(Int(membershipMonths) ?? 1 > 1 ? "s" : "")")
                                        .foregroundStyle(.black)
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                        .foregroundStyle(.main)
                                }
                                .padding(12)
                                .background(Color(.systemBackground))
                                .cornerRadius(12)
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.main.opacity(0.3), lineWidth: 1))
                            }
                        }
                        
                        HStack(spacing: 12) {
                            VStack(alignment: .leading, spacing: 8) {
                                Label("Start Date", systemImage: "calendar")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black)
                                
                                DatePicker("", selection: $startDate, displayedComponents: .date)
                                    .labelsHidden()
                                    .datePickerStyle(.compact)
                                    .tint(.main)
                                    .onChange(of: startDate) { oldValue, newValue in
                                        endDate = DateManager.shared.calculateEndDate(
                                            startDate: newValue,
                                            months: Int(membershipMonths) ?? 1
                                        )
                                    }
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Label("End Date", systemImage: "calendar")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black)
                                
                                DatePicker("", selection: $endDate, displayedComponents: .date)
                                    .labelsHidden()
                                    .datePickerStyle(.compact)
                                    .tint(.main)
                            }
                        }
                    }
                    .padding(16)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(16)
                    
                    VStack(spacing: 16) {
                        SectionHeader(title: "Payment Information", icon: "banknote.fill")
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Label("Payment Method", systemImage: "creditcard")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                            
                            Picker("Method", selection: $paymentMethod) {
                                ForEach(paymentMethods, id: \.self) { method in
                                    Text(method).tag(method)
                                }
                            }
                            .pickerStyle(.menu)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .tint(.main)
                        }
                        
                        FormTextField(label: "Amount Paid", placeholder: "Enter amount", text: $amountPaid, icon: "indianrupeesign", keyboardType: .decimalPad)
                        
                        VStack(spacing: 12) {
                            HStack {
                                Text("Total Amount")
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                                Spacer()
                                Text("₹\(Int(totalAmount))")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)
                            }
                            
                            HStack {
                                Text("Amount Paid")
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                                Spacer()
                                Text("₹\(amountPaid.isEmpty ? "0" : amountPaid)")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.green)
                            }
                            
                            HStack {
                                Text("Amount Due")
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                                Spacer()
                                Text("₹\(Int(amountDue))")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(amountDue > 0 ? .orange : .green)
                            }
                        }
                        .padding(12)
                        .background(Color.main.opacity(0.05))
                        .cornerRadius(10)
                    }
                    .padding(16)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(16)
                    
                    VStack(spacing: 16) {
                        SectionHeader(title: "Emergency Contact", icon: "phone.badge.checkmark")
                        
                        FormTextField(label: "Contact Name", placeholder: "Enter name", text: $emergencyContact, icon: "person")
                        FormTextField(label: "Contact Phone", placeholder: "Enter phone", text: $emergencyPhone, icon: "phone")
                    }
                    .padding(16)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(16)
                    
                    VStack(spacing: 16) {
                        SectionHeader(title: "Additional Notes", icon: "note.text")
                        
                        TextEditor(text: $notes)
                            .frame(height: 80)
                            .padding(12)
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.main.opacity(0.3), lineWidth: 1))
                    }
                    .padding(16)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(16)
                    
                    Button(action: saveMember) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Save Member")
                                .fontWeight(.semibold)
                        }
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .foregroundStyle(.white)
                        .background(Color.main)
                        .cornerRadius(16)
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty || phone.trimmingCharacters(in: .whitespaces).isEmpty)
                    .opacity(name.isEmpty || phone.isEmpty ? 0.6 : 1.0)
                    .padding(.top, 8)
                }
                .padding(16)
            }
            .navigationTitle("Add New Member")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemBackground))
        }
    }
    
    private func saveMember() {
        guard ValidationManager.shared.isValidName(name) else { return }
        guard ValidationManager.shared.isValidPhone(phone) else { return }
        guard ValidationManager.shared.isValidAge(age) else { return }
        
        let paidAmount = Double(amountPaid) ?? 0.0
        let calculatedDue = totalAmount - paidAmount
        
        let paymentStatus: String
        if calculatedDue <= 0 {
            paymentStatus = "Paid"
        } else if paidAmount > 0 {
            paymentStatus = "Partial"
        } else {
            paymentStatus = "Due"
        }
        
        if var newMember = MemberBuilder.shared.createMember(
            name: name,
            age: age,
            gender: gender,
            phone: phone,
            address: address,
            profileImage: selectedImage,
            membershipPlan: membershipPlan,
            membershipMonths: membershipMonths,
            startDate: startDate,
            endDate: endDate,
            paymentMethod: paymentMethod,
            amountPaid: amountPaid,
            emergencyContact: emergencyContact,
            emergencyPhone: emergencyPhone,
            bloodGroup: bloodGroup,
            notes: notes
        ) {
            newMember.totalAmount = totalAmount
            newMember.amountDue = calculatedDue
            newMember.paymentStatus = paymentStatus
            
            viewModel.addMember(newMember)
            dismiss()
        }
    }
}

struct PlanPriceCard: View {
    let plan: String
    let price: Double
    let description: String
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(plan)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                Text(description)
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text("₹\(Int(price))")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.main)
                
                Text("per month")
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
            
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title3)
                    .foregroundStyle(.main)
            }
        }
        .padding(10)
        .background(isSelected ? Color.main.opacity(0.1) : Color(.systemBackground))
        .cornerRadius(8)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(isSelected ? Color.main : Color.main.opacity(0.2), lineWidth: 1))
    }
}

struct SectionHeader: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(.main)
            
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
            
            Spacer()
        }
    }
}

struct FormTextField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    let icon: String
    var keyboardType: UIKeyboardType = .default
    var isDropdown: Bool = false
    var items: [String] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(label, systemImage: icon)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
            
            if isDropdown {
                Picker(label, selection: $text) {
                    ForEach(items, id: \.self) { item in
                        Text(item).tag(item)
                    }
                }
                .pickerStyle(.menu)
                .frame(maxWidth: .infinity, alignment: .leading)
                .tint(.main)
            } else {
                TextField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .padding(12)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.main.opacity(0.3), lineWidth: 1))
            }
        }
    }
}

#Preview {
    AddSheet2(viewModel: MembersViewModel())
}
