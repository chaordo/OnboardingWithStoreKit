//
//  SubscriptionView.swift
//  OnboardingWithStoreKit
//
//  Created by John on 5/24/23.
//

import SwiftUI
import StoreKit

struct SubscriptionView: View {
    
    @EnvironmentObject var storeVM: StoreVM
    @State var isPurchased = false

    var body: some View {
        TabView {
            PageView(
                title: "Ask Your AI",
                subtitle: "Unlock a world of personalized assistance, instant knowledge, and captivating conversations.",
                imageName: "logo",
                showsDismissButton: true
            )
        }
        .tabViewStyle(PageTabViewStyle())
        VStack {
            ForEach(storeVM.subscriptions) { product in
                Button(action: {
                    Task {
                        await buy(product: product)
                    }
                }) {
                    Text(product.displayName)
                        .bold()
                        .foregroundColor(Color.white)
                        .frame(width: 300, height: 50)
                        .background(Color.red)
                        .cornerRadius(20)
                }
            }
        }
        .padding(.bottom, 50)
    }
    
    func buy(product: Product) async {
        do {
            if try await storeVM.purchase(product) != nil {
                isPurchased = true
            }
        } catch {
            print("purchase failed")
        }
    }
}

struct PageView: View {
    let title: String
    let subtitle: String
    let imageName: String
    let showsDismissButton: Bool

    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 150)

            Text(title)
                .font(.system(size: 32))
                .padding(.bottom, 200)

            Text(subtitle)
                .font(.system(size: 20))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(.secondaryLabel))
                .padding()
        }
    }
}

struct SubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionView().environmentObject( StoreVM())
    }
}

