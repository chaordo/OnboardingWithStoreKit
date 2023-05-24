//
//  ContentView.swift
//  OnboardingWithStoreKit
//
//  Created by John on 5/24/23.
//

import SwiftUI
import StoreKit

struct ContentView: View {
    
    @StateObject var storeVM = StoreVM()
    
    var body: some View {
        VStack {
            if let subscriptionGroupStatus = storeVM.subscriptionGroupStatus {
                if subscriptionGroupStatus == .expired || subscriptionGroupStatus == .revoked {
                    Text("Welcome back, give the subscription another try.")
                    //display products
                }
            }
            if storeVM.purchasedSubscriptions.isEmpty {
                SubscriptionView()
                
            } else {
                Text("Premium Content")
            }
        }
        .environmentObject(storeVM)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
