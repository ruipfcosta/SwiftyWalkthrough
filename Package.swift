// swift-tools-version:5.4.0
import PackageDescription

let package = Package(
    name: "SwiftyWalkthrough",
    platforms: [.iOS(.v9)],
	products: [
    	.library(
	        name: "SwiftyWalkthrough",
        	targets: ["SwiftyWalkthrough"])
    	],
	targets: [
    	.target(
	        name: "SwiftyWalkthrough",
        	path: "Sources")
       	]
	)
