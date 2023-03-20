//
//  ContentView.swift
//  LearningApp
//
//  Created by Kafui Kpoh on 18/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        ScrollView {
            
            LazyVStack {
                
                // Confirm that currentModule is set
                if model.currentModule != nil {
                    
                    ForEach (0..<model.currentModule!.content.lessons.count, id: \.self) { index in
                        
                        NavigationLink(
                            destination: ContentDetailView()
                                .onAppear(perform: {
                                    model.beginLesson(index)
                                }),
                            label: {
                                
                                let lesson = model.currentModule!.content.lessons[index]
                                
                                // Lesson card
                                ZStack (alignment: .leading) {
                                    
                                    Rectangle()
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)
                                        .frame(height: 66)
                                    
                                    HStack (spacing: 30) {
                                        
                                        Text(String(index + 1))
                                            .bold()
                                        
                                        VStack (alignment: .leading ) {
                                            Text(lesson.title)
                                                .bold()
                                            Text(lesson.duration)
                                        }
                                    }
                                    .padding()
                                }
                                .padding(.bottom, 8)
                            })
                        
                        
                    }
                }
            }
            .accentColor(.black)
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
    }
}


