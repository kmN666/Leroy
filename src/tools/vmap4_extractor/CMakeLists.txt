# Copyright (C) 2005-2009 MaNGOS project <http://getmangos.com/>
# Copyright (C) 2012 DeadCore <https://bitbucket.org/selectorcore/deadcore-private>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

file(GLOB_RECURSE sources *.cpp *.h)

# uncomment next line to disable debug mode
add_definitions("-DIOMAP_DEBUG")

# build setup currently only supports libmpq 0.4.x
add_definitions("-DUSE_LIBMPQ04")
add_definitions("-Wall")
add_definitions("-ggdb")
add_definitions("-O3")

if( UNIX )
  include_directories(
    ${CMAKE_SOURCE_DIR}/dep/libmpq
  )
elseif( WIN32 )
  include_directories(
    ${CMAKE_SOURCE_DIR}/dep/libmpq
    ${CMAKE_SOURCE_DIR}/dep/libmpq/win
  )
endif()

add_executable(vmap4extractor ${sources})

target_link_libraries(vmap4extractor
  mpq
  ${BZIP2_LIBRARIES}
  ${ZLIB_LIBRARIES}
)

add_dependencies(vmap4extractor mpq)

if( UNIX )
  install(TARGETS vmap4extractor DESTINATION bin)
elseif( WIN32 )
  install(TARGETS vmap4extractor DESTINATION "${CMAKE_INSTALL_PREFIX}")
endif()
