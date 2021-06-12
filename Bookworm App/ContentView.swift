//
//  ContentView.swift
//  Bookworm App
//
//  Created by Alicia Windsor on 10/06/2021.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Book.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Book.title, ascending: true),
                                    NSSortDescriptor(keyPath: \Book.author, ascending: true)])
    var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView{
            
            List{
                ForEach(books, id: \.self){ book in
                    
                    NavigationLink( destination: DetailView(book: book)){
                        
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        
                        VStack(alignment: .leading){
                            if book.rating <= 1{
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                    .foregroundColor(.red)
                            }else{
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                            }
                            Text(book.author ?? "Unknown Author")
                                .foregroundColor(.secondary)
                        }
                        
                    }
                }
                .onDelete(perform: deleteBook)
            }
   
                .navigationBarTitle("Bookworm")
            .navigationBarItems(leading: EditButton(),
                                trailing: Button(action: {
                                    self.showingAddScreen.toggle()
                                    }) {
                                        Image(systemName: "plus")
                                    })
                                    .sheet(isPresented: $showingAddScreen){
                                        AddBookView().environment(\.managedObjectContext, self.moc)
                                    }
            
        }
    }
    
    func deleteBook(at offsets: IndexSet){
        for offset in offsets{
            let book = books[offset] //find item in fetch request
            moc.delete(book) //delete item from context
            do{
                try moc.save() //save new context
            }catch{
                print(error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
