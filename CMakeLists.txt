cmake_minimum_required(VERSION 3.16)
project(driver-displays VERSION 1.0 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(QT NAMES Qt5 Qt6 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Gui Quick)
find_package(Qt6 REQUIRED COMPONENTS SerialBus )

# Tell CMake where to find additional header files
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include /usr/local/include)

# Tell CMake where to find the pigpio library
link_directories(${CMAKE_CURRENT_SOURCE_DIR}/lib /usr/local/lib)

qt_standard_project_setup()

# Makes sure config.json is included next to binary in build folder
set(CONFIG_FILE_NAME "config.json")
set(CONFIG_DIR ${CMAKE_CURRENT_SOURCE_DIR}/config)
set(CONFIG_FILE ${CONFIG_DIR}/${CONFIG_FILE_NAME})
configure_file(${CONFIG_FILE} ${CMAKE_BINARY_DIR}/config/${CONFIG_FILE_NAME} COPYONLY)

set(GRADIENT_FILE_NAME "gradient.png")
set(GRADIENT_FILE ${CMAKE_CURRENT_SOURCE_DIR}/resources/images/${GRADIENT_FILE_NAME})
configure_file(${GRADIENT_FILE} ${CMAKE_BINARY_DIR}/config/${GRADIENT_FILE_NAME} COPYONLY)

set(DBC1_FILE_NAME "SensorBus.dbc")
set(DBC1_DIR ${CMAKE_CURRENT_SOURCE_DIR}/config/${DBC1_FILE_NAME})
configure_file(${DBC1_DIR} ${CMAKE_BINARY_DIR}/config/${DBC1_FILE_NAME} COPYONLY)

set(DBC2_FILE_NAME "TractiveBus.dbc")
set(DBC2_DIR ${CMAKE_CURRENT_SOURCE_DIR}/config/${DBC2_FILE_NAME})
configure_file(${DBC2_DIR} ${CMAKE_BINARY_DIR}/config/${DBC2_FILE_NAME} COPYONLY)

qt_add_executable(driver-displays WIN32 MACOSX_BUNDLE
    main.cpp
    resources/backend.h resources/backend.cpp 
    resources/colourmap.h resources/colourmap.cpp
    resources/logformatter.h resources/logformatter.cpp
)

qt_add_resources(driver-displays "imageresources"
    PREFIX "/resources/images"
    FILES
        ./resources/images/gradient.png
)

qt_add_qml_module(driver-displays
    URI test
    VERSION 1.0
    QML_FILES
        main.qml
        resources/screens/MainVertical.qml
        resources/screens/MainWide.qml
        resources/screens/AccelerationVertical.qml
        resources/screens/AutocrossVertical.qml
        resources/modules/LaptimeRolling.qml
        resources/modules/StateOfCharge.qml
        resources/modules/LaptimeBest.qml
        resources/modules/LaptimeDelta.qml
        resources/modules/LaptimeLast.qml
        resources/modules/RPMBar.qml
        resources/modules/TemperatureBar.qml
        resources/modules/LaunchControlSymbol.qml
        resources/modules/CruiseControlSymbol.qml
        resources/modules/PowerRegenSymbols.qml
        resources/modules/RPMWrapper.qml
        resources/modules/Speed.qml
        resources/modules/TemperatureAccuDigital.qml
        resources/modules/BrakeIndicators.qml
        resources/modules/TyreIndicators.qml
        resources/modules/WarningSoCTemp.qml
        resources/modules/LongitudinalGs.qml
        resources/modules/InfoBar.qml
        resources/modules/RegenStrength.qml
        resources/modules/TorqueSetting.qml
        resources/modules/LaunchControlWithText.qml
        resources/screens/SkidpadVertical.qml
        resources/modules/LongitudinalGsWithArrow.qml

    RESOURCES
        config/config.json
        config/SensorBus.dbc
        config/TractiveBus.dbc
        resources/images/Temperature\ Bar.png
        resources/images/abs_off.png
        resources/images/abs_on.png
        resources/images/tc_off.png
        resources/images/tc_on.png
        resources/images/temp_off.png
        resources/images/temp_on.png
        resources/images/Pirelli_2019_C2.png
        resources/images/gradient.png
        resources/images/thermostat.png
        resources/images/launch_control_on.png
        resources/images/launch_control_off.png
        resources/images/cruise_control_on.png
        resources/images/cruise_control_off.png
        resources/images/white_arrow.png
    NO_RESOURCE_TARGET_PATH
    QML_FILES
    QML_FILES resources/screens/TestVertical.qml
    QML_FILES resources/modules/TemperatureInverter.qml
    QML_FILES resources/modules/TemperatureMotor.qml
    QML_FILES resources/modules/TractionControlSymbol.qml
    QML_FILES resources/modules/HighVoltage.qml
    QML_FILES resources/modules/LV.qml
    QML_FILES resources/modules/DCL.qml
    QML_FILES resources/modules/WarningLVBattery.qml
    QML_FILES resources/modules/TemperatureAllCoolants.qml
)

target_link_libraries(driver-displays PRIVATE
    Qt::Core
    Qt::Gui
    Qt::Quick
    Qt6::SerialBus
)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

install(TARGETS driver-displays
    BUNDLE DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

qt_generate_deploy_qml_app_script(
    TARGET driver-displays
    OUTPUT_SCRIPT deploy_script
    NO_UNSUPPORTED_PLATFORM_ERROR
    DEPLOY_USER_QML_MODULES_ON_UNSUPPORTED_PLATFORM
    MACOS_BUNDLE_POST_BUILD
)
install(SCRIPT ${deploy_script})
