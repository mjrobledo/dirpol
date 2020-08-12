//
//  RegionExtencionCardVC.swift
//  dirpol
//
//  Created by Developer iOS on 8/11/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import Foundation

// Mark: - Methods Card Menu
extension RegionsVC {
    func setupCard() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        //self.view.addSubview(visualEffectView)
        
        regionCard = RegionCardVC(nibName:"RegionCardVC", bundle:nil)
        regionCard.delegate = self
        self.regionCard.view.layer.cornerRadius = 12
        self.addChild(regionCard)
        self.view.addSubview(regionCard.view)
        
        cardHeight = 560
        regionCard.view.frame = CGRect(x: 20, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width - 40, height: cardHeight)
        
        regionCard.view.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleCardTap(recognzier:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handleCardPan(recognizer:)))
        
        regionCard.handleArea.addGestureRecognizer(tapGestureRecognizer)
        regionCard.handleArea.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc
       func handleCardTap(recognzier:UITapGestureRecognizer) {
           switch recognzier.state {
           case .ended:
               animateTransitionIfNeeded(state: nextState, duration: 0.9)
           default:
               break
           }
       }
       
       @objc
       func handleCardPan (recognizer:UIPanGestureRecognizer) {
           switch recognizer.state {
           case .began:
               startInteractiveTransition(state: nextState, duration: 0.9)
           case .changed:
               let translation = recognizer.translation(in: self.regionCard.handleArea)
               var fractionComplete = translation.y / cardHeight
               fractionComplete = cardVisible ? fractionComplete : -fractionComplete
               updateInteractiveTransition(fractionCompleted: fractionComplete)
           case .ended:
               continueInteractiveTransition()
           default:
               break
           }
           
       }
       
       func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
           if runningAnimations.isEmpty {
               let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                   switch state {
                   case .expanded:
                       self.regionCard.view.frame.origin.y = (self.view.frame.height + 60) - self.cardHeight
                   case .collapsed:
                       self.regionCard.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
                   }
               }
               
               frameAnimator.addCompletion { _ in
                   self.cardVisible = !self.cardVisible
                   self.runningAnimations.removeAll()
               }
               
               frameAnimator.startAnimation()
               runningAnimations.append(frameAnimator)
               
               
               let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                   switch state {
                   case .expanded:
                       self.regionCard.view.layer.cornerRadius = 12
                   case .collapsed:
                       self.regionCard.view.layer.cornerRadius = 12
                   }
               }
               
               cornerRadiusAnimator.startAnimation()
               runningAnimations.append(cornerRadiusAnimator)
               
               let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                   switch state {
                   case .expanded:
                       self.visualEffectView.effect = UIBlurEffect(style: .dark)
                   case .collapsed:
                       self.visualEffectView.effect = nil
                   }
               }
               
               blurAnimator.startAnimation()
               runningAnimations.append(blurAnimator)
               
           }
       }
       
       func startInteractiveTransition(state:CardState, duration:TimeInterval) {
           if runningAnimations.isEmpty {
               animateTransitionIfNeeded(state: state, duration: duration)
           }
           for animator in runningAnimations {
               animator.pauseAnimation()
               animationProgressWhenInterrupted = animator.fractionComplete
           }
       }
       
       func updateInteractiveTransition(fractionCompleted:CGFloat) {
           for animator in runningAnimations {
               animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
           }
       }
       
       func continueInteractiveTransition (){
           for animator in runningAnimations {
               animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
           }
       }
}

extension RegionsVC: RegionCardVCDelegate {
    func filter() {
        
    }
    
    func goToProvince() {
        
    }
    
    func goToCity() {
        
    }
    
    func goToDistrito() {
        
    }
    
    
}
