//
//  DetailView.swift
//  Bookworm App
//
//  Created by Alicia Windsor on 11/06/2021.
//

import SwiftUI
import CoreData

struct DetailView: View {
    
    let book: Book
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "Unknown Genre")
                        .frame(maxWidth: geometry.size.width)

                    Text(self.book.genre?.uppercased() ?? "Unknown Genre")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                
                Text(self.book.author ?? "Unknown author")
                    .font(.title)
                    .foregroundColor(.secondary)

                Text(self.book.review ?? "No review")
                    .padding()

                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                
                Text("Date Read: \(self.book.dateAdded ?? Date(), formatter: bookDateFormatter)")
                    .padding()

                Spacer()
                
            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
                                self.showingDeleteAlert = true
                            }) {
                                Image(systemName: "trash")
                            })
        .alert(isPresented: $showingDeleteAlert){
            Alert(title:Text("Delete Book"),
                  message: Text("Are you sure you want to delete this book?"),
                  primaryButton: .destructive(Text("Delete")){
                    self.deleteBook()},
                  secondaryButton: .cancel()
            )
        }
    }
    
    func deleteBook(){
        
        moc.delete(book) //delete item from context
        do{
            try moc.save() //save new context
        }catch{
            print(error)
        }
        
        presentationMode.wrappedValue.dismiss()
    }
    
    let bookDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

        static var previews: some View {
            let book = Book(context: moc)
            book.title = "Test book"
            book.author = "Test author"
            book.genre = "Fantasy"
            book.rating = 4
            book.review = "This was a great book; I really enjoyed it."

            return NavigationView {
                DetailView(book: book)
            }
        }
}
