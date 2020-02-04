#
# Be sure to run `pod lib lint UBProfile.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UBProfile'
  s.version          = '0.2.3'
  s.summary          = 'UBProfile.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'http://git.usemobile.com.br/libs-iOS/use-blue/profile'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tulio de Oliveira Parreiras' => 'tulio@usemobile.xyz' }
  s.source           = { :git => 'http://git.usemobile.com.br/libs-iOS/use-blue/profile.git', :tag => s.version.to_s }

    s.swift_version    = '4.2'
    s.ios.deployment_target = '10.1'
  
    s.source_files = 'UBProfile/Classes/**/*'
    s.static_framework = true
    s.frameworks = 'UIKit'
    s.dependency 'USE_Coordinator'
    s.dependency 'HCSStarRatingView'
    s.dependency 'TPKeyboardAvoiding'
    s.dependency 'TransitionButton'
  
   s.resource_bundles = {
     'UBProfile' => ['UBProfile/Assets/*.png']
   }

end
