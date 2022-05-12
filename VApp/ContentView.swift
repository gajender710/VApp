//
//  ContentView.swift
//  VApp
//
//  Created by Gajender Jangir on 02/05/22.
//

import SwiftUI

struct MenuItems : Identifiable{
    var id = UUID()
    var name : String
    var iconName : String
    var PageLink : String
}

struct MenuContent: View {
    var items : [MenuItems] = [
        MenuItems(name: "Home",iconName: "house",PageLink: "secondPage"),
        MenuItems(name: "Setting",iconName: "gear",PageLink: "secondPage"),
        MenuItems(name: "Accout",iconName: "person.fill",PageLink: "secondPage"),
        MenuItems(name: "Security",iconName: "key.fill",PageLink: "secondPage"),
        MenuItems(name: "Refer",iconName: "arrowshape.turn.up.right.circle.fill",PageLink: "secondPage")
    ]
    
    var body: some View {
        ZStack {
            Color(UIColor(.teal))
            
            VStack(alignment: .leading, spacing: 0)
            {
                ForEach(items){
                    item in
                    HStack{
                        Image(systemName: item.iconName)
                        
                        Text(item.name)
                            .bold()
                            .font(.system(size: 25))
                            
                    }
                    
                    .padding()
                    Divider()
                }
                Spacer()
            }
            .padding(.top,40)
                
        }
    }
}

struct SideMenu: View {
    
    var width : CGFloat
    var isMenuOpened :Bool
    var isToggle : () -> Void
    var body: some View {
        ZStack {
            GeometryReader{ _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.5))
            .opacity(isMenuOpened ? 1: 0)
            .animation(Animation.easeIn.delay(0.2))
            .onTapGesture {
                self.isToggle()
            }
            
            HStack{
                MenuContent()
                    .frame(width: width)
                    .offset(x: isMenuOpened ? 0 : -width)
                    .animation(.default)
                Spacer()
            }
        }
    }
    
}


struct ContentView: View {
    @State var isMenuOpened = false
    var twitterBG : UIColor = UIColor(red: 29/255.0, green: 161/255.0, blue: 242/255.0, alpha: 1)
    @State var animate : Bool = false
    @State var isSplashOn :Bool = true
    
    var body: some View {
        
        
        VStack {
            ZStack {
                ZStack{
                    HomeView(isMenuOpened: $isMenuOpened)
                }
                ZStack{
                    Color(twitterBG)
                        
                    Image("bird")
                        .resizable()
                        .frame(width: 160, height: 100, alignment: .center)
                        .scaleEffect(animate ? 100 : 1)
                        .animation(Animation.easeIn(duration: 1.5))
                    
                        
                }
                .edgesIgnoringSafeArea(.all)
                .opacity(isSplashOn ? 1 : 0)
                .animation(.default)
                
            }
        }
        .onAppear()
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1, execute: {
                animate.toggle()
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                isSplashOn = false
            })
            
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HomeView: View {
    @Binding var isMenuOpened : Bool
    var body: some View {
        NavigationView {
            ZStack {
                VStack{
                    if !isMenuOpened{
                        Button {
                            //open menu
                            isMenuOpened.toggle()
                        } label: {
                            Text("open menu")
                                .bold()
                                .foregroundColor(.white)
                                .padding(10)
                                .background(.teal)
                                .cornerRadius(10)
                        }
                    }
                    
                    NavigationLink(destination: secondPage()) {
                        Text("NextPage")
                            .bold()
                            .foregroundColor(.white)
                            .padding(10)
                            .background(.teal)
                            .cornerRadius(10)
                        
                    }
                    
                }
                
                
                SideMenu(width: UIScreen.main.bounds.width/1.6, isMenuOpened: isMenuOpened,isToggle: toggleMenu)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    func toggleMenu() {
        isMenuOpened.toggle()
    }
}

extension Thread {

    var threadName: String {
        if let currentOperationQueue = OperationQueue.current?.name {
            return "OperationQueue: \(currentOperationQueue)"
        } else if let underlyingDispatchQueue = OperationQueue.current?.underlyingQueue?.label {
            return "DispatchQueue: \(underlyingDispatchQueue)"
        } else {
            let name = __dispatch_queue_get_label(nil)
            return String(cString: name, encoding: .utf8) ?? Thread.current.description
        }
    }
}
