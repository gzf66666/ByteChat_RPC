# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ubuntu/ByteTalk/UserService

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ubuntu/ByteTalk/UserService/build

# Include any dependencies generated for this target.
include example/CMakeFiles/callee.dir/depend.make

# Include the progress variables for this target.
include example/CMakeFiles/callee.dir/progress.make

# Include the compile flags for this target's objects.
include example/CMakeFiles/callee.dir/flags.make

example/CMakeFiles/callee.dir/UserService.pb.cc.o: example/CMakeFiles/callee.dir/flags.make
example/CMakeFiles/callee.dir/UserService.pb.cc.o: ../example/UserService.pb.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ubuntu/ByteTalk/UserService/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object example/CMakeFiles/callee.dir/UserService.pb.cc.o"
	cd /home/ubuntu/ByteTalk/UserService/build/example && /usr/bin/g++-7  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/callee.dir/UserService.pb.cc.o -c /home/ubuntu/ByteTalk/UserService/example/UserService.pb.cc

example/CMakeFiles/callee.dir/UserService.pb.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/callee.dir/UserService.pb.cc.i"
	cd /home/ubuntu/ByteTalk/UserService/build/example && /usr/bin/g++-7 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ubuntu/ByteTalk/UserService/example/UserService.pb.cc > CMakeFiles/callee.dir/UserService.pb.cc.i

example/CMakeFiles/callee.dir/UserService.pb.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/callee.dir/UserService.pb.cc.s"
	cd /home/ubuntu/ByteTalk/UserService/build/example && /usr/bin/g++-7 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ubuntu/ByteTalk/UserService/example/UserService.pb.cc -o CMakeFiles/callee.dir/UserService.pb.cc.s

example/CMakeFiles/callee.dir/UserService.pb.cc.o.requires:

.PHONY : example/CMakeFiles/callee.dir/UserService.pb.cc.o.requires

example/CMakeFiles/callee.dir/UserService.pb.cc.o.provides: example/CMakeFiles/callee.dir/UserService.pb.cc.o.requires
	$(MAKE) -f example/CMakeFiles/callee.dir/build.make example/CMakeFiles/callee.dir/UserService.pb.cc.o.provides.build
.PHONY : example/CMakeFiles/callee.dir/UserService.pb.cc.o.provides

example/CMakeFiles/callee.dir/UserService.pb.cc.o.provides.build: example/CMakeFiles/callee.dir/UserService.pb.cc.o


example/CMakeFiles/callee.dir/main.cpp.o: example/CMakeFiles/callee.dir/flags.make
example/CMakeFiles/callee.dir/main.cpp.o: ../example/main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ubuntu/ByteTalk/UserService/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object example/CMakeFiles/callee.dir/main.cpp.o"
	cd /home/ubuntu/ByteTalk/UserService/build/example && /usr/bin/g++-7  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/callee.dir/main.cpp.o -c /home/ubuntu/ByteTalk/UserService/example/main.cpp

example/CMakeFiles/callee.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/callee.dir/main.cpp.i"
	cd /home/ubuntu/ByteTalk/UserService/build/example && /usr/bin/g++-7 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ubuntu/ByteTalk/UserService/example/main.cpp > CMakeFiles/callee.dir/main.cpp.i

example/CMakeFiles/callee.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/callee.dir/main.cpp.s"
	cd /home/ubuntu/ByteTalk/UserService/build/example && /usr/bin/g++-7 $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ubuntu/ByteTalk/UserService/example/main.cpp -o CMakeFiles/callee.dir/main.cpp.s

example/CMakeFiles/callee.dir/main.cpp.o.requires:

.PHONY : example/CMakeFiles/callee.dir/main.cpp.o.requires

example/CMakeFiles/callee.dir/main.cpp.o.provides: example/CMakeFiles/callee.dir/main.cpp.o.requires
	$(MAKE) -f example/CMakeFiles/callee.dir/build.make example/CMakeFiles/callee.dir/main.cpp.o.provides.build
.PHONY : example/CMakeFiles/callee.dir/main.cpp.o.provides

example/CMakeFiles/callee.dir/main.cpp.o.provides.build: example/CMakeFiles/callee.dir/main.cpp.o


# Object files for target callee
callee_OBJECTS = \
"CMakeFiles/callee.dir/UserService.pb.cc.o" \
"CMakeFiles/callee.dir/main.cpp.o"

# External object files for target callee
callee_EXTERNAL_OBJECTS =

../bin/callee: example/CMakeFiles/callee.dir/UserService.pb.cc.o
../bin/callee: example/CMakeFiles/callee.dir/main.cpp.o
../bin/callee: example/CMakeFiles/callee.dir/build.make
../bin/callee: example/CMakeFiles/callee.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/ubuntu/ByteTalk/UserService/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking CXX executable ../../bin/callee"
	cd /home/ubuntu/ByteTalk/UserService/build/example && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/callee.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
example/CMakeFiles/callee.dir/build: ../bin/callee

.PHONY : example/CMakeFiles/callee.dir/build

example/CMakeFiles/callee.dir/requires: example/CMakeFiles/callee.dir/UserService.pb.cc.o.requires
example/CMakeFiles/callee.dir/requires: example/CMakeFiles/callee.dir/main.cpp.o.requires

.PHONY : example/CMakeFiles/callee.dir/requires

example/CMakeFiles/callee.dir/clean:
	cd /home/ubuntu/ByteTalk/UserService/build/example && $(CMAKE_COMMAND) -P CMakeFiles/callee.dir/cmake_clean.cmake
.PHONY : example/CMakeFiles/callee.dir/clean

example/CMakeFiles/callee.dir/depend:
	cd /home/ubuntu/ByteTalk/UserService/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ubuntu/ByteTalk/UserService /home/ubuntu/ByteTalk/UserService/example /home/ubuntu/ByteTalk/UserService/build /home/ubuntu/ByteTalk/UserService/build/example /home/ubuntu/ByteTalk/UserService/build/example/CMakeFiles/callee.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : example/CMakeFiles/callee.dir/depend
