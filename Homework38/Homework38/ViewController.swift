//
//  ViewController.swift
//  Homework38
//
//  Created by Kato on 6/10/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let drawing = DrawingBoard()

    
    override func loadView() {
        self.view = drawing
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        drawing.backgroundColor = .white
        
    }
    
    @IBAction func undoButton(_ sender: UIBarButtonItem) {
        drawing.undo()
    }
    
    @IBAction func clearButton(_ sender: UIBarButtonItem) {
        drawing.clear()
    }
    
}

class DrawingBoard: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {return}

        context.setStrokeColor(UIColor.blue.cgColor)
        context.setLineWidth(10)
        
        lines.forEach { (line) in
        
            for (index, point) in line.enumerated() {
                
                if index == 0 {
                    context.move(to: point)
                }
                else {
                    context.addLine(to: point)
                }
            }
        }
        
        context.strokePath()
        
    }
    
    var lines = [[CGPoint]]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let point = touches.first?.location(in: nil) else {return}
//      print(point)
        guard var lastLine = lines.popLast() else {return}
        lastLine.append(point)
        
        lines.append(lastLine)
        setNeedsDisplay()
        
    }
    
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    
}


