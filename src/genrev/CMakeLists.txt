# Copyright (C) 2012 DeadCore <https://bitbucket.org/selectorcore/deadcore-private>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# Need to pass old ${CMAKE_BINARY_DIR} as param because its different at build stage
add_custom_target(revision.h ALL
  COMMAND ${CMAKE_COMMAND} -DBUILDDIR=${CMAKE_BINARY_DIR} -P ${CMAKE_SOURCE_DIR}/cmake/genrev.cmake
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
)
