Pod::Spec.new do |s|
  s.name         = "SwiftyWalkthrough"
  s.version      = "0.0.3"
  s.summary      = "SwiftyWalkthrough is the easiest way to create a great walkthrough experience in your apps, powered by Swift."
  s.homepage     = "https://github.com/ruipfcosta/SwiftyWalkthrough"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "Rui Costa" => "rui.pfcosta@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => 'https://github.com/ruipfcosta/SwiftyWalkthrough.git', :tag => s.version }
  s.source_files = "Sources/*.swift"
  s.requires_arc = true
end
