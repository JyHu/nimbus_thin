Pod::Spec.new do |s|
  s.name         = "Nimbus"
  s.version      = "0.1.0"
  s.summary      = "The iOS framework that grows only as fast as its documentation"
  s.description  = <<-DESC
  Nimbus is an iOS framework whose feature set grows only as fast as its documentation. By focusing
  on documentation first and features second, Nimbus hopes to be a framework that accelerates the
  development process of any application by being easy to use and simple to understand.
                   DESC
  s.homepage     = "http://nimbuskit.info"
  s.license      = "Apache License, Version 2.0"
  s.authors            = {
    "Jeff Verkoeyen" => "jverkoey@gmail.com",
    "Bubnov Slavik" => "bubnovslavik@gmail.com",
    "Roger Chapman" => "rogchap@gmail.com",
    "Manu Cornet" => "manu.cornet@gmail.com",
    "Glenn Grant" => "glenn@ensquared.net",
    "Aviel Lazar" => "aviellazar@gmail.com",
    "Benedikt Meurer" => "benedikt.meurer@googlemail.com",
    "Anderson Miller" => "anderson@submarinerich.com",
    "Basil Shkara" => "basil@neat.io",
    "Peter Steinberger" => "me@petersteinberger.com",
    "Hwee-Boon Yar" => "hboon@motionobj.com",
    "Stephane Moore" => "stephane.moore@gmail.com"
  }
  s.social_media_url   = "http://twitter.com/NimbusKit"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/JyHu/nimbus_thin.git", :tag => s.version }
  s.requires_arc = true

  s.subspec 'AttributedLabel' do |ss|
    ss.source_files = 'NimbusAttributedLabel'
    ss.dependency 'Nimbus/Core'
  end

  s.subspec 'Core' do |ss|
    ss.source_files = 'NimbusCore'
  end

  s.subspec 'Badge' do |ss|
    ss.source_files = 'NimbusBadge'
    ss.dependency 'Nimbus/Core'
  end

  s.subspec 'Collections' do |ss|
    ss.source_files = 'NimbusCollections'
    ss.dependency 'Nimbus/Core'
  end

  s.subspec 'Interapp' do |ss|
    ss.source_files = 'NimbusInterapp'
    ss.dependency 'Nimbus/Core'
    ss.framework = 'CoreLocation'
  end

  s.subspec 'Launcher' do |ss|
    ss.source_files = 'NimbusLauncher'
    ss.dependency 'Nimbus/Core'
    ss.dependency 'Nimbus/PagingScrollView'
  end

  s.subspec 'Models' do |ss|
    ss.source_files = 'NimbusModels'
    ss.dependency 'Nimbus/Core'
  end

  s.subspec 'Overview' do |ss|
    ss.source_files = 'NimbusOverview'
    ss.dependency 'Nimbus/Core'
    ss.dependency 'Nimbus/Models'
    s.resource_bundles = {
      'Overview' => ['src/overview/resources/NimbusOverviewer.bundle/*']
    }
  end

  s.subspec 'PagingScrollView' do |ss|
    ss.source_files = 'NimbusPagingScrollView'
    ss.dependency 'Nimbus/Core'
  end

  s.subspec 'Textfield' do |ss|
    ss.source_files = 'NimbusTextField'
    ss.dependency 'Nimbus/Core'
  end
end
