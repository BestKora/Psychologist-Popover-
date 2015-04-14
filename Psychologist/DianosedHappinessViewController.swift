//
//  DianosedHappinessViewController.swift
//  Psychologist
//
//  Created by Tatiana Kornilova on 4/7/15.
//  Copyright (c) 2015 Tatiana Kornilova. All rights reserved.
//

import UIKit

class DiagnosedHappinessViewController : HappinessViewController, UIPopoverPresentationControllerDelegate
{
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    var diagnosticHistory:[Int] {
        get{return defaults.objectForKey(History.DefaultsKey) as? [Int] ?? [] }
        set{defaults.setObject(newValue, forKey: History.DefaultsKey)}
    }
    
    override var happiness: Int {
        didSet {
            diagnosticHistory += [happiness]
        }
    }

    private struct History {
        static let SegueIdentifier = "Show Diagnostic History"
        static let DefaultsKey = "DiagnosedHappinessViewController.History"
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case History.SegueIdentifier:
                if let tvc = segue.destinationViewController as? TextViewController {
                    if let ppc = tvc.popoverPresentationController {
                        ppc.delegate = self
                    }

                     tvc.text = "\(diagnosticHistory)"
                }
	
            default:  break
            }
        }
    }
// Для iOS 8.3 SDK
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController!, traitCollection: UITraitCollection!) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}

/*
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}
*/