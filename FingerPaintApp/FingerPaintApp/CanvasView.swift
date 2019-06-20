//
//  CanvasView.swift
//  FingerPaintApp
//
//  Created by Derrick Park on 2018-05-22.
//  Copyright © 2018 Derrick Park. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    //MARK: - Properties
    private var lastPoint: CGPoint = CGPoint.zero
    private var buffer: UIImage?
    
    var lineColor: UIColor = UIColor.black
    var lineWidth: CGFloat = 5.0
    var viewSize: CGSize = CGSize(width: 0, height: 0)
    
    
    var machinePoints: [(x: Double, y: Double)] = []
    var userPoints: [(x: Double, y: Double)] = []
    var auxMachinePoints: [(x: Double, y: Double)] = []
    var auxUserPoints: [(x: Double, y: Double)] = []
    
    //MARK: - View cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGestureRecognizer()
        drawRandomly()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupGestureRecognizer() {
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        self.addGestureRecognizer(panGR)
    }
    
    @objc private func handlePan(sender: UIPanGestureRecognizer){
        let point = sender.location(in: self)
        switch sender.state {
        case .began:
            startAtPoint(point: point)
        case .changed:
            continueAtPoint(point: point)
            userPoints.append((Double(point.x), Double(point.y)))
        case .ended:
            endAtPoint(point: point)
        case .failed:
            endAtPoint(point: point)
        default:
            assert(false, "State not handled")
        }
    }
    
    private func drawLine(a: CGPoint, b: CGPoint, buffer: UIImage?) -> UIImage {
        let size = bounds.size
        // Init a full size image. Opaque because we don't need to draw over anything.
        // Will be more performant.
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(backgroundColor?.cgColor ?? UIColor.white.cgColor)
        context?.fill(bounds)
        
        // draw prev buffer first
        if let buffer = buffer {
            buffer.draw(in: bounds)
        }
        
        // draw the line
        lineColor.setStroke()
        context?.setLineWidth(lineWidth)
        context?.setLineCap(.round)
        context?.move(to: a)
        context?.addLine(to: b)
        context?.strokePath()
        
        // grab the updated buffer
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    private func drawLineWithRedLine(a: CGPoint, b: CGPoint, buffer: UIImage?) -> UIImage {
        let size = bounds.size
        // Init a full size image. Opaque because we don't need to draw over anything.
        // Will be more performant.
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(backgroundColor?.cgColor ?? UIColor.white.cgColor)
        context?.fill(bounds)
        
        // draw prev buffer first
        if let buffer = buffer {
            buffer.draw(in: bounds)
        }
        
        // draw the line
        UIColor.red.setStroke()
        context?.setLineWidth(lineWidth)
        context?.setLineCap(.round)
        context?.move(to: a)
        context?.addLine(to: b)
        context?.strokePath()
        
        // grab the updated buffer
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    
    // Tracing a line
    private func startAtPoint(point: CGPoint) {
        lastPoint = point
    }
    
    private func continueAtPoint(point: CGPoint) {
        autoreleasepool {
            // to force ARC to release of all autoreleased objects at the end of this method.
            // Draw the current stroke in an accumulated bitmap
            buffer = drawLine(a: lastPoint, b: point, buffer: buffer)
            // Replace the layer contents with the updated image
            layer.contents = buffer?.cgImage ?? nil
            // Update last point for next stroke
            lastPoint = point
            
        }
    }
    
    private func endAtPoint(point: CGPoint) {
        lastPoint = CGPoint.zero
        calculatingSlopesGeneratingAuxPoints(points: machinePoints, auxPointsArray: &auxMachinePoints)
        print("===========================")
        generateCriticalPointsUser(points: userPoints, auxPointsArray: &auxUserPoints)
//        calculatingSlopesGeneratingAuxPoints(points: userPoints, auxPointsArray: &auxUserPoints)
        
//        var sum = 0.0
//        for b in 0..<auxMachinePoints.count {
//            let distance = sqrt(pow(auxUserPoints[b].x - auxMachinePoints[b].x, 2) + pow(auxUserPoints[b].y - auxMachinePoints[b].y, 2))
//            sum += distance
//            print(distance)
//        }
        
//        print("User smooth points: ")
//        for i in smoothPointsTuple(points: userPoints) {
//            print(i.x,",",i.y)
//        }
//        print("============================================")
//        print("PC smooth points:")
//        for i in smoothPointsTuple(points: machinePoints) {
//            print(i.x,",",i.y)
//        }
        
        print("============================================")
        print("PC aux points:")
        for i in auxMachinePoints {
            print(i.x,",",i.y)
        }
        print("============================================")
        print("User aux points:")
        for i in auxUserPoints{
            print(i.x,",",i.y)
        }
//        var firstUserPoint = userPoints[0]
//        for i in 1..<userPoints.count - 1 {
//            buffer = drawLineWithRedLine(a: CGPoint(x: firstUserPoint.x, y: firstUserPoint.y), b: CGPoint(x: userPoints[i].x, y: userPoints[i].y), buffer: buffer)
//            layer.contents = buffer?.cgImage ?? nil
//            firstUserPoint = userPoints[i]
//        }
        
    }
    
    // drawing functions
    override func draw(_ rect: CGRect) {
        // Redraw the whole rect, ignoring parameter. We always invalidate whole view.
    }
    
    private func drawCircle(r: Double) {
        autoreleasepool {
            // Drawing a circle
            var theta: Double = 0.0
            let step = 2 * Double.pi / 20
            var a: CGPoint = CGPoint(x: center.x + CGFloat(r * cos(theta)), y: center.y - CGFloat(r * sin(theta)))
            while theta <= 2 * Double.pi {
                let b: CGPoint = CGPoint(x: center.x + CGFloat(r * cos(theta)), y: center.y - CGFloat(r * sin(theta)))
                buffer = drawLine(a: a, b: b, buffer: buffer)
                layer.contents = buffer?.cgImage ?? nil
                a = b
                theta += step
            }
        }
    }
    
    private func drawEquation(generateY: (CGFloat) -> CGFloat){
        var x: CGFloat = -3
        var y = generateY(x)
        var a = cgPointWithCenterOrigin(point: CGPoint(x: x * 20, y: y * 20))
        repeat {
            x += 0.05
            y = generateY(x)
            let b = cgPointWithCenterOrigin(point: CGPoint(x: x * 20, y: y * 20))
            buffer = drawLine(a: a, b: b, buffer: buffer)
            layer.contents = buffer?.cgImage ?? nil
            a = b
        } while x <= 1
    }
    
    private func drawWithPoint(array: [CGPoint]) {
        var array = array
        var a = array[0]
        while array.isEmpty == false {
            let b = array.removeFirst()
            buffer = drawLine(a: a, b: b, buffer: buffer)
            layer.contents = buffer?.cgImage ?? nil
            a = b
        }
    }
    
    private func drawRandomly() {
        var previousDirection = 0
        var startPoint = cgPointWithCenterOrigin(point: CGPoint(x: 0, y: 0))
        machinePoints.append((Double(startPoint.x), Double(startPoint.y)))
        
        var numOfLines = 0
        while numOfLines < 5 {
            
            var randomDirectionArray: [Int] = [1,2,3,4,-1,-2,-3,-4]
            var ran = 0
            let numOfPointsInLine = Int.random(in: 10...20)
            var estimatedPoint = CGPoint(x: 0, y: 0)
            
            repeat {
                ran = randomDirectionArray.randomElement()!
                randomDirectionArray.removeAll(where: {$0 == ran})
                estimatedPoint = startPoint.getDirectedPoint(ran: ran, numOfPixels: numOfPointsInLine * 5)
            } while (ran == previousDirection) || (estimatedPoint.x < bounds.minX + 40 || estimatedPoint.x > bounds.maxX - 40 || estimatedPoint.y < bounds.minY + 40 || estimatedPoint.y > bounds.maxY - 40)
            
            previousDirection = ran * -1
            
            for _ in 0...numOfPointsInLine  {
                let b = startPoint.getDirectedPoint(ran: ran, numOfPixels: 5)
                machinePoints.append((Double(b.x), Double(b.y)))
                buffer = drawLine(a: startPoint, b: b, buffer: buffer)
                layer.contents = buffer?.cgImage ?? nil
                startPoint = b
            }
            numOfLines += 1
        }
    }
    
    
    func smoothPointsTuple(points: [(x: Double, y: Double)]) -> [(x: Double, y: Double)] {
        var newPoints = [(x: Double, y: Double)]()
        var initialPoint = points.first!
        newPoints.append((initialPoint.x,initialPoint.y))
        for p in points{
            if ((initialPoint.x + 10.3) < p.x) || ((initialPoint.y + 10.3) < p.y) || ((initialPoint.x - 10.3) > p.x) || ((initialPoint.y - 10.3) > p.y) {
                initialPoint = p
                newPoints.append((p.x,p.y))
            }
        }
        return newPoints
    }
    
    func calculatingSlopesGeneratingAuxPoints(points: [(x: Double, y: Double)], auxPointsArray: inout [(x: Double, y: Double)]) {
        print("============================================")
        
        var firstPoint = points[1]
        let secondPoint = points[2]
        var signal = 0 // 1: slope > 0, -1: slope < 0, 2: vertical line, -2: horizontal line

        var deltaX = secondPoint.x - firstPoint.x
        var deltaY = secondPoint.y - firstPoint.y
        auxPointsArray.append(firstPoint)
        if deltaX == 0 {
            signal = 2
        } else if deltaY == 0 {
            signal = -2
        } else if (deltaY / deltaX) > 0 {
            signal = 1
        } else if (deltaY / deltaX) < 0 {
            signal = -1
        } else {
            return
        }
//        print(signal)
        firstPoint = secondPoint
        for i in 3..<points.count - 2 {
            var secSignal = 0
            deltaX = (points[i].x * 1) - firstPoint.x
            deltaY = (points[i].y * 1) - firstPoint.y
            if deltaX == 0 {
                secSignal = 2
            } else if deltaY == 0 {
                secSignal = -2
            } else if (deltaY / deltaX) > 0 {
                secSignal = 1
            } else if (deltaY / deltaX) < 0 {
                secSignal = -1
            } else {
                return
            }
//            print(secSignal)
            if secSignal != signal {
                auxPointsArray.append(points[i])
                signal = secSignal
                
            }
            firstPoint = points[i]
            
        }
        auxPointsArray.append(points[points.count - 2])
    }
    
    private func generateCriticalPointsUser(points: [(x: Double, y: Double)], auxPointsArray: inout [(x: Double, y: Double)]) {
        var generatedSignal = false
        var firstPoint = points[10]
        auxPointsArray.append(firstPoint)
        let secondPoint = points[20]
        var signal = generateCriticalPointsUserHelper(firstPoint: firstPoint, secondPoint: secondPoint) // 1: vertical, -1: horizontal, 0: diagonal
        generatedSignal = true
        print("signal: ", signal)
        firstPoint = secondPoint
        var i = 30
        while i < points.count - 10 {
            let secSignal = generateCriticalPointsUserHelper(firstPoint: firstPoint, secondPoint: points[i])
            print("Second signal: ", secSignal)
            if (secSignal != signal) && generatedSignal == true {
                auxPointsArray.append(points[i])
                signal = secSignal
            }else {
                
            }
            firstPoint = points[i]
            i += 10
        }
        auxPointsArray.append(points[points.count - 10])
    }
    
    
    private func generateCriticalPointsUserHelper(firstPoint: (x: Double, y: Double), secondPoint: (x: Double, y: Double)) -> Int {
        print()

        print("firstPoint: ", firstPoint)
        print("secondPoint: ", secondPoint)
        
        let deltaY = abs(secondPoint.y - firstPoint.y)
        let deltaX = abs(secondPoint.x - firstPoint.x)
        print("deltaX: ", deltaX)
        print("deltaY: ", deltaY)
        if deltaX <= 5 && deltaY > 5{
            return 1
        } else if deltaY <= 5 && deltaX > 5 {
            return -1
        } else if deltaX > 5 && deltaY > 5 {
            return 0
        } else {
            return 10
        }
    }
    
    // return point in coordinate system with the origin at center of screen
    private func cgPointWithCenterOrigin(point: CGPoint) -> CGPoint {
        let a: CGPoint = CGPoint(x: center.x + point.x, y: center.y - point.y)
        return a
    }
    
    
}

extension CGPoint {
    func topPoint(pixels: Int) -> CGPoint {
        return CGPoint(x: self.x - 0, y: self.y - CGFloat(pixels))
    }
    func bottomPoint(pixels: Int) -> CGPoint {
        return CGPoint(x: self.x - 0, y: self.y + CGFloat(pixels))
    }
    func leftPoint(pixels: Int) -> CGPoint {
        return CGPoint(x: self.x - CGFloat(pixels), y: self.y + 0)
    }
    func rightPoint(pixels: Int) -> CGPoint {
        return CGPoint(x: self.x + CGFloat(pixels), y: self.y + 0)
    }
    func topLeftPoint(pixels: Int) -> CGPoint {
        return CGPoint(x: self.x - CGFloat(pixels), y: self.y - CGFloat(pixels))
    }
    func topRightPoint(pixels: Int) -> CGPoint {
        return CGPoint(x: self.x + CGFloat(pixels), y: self.y - CGFloat(pixels))
    }
    func bottomLeftPoint(pixels: Int) -> CGPoint {
        return CGPoint(x: self.x - CGFloat(pixels), y: self.y + CGFloat(pixels))
    }
    func bottomRightPoint(pixels: Int) -> CGPoint {
        return CGPoint(x: self.x + CGFloat(pixels), y: self.y + CGFloat(pixels))
    }
    func getDirectedPoint(ran: Int, numOfPixels: Int) -> CGPoint {
        switch ran {
        case 1:
            return self.topPoint(pixels: numOfPixels)
        case -1:
            return self.bottomPoint(pixels: numOfPixels)
        case -3:
            return self.leftPoint(pixels: numOfPixels)
        case 3:
            return self.rightPoint(pixels: numOfPixels)
        case -4:
            return self.topLeftPoint(pixels: numOfPixels)
        case 2:
            return self.topRightPoint(pixels: numOfPixels)
        case -2:
            return self.bottomLeftPoint(pixels: numOfPixels)
        case 4:
            return self.bottomRightPoint(pixels: numOfPixels)
        default:
            return CGPoint(x: 0, y: 0)
        }
    }
}












