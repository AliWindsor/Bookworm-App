//
//  AddBookView.swift
//  Bookworm App
//
//  Created by Alicia Windsor on 10/06/2021.
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 0
    @State private var genre = ""
    @State private var review = ""
    @State private var fieldError = false
    @State private var dateRead = Date()
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    
    var body: some View {
        
        NavigationView{
            
            Form{
                Section{
                    
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre){
                        ForEach(genres, id: \.self){
                            Text($0)
                        }
                    }
                }
                
                Section{
                    RatingView(rating: $rating)
                    TextField("Write a review", text: $review)
                }
                
                Section{
                    DatePicker("Date Read", selection: $dateRead, displayedComponents: .date)
                }
                
                Section{
                    Button ("Save"){
                        
                        if genre.isEmpty || title.isEmpty || author.isEmpty {
                            self.genreError = true
                            
                        }else{
                            
                        let newBook = Book(context: self.moc)
                        
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.rating = Int16(self.rating)
                        newBook.genre = self.genre
                        newBook.review = self.review
                        newBook.dateAdded = self.dateRead
                        
                        do{
                            try self.moc.save()
                        } catch {
                            print(error)
                        }
                        
                        self.presentationMode.wrappedValue.dismiss()
                        }

                    }
                }
                
            }

            .navigationBarTitle("Add A Book")
        }
        .alert(isPresented: $fieldError){
            Alert(title:Text("Empty fields"),
                  message: Text("You have have left one or more fields empty, please check your details and try again."),
                  dismissButton: .default(Text("Ok"))
            )
        }
        
    }
   
}

