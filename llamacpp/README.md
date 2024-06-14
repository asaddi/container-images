Use build-cuda to build.

    git config --global --add safe.directory /build
    cmake -B build -DLLAMA_CUDA=on
    cmake --build build --config Release -j8
