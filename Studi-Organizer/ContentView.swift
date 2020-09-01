//
//  ContentView.swift
//  Studi-Organizer
//
//  Created by Dima on 01.04.20.
//  Copyright © 2020 Dimitri Achziger. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Subject.entity(), sortDescriptors: []) var subjects:FetchedResults<Subject>
    //    @FetchRequest(fetchRequest: Subject.getAllSubjectItems()) var subjects:FetchedResults<Subject>
    
    @State private var newSubject = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
                List {
                    Text("item")
                    ForEach(subjects, id: \.id) { subject in
                        Text(subject.name ?? "Unknown")
                    }
                }
                Divider()
                NavigationLink(destination: GradesView()) {
                    Text("Notenschnitt berechnen")
                }
            }
        }
        
    }
}

func calc() -> Double {
    return 0.0
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView().environment(\.managedObjectContext, context)
    }
}
#endif


