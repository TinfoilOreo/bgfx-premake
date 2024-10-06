function setBxCompat()
    filter "action:vs*"
		includedirs { "bx/include/compat/msvc" }
	filter { "system:windows", "action:gmake" }
		includedirs { "bx/include/compat/mingw" }
    filter "system:linux"
        includedirs { "bx/include/compat/linux" }
	filter { "system:macosx" }
		includedirs { "bx/include/compat/osx" }
		buildoptions { "-x objective-c++" }
        linkoptions {
            "-framework Cocoa",
            "-framework IOKit",
            "-framework OpenGL",
            "-framework QuartzCore",
            "-weak_framework Metal",
            "-weak_framework MetalKit"
        }
end

project "bx"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    exceptionhandling "Off"
    rtti "Off"

    defines {
        "__STDC_FORMAT_MACROS"
    }

    includedirs {
        "bx/include",
        "bx/3rdparty"
    }

    files {
        "bx/src/amalgamated.cpp"
    }

    filter "configurations:Debug"
        defines {
            "BX_CONFIG_DEBUG=1"
        }

    filter "configurations:not Debug"
        defines {
            "BX_CONFIG_DEBUG=0"
        }

project "bimg"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    rtti "Off"
    defines {
        "__STDC_FORMAT_MACROS"
    }

    includedirs {
        "bimg/include",
        "bimg/3rdparty",
        "bimg/3rdparty/tinyexr/deps/miniz",
        "bimg/3rdparty/iqa/include",
        "bimg/3rdparty/astc-encoder/include",
        "bx/include"
    }
    
    files {
        "bimg/src/**.cpp"
    }

    filter "configurations:Debug"
        defines {
            "BX_CONFIG_DEBUG=1"
        }

    filter "configurations:not Debug"
        defines {
            "BX_CONFIG_DEBUG=0"
        }

project "bgfx"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    exceptionhandling "Off"
    rtti "Off"

    defines {
        "__STDC_FORMAT_MACROS"
    }

    includedirs {
        "bx/include",
        "bimg/include",
        "bgfx/include",
        "bgfx/3rdparty",
        "bgfx/3rdparty/khronos"
    }

    files {
        "bgfx/src/amalgamated.cpp"
    }

    filter "configurations:Debug"
        defines {
            "BX_CONFIG_DEBUG=1"
        }

    filter "configurations:not Debug"
        defines {
            "BX_CONFIG_DEBUG=0"
        }
    
    filter "system:windows"
        includedirs {
			"bgfx/3rdparty/directx-headers/include/directx"
		}

    filter { "system:windows", "action:vs*" }
        includedirs {
            "bx/include/compat/msvc"
        }

    filter { "system:windows", "action:gmake" }
        includedirs {
            "bx/include/compat/mingw"
        }

    filter "system:linux"
        includedirs {
			"bgfx/3rdparty/directx-headers/include/directx",
			"bgfx/3rdparty/directx-headers/include",
			"bgfx/3rdparty/directx-headers/include/wsl/stubs",
            "bx/include/compat/linux"
		}

    filter "system:macosx"
        includedirs {
            "bx/include/compat/osx"
        }

        buildoptions {
            "-x objective-c++"
        }
