//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Kafui Kpoh on 19/03/2023.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        VStack {
            // Only show video if we get a valid url
            if url != nil {
                
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            
            // Description
            CodeTextView()
            
            
            // Next element button
                // Show next lesson button, only if there is a next lesson
            if model.hasNextLesson() {
                Button(action: {
                    // Advance the lesson
                    model.nextLesson()
                }, label: {
                    
                    ZStack {
                        
                        RectangleCard(color: Color.green)
                            .frame(height:48)
                        
                        Text("Next lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .foregroundColor(.white)
                            .bold()
                    }
                })
            }
            else {
                
                // Show the complete button instead
                Button(action: {
                    // Complete the lesson and take user back to homeview
                    
                    model.currentContentSelected = 0
                    
                }, label: {
                    
                    ZStack {
                        
                        RectangleCard(color: Color.green)
                            .frame(height:48)
                        
                        Text("Complete")
                            .foregroundColor(.white)
                            .bold()
                    }
                })
            }
            
        }
        .padding()
        .navigationTitle(lesson?.title ?? "")
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
            .environmentObject(ContentModel())
    }
}
