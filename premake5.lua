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
end

project "bgfx"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    exceptionhandling "Off"
    rtti "Off"
    defines "__STDC_FORMAT_MACROS"
    
    files {
		"bgfx/include/bgfx/**.h",
		"bgfx/src/*.cpp",
		"bgfx/src/*.h",
        "bimg/include/bimg/*.h",
        "bimg/src/image.cpp",
        "bimg/src/image_gnf.cpp",
        "bimg/src/*.h",
        "bimg/3rdparty/astc-codec/src/decoder/*.cc",
        "bimg/3rdparty/astc-encoder/source/*.cpp",
        "bx/include/bx/*.h",
        "bx/include/bx/inline/*.inl",
        "bx/src/*.cpp"
	}

	excludes {
		"bgfx/src/amalgamated.cpp",
        "bx/src/amalgamated.cpp",
        "bx/src/crtnone.cpp"
	}

	includedirs {
		"bx/include",
        "bx/3rdparty",
		"bimg/include",
        "bimg/3rdparty/astc-codec",
        "bimg/3rdparty/astc-codec/include",
        "bimg/3rdparty/astc-encoder/include",
		"bgfx/include",
		"bgfx/3rdparty",
		"bgfx/3rdparty/directx-headers/include/directx",
		"bgfx/3rdparty/directx-headers/include/wsl/stubs",
		"bgfx/3rdparty/khronos"
	}

	filter "action:vs*"
		defines "_CRT_SECURE_NO_WARNINGS"
		excludes {
			"bgfx/src/glcontext_glx.cpp",
			"bgfx/src/glcontext_egl.cpp"
		}
	filter "system:macosx"
		files {
			"bgfx/src/*.mm",
		}

	setBxCompat()

    filter "not configurations:Debug"
        defines {
            "NDEBUG",
            "BX_CONFIG_DEBUG=0"
        }
        optimize "Full"
    filter "configurations:Debug"
        defines {
            "_DEBUG",
            "BX_CONFIG_DEBUG=1"
        }
        optimize "Debug"
        symbols "On"

    filter "platforms:x86"
        architecture "x86"
    filter "platforms:x86_64"
        architecture "x86_64"
    filter "system:macosx"
        xcodebuildsettings {
            ["MACOSX_DEPLOYMENT_TARGET"] = "10.9",
            ["ALWAYS_SEARCH_USER_PATHS"] = "YES",
        };
