//
//  DropDown.swift
//  Apego
//
//  Created by Daniel Nobre on 21/06/24.
//

import SwiftUI

struct MyDropDown: View {
    let title: String
    let prompt: String
    let options: [String]
    
    @State private var isExpanded = false
    @Binding var selection: String?
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.footnote)
                .foregroundStyle(.gray)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            VStack{
                HStack{
                    Text(prompt)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .rotationEffect(.degrees(isExpanded ? -180 : 0))
                    
                }
                .frame(height: 40)
                .padding(.horizontal)
                .onTapGesture {
                    withAnimation(.snappy) { isExpanded.toggle()}
                }
                if isExpanded {
                    VStack{
                        ForEach(options, id: \.self) { option in
                            HStack{
                                Text(option)
                                    .foregroundStyle(selection == option ? Color.primary : .gray)
                                
                                Spacer()
                                
                                if selection == option {
                                    Image(systemName: "checkmark")
                                        .font(.subheadline)
                                }
                            }
                            .frame(height: 40)
                            .padding(.horizontal)
                            .onTapGesture {
                                withAnimation(.snappy){
                                    selection = option
                                    isExpanded.toggle()
                                }
                            }
                        }
                    }
                    .transition(.move(edge: .bottom))
                }
            }
            .background(Color.cinzaClaro)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 0.25)
            .frame(width: 353, height: 38)
        }
    }
}

#Preview {
    MyDropDown(title: "Make", prompt: "Selecione a Categoria", options: [
        "Camisa", "Calça", "Sapato"
    ], selection: .constant("Camisa"))
}
