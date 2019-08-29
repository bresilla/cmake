# Add a make target 'doc' to generate API documentation with Doxygen.
# You should set options to your liking in the file 'Doxyfile.in'.
find_package(Doxygen)
if(DOXYGEN_FOUND)
    configure_file(${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.in ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile @ONLY)
    set(DOC_TARGET_NAME "doc")
    if(TARGET doc)
        set(DOC_TARGET_NAME "doc${PROJECT_NAME}")
    endif()

    add_custom_target(${DOC_TARGET_NAME} ${TARGET_ALL}
        ${DOXYGEN_EXECUTABLE} ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile &> doxygen.log
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        COMMENT "Generating API documentation using doxygen for ${PROJECT_NAME}" VERBATIM)
    set(INSTALL_DOC_DIR ${CMAKE_BINARY_DIR}/doc/${PROJECT_NAME}/html)

    file(MAKE_DIRECTORY ${INSTALL_DOC_DIR}) # needed for install
    install(DIRECTORY ${INSTALL_DOC_DIR} DESTINATION share/${PROJECT_NAME}-${VERSION_MAJOR} COMPONENT doc)
endif(DOXYGEN_FOUND)
