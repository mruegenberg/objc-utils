cmake_minimum_required(VERSION 2.8.5)
project(objc-utils)

set(CMAKE_OSX_SYSROOT iphoneos5.0)
set(CMAKE_OSX_ARCHITECTURES "armv6;armv7;i386")
set(CMAKE_XCODE_EFFECTIVE_PLATFORMS "-iphoneos;-iphonesimulator")

include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}/CoreFoundation/*
  ${CMAKE_CURRENT_SOURCE_DIR}/UIKit/*
)

FILE (GLOB M_SRCS *.m CoreFoundation/*.m CoreFoundation/*/*.m UIKit/*/*.m)
FILE (GLOB HEADERS *.h CoreFoundation/*.h CoreFoundation/*/*.h UIKit/*/*.h)

add_library(objc-utils ${M_SRCS} ${HEADERS})

target_link_libraries(objc-utils
  "-framework CoreFoundation"
  "-framework UIKit"
  )

set_target_properties(objc-utils PROPERTIES
   MACOSX_BUNDLE_GUI_IDENTIFIER "com.yourcompany.objc-utils"
   MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_SOURCE_DIR}/Info.plist.in
   RESOURCE "${RESOURCES}"
   XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer"
   XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT "dwarf-with-dsym"
   XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET 5.0
   )
