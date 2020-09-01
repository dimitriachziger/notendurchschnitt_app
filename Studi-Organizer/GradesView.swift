//
//  GradesView.swift
//  Studi-Organizer
//
//  Created by Dima on 01.04.20.
//  Copyright © 2020 Dimitri Achziger. All rights reserved.
//

import SwiftUI


struct GradesView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Subject.entity(), sortDescriptors: []) var subjects:FetchedResults<Subject>
    
    @State private var showSheet = false
    @State private var showEditSheet = false
    
    //   @State private var subjects = CoreDataManager.shared.getItems()
    @State private var average = Double(Double.nan)
    
    //@State private var selectedSub = Subject()
    
    var sumMarks : Double {
        subjects.reduce(0) {
            $0 + $1.mark
        }
    }
    
    var countSubjects : Int { subjects.count }
    
    var sumECTS : Int {
        subjects.reduce(0) {
            $0 + Int($1.points)
        }
    }
    
    var sumOfMultMarksAndPoints : Double {
        subjects.reduce(0) {
            let a = $1.mark * Double($1.points)
            return $0 + a
        }
    }
    
    var grade_average : Int {
        countSubjects
    }
    
    @State var param = "vonGradesView"
    
    var body: some View {
       // VStack {
            NavigationView {
                VStack {
                    Button(action: {
                        self.showSheet.toggle()
                        print("Button pressed")
                    }) {
                        Spacer().frame(width: 20)
                        Image(systemName: "plus")
                        Spacer()
                        Text("Note hinzufügen")
                            .font(.title)
                        
                        
                    }
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(5)
                    .padding()
                    List {
                        ForEach(subjects, id: \.id) { sub in
                            NavigationLink(destination: ModifyView(currentSubject: sub) .environment(\.managedObjectContext, self.moc)) {
                                
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(sub.name ?? "Unbekannt")
                                            
                                            .font(.headline)
                                        // .multilineTextAlignment(.leading)
                                        Text("ECTS: \(sub.points)")
                                            .font(.subheadline)
                                            .multilineTextAlignment(.leading)
                                        
                                    }
                                    Spacer()
                                    
                                    Text(String(format:"%.1f", sub.mark))
                                }
                            }
                            
                        }
                        .onMove { (indexSet, index) in
                            print("move")
                        }
                        .onDelete { indexSet in
                            let obj = self.subjects[indexSet.first!]
                            self.moc.delete(obj)
                            do {
                                try self.moc.save()
                            } catch {
                                print("could not save")
                            }
                            //self.subjects.remove(at: indexSet.first!)
                            //test = try? self.moc.fetch(subjects)
                        }
                        .onTapGesture {
                            print("onTap")
                        }
                        
                        
                    }
                        // .border(Color.red)
                        .padding()
                    //.frame(height: 500)
                    
                    
                    //   .padding()
                    // .frame(maxWidth: .infinity)
                    Text("Anzahl Noten: \(countSubjects)")
                    Text("Anzahl ECTS-Punkte: \(sumECTS)")
                    
                    //              .navigationViewStyle(StackNavigationViewStyle())
                    
                    //                Text("Durchschnitt: \(String(format: "%.1f", (sumMarks / Double(countSubjects))))")
                    //                    .font(.title)
                    Text("Durchschnitt: \(String(format: "%.1f", (sumOfMultMarksAndPoints / Double(sumECTS)) ))")
                        .font(.title)
                    
                    
                    
                }
                .navigationBarTitle("Noten")
                .navigationBarItems(trailing: EditButton())
            }
            
       // }
        .sheet(isPresented: $showSheet) {
            AddMarkView(showSheet: self.$showSheet).environment(\.managedObjectContext, self.moc)
            
        }
        //        .sheet(isPresented: $showEditSheet) {
        ////            ModifyView(currentSubject: self.selectedSub).environment(\.managedObjectContext, self.moc)
        //
        //        }
    }
    
    
    
}



struct GradesView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return GradesView().environment(\.managedObjectContext, context)
    }
}
