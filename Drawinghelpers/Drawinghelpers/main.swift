//
//  main.swift
//  Drawinghelpers
//
//  Created by Guilherme Wahlbrink on 2019-06-04.
//  Copyright © 2019 Guilherme Wahlbrink. All rights reserved.
//
//
import Foundation

//class Point {
//   var x: Double
//   var y: Double
//
//    init(x: Double, y: Double) {
//        self.x = x
//        self.y = y
//    }
//
//}
//
//
//var point = (0, 0)
//
//
//
//var p1 = Point(x: 1, y: 2)
//var p2 = Point(x: 2, y: 5.5)
//var p3 = Point(x: 3, y: 3.2)
//var p4 = Point(x: 4, y: 7)
//var p5 = Point(x: 6, y: 2)
//var p6 = Point(x: 8, y: 9)
//
//var mypoints = [Point]()
//mypoints.append(p1)
//mypoints.append(p2)
//mypoints.append(p3)
//mypoints.append(p4)
//mypoints.append(p5)
//mypoints.append(p6)
//
//
//func smoothPoints(points: [Point]) -> [Point] {
//    var newPoints = [Point]()
//
//    var initialPoint = points.first!
//    newPoints.append(initialPoint)
//    for p in points{
//        if ((initialPoint.x + 0.3) < p.x) || ((initialPoint.y + 0.3) < p.y) || ((initialPoint.x - 0.3) > p.x) || ((initialPoint.y - 0.3) > p.y) {
//            initialPoint = p
//            newPoints.append(p)
//        }
//    }
//    return newPoints
//}
//
//
////for p in smoothPoints(points: mypoints){
////    print(p.x,p.y)
////}
//
//
//func calculatingDeltas(points: [Point]) {
//    var initialPoint = points[0]
//    var deltaX = 0.0
//    var deltaY = 0.0
//    for i in 1..<points.count {
//        deltaX = points[i].x - initialPoint.x
//        deltaY = points[i].y - initialPoint.y
//        print(deltaY/deltaX)
//        initialPoint = points[i]
//    }
//}
//
////calculatingDeltas(points: smoothPoints(points: mypoints))
////calculatingDeltas(points: mypoints)
//// the deltas i have to research a little bit more, means that the function is changing direction
//
////this delta is the slope of the function
//
//// In mathematical language, the slope m of the line is
//
////m = y2 - y1 / x2 - x 1
//
//// https://en.wikipedia.org/wiki/Slope
//
//
//
//var pc1 = Point(x: 1, y: 3)
//var pc2 = Point(x: 2, y: 5)
//var pc3 = Point(x: 3, y: 1)
//var pc4 = Point(x: 2, y: 0)
//var pc5 = Point(x: 1, y: 3)
//
//var myCirclePoints = [Point]()
//myCirclePoints.append(pc1)
//myCirclePoints.append(pc2)
//myCirclePoints.append(pc3)
//myCirclePoints.append(pc4)
//myCirclePoints.append(pc5)
//
//
//calculatingDeltas(points: myCirclePoints)
//
//
//
//
// tuple


var tupleArray: [(x: Double, y: Double)] = []

var auxPointsArray: [(x: Double, y: Double)] = []


func smoothPointsTuple(points: [(x: Double, y: Double)]) -> [(x: Double, y: Double)] {

    var newPoints = [(x: Double, y: Double)]()

    var initialPoint = points.first!
    newPoints.append((initialPoint.x,initialPoint.y))
    for p in points{
        if ((initialPoint.x + 10.3) < p.x) || ((initialPoint.y + 10.3) < p.y) || ((initialPoint.x - 10.3) > p.x) || ((initialPoint.y - 10.3) > p.y) {
            print("(",initialPoint.x,",",initialPoint.y,")")
            initialPoint = p
            newPoints.append((p.x,p.y))
        }
    }
    return newPoints
}

func calculatingSlopes(points: [(x: Double, y: Double)]) {
    var initialPoint = points[0]
    var deltaX = 0.0
    var deltaY = 0.0
    for i in 1..<points.count {
        deltaX = points[i].x - initialPoint.x
        deltaY = points[i].y - initialPoint.y
        print(deltaY/deltaX)
        initialPoint = points[i]
    }
}

func calculatingSlopesGeneratingAuxPoints(points: [(x: Double, y: Double)]) {
    var initialPoint = points[0]
    auxPointsArray.append(initialPoint)
    var deltaX = 0.0
    var deltaY = 0.0
    var signal = true // true = positive, false = negative
    for i in 1..<points.count {
        deltaX = points[i].x - initialPoint.x
        deltaY = points[i].y - initialPoint.y
        if deltaY/deltaX < 0 && signal == true {
            auxPointsArray.append(points[i])
            signal = false
        }else if deltaY/deltaX > 0 && signal == false{
            auxPointsArray.append(points[i])
            signal = true
        } else{
            
        }
        print(deltaY/deltaX)
        initialPoint = points[i]
        if i == points.count - 1 {
            auxPointsArray.append(points[i])
        }
    }
}


//
//func calculatingDeltasTuple(points: [Point]) {
//    var initialPoint = points[0]
//    var deltaX = 0.0
//    var deltaY = 0.0
//    for i in 1..<points.count {
//        deltaX = points[i].x - initialPoint.x
//        deltaY = points[i].y - initialPoint.y
//        print(deltaY/deltaX)
//        initialPoint = points[i]
//    }
//}


tupleArray.append((163.66665649414062, 413.0))
tupleArray.append((163.66665649414062, 413.0))
tupleArray.append((161.0, 410.0))
tupleArray.append((160.0, 409.6666564941406))
tupleArray.append((159.0, 408.6666564941406))
tupleArray.append((158.3333282470703, 408.3333282470703))
tupleArray.append((157.3333282470703, 407.0))
tupleArray.append((156.66665649414062, 406.6666564941406))
tupleArray.append((155.66665649414062, 405.6666564941406))
tupleArray.append((154.3333282470703, 404.6666564941406))
tupleArray.append((153.3333282470703, 404.0))
tupleArray.append((152.66665649414062, 403.3333282470703))
tupleArray.append((151.3333282470703, 402.0))
tupleArray.append((151.3333282470703, 401.6666564941406))
tupleArray.append((150.3333282470703, 401.0))
tupleArray.append((149.3333282470703, 400.0))
tupleArray.append((149.0, 399.3333282470703))
tupleArray.append((148.0, 398.3333282470703))
tupleArray.append((147.0, 397.3333282470703))
tupleArray.append((146.3333282470703, 397.0))
tupleArray.append((145.3333282470703, 395.6666564941406))
tupleArray.append((144.3333282470703, 394.3333282470703))
tupleArray.append((143.66665649414062, 393.3333282470703))
tupleArray.append((143.0, 392.3333282470703))
tupleArray.append((141.66665649414062, 390.6666564941406))
tupleArray.append((140.3333282470703, 390.0))
tupleArray.append((139.66665649414062, 389.0))
tupleArray.append((138.66665649414062, 388.6666564941406))
tupleArray.append((137.0, 387.6666564941406))
tupleArray.append((136.0, 386.6666564941406))
tupleArray.append((134.66665649414062, 385.6666564941406))
tupleArray.append((133.66665649414062, 384.0))
tupleArray.append((132.3333282470703, 382.6666564941406))
tupleArray.append((130.66665649414062, 381.0))
tupleArray.append((129.66665649414062, 379.6666564941406))
tupleArray.append((129.0, 379.0))
tupleArray.append((128.0, 378.0))
tupleArray.append((127.33332824707031, 377.0))
tupleArray.append((125.66665649414062, 375.6666564941406))
tupleArray.append((125.0, 374.6666564941406))
tupleArray.append((124.33332824707031, 373.6666564941406))
tupleArray.append((123.33332824707031, 372.6666564941406))
tupleArray.append((122.66665649414062, 371.3333282470703))
tupleArray.append((122.0, 370.3333282470703))
tupleArray.append((120.66665649414062, 369.0))
tupleArray.append((120.0, 367.6666564941406))
tupleArray.append((119.0, 366.6666564941406))
tupleArray.append((118.33332824707031, 365.3333282470703))
tupleArray.append((117.0, 363.6666564941406))
tupleArray.append((116.33332824707031, 362.6666564941406))
tupleArray.append((115.33332824707031, 361.3333282470703))
tupleArray.append((114.66665649414062, 360.6666564941406))
tupleArray.append((113.0, 359.3333282470703))
tupleArray.append((112.33332824707031, 358.3333282470703))
tupleArray.append((111.33332824707031, 357.3333282470703))
tupleArray.append((110.66665649414062, 356.3333282470703))
tupleArray.append((109.0, 355.0))
tupleArray.append((108.33332824707031, 353.6666564941406))
tupleArray.append((108.0, 353.3333282470703))
tupleArray.append((107.0, 352.6666564941406))
tupleArray.append((106.33332824707031, 351.6666564941406))
tupleArray.append((105.66665649414062, 351.0))
tupleArray.append((104.0, 349.0))
tupleArray.append((103.33332824707031, 348.3333282470703))
tupleArray.append((102.66665649414062, 347.6666564941406))
tupleArray.append((101.66665649414062, 347.0))
tupleArray.append((101.0, 346.3333282470703))
tupleArray.append((100.0, 345.6666564941406))
tupleArray.append((99.33332824707031, 344.6666564941406))
tupleArray.append((98.0, 344.0))
tupleArray.append((96.66665649414062, 342.3333282470703))
tupleArray.append((96.0, 342.0))
tupleArray.append((95.33332824707031, 341.0))
tupleArray.append((93.33332824707031, 339.3333282470703))
tupleArray.append((92.66665649414062, 339.0))
tupleArray.append((91.33332824707031, 338.0))
tupleArray.append((90.33332824707031, 337.0))
tupleArray.append((90.0, 336.3333282470703))
tupleArray.append((89.33332824707031, 336.0))
tupleArray.append((89.0, 335.3333282470703))
tupleArray.append((88.0, 334.3333282470703))
tupleArray.append((87.66665649414062, 334.0))
tupleArray.append((87.33332824707031, 333.3333282470703))
tupleArray.append((86.66665649414062, 332.3333282470703))
tupleArray.append((86.0, 331.3333282470703))
tupleArray.append((85.0, 329.3333282470703))
tupleArray.append((84.33332824707031, 328.3333282470703))
tupleArray.append((84.0, 327.6666564941406))
tupleArray.append((84.0, 327.3333282470703))
tupleArray.append((84.0, 327.0))
tupleArray.append((83.66665649414062, 327.0))
tupleArray.append((83.33332824707031, 326.6666564941406))
tupleArray.append((82.66665649414062, 325.6666564941406))
tupleArray.append((81.66665649414062, 325.0))
tupleArray.append((80.66665649414062, 323.6666564941406))
tupleArray.append((79.33332824707031, 322.6666564941406))
tupleArray.append((78.66665649414062, 321.3333282470703))
tupleArray.append((78.33332824707031, 321.0))
tupleArray.append((78.0, 320.3333282470703))
tupleArray.append((77.66665649414062, 320.3333282470703))
tupleArray.append((77.66665649414062, 320.0))
tupleArray.append((77.66665649414062, 320.0))
tupleArray.append((77.66665649414062, 320.0))
tupleArray.append((78.0, 318.6666564941406))
tupleArray.append((79.66665649414062, 316.3333282470703))
tupleArray.append((80.33332824707031, 315.3333282470703))
tupleArray.append((81.66665649414062, 314.0))
tupleArray.append((82.33332824707031, 313.6666564941406))
tupleArray.append((83.0, 313.0))
tupleArray.append((83.33332824707031, 312.3333282470703))
tupleArray.append((84.66665649414062, 311.0))
tupleArray.append((85.66665649414062, 309.6666564941406))
tupleArray.append((86.66665649414062, 308.3333282470703))
tupleArray.append((87.0, 308.0))
tupleArray.append((87.66665649414062, 307.3333282470703))
tupleArray.append((88.66665649414062, 306.0))
tupleArray.append((89.33332824707031, 305.0))
tupleArray.append((90.0, 304.3333282470703))
tupleArray.append((91.0, 303.6666564941406))
tupleArray.append((91.66665649414062, 303.0))
tupleArray.append((92.0, 302.0))
tupleArray.append((92.66665649414062, 301.3333282470703))
tupleArray.append((93.33332824707031, 299.6666564941406))
tupleArray.append((94.33332824707031, 299.0))
tupleArray.append((95.0, 298.0))
tupleArray.append((95.66665649414062, 297.0))
tupleArray.append((96.66665649414062, 295.6666564941406))
tupleArray.append((97.66665649414062, 294.0))
tupleArray.append((99.0, 292.3333282470703))
tupleArray.append((100.0, 291.0))
tupleArray.append((102.0, 288.3333282470703))
tupleArray.append((103.0, 287.3333282470703))
tupleArray.append((103.66665649414062, 286.0))
tupleArray.append((104.33332824707031, 285.0))
tupleArray.append((105.33332824707031, 283.6666564941406))
tupleArray.append((106.33332824707031, 282.3333282470703))
tupleArray.append((107.33332824707031, 281.0))
tupleArray.append((108.0, 280.0))
tupleArray.append((109.0, 279.0))
tupleArray.append((109.33332824707031, 278.0))
tupleArray.append((110.0, 277.3333282470703))
tupleArray.append((111.0, 276.0))
tupleArray.append((111.33332824707031, 276.0))
tupleArray.append((111.66665649414062, 275.6666564941406))
tupleArray.append((112.0, 275.0))
tupleArray.append((113.0, 273.6666564941406))
tupleArray.append((113.66665649414062, 272.6666564941406))
tupleArray.append((114.66665649414062, 271.6666564941406))
tupleArray.append((115.33332824707031, 271.3333282470703))
tupleArray.append((115.66665649414062, 270.6666564941406))
tupleArray.append((116.0, 270.3333282470703))
tupleArray.append((116.33332824707031, 269.6666564941406))
tupleArray.append((116.66665649414062, 269.3333282470703))
tupleArray.append((117.33332824707031, 268.6666564941406))
tupleArray.append((117.66665649414062, 268.0))
tupleArray.append((118.33332824707031, 267.6666564941406))
tupleArray.append((118.33332824707031, 267.0))
tupleArray.append((118.66665649414062, 267.0))
tupleArray.append((119.33332824707031, 266.0))
tupleArray.append((120.0, 265.6666564941406))
tupleArray.append((120.0, 265.3333282470703))
tupleArray.append((120.33332824707031, 265.0))
tupleArray.append((121.0, 264.3333282470703))
tupleArray.append((121.33332824707031, 263.0))
tupleArray.append((122.0, 262.0))
tupleArray.append((122.66665649414062, 261.3333282470703))
tupleArray.append((123.0, 260.3333282470703))
tupleArray.append((123.33332824707031, 259.6666564941406))
tupleArray.append((124.0, 259.3333282470703))
tupleArray.append((124.0, 259.0))
tupleArray.append((123.66665649414062, 259.0))
tupleArray.append((123.0, 259.0))
tupleArray.append((122.66665649414062, 259.0))
tupleArray.append((121.66665649414062, 259.0))
tupleArray.append((120.66665649414062, 258.3333282470703))
tupleArray.append((119.66665649414062, 257.6666564941406))
tupleArray.append((118.66665649414062, 257.0))
tupleArray.append((117.33332824707031, 255.66665649414062))
tupleArray.append((116.33332824707031, 255.0))
tupleArray.append((115.66665649414062, 254.0))
tupleArray.append((114.66665649414062, 253.3333282470703))
tupleArray.append((113.66665649414062, 252.66665649414062))
tupleArray.append((112.66665649414062, 251.66665649414062))
tupleArray.append((112.0, 250.66665649414062))
tupleArray.append((110.66665649414062, 250.0))
tupleArray.append((110.0, 249.0))
tupleArray.append((108.33332824707031, 248.0))
tupleArray.append((108.0, 247.0))
tupleArray.append((107.0, 246.66665649414062))
tupleArray.append((106.33332824707031, 245.66665649414062))
tupleArray.append((105.33332824707031, 244.66665649414062))
tupleArray.append((104.66665649414062, 244.0))
tupleArray.append((104.33332824707031, 243.0))
tupleArray.append((103.66665649414062, 242.3333282470703))
tupleArray.append((103.0, 241.3333282470703))
tupleArray.append((102.66665649414062, 240.3333282470703))
tupleArray.append((101.0, 238.0))
tupleArray.append((100.33332824707031, 237.0))
tupleArray.append((99.33332824707031, 236.0))
tupleArray.append((98.66665649414062, 235.0))
tupleArray.append((98.33332824707031, 234.3333282470703))
tupleArray.append((97.66665649414062, 233.0))
tupleArray.append((97.33332824707031, 232.0))
tupleArray.append((96.33332824707031, 230.0))
tupleArray.append((96.0, 229.0))
tupleArray.append((95.33332824707031, 228.66665649414062))
tupleArray.append((94.66665649414062, 227.3333282470703))
tupleArray.append((94.0, 226.0))
tupleArray.append((94.0, 225.3333282470703))
tupleArray.append((93.66665649414062, 224.3333282470703))
tupleArray.append((93.0, 223.66665649414062))
tupleArray.append((92.66665649414062, 223.0))
tupleArray.append((92.33332824707031, 222.66665649414062))
tupleArray.append((91.66665649414062, 222.3333282470703))
tupleArray.append((91.66665649414062, 222.0))
tupleArray.append((91.0, 222.0))
tupleArray.append((90.66665649414062, 222.0))
tupleArray.append((90.33332824707031, 222.0))
tupleArray.append((89.66665649414062, 221.3333282470703))
tupleArray.append((89.0, 221.0))
tupleArray.append((88.66665649414062, 221.0))
tupleArray.append((88.66665649414062, 220.3333282470703))
tupleArray.append((88.0, 220.0))
tupleArray.append((87.66665649414062, 219.66665649414062))
tupleArray.append((87.33332824707031, 219.0))
tupleArray.append((87.0, 218.66665649414062))
tupleArray.append((86.66665649414062, 218.0))
tupleArray.append((86.33332824707031, 217.3333282470703))
tupleArray.append((86.0, 217.3333282470703))
tupleArray.append((86.0, 216.66665649414062))
tupleArray.append((85.66665649414062, 216.3333282470703))
tupleArray.append((85.33332824707031, 216.0))
tupleArray.append((84.66665649414062, 215.0))
tupleArray.append((84.33332824707031, 214.66665649414062))
tupleArray.append((84.0, 214.3333282470703))
tupleArray.append((84.0, 213.66665649414062))
tupleArray.append((83.33332824707031, 213.3333282470703))
tupleArray.append((83.0, 213.0))
tupleArray.append((82.66665649414062, 212.66665649414062))
tupleArray.append((82.66665649414062, 212.3333282470703))
tupleArray.append((82.66665649414062, 212.0))
tupleArray.append((82.33332824707031, 212.0))
tupleArray.append((82.0, 212.0))
tupleArray.append((81.66665649414062, 212.0))
tupleArray.append((81.33332824707031, 212.0))
tupleArray.append((81.0, 212.3333282470703))
tupleArray.append((81.0, 212.66665649414062))
tupleArray.append((80.66665649414062, 213.0))
tupleArray.append((79.33332824707031, 214.0))
tupleArray.append((78.66665649414062, 215.0))
tupleArray.append((77.33332824707031, 216.0))
tupleArray.append((76.66665649414062, 217.3333282470703))
tupleArray.append((75.66665649414062, 218.0))
tupleArray.append((75.0, 219.0))
tupleArray.append((73.33332824707031, 221.0))
tupleArray.append((72.33332824707031, 222.0))
tupleArray.append((71.33332824707031, 223.0))
tupleArray.append((70.66665649414062, 223.66665649414062))
tupleArray.append((69.66665649414062, 224.66665649414062))
tupleArray.append((69.33332824707031, 225.3333282470703))
tupleArray.append((68.66665649414062, 226.0))
tupleArray.append((68.33332824707031, 226.3333282470703))
tupleArray.append((67.66665649414062, 227.0))
tupleArray.append((67.0, 227.3333282470703))
tupleArray.append((66.33332824707031, 228.0))
tupleArray.append((65.33332824707031, 228.66665649414062))
tupleArray.append((64.0, 229.66665649414062))
tupleArray.append((62.666656494140625, 231.0))
tupleArray.append((61.33332824707031, 232.0))
tupleArray.append((59.33332824707031, 233.66665649414062))
tupleArray.append((58.33332824707031, 234.66665649414062))
tupleArray.append((58.0, 235.0))
tupleArray.append((57.33332824707031, 235.66665649414062))
tupleArray.append((56.666656494140625, 236.3333282470703))
tupleArray.append((55.666656494140625, 236.66665649414062))
tupleArray.append((55.0, 237.66665649414062))
tupleArray.append((53.666656494140625, 238.66665649414062))
tupleArray.append((52.666656494140625, 239.66665649414062))
tupleArray.append((51.666656494140625, 240.0))
tupleArray.append((51.0, 241.0))
tupleArray.append((50.666656494140625, 241.3333282470703))
tupleArray.append((50.33332824707031, 242.0))
tupleArray.append((49.666656494140625, 242.3333282470703))
tupleArray.append((49.33332824707031, 242.66665649414062))
tupleArray.append((48.33332824707031, 243.3333282470703))
tupleArray.append((47.666656494140625, 243.66665649414062))
tupleArray.append((47.0, 244.3333282470703))
tupleArray.append((46.0, 244.66665649414062))
tupleArray.append((45.666656494140625, 245.3333282470703))
tupleArray.append((45.0, 245.66665649414062))
tupleArray.append((44.666656494140625, 246.3333282470703))
tupleArray.append((44.0, 247.0))
tupleArray.append((43.33332824707031, 247.3333282470703))
tupleArray.append((42.666656494140625, 248.3333282470703))
tupleArray.append((42.33332824707031, 249.0))
tupleArray.append((41.666656494140625, 249.66665649414062))
tupleArray.append((41.0, 250.0))
tupleArray.append((40.666656494140625, 250.66665649414062))
tupleArray.append((40.33332824707031, 251.0))
tupleArray.append((40.33332824707031, 251.3333282470703))
tupleArray.append((40.33332824707031, 251.66665649414062))
tupleArray.append((40.33332824707031, 252.3333282470703))
tupleArray.append((40.33332824707031, 253.0))
tupleArray.append((40.33332824707031, 253.66665649414062))
tupleArray.append((40.33332824707031, 254.0))
tupleArray.append((40.33332824707031, 254.66665649414062))
tupleArray.append((40.33332824707031, 255.3333282470703))
tupleArray.append((40.33332824707031, 256.3333282470703))
tupleArray.append((40.33332824707031, 257.0))
tupleArray.append((40.33332824707031, 258.0))
tupleArray.append((40.33332824707031, 258.6666564941406))
tupleArray.append((40.33332824707031, 259.6666564941406))
tupleArray.append((40.33332824707031, 261.0))
tupleArray.append((40.33332824707031, 262.3333282470703))
tupleArray.append((40.33332824707031, 264.0))
tupleArray.append((40.33332824707031, 265.6666564941406))
tupleArray.append((40.33332824707031, 269.6666564941406))
tupleArray.append((40.33332824707031, 271.3333282470703))
tupleArray.append((40.33332824707031, 273.0))
tupleArray.append((40.33332824707031, 274.0))
tupleArray.append((40.33332824707031, 276.0))
tupleArray.append((40.33332824707031, 278.0))
tupleArray.append((40.33332824707031, 279.6666564941406))
tupleArray.append((40.33332824707031, 281.0))
tupleArray.append((40.33332824707031, 282.0))
tupleArray.append((40.33332824707031, 282.6666564941406))
tupleArray.append((40.33332824707031, 284.0))
tupleArray.append((40.33332824707031, 286.6666564941406))
tupleArray.append((40.33332824707031, 287.3333282470703))
tupleArray.append((40.33332824707031, 288.3333282470703))
tupleArray.append((40.33332824707031, 289.0))
tupleArray.append((40.33332824707031, 289.6666564941406))
tupleArray.append((40.33332824707031, 290.0))
tupleArray.append((40.33332824707031, 290.6666564941406))
tupleArray.append((40.33332824707031, 291.0))
tupleArray.append((40.33332824707031, 291.6666564941406))
tupleArray.append((40.33332824707031, 292.0))
tupleArray.append((40.33332824707031, 292.3333282470703))
tupleArray.append((40.33332824707031, 292.6666564941406))
tupleArray.append((40.33332824707031, 293.0))
tupleArray.append((40.33332824707031, 293.3333282470703))
tupleArray.append((40.33332824707031, 294.3333282470703))
tupleArray.append((40.33332824707031, 295.0))
tupleArray.append((40.33332824707031, 296.0))
tupleArray.append((40.33332824707031, 296.3333282470703))
tupleArray.append((40.33332824707031, 297.0))
tupleArray.append((40.33332824707031, 297.6666564941406))
tupleArray.append((40.33332824707031, 298.0))
tupleArray.append((40.33332824707031, 299.0))
tupleArray.append((40.33332824707031, 299.6666564941406))
tupleArray.append((40.33332824707031, 301.0))
tupleArray.append((40.33332824707031, 301.6666564941406))
tupleArray.append((40.33332824707031, 302.6666564941406))
tupleArray.append((40.33332824707031, 303.6666564941406))
tupleArray.append((40.33332824707031, 304.3333282470703))
tupleArray.append((40.33332824707031, 304.6666564941406))
tupleArray.append((40.33332824707031, 305.3333282470703))
tupleArray.append((40.33332824707031, 305.3333282470703))
tupleArray.append((40.33332824707031, 305.3333282470703))


//smoothPointsTuple(points: tupleArray)


calculatingSlopesGeneratingAuxPoints(points: smoothPointsTuple(points: tupleArray))


//calculatingSlopesGeneratingAuxPoints(points: tupleArray)

for p in auxPointsArray {
    print("AAAAAAA",p.x,p.y)
}
