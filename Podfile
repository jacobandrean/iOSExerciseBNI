# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

workspace 'iOSExerciseBNI.xcworkspace'

target 'iOSExerciseBNI' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iOSExerciseBNI

  target 'iOSExerciseBNITests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'iOSExerciseBNIUITests' do
    # Pods for testing
  end
  
  target 'InjectorModule' do
    project 'modules/InjectorModule/InjectorModule.xcodeproj'
  end
  
  target 'NetworkModule' do
    project 'modules/NetworkModule/NetworkModule.xcodeproj'
  end
  
  target 'APIModule' do
    project 'modules/APIModule/APIModule.xcodeproj'
  end
  
  target 'UIModule' do
    project 'modules/UIModule/UIModule.xcodeproj'
  end

end
