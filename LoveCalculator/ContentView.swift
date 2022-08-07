//
//  ContentView.swift
//  LoveCalculator
//
//  Created by Kishan Kr Sharma on 8/6/22.
//

import SwiftUI

struct ContentView: View {
    var appName:String = "Love Calculator ❤️"
    @State private var yourName:String=""
    @State private var theirName:String=""
    @State private var yourDob = Date()
    @State private var theirDob = Date()
    @State private var yourGender = "Male"
    @State private var theirGender = "Female"

    
    @State private var lovePercentage:CGFloat=0
    @State private var buttonTitle:String = "Check"
    @State private var showPercentage:Bool = false
    @State private var shoWError:Bool = false
    
    var body: some View {
        NavigationView{
            Form{
//                First section starts
                Section{
                        TextField("Full Name", text: $yourName)
                            .keyboardType(.alphabet)
                    
                    DatePicker(selection: $yourDob, in: ...Date(), displayedComponents: .date) {
                                    Text("Date of birth")
                    }.statusBar(hidden: true)
                        
                    Picker("Choose gender", selection: $yourGender){
                        ForEach(["Male","Female","Other"], id:\.self){
                            Text("\($0)")
                        }
                    }.pickerStyle(.segmented)
                }header: {
                    Text("Your Details")
                }
//                first section ends
                
//                Second section starts
                Section{
                        TextField("Full Name", text: $theirName)
                            .keyboardType(.alphabet)
                    DatePicker(selection: $theirDob, in: ...Date(), displayedComponents: .date) {
                                    Text("Date of birth")
                    }
                    Picker("Choose gender", selection: $theirGender){
                        ForEach(["Male","Female","Other"], id:\.self){
                            Text("\($0)")
                        }
                    }.pickerStyle(.segmented)
                }header: {
                    Text("His/Her Details")
                }
//                Second section ends
                
                Button(buttonTitle){
                    // show or hide percentage
                        showPercentage.toggle()
                        if(buttonTitle=="Check"){
                            // generate randome numbers
                            withAnimation(Animation.easeInOut(duration: 3)) {lovePercentage = CGFloat.random(in: 10...100)}
                            
                            buttonTitle="Reset"
                        }else{
                            buttonTitle="Check"
                            lovePercentage=0.0
                        }
                }.padding().foregroundColor(yourName.isEmpty || theirName.isEmpty ? Color.gray: Color.blue)
                    .disabled(yourName.isEmpty || theirName.isEmpty)
                
//                Fourth section to show/hide love percentage
                Section{
                    if(showPercentage){
                    Circle()
                        .fill(.background)
                        .modifier(AnimatingNumberOverlay(number: lovePercentage))
                }}
                .frame(width: .infinity, height: 70, alignment: .center)
                
            }
            .navigationTitle(appName)
            .background(.blue)
            .foregroundColor(.black)
            
            
        }
    }

}
struct AnimatingNumberOverlay:AnimatableModifier{
    var number:CGFloat
    var animatableData:CGFloat {
        get{
            number
        }
        set{
            number=newValue
        }
    }
    func body(content: Content)-> some View {
//        return content.overlay(Text("\(number)")
          return content.overlay(Text("\(number, specifier: "%.2f") %")
            .font(.system(size: 50))
            .fontWeight(.bold)
            .foregroundColor(number<30 ? .red :number<60 ? .orange : .green)
          )
    }
    
}
