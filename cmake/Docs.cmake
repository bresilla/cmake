###### DOXYFILE ######
if(BUILD_DOXYGEN_DOCS)
    find_package(Doxygen)
    set(DOXYGEN_OUTPUT_DIR ${CMAKE_CURRENT_BINARY_DIR}/docs/doxygen)
    set(DOXYGEN_INDEX_FILE ${DOXYGEN_OUTPUT_DIR}/html/index.html)
    set(DOXYFILE_IN ${PROJECT_PATH}/etc/Doxyfile.in)
    set(DOXYFILE_OUT ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile)
    configure_file(${DOXYFILE_IN} ${DOXYFILE_OUT} @ONLY)
    add_custom_command(OUTPUT ${DOXYGEN_INDEX_FILE}
                    COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYFILE_OUT}
                    MAIN_DEPENDENCY ${DOXYFILE_OUT} ${DOXYFILE_IN}
                    WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
                    COMMENT "Generating docs")
    add_custom_target(docs ALL DEPENDS ${DOXYGEN_INDEX_FILE})
    install(DIRECTORY ${INSTALL_DOC_DIR} DESTINATION share/${PROJECT_NAME}-${VERSION_MAJOR} COMPONENT docs)
endif()

###### SPHINX ######
if(BUILD_SPHINX_DOCS)
    find_package(Sphinx REQUIRED)
    # create a "read" command to use with: make read
    set(RTD_TARGET_NAME "read")
    set(SPHINX_SOURCE ${CMAKE_CURRENT_SOURCE_DIR})
    set(SPHINX_BUILD ${CMAKE_CURRENT_BINARY_DIR}/sphinx)
    set(SPHINX_INDEX_FILE ${SPHINX_BUILD}/index.html)
    add_custom_command(OUTPUT ${SPHINX_INDEX_FILE}
                    COMMAND
                        ${SPHINX_EXECUTABLE} -b html
                        # Tell Breathe where to find the Doxygen output
                        -Dbreathe_projects.CatCutifier=${DOXYGEN_OUTPUT_DIR}/xml
                    ${SPHINX_SOURCE} ${SPHINX_BUILD}
                    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                    DEPENDS
                    # Other docs files you want to track should go here (or in some variable)
                    ${CMAKE_CURRENT_SOURCE_DIR}/index.rst
                    ${DOXYGEN_INDEX_FILE}
                    MAIN_DEPENDENCY ${SPHINX_SOURCE}/conf.py
                    COMMENT "Generating documentation with Sphinx")
    # Nice named target so we can run the job easily
    add_custom_target(${RTD_TARGET_NAME} ALL DEPENDS ${SPHINX_INDEX_FILE})
    # Add an install target to install the docs
    install(DIRECTORY ${SPHINX_BUILD} DESTINATION ${CMAKE_INSTALL_DOCDIR})
endif()
