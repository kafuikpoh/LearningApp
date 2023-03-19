//
//  ContentModel.swift
//  LearningApp
//
//  Created by Kafui Kpoh on 17/03/2023.
//

import Foundation

class ContentModel: ObservableObject {
    
    // List of modules
    @Published var modules = [Module]()
    
    // Current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    var styleData: Data?
    
    init(){
        getLocalData()
    }
    
    // MARK: - Data methods
    
    func getLocalData () {
        
        // Get a url for the json file
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        
        do{
            // Read the file into a data object
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            // Try to decode the json into an array of modules
            let jsonDecoder = JSONDecoder()
            
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            // Assign parsed modules to modules property
            self.modules = modules
        }
        catch {
            // TODO: log error
            
            print("Couldn't parse local data")
        }
        
        // Parse the style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            
            // Read the file into a data object
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData
        }
        catch {
            // Log error
            print("Couldn't parse style data")
        }
        
    }
    
    // MARK: - Module navigation methods
    
    func beginModule (_ moduleId:Int) {
        
        // Find the index for this module id
        for index in 0..<modules.count {
            
            // Found the matching index
            if modules[index].id == moduleId {
                currentModuleIndex = index
                
                break
            }
        }
        
        // Set the current module
        currentModule = modules[currentModuleIndex]
    }
}
