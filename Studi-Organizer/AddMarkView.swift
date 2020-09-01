//
//  AddMarkView.swift
//  Studi-Organizer
//
//  Created by Dima on 03.04.20.
//  Copyright © 2020 Dimitri Achziger. All rights reserved.
//

import SwiftUI

struct AddMarkView: View {
    @Environment(\.managedObjectContext) var moc
    
    @Binding var showSheet : Bool
    //  @Binding var items : [Subject]
    
    //    var currentSubject : Subject = Subject()
    
    
    @State var subjectName:String = ""
    
    var testStr = "testStr"
    //var test : String = ""
    @State private var mark = Double(exactly: Double.nan)
    @State private var selectedMark = 1.0
    @State private var selectedPoints = 5
    
    @State var showPopover = false
    
    @State var date = Date()
    
    let marks = [1.0 , 1.3, 1.7, 2.0, 2.3, 2.7, 3.0, 3.3, 3.7, 4.0, 5.0]
    
    
    @State private var test = false
    

    
    var body: some View {
        NavigationView {
            VStack(spacing: 15.0) {
                
                //Spacer().frame(height: 100)
                Form {
                HStack {
                    Text("Fach")
                    
                    TextField("Name", text: $subjectName)
                        .disableAutocorrection(true)
                       .multilineTextAlignment(.trailing) .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                }
                
                    Section {
                    Picker("Note", selection: $selectedMark) {
                        ForEach(marks, id: \.self) {
                            Text(String(format: "%.1f", $0))
                        }
                    }
                    
                    
                    // TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: $mark)
                
                //Text("Selection: \(selectedMark)")
                
                
                    
                        Picker("Punkte", selection: $selectedPoints) {
                            ForEach(1...20, id: \.self){
                                Text("\($0)").tag($0)
                            }
                        }
                        
                        DatePicker(selection: self.$date) {
                            Text("Datum")
                            
                        }//.clipped()
                    }
                }
                //Spacer().frame(height: 50)
                Button(action: {
                    
                }) {
                    Text("Show action sheet")
                    
                }
                .actionSheet(isPresented: $test) {

                    ActionSheet(title: Text("Titel"),
                                message: Text("Message"))

                }

                
                Text("Options")
                .contextMenu {
                    Button(action: {
                        // change country setting
                    }) {
                        Text("Choose Country")
                        Image(systemName: "globe")
                    }
                }
                Button("Show popover") {
                    self.showPopover.toggle()
                }.popover(
                    isPresented: self.$showPopover,
                    arrowEdge: .bottom
                ) { Text("popover")
                }
                    
                //.navigationBarBackButtonHidden(true)
                //  .navigationBarTitle(Text("Punkte"))
                
                
                Spacer().frame(height: 50)
                
                VStack() {
                    Button(action: {
                        guard self.subjectName != "" else {
                            print("Kein Fach eingegeben")
                            return
                        }
                        let newSubject = Subject(context: self.moc)
                        newSubject.name = self.subjectName
                        newSubject.mark = self.selectedMark
                        newSubject.points = Int16(self.selectedPoints)
                        try? self.moc.save()
                        print(self.selectedPoints)
                        self.showSheet.toggle()
                    }) {
                        Spacer()
                        Text("Speichern")
                        Spacer()
                    }
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(5)
                    .padding()
                    Button(action: {
                        self.showSheet.toggle()
                    }) {
                        Spacer()
                        Text("Abbrechen")
                        Spacer()
                    }
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(5)
                    .padding()
                    
                }
                .font(.title)
                
            }
            .padding()
        .navigationBarTitle("Neue Note hinzufügen")
        }
        .padding(0.0)
    }
}

struct PickerView:  View {

    
    @Binding private var selectionValue: Int
    
    var body: some View {
        Picker("Punkte", selection: $selectionValue) {
            ForEach(1...20, id: \.self){
                Text("\($0)").tag($0)
            }
        }
    }
}


struct AddMarkView_Previews: PreviewProvider {
    //@State private var str = "testStr"
    //var bind : Binding = ""
    // let param : String = "testPreview"
    @Environment(\.managedObjectContext) static var moc
    
    static var previews: some View {
        //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        
        //        var test = NSEntityDescription.insertNewObjectForEntityForName(Subject,
        //        inManagedObjectContext: context)
        
        
        var testSub : Subject {
            let sub = Subject(context: moc)
            sub.name = "previewName"
            sub.mark = 0.2
            return sub
        }
        
        //        return AddMarkView(showSheet: .constant(true), subjectName: "namePreview", test: testSub)
        return AddMarkView(showSheet: .constant(true), subjectName: "namePreview")
    }
}
