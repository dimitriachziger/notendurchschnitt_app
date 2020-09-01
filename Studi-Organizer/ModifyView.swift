//
//  ModifyView.swift
//  Studi-Organizer
//
//  Created by Dima on 08.04.20.
//  Copyright © 2020 Dimitri Achziger. All rights reserved.
//

import SwiftUI

struct ModifyView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var currentSubject : Subject
    
    // @Binding var showEditSheet : Bool
    
    @State var subjectName = ""
    @State private var mark = Double(exactly: Double.nan)
    @State private var selectedMark = 0.0
    @State private var selectedPoints = 5
    
    
    let marks = [1.0 , 1.3, 1.7, 2.0, 2.3, 2.7, 3.0, 3.3, 3.7, 4.0, 5.0]
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Fach: ")
                    
                    TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: $subjectName)
                        .disableAutocorrection(true)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    
                }
                HStack {
                    Text("Note: ")
                    Picker("SelMark", selection: $selectedMark) {
                        ForEach(marks, id: \.self) {
                            Text(String(format: "%.1f", $0))
                        }
                    }
                    // TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: $mark)
                }
                //Text("Selection: \(selectedMark)")
                
                Picker(selection: $selectedPoints, label: Text("ECTS")) {
                    ForEach(1...20, id: \.self){
                        Text("\($0)").tag($0)
                    }
                }
                
                
                
                //   Spacer().frame(height: 100)
                
                VStack {
                    Button(action: {
                        guard self.subjectName != "" else {
                            print("Kein Fach eingegeben")
                            return
                        }
                        var changed = false
                        if self.currentSubject.name != self.subjectName
                        {
                            self.currentSubject.name = self.subjectName
                            changed = true
                        }
                        
                        if self.currentSubject.mark != self.selectedMark {
                            self.currentSubject.mark = self.selectedMark
                            changed = true
                        }
                        
                        if self.currentSubject.points != self.selectedPoints {
                            self.currentSubject.points = Int16(self.selectedPoints)
                            changed = true
                        }
                        if changed {
                            self.moc.refresh(self.currentSubject, mergeChanges: true)
                            try? self.moc.save()
                            print("change")
                        }
                        
                        self.presentationMode.wrappedValue.dismiss()
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
                        self.presentationMode.wrappedValue.dismiss()
                        //   self.showEditSheet.toggle()
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
            .onAppear {
                self.subjectName = self.currentSubject.name ?? "empty"
                self.selectedMark = self.currentSubject.mark
                self.selectedPoints = Int(self.currentSubject.points)
            }
            .padding()
        .navigationBarTitle("Note bearbeiten")
        }
    }
}

struct ModifyView_Previews: PreviewProvider {
    
    @Environment(\.managedObjectContext) static var moc
    
    static var previews: some View {
        
        var testSub : Subject {
            let sub = Subject(context: moc)
            sub.name = "previewName"
            sub.mark = 3.7
            sub.points = 6
            return sub
        }
        
        //        return AddMarkView(showSheet: .constant(true), subjectName: "namePreview", test: testSub)
        return ModifyView(currentSubject: testSub, subjectName: "namePreview")
    }
}
