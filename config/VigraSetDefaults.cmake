# Set default values for various cmake configuration variables

# Output of doxygen and sphinx-build will be written
# to ${DOCDIR}.
# Vigra html files generated by doxygen will be stored
# in ${DOCDIR}/vigra.
# Vigranumpy sphinx output will be stored in
# ${DOCDIR}/vigranumpy.
# This should keep relative links between
# vigranumpy and vigra working.
IF(NOT DEFINED DOCDIR)
    SET(DOCDIR ${vigra_SOURCE_DIR}/doc)
ENDIF()
SET(DOCDIR ${DOCDIR}
    CACHE PATH "Output path of created documentation files."
    FORCE)

# running make install, the content of ${DOCDIR}
# is copied/installed at ${DOCINSTALL}.
IF(NOT DEFINED DOCINSTALL)
    SET(DOCINSTALL "doc")
ENDIF()
SET(DOCINSTALL ${DOCINSTALL}
    CACHE STRING "where to install the documentation (relative to install prefix)"
    FORCE)

IF(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    set(MACOSX TRUE)
ENDIF()

IF(NOT DEFINED WITH_HDF5)
    SET(WITH_HDF5 "ON")
ENDIF()
SET(WITH_HDF5 ${WITH_HDF5}
    CACHE BOOL "Build HDF5 import/export ?"
    FORCE)
    
OPTION(WITH_OPENEXR "Support for the OpenEXR graphics format" OFF)

OPTION(WITH_BOOST_THREAD "Use boost::thread instead of std::thread" OFF)

IF(NOT DEFINED WITH_VIGRANUMPY)
    SET(WITH_VIGRANUMPY "ON")
ENDIF()
SET(WITH_VIGRANUMPY ${WITH_VIGRANUMPY}
    CACHE BOOL "Build VIGRA Python bindings ?"
    FORCE)
    
IF(NOT DEFINED WITH_VALGRIND)
    SET(WITH_VALGRIND "OFF")
ENDIF()
SET(WITH_VALGRIND ${WITH_VALGRIND}
    CACHE BOOL "Perform valgrind memory testing upon 'make ctest' ?"
    FORCE)
    
IF(NOT DEFINED LIBDIR_SUFFIX)
    SET(LIBDIR_SUFFIX "")
ENDIF()
SET(LIBDIR_SUFFIX ${LIBDIR_SUFFIX}
    CACHE STRING "Define suffix of lib directory name (empty string or 32 or 64)." 
    FORCE)
    
IF(NOT DEFINED DEPENDENCY_SEARCH_PREFIX)
    SET(DEPENDENCY_SEARCH_PREFIX "")
ENDIF()    
SET(DEPENDENCY_SEARCH_PREFIX ${DEPENDENCY_SEARCH_PREFIX}
    CACHE PATH "Additional search prefixes (used by Find... macros)."
    FORCE)

IF(NOT DEFINED AUTOEXEC_TESTS)
    SET(AUTOEXEC_TESTS "ON")
ENDIF()    
SET(AUTOEXEC_TESTS ${AUTOEXEC_TESTS}
    CACHE BOOL "Automatically execute each test after compilation ?"
    FORCE)

IF(NOT DEFINED AUTOBUILD_TESTS)
    SET(AUTOBUILD_TESTS "OFF")
ENDIF()    
SET(AUTOBUILD_TESTS ${AUTOBUILD_TESTS}
    CACHE BOOL "Compile tests as part of target 'all' (resp. 'ALL_BUILD') ?"
    FORCE)

IF(NOT DEFINED VIGRA_STATIC_LIB)
    SET(VIGRA_STATIC_LIB "OFF")
ENDIF()    
SET(VIGRA_STATIC_LIB ${VIGRA_STATIC_LIB}
    CACHE BOOL "Whether to build vigra as a static library ?"
    FORCE)

# This is only executed once on the first cmake run.
IF(NOT VIGRA_DEFAULTS_INIT)
    SET(VIGRA_DEFAULTS_INIT TRUE CACHE INTERNAL "initial flags set")

    IF (NOT MSVC AND NOT CMAKE_BUILD_TYPE)
        SET(CMAKE_BUILD_TYPE "Release"
            CACHE STRING "Choose the type of build, options are None Release Debug RelWithDebInfo MinSizeRel."
            FORCE)
    ENDIF ()
    
    IF(NOT DEFINED VALGRIND_SUPPRESSION_FILE)
        SET(VALGRIND_SUPPRESSION_FILE ""
            CACHE FILEPATH "File containing valgrind error suppression rules."
            FORCE)
    ENDIF()
    
    # initial compiler flags can be set here, this is only
    # executed once in the first configure run.
    IF(CMAKE_COMPILER_IS_GNUCXX)
        IF(NOT CMAKE_CXX_FLAGS)
            if(NOT MINGW AND NOT MACOSX)
                SET(CMAKE_CXX_FLAGS "-W -Wall -Wextra -Wno-unused-parameter -Wno-sign-compare -Wno-unused-variable -Wno-type-limits")
            elseif(MACOSX)
                SET(CMAKE_CXX_FLAGS "-W -Wall -Wextra -Wno-unused-parameter -Wno-sign-compare -Wno-unused-variable")
            endif()
        ENDIF()
        IF(NOT CMAKE_C_FLAGS)
            SET(CMAKE_C_FLAGS "-W -Wall -Wextra -pedantic -std=c99 -Wno-sign-compare")
        ENDIF()
    ENDIF(CMAKE_COMPILER_IS_GNUCXX)

    SET(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} CACHE STRING
        "Flags used by the compiler during all build types."
        FORCE
    )
    SET(CMAKE_C_FLAGS ${CMAKE_C_FLAGS} CACHE STRING
        "Flags used by the compiler during all build types."
        FORCE
    )
ENDIF(NOT VIGRA_DEFAULTS_INIT)

