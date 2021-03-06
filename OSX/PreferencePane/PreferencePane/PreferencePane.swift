//
//  PreferencePane.swift
//  PreferencePane
//
//  Created by Jon Manning on 23/06/2014.
//  Copyright (c) 2014 Secret Lab. All rights reserved.
//

import PreferencePanes


/*
// BEGIN preference_domains
let domainName = "com.oreilly.MyAmazingApplication"
var preferences =
    NSUserDefaults.standardUserDefaults().persistentDomainForName(domainName)
// END preference_domains

// BEGIN preference_setting
preferences["isChecked"] = true
// END preference_setting

// BEGIN preference_saving
NSUserDefaults.standardUserDefaults().setPersistentDomain(preferences,
    forName: domainName)
// END preference_saving
*/

class PreferencePane : NSPreferencePane {
    @IBOutlet var checkbox: NSButton!
    
    let domainName = "com.oreilly.MyAmazingApplication"
    
    // BEGIN main-view-did-load
    override func mainViewDidLoad()  {
        var preferences = NSUserDefaults.standardUserDefaults()
            .persistentDomainForName(domainName)
        
        if let checked = preferences?["isChecked"] as? NSNumber {
            switch checked {
            case true:
                self.checkbox.state = NSOnState
            default:
                self.checkbox.state = NSOffState
            }
        }
        
    }
    // END main-view-did-load
    
    // BEGIN did-unselect
    override func didUnselect()  {
        var preferences = NSUserDefaults.standardUserDefaults()
            .persistentDomainForName(domainName) as? [String: AnyObject]
        
        // persistentDomainForName might return nil, because this might
        // be the first time we've ever tried to save the preferences.
        // If this is the case, set 'preferences' to be an empty
        // dictionary, so that it can be used.
        
        if preferences == nil {
            preferences = [:]
        }
      
        // Store the info in the dictionary
        switch self.checkbox.state {
        case NSOnState:
            preferences?["isChecked"] = true
        default:
            preferences?["isChecked"] = false
        }
        
        // Store the dictionary in NSUserDefaults
        NSUserDefaults.standardUserDefaults()
            .setPersistentDomain(preferences!, forName: domainName)
    }
    // END did-unselect
}
