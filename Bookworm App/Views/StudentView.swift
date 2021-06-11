//
//  ContentView.swift
//  Bookworm App
//
//  Created by Alicia Windsor on 10/06/2021.
//

import SwiftUI
import CoreData

struct StudentView: View {
    @Environment(\.managedObjectContext) private var moc


    @FetchRequest(entity: Student.entity(), sortDescriptors: [])
     var students: FetchedResults<Student>
    
    var body: some View {
        VStack{
            
            List {
                ForEach(students, id: \.id) { student in
                    Text(student.name ?? "Unknown")
                }
            }
            
            Button("Add"){
                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                //can use nil coalessing values instead of a forced unwrap
                let chosenFirstName = firstNames.randomElement()!
                let chosenLastName = lastNames.randomElement()!
                
                let student = Student(context: self.moc)
                student.id = UUID()
                student.name = "\(chosenFirstName) \(chosenLastName)"
                
                do{
                    try self.moc.save()
                } catch {
                    print(error)
                    
                }

            }
            
        }
    }

}

struct StudentView_Previews: PreviewProvider {
    static var previews: some View {
        StudentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
