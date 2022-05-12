//
//  secondPage.swift
//  VApp
//
//  Created by Gajender Jangir on 03/05/22.
//

import SwiftUI

struct secondPage: View {
    var body: some View {
        
        ScrollView{
            VStack{
                GeometryReader{
                    
                    proxy in
                    let global = proxy.frame(in: .global)
                    Image("twitter")
                        .resizable()
                        .offset(y: global.minY > 0 ? -global.minY: 0)
                        .frame(height: global.minY > 0 ? UIScreen.main.bounds.height/2.5 + global.minY: UIScreen.main.bounds.height/2.5)
                    
                }
                .frame(height: UIScreen.main.bounds.height/2.8)
                
                ForEach(Range(1...5)){
                    item in
                    Image("cafe-\(item)")
                        .resizable()
                        .frame(width:350,height: 200)
                        .cornerRadius(10)
                }
            }
            
            
            
        }
        
    }
}

struct secondPage_Previews: PreviewProvider {
    static var previews: some View {
        secondPage()
    }
}
