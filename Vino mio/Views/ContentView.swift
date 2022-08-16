//
//  ContentView.swift
//  Vino mio
//
//  Created by Hailey Matzen on 7/29/22.
//

import SwiftUI
import Firebase

struct ContentView: View {
    var body: some View {
        
            Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            ContentView()
        }
    }
}

struct Home: View {
    
    @State var show = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View {
        
        NavigationView{
            
            VStack {
                
                if self.status {
                    
                    Library()
                    
                }
                else {
                    
                    ZStack {
                        
                        NavigationLink(destination: SignUp(show: self.$show), isActive: self.$show) {
                            
                            Text("")
                        }
                        .hidden()
                        
                        Login(show: self.$show)
                    }
                }
            }
            
            // Navigation Bar on the top left
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) { (_) in
                
                    self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                }
            }
        }
    }
}

struct Library: View {
    var body: some View {
        
        WineCollectionsView()
    }
}


struct WineWaveView: View {

    let universalSize = UIScreen.main.bounds
    
    var body: some View {
        ZStack{
            
            Wave2()
                .foregroundColor(Color("ErrorColor"))
            Wave1()
                .foregroundColor(Color("background").opacity(0.4))
        }
    }
    
    func Wave1(baseline:CGFloat = UIScreen.main.bounds.height/2) -> Path {
        Path {path in
             path.move(to:CGPoint(x: 0, y: baseline))
            path.addCurve(to: CGPoint(x: universalSize.width, y: baseline),
                          control1: CGPoint(x: universalSize.width * (0.25), y: 200 + baseline),
                          control2: CGPoint(x: universalSize.width * (0.75), y: -200 + baseline)
            )

            path.addLine(to: CGPoint(x: universalSize.width, y: universalSize.height))
            path.addLine(to: CGPoint(x: 0, y: universalSize.height))
            
        }
    }
    func Wave2(baseline:CGFloat = UIScreen.main.bounds.height/2) -> Path {
        Path {path in
             path.move(to:CGPoint(x: 0, y: baseline))
            path.addCurve(to: CGPoint(x: universalSize.width, y: baseline),
                          control1: CGPoint(x: universalSize.width * (0.75), y: -200 + baseline),
                          control2: CGPoint(x: universalSize.width * (0.25), y: 200 + baseline)
            )

            path.addLine(to: CGPoint(x: universalSize.width, y: universalSize.height))
            path.addLine(to: CGPoint(x: 0, y: universalSize.height))
            
        }
    }
}

struct HomeScreen: View {
    
    @State private var notSure: Bool = false
    var body: some View {

        ZStack {
            WineWaveView()
            // Log Out button
            VStack {
            Text("Are you sure?")
                    .foregroundColor(Color("Color"))
                    .fontWeight(.bold)
            Button(action: {
                
                try! Auth.auth().signOut()
                UserDefaults.standard.set(false, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)

            }) {

                Text("Yes, I am sure")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
               
                    
            }
            .background(Color("Color"))
            .cornerRadius(20)
            .padding(.top, 25)
            }

        }
        
    }
    
}

struct Login: View {
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var pass = ""
    @State var visible = false
    @Binding var show: Bool
    @State var alert = false
    @State var error = ""
    
    var body: some View {
        
        ZStack {
            
            ZStack{
                
                 // Background
                WineWaveView()
                
                    // Main screen
                    VStack(spacing: 20) {
                        
                        Image("logo")
                        
                        Text("Log in to your account")
                            .bold()
                            .foregroundColor(Color("Color"))
                            .padding(.top, 35)
                        
                        TextField("Email", text: self.$email)
                            .autocapitalization(.none)
                            .foregroundColor(Color("Color"))
                            .textFieldStyle(.plain)
                            .disableAutocorrection(true)

                        Rectangle()
                            .frame(width: 350, height: 2)
                            .foregroundColor(Color("Color"))
                            .padding(.bottom, 20)
                        
                        // Password session
                        HStack(spacing: 15) {
                            
                            VStack {
                                
                                if self.visible {
                                    
                                    TextField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                }
                                else {
                                    
                                    SecureField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                }
                            }
                            
                            Button(action: {
                                
                                self.visible.toggle()
                                
                            }) {
                                
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(Color("Color"))
                            }
                        }
                        .foregroundColor(Color("Color"))
                        .textFieldStyle(.plain)

                        
                        // Bottom line under password
                        Rectangle()
                            .frame(width: 350, height: 2)
                            .foregroundColor(Color("Color"))
                        
                        // Forgot password button
                        HStack {
                            
                            Spacer()
                            
                            Button(action: {
                                
                                self.reset()
                                
                            }) {
                                
                                Text("Forgot Password?")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("Color"))
                            }
                        }
                        .padding(.top, 25)
                        
                        // Log in button
                        Button(action: {
                            
                            self.verify()

                        }) {

                            Text("Log In")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                                
                        }
                        .background(Color("Color"))
                        .cornerRadius(20)
                        .padding(.top, 25)
                        
                        // Register button
                        Button(action: {
                            
                            self.show.toggle()
                            
                        }) {
                            
                            Text("I am new here!")
                                .fontWeight(.bold)
                                .foregroundColor(Color("Color"))
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(.white)
                        .cornerRadius(20)
                        
                    }
                    .padding(.horizontal, 25)
                    .frame(width: 350)
                
                

            }
            
            if self.alert{
                
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
        
    }
    func verify(){
            
            if self.email != "" && self.pass != "" {
                
                Auth.auth().signIn(withEmail: self.email, password: self.pass) { (res, err) in
                    // res?.user.uid (need user ID to get the user's list of wines)
                    if err != nil {
                        
                        self.error = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    
                    print("success")
                    UserDefaults.standard.set(true, forKey: "status")
                    UserDefaults.standard.set(res?.user.uid, forKey: "userId")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                }
                
            }
            else {
                
                self.error = "Please fill all the contents properly"
                self.alert.toggle()
            }
        }
    func reset() {
        
        if self.email != "" {
            
            Auth.auth().sendPasswordReset(withEmail: self.email) { (err) in
                
                if err != nil {
                    
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                self.error = "RESET"
                self.alert.toggle()
            }
        }
        else {
            
            self.error = "Email Id is empty"
            self.alert.toggle()
        }
        
    }
}
    
struct SignUp: View {
    
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var pass = ""
    @State var repass = ""
    @State var visible = false
    @State var revisible = false
    @Binding var show: Bool
    @State var alert = false
    @State var error = ""
    
    var body: some View {
        
        ZStack {
            
            ZStack{
                
                // Background
//                Color("background")

//                RoundedRectangle(cornerRadius: 30, style: .continuous)
//                    .foregroundStyle(.linearGradient(colors: [.white], startPoint: .topLeading, endPoint: .bottomTrailing))
//                    .frame(width: 1000, height: 1000)
//                    .rotationEffect(.degrees(200))
//                    .offset(y: -500)
                    WineWaveView()
                    // Main screen
                    VStack(spacing: 20) {
                        
                            // Back button (I am not sure where to put it)
                            Button(action: {
                                self.show.toggle()
                            }) {

                                Image(systemName: "chevron.left")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .foregroundColor(Color("Color"))
                                    .padding(.vertical)
                                    .frame(width: 50, height: 50)

                            }
                            .background(Color("background"))
                            .cornerRadius(50)
                            .padding(.top, 25)
     
                        Image("logo")
                            .padding(.bottom, 70)

                        TextField("Email", text: self.$email)
                            .autocapitalization(.none)
                            .foregroundColor(Color("Color"))
                            .textFieldStyle(.plain)

                        Rectangle()
                            .frame(width: 350, height: 2)
                            .foregroundColor(Color("Color"))

                        // Password session
                        HStack(spacing: 15) {
                            
                            VStack {
                                
                                if self.visible {
                                    
                                    TextField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                }
                                else {
                                    
                                    SecureField("Password", text: self.$pass)
                                        .autocapitalization(.none)
                                }
                            }
                            
                            Button(action: {
                                
                                self.visible.toggle()
                                
                            }) {
                                
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(Color("Color"))
                            }
                        }
                        .foregroundColor(Color("Color"))
                        .textFieldStyle(.plain)

                        
                        // Bottom line under password
                        Rectangle()
                            .frame(width: 350, height: 2)
                            .foregroundColor(Color("Color"))
    //                        .padding(.bottom, 20)
                        
                        // Password(repeat) button
                        HStack(spacing: 15) {
                            
                            VStack {
                                
                                if self.revisible {
                                    
                                    TextField("Password(repeat)", text: self.$repass)
                                        .autocapitalization(.none)
                                }
                                else {
                                    
                                    SecureField("Password(repeat)", text: self.$repass)
                                        .autocapitalization(.none)
                                }
                            }
                            
                            Button(action: {
                                
                                self.revisible.toggle()
                                
                            }) {
                                
                                Image(systemName: self.revisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(Color("Color"))
                            }
                        }
                        .foregroundColor(Color("Color"))
                        .textFieldStyle(.plain)

                        
                        // Bottom line under password
                        Rectangle()
                            .frame(width: 350, height: 2)
                            .foregroundColor(Color("Color"))
    //                        .padding(.bottom, 20)
                        
                        // Sign Up button
                        Button(action: {
                            
                            self.register()

                        }) {

                            Text("I love to join 🍷")
                                .fontWeight(.bold)
                                .foregroundColor(Color("Color"))
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                                
                        }
                        .background(.white)
                        .cornerRadius(20)
                        .padding(.top, 25)
                        .padding(.bottom, 200)
                    }
//                    .padding(.horizontal, 25)
                    .frame(width: 350)
                
                

            }
            
            if self.alert {
                
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
        // Navigation Bar on the top
        .navigationBarBackButtonHidden(true)
    }
    
    func register() {
        
        if self.email != "" {
            
            if self.pass == self.repass {
                
                Auth.auth().createUser(withEmail: self.email, password: self.pass) { (res, err) in
                    
                    if err != nil {
                        
                        self.error = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    
                    print("Success")
                    
                    UserDefaults.standard.set(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                }
            }
            else {
                
                self.error = "Passwords do not match"
                self.alert.toggle()
            }
        }
        else {
            
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
    }
    
}

struct ErrorView: View {
    
    @State var color = Color.black.opacity(0.7)
    @Binding var alert: Bool
    @Binding var error: String
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                HStack {
                    
                    Text(self.error == "RESET" ? "Message" : "Error")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                    
                    Spacer()
                }
                .padding(.horizontal, 25)
                
                Text(self.error == "RESET" ? "Password reset link has been sent successfully" : self.error)
                    .foregroundColor(self.color)
                    .padding(.top)
                    .padding(.horizontal, 25)
                
                Button(action: {
                    
                    self.alert.toggle()
                }) {
                    
                    Text(self.error == "RESET" ? "OK": "Cancel")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 120)
                        .background(Color("Color"))
                }
            }
            .padding(.vertical, 25)
            .frame(width: UIScreen.main.bounds.width - 10)
            .background(Color("ErrorColor"))
//            .cornerRadius(15)
        }
        .background(Color.black.opacity(0.35).edgesIgnoringSafeArea(.all))
    }
}
