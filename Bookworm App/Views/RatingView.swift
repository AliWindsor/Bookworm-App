//
//  RatingView.swift
//  Bookworm App
//
//  Created by Alicia Windsor on 11/06/2021.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Int
    
    var label = ""
    
    var maxRating = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "heart.fill")
    
    var offColour = Color.gray
    var onColour = Color.red
    
    var body: some View {
        HStack{
            if label.isEmpty == false{
                Text(label)
            }
            
            ForEach(1..<maxRating + 1){ number in
                self.image(for: number)
                    .foregroundColor(number > self.rating ? self.offColour : self.onColour)
                    .onTapGesture {
                        self.rating = number
                    }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(0))
    }
}
