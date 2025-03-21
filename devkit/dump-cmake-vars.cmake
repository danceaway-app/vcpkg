cmake_minimum_required(VERSION 3.30)

function(dump_cmake_variables)
    get_cmake_property(_variableNames VARIABLES)
    list (SORT _variableNames)
    foreach (_variableName ${_variableNames})
        if (ARGV0)
            unset(MATCHED)

            #case sensitive match
            # string(REGEX MATCH ${ARGV0} MATCHED ${_variableName})
            #
            #case insenstitive match
            string( TOLOWER "${ARGV0}" ARGV0_lower )
            string( TOLOWER "${_variableName}" _variableName_lower )
            string(REGEX MATCH ${ARGV0_lower} MATCHED ${_variableName_lower})

            if (NOT MATCHED)
                continue()
            endif()
        endif()
        message(STATUS "${_variableName}=${${_variableName}}")
    endforeach()
endfunction()

# Example
#   dump_cmake_variables("^sqlite")
