//
//  EmojiRatingView.swift
//  Bookworm App
//
//  Created by Alicia Windsor on 11/06/2021.
//

import SwiftUI

struct EmojiRatingView: View {
    
    let rating: Int16
    
    var body: some View {
        
        ZStack{
            Circle()
                .fill(Color.blue)
                .frame(width: 50, height: 50)
            switch rating {
                case 1:
                    Text("1")
                case 2:
                    Text("2")
                case 3:
                    Text("3")
                case 4:
                    Text("4")
                case 5:
                    Text("5")
                default:
                    Text("0")
            }
        }
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: 3)
    }
}
