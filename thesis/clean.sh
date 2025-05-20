#!/bin/sh

BUILD_DIR="./build"

# Check if build directory exists
if [ -d "$BUILD_DIR" ]; then
    echo "Cleaning build directory..."
    rm -rf "$BUILD_DIR"/*
    echo "Build directory cleaned successfully!"
fi