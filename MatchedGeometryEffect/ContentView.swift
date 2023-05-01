//
//  ContentView.swift
//  MatchedGeometryEffect
//
//  Created by sss on 01.05.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var selected = "Meet"
    
    var body: some View {
        HStack {
            MenuView(selectedFood: $selected)
            Spacer()
            
            if selected == "Meet" {
                dishesView
                    .zIndex(1)
                     
                    .transition(.asymmetric(insertion: .offset(y: -500), removal: .offset(y: 500)))
            }
           
            Spacer()
        }
    }
    
    var dishesView: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color("background"))
            .frame(width: 200, height: 300)
            .overlay {
                Text("Dishes")
                    .bold()
                    .foregroundColor(.orange)
            }
            .overlay {
                Circle()
                    .fill(.white.opacity(0.6))
                    .frame(width: 200, height: 200)
            }
            .overlay {
                Image("plate")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .offset(x: -30, y: -120)
            }
    }
}


struct MenuView: View {
    
    @Binding var selectedFood: String
    
    @State var selected = "Meet"
    
    @Namespace var menuSpace
    @Namespace var menuSpace2
    
    var menu = ["Drink", "Meet", "Cheese"]
    
  
    var body: some View {
        VStack(spacing: 150) {
            ForEach(menu, id: \.self) { item in
                
                ZStack(alignment: .bottom) {
                    
                    if selected == item {
                        menuItemView
                    }
                    Text(item)
                        .frame(height: 70)
                        .offset(y: -10)
                        .font(.headline)
                        .foregroundColor(selected == item ? .purple: .black.opacity(0.5))
                        .scaleEffect(selected == item ? 1.5 : 0.8)
                }
                .frame(width: 75)
                .onTapGesture {
                    withAnimation(.spring()) {
                        selected = item
                        selectedFood = item
                    }
                }
                
            }
            .rotationEffect(Angle(degrees: 270))
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("background"))
                .frame(width: 50,
                       height: UIScreen.main.bounds.height + 100)
        )
        
        .offset(x: -10)
        
    }
    
    
    var menuItemView: some View {
        VStack {
            Circle()
                .fill(Color("background"))
                .matchedGeometryEffect(id: "menuSpace2", in: menuSpace2)
                .frame(width: 90, height: 90)
                .offset(y: 10)
            
            Circle()
                .fill(.purple)
                .matchedGeometryEffect(id: "menuSpace", in: menuSpace)
                .frame(width: 8, height: 8)
                .offset(y: -15)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
