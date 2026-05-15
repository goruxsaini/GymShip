//
//  ExpiryAlertView.swift
//  GymShip
//
//  Created by Goru Saini on 09/10/25.
//

import SwiftUI

struct ExpiryAlertView: View {
    @State private var showActionSheet:Bool = false
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(Color(.secondarySystemBackground))
                .frame(width: 370, height: 160)
                .padding(.horizontal,16)
            VStack(alignment:.leading){
                Text("Membership Expiry Alerts")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom,4)
                Text("3 expiring in next 7 days")
                    .font(.title3)
                    .padding(.bottom,8)
                Button {
                    showActionSheet.toggle()
                } label: {
                    Text("Send Reminder")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(width:150,height: 40)
                        .background(.main)
                        .cornerRadius(10)
                        .actionSheet(isPresented: $showActionSheet) {
                            getActionSheet()
                        }
                }
            }
        }
    }
    func getActionSheet() -> ActionSheet {
//                    let title = Text("Sending fee Deadline to all members")
            let sendButton : ActionSheet.Button = .default(Text("Send")){}
            let cancelButton : ActionSheet.Button = .cancel{}
            return ActionSheet(
                title: Text("Sending to all members"),
                message: nil,
                buttons: [sendButton,cancelButton])
        
    }
}

#Preview {
    ExpiryAlertView()
}
