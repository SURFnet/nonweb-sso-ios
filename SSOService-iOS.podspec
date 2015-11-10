Pod::Spec.new do |s|
  s.name         = "SSOService-iOS"
  s.version      = "0.0.1"
  s.summary      = "Integrate the SURFnet SSO process flow in your iOS app"
  s.description  = <<-DESC
  Now you can easily integrate the [SURFnet](https://www.surf.nl) SSO process flow in your iOS application by using this library.
                   DESC
  s.homepage     = "https://github.com/SURFnet/nonweb-sso-ios"
  s.license      = "Apache License, Version 2.0"
  s.author       = { "SURFnet" => "info@surf.nl" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/SURFnet/nonweb-sso-ios.git", :tag => "v#{s.version}"  }
  s.source_files  = "SSOService/**/*.{h,m}"
  s.public_header_files = "SSOService/**/*.h"
  s.weak_framework  = "SafariServices"
  s.requires_arc = true
end
